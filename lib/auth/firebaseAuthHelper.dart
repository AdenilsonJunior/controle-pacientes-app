import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthHelper {
  FirebaseAuthHelper._();

  static bool checkHasUserLogged() {
    return FirebaseAuth.instance.currentUser != null;
  }

  static void logout() {
    FirebaseAuth.instance.signOut();
  }

  static Future<String> login(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return Future.value("Sucesso");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Future.value("Usuário não encontrado");
      } else if (e.code == 'wrong-password') {
        return Future.value("Senha incorreta");
      } else {
        return Future.value("Tente novamente mais tarde");
      }
    }
  }

  static Future<String> sendForgotPassword(String email) async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    return Future.value("Um link foi enviado ao email informado");
  }
}
