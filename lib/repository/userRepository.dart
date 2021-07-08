import 'package:controle_pacientes/auth/firebaseAuthHelper.dart';
import 'package:controle_pacientes/database/firebaseDatabaseHelper.dart';
import 'package:controle_pacientes/model/currentUser.dart';
import 'package:controle_pacientes/util/emailUtil.dart';
import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserRepository {
  void saveToken(String token) async {
    CurrentUser user = await FirebaseDatabaseHelper.getCurrentUser();
    user.pushToken = token;
    FirebaseDatabaseHelper.updateUser(user);
  }


  Future<String> signup(String name, String cpf, String email, String password, String confirmPassword) async {
    email = email.trim();
    name = name.trim();
    cpf = cpf.trim().replaceAll(".", "").replaceAll("-", "");


    if(name.isEmpty || name.length < 3) {
      return Future.value("Nome inválido");
    }

    if(cpf.isEmpty || !CPF.isValid(cpf)) {
      return Future.value("CPF inválido");
    }

    if(!EmailUtil.isValidEmail(email)) {
      return Future.value("Email inválido");
    }

    if(password.isEmpty || confirmPassword.isEmpty || password != confirmPassword) {
      return Future.value("Suas senhas não coincidem");
    }
    var authorized = await FirebaseDatabaseHelper.checkAuthorizedEmail(email);
    if(authorized) {
      return await FirebaseDatabaseHelper.singup(name, cpf, email, password);
    } else {
      return Future.value('Email não autorizado');
    }
  }

  bool checkHasUserLogged() {
    return FirebaseAuthHelper.checkHasUserLogged();
  }

  void logout() {
    FirebaseAuthHelper.logout();
  }

  Future<String> login(String email, String password) async {
    email = email.trim();

    if (email.isEmpty || !EmailUtil.isValidEmail(email)) {
      return Future.value("Email inválido");
    }

    if (password.isEmpty) {
      return Future.value("Senha inválida");
    }

    return FirebaseAuthHelper.login(email, password);
  }

  Future<String> sendForgotPassword(String email) async {
    email = email.trim();

    if(email.isEmpty || !EmailUtil.isValidEmail(email)) {
      return Future.value('Email inválido');
    }

    return await FirebaseAuthHelper.sendForgotPassword(email);
  }
}