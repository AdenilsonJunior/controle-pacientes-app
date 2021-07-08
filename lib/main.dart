import 'package:controle_pacientes/login/loginScreen.dart';
import 'package:controle_pacientes/repository/userRepository.dart';
import 'package:controle_pacientes/util/imageUtil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:controle_pacientes/section/sectionListScreen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureNotifications();
  runApp(MyApp());
}

void configureNotifications() async {
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>();

  FirebaseMessaging.onMessage.listen((message) {
    RemoteNotification notification = message.notification;

    if (notification != null) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            iOS: IOSNotificationDetails(),
            android: AndroidNotificationDetails(
                channel.id, channel.name, channel.description,
                priority: Priority.high,
                importance: Importance.max,
                icon: "mipmap/ic_launcher",
                styleInformation: BigTextStyleInformation('')),
          ));
    }
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error", textDirection: TextDirection.ltr);
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return App();
        }

        return Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.white),
          child: Center(
            child: SizedBox(width: 80, height: 80, child: SizedBox(
              width: 300,
              height: 300,
              child: Padding(
                padding: const EdgeInsets.only(top: 46.0, bottom: 36),
                child: Image.asset(ImageUtil.image_santacasa_url),
              ),
            )),
          ),
        );
      },
    );
  }
}

class App extends StatelessWidget {
  UserRepository _repository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Controle de pacientes",
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.teal,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  primary: Colors.teal,
                  textStyle: TextStyle(color: Colors.white, fontSize: 16.0)))),
      home: checkHasUserLogged(),
    );
  }

  Widget checkHasUserLogged() {
    var logged = _repository.checkHasUserLogged();
    if (logged) {
      return SectionListScreen();
    } else {
      return LoginScreen();
    }
  }
}
