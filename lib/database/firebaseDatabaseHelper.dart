import 'package:controle_pacientes/model/currentUser.dart';
import 'package:controle_pacientes/model/multidisciplinaryVisit.dart';
import 'package:controle_pacientes/model/notification.dart';
import 'package:controle_pacientes/model/patient.dart';
import 'package:controle_pacientes/model/section.dart';
import 'package:controle_pacientes/model/therapeuticPlanning.dart';
import 'package:controle_pacientes/util/dateUtil.dart';
import 'package:controle_pacientes/util/listUtil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:intl/intl.dart';

class FirebaseDatabaseHelper {
  var _url = "https://controle-pacientes-tcc-default-rtdb.firebaseio.com/";

  static var _patientsChild = "patients";
  static var _therapeuticPlanning = "therapeuticPlannings";
  static var _multidisciplinaryVisit = "multidisciplinaryVisit";
  static var _authorizedEmails = "authorizedEmails";
  static var _users = "users";
  static var _section = "section";
  static var _notifications = "notifications";

  FirebaseDatabaseHelper._();

  static Future<DataSnapshot> getPatients(Section section) async {
    return FirebaseDatabase.instance
        .reference()
        .child(_section)
        .child(section.id)
        .child(_patientsChild)
        .reference()
        .once();
  }

  static Future<DataSnapshot> getTherapeuticPlanningsByPatient(
      Patient patient) async {
    return FirebaseDatabase.instance
        .reference()
        .child(_section)
        .child(patient.sectionId)
        .child(_patientsChild)
        .child(patient.cpf)
        .child(_therapeuticPlanning)
        .reference()
        .once();
  }

  static Future<void> saveTherapeuticPlanning(
      TherapeuticPlanning planning) async {
    FirebaseDatabase.instance
        .reference()
        .child(_section)
        .child(planning.patient.sectionId)
        .child(_patientsChild)
        .child(planning.patient.cpf)
        .child(_therapeuticPlanning)
        .child(planning.id)
        .set(planning.toJson());
  }

  static Future<void> saveVisit(
      TherapeuticPlanning planning, MultidisciplinaryVisit visit) async {
    var visitReference = FirebaseDatabase.instance
        .reference()
        .child(_section)
        .child(planning.patient.sectionId)
        .child(_patientsChild)
        .child(planning.patient.cpf)
        .child(_therapeuticPlanning)
        .child(planning.id)
        .child(_multidisciplinaryVisit);

    if (visit.id == null || visit.id.isEmpty) {
      visit.id = visitReference.push().key;
    }

    visit.createdAt = DateTime.now().millisecondsSinceEpoch;

    visitReference.child(visit.id).set(visit.toJson());

    String title = "Visita Multidisciplinar Encerrada";
    String hour = DateUtil.getCurrentTime(DateTime.now());
    String message = "A visita de " + planning.patient.name + " foi feita por " + visit.responsible + " às " + visit.date + " " + hour;

    sendNotification(title, message, planning.patient.sectionId);
  }

  static Future<CurrentUser> getCurrentUser() async {
    DataSnapshot dataSnapShot = await FirebaseDatabase.instance
        .reference()
        .child(_users)
        .orderByChild("uid")
        .equalTo(FirebaseAuth.instance.currentUser.uid)
        .once();

    return CurrentUser.fromJson(
        (dataSnapShot.value as Map<dynamic, dynamic>).values.elementAt(0));
  }

  static void updateUser(CurrentUser currentUser) {
    FirebaseDatabase.instance
        .reference()
        .child(_users)
        .child(currentUser.cpf)
        .set(currentUser.toJson());
}

  static Future<TherapeuticPlanning> createTherapeuticPlanning(
      Patient patient) async {
    TherapeuticPlanning planning = TherapeuticPlanning.newInstance();
    planning.createdAt = DateTime.now().millisecondsSinceEpoch;

    var currentUser = await getCurrentUser();

    var reference = FirebaseDatabase.instance
        .reference()
        .child(_section)
        .child(patient.sectionId)
        .child(_patientsChild)
        .child(patient.cpf)
        .child(_therapeuticPlanning)
        .push();
    var id = reference.key;

    planning.id = id;
    planning.patient = patient;
    planning.responsible = currentUser.name;
    reference.set(planning.toJson());

    return planning;
  }

