import 'package:controle_pacientes/forgot/forgotPasswordScreen.dart';
import 'package:controle_pacientes/repository/userRepository.dart';
import 'package:controle_pacientes/section/sectionListScreen.dart';
import 'package:controle_pacientes/signup/signupScreen.dart';
import 'package:controle_pacientes/util/imageUtil.dart';
import 'package:controle_pacientes/view/rowInputValue.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  UserRepository _userRepository = UserRepository();

  TextEditingController _emailController;
  TextEditingController _passwordController;

  void initControllers() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    initControllers();

    return Scaffold(
      appBar: AppBar(
        title: Text('Controle de Pacientes'),
        actions: [
          TextButton(onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SignupScreen()));
          }, child: Text('CRIAR CONTA', style: TextStyle(color: Colors.white),))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 46.0, bottom: 36),
                      child: Image.asset(ImageUtil.image_santacasa_url),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: RowInputValue(
                        _emailController,
                        "Email:",
                        align: TextAlign.start,
                        inputType: TextInputType.emailAddress,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 16.0, right: 16.0, top: 12.0),
                      child: RowInputValue(
                        _passwordController,
                        "Senha:",
                        align: TextAlign.start,
                        isObscured: true,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 36.0, right: 36.0, top: 48.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text("Entrar"),
                          onPressed: () async {
                            showLoading(context);
                            String result = await _userRepository.login(
                                _emailController.text, _passwordController.text);
                            Navigator.pop(context);
                            if (result == "Sucesso") {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SectionListScreen()),
                                  (route) => false);
                            } else {
                              showAlertDialogWithResult(context, result);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 16.0, right: 16.0, top: 24.0, bottom: 64.0),
                      child: TextButton(
                        child: Text(
                          "Esqueci minha senha",
                          style: TextStyle(decoration: TextDecoration.underline),
                        ),
                        onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLoading(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 45,
                      height: 45,
                      child: CircularProgressIndicator()),
                ],
              ),
            ),
        barrierDismissible: false);
  }

  void showAlertDialogWithResult(BuildContext context, String result) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Erro"),
              content: Text(result),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context), child: Text("OK"))
              ],
            ));
  }
}
