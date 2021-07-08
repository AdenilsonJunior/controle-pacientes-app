import 'package:controle_pacientes/repository/userRepository.dart';
import 'package:controle_pacientes/view/rowInputValue.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatelessWidget {
  UserRepository _repository = UserRepository();

  TextEditingController _emailController;

  void initControllers() {
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    initControllers();

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Esqueci minha senha",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: RowInputValue(
                      _emailController,
                      "Email:",
                      align: TextAlign.start,
                    ),
                  ))
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          child: Text("Enviar"),
                          onPressed: () async {
                            String result = await _repository
                                .sendForgotPassword(_emailController.text);
                            if (result ==
                                "Um link foi enviado ao email informado") {
                              showSuccessDialog(context, result);
                            } else {
                              showErrorDialog(context, result);
                            }
                          },
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  void showSuccessDialog(BuildContext context, String result) {
    showAlertDialog(context, "Sucesso", result);
  }

  void showErrorDialog(BuildContext context, String result) {
    showAlertDialog(context, "Erro", result);
  }

  void showAlertDialog(BuildContext context, String title, String content) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                TextButton(
                    onPressed: () {
                      if (title == "Sucesso") {
                        Navigator.pop(context);
                      }
                      Navigator.pop(context);
                    },
                    child: Text("OK"))
              ],
            ));
  }
}