  static Future<void> removeTherapeuticPlanning(
      TherapeuticPlanning planning) async {
    FirebaseDatabase.instance
        .reference()
        .child(_section)
        .child(planning.patient.sectionId)
        .child(_patientsChild)
        .child(planning.patient.cpf)
        .child(_therapeuticPlanning)
        .child(planning.id)
        .set(null);
  }

  static Future<DataSnapshot> getTherapeuticPlanning(
      TherapeuticPlanning planning) async {
    return FirebaseDatabase.instance
        .reference()
        .child(_section)
        .child(planning.patient.sectionId)
        .child(_patientsChild)
        .child(planning.patient.cpf)
        .child(_therapeuticPlanning)
        .child(planning.id)
        .once();
  }

  static Future<void> removeVisit(
      TherapeuticPlanning planning, MultidisciplinaryVisit visit) async {
    FirebaseDatabase.instance
        .reference()
        .child(_section)
        .child(planning.patient.sectionId)
        .child(_patientsChild)
        .child(planning.patient.cpf)
        .child(_therapeuticPlanning)
        .child(planning.id)
        .child(_multidisciplinaryVisit)
        .child(visit.id)
        .set(null);
  }

  static Future<String> singup(
      String name, String cpf, String email, String password) async {
    try {
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      var messaging = FirebaseMessaging.instance;
      var token = await messaging.getToken();
      CurrentUser user = CurrentUser(credential.user.uid, name, cpf, email, token);

      FirebaseDatabase.instance
          .reference()
          .child(_users)
          .child(cpf)
          .set(user.toJson());

      return Future.value("Usuário criado com sucesso");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Future.value('Senha muito fraca');
      } else if (e.code == 'email-already-in-use') {
        return Future.value('O email já está em uso');
      }
    } catch (e) {
      return Future.value("Erro desconhecido");
    }
  }

  static Future<bool> checkAuthorizedEmail(String email) async {
    DataSnapshot snapshot = await FirebaseDatabase.instance
        .reference()
        .child(_authorizedEmails)
        .once();
    List<String> emails = ListUtil.parseToListString(snapshot.value);

    return emails.contains(email.toLowerCase());
  }

  static Future<DataSnapshot> getSections() async {
    return await FirebaseDatabase.instance.reference().child(_section).once();
  }

  static Future<bool> addSection(String name, String date, String time) async {
    try {

      if(name.isEmpty) {
        return Future.value(false);
      }

      if(time.length != 5) {
        return Future.value(false);
      }

      if(date.length != 10) {
        return Future.value(false);
      }
      DateFormat dateFormat = DateFormat('dd-MM-yyyy');
      DateTime dateTime = dateFormat.parse(date);

      CurrentUser currentUser = await getCurrentUser();

      Section section = Section.newInstance(
          name, date, currentUser.name, dateTime.millisecondsSinceEpoch, time);

      FirebaseDatabase.instance
          .reference()
          .child(_section)
          .child(section.id)
          .set(section.toJson());
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
  }

  static void removeSection(Section section) {
    FirebaseDatabase.instance
        .reference()
        .child(_section)
        .child(section.id)
        .set(null);
  }

  static Future<void> addPatient(Patient patient) async {
    return await FirebaseDatabase.instance
        .reference()
        .child(_section)
        .child(patient.sectionId)
        .child(_patientsChild)
        .child(patient.cpf)
        .set(patient.toJson());
  }

  static void removePatient(Patient patient) {
    FirebaseDatabase.instance
        .reference()
        .child(_section)
        .child(patient.sectionId)
        .child(_patientsChild)
        .child(patient.cpf)
        .set(null);
  }

  static void sendNotification(String title, String message, sectionId) {
    Notification notification = Notification(sectionId.replaceAll(" ", "").replaceAll("-", ""), title, message);

    FirebaseDatabase.instance.reference()
        .child(_notifications)
        .push()
        .set(notification.toJson());
  }
}
