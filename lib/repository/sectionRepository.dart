import 'package:controle_pacientes/database/firebaseDatabaseHelper.dart';
import 'package:controle_pacientes/model/currentUser.dart';
import 'package:controle_pacientes/model/section.dart';
import 'package:controle_pacientes/model/sectionVM.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SectionRepository {
  Future<SectionVM> getUserAndSections() async {
    var sections = await getSections();
    var currentUser = await FirebaseDatabaseHelper.getCurrentUser();

    var sectionVM = SectionVM(currentUser, sections);

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    return sectionVM;
  }

  Future<List<Section>> getSections() async {
    DataSnapshot snapshot = await FirebaseDatabaseHelper.getSections();
    List<Section> sections = (snapshot.value as Map<dynamic, dynamic>)
        .values
        .map((d) => Section(d))
        .toList();
    sections.sort((a, b) => -a.timestamp.compareTo(b.timestamp));
    return sections;
  }

  Future<bool> addSection(String name, String date, String time) async {
    return await FirebaseDatabaseHelper.addSection(name, date, time);
  }

  void removeSection(Section section) {
    FirebaseDatabaseHelper.removeSection(section);
  }

  void listenUpdates(CurrentUser user, String sectionId) {
    String topic = sectionId.replaceAll(" ", "").replaceAll("-", "");
    if(user.listenSections.contains(sectionId)) {
      user.listenSections.remove(sectionId);
      FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    } else {
      user.listenSections.add(sectionId);
      FirebaseMessaging.instance.subscribeToTopic(topic);
    }
    FirebaseDatabaseHelper.updateUser(user);
  }
}
