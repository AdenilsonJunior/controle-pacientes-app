import 'package:controle_pacientes/patientList/patientListScreen.dart';
import 'package:controle_pacientes/repository/userRepository.dart';
import 'package:controle_pacientes/section/sectionListScreen.dart';
import 'package:controle_pacientes/view/rowInputValue.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class SignupScreen extends StatelessWidget {

  UserRepository _repository = UserRepository();

  MaskTextInputFormatter cpfFormatter = MaskTextInputFormatter(mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});

  TextEditingController _nameController;
  TextEditingController _cpfController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;

  void initControllers() {
    _nameController = TextEditingController();
    _cpfController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    initControllers();
    return Scaffold(
      appBar: AppBar(
        title: Text("Criar Conta"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: RowInputValue(
                  _nameController, "Nome:", inputType: TextInputType.name,
                  align: TextAlign.start,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: RowInputValue(
                  _cpfController, "CPF:", inputType: TextInputType.number,
                  align: TextAlign.start,
                formatter: cpfFormatter,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: RowInputValue(_emailController, "Email:",
                  inputType: TextInputType.emailAddress, align: TextAlign.start,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: RowInputValue(
                  _passwordController, "Senha:", align: TextAlign.start,
                  isObscured: true,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                child: RowInputValue(
                  _confirmPasswordController, "Confirme a senha:",
                  align: TextAlign.start, isObscured: true,),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 48.0, right: 36.0, left: 36.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text("Criar"),
                    onPressed: () async {
                      String result = await _repository.signup(
                          _nameController.text,
                          cpfFormatter.getUnmaskedText(),
                          _emailController.text,
                          _passwordController.text,
                          _confirmPasswordController.text
                      );
                        showMessage(context, result);
                    },
                  ),
                ),)
            ],
          ),
        ),
      ),
    );
  }

  void showMessage(BuildContext context, String result) {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text("Criar conta"),
        content: Text(result),
        actions: [
          TextButton(onPressed: () {
            Navigator.pop(context);
            if(result == "Usuário criado com sucesso") {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SectionListScreen()), (route) => false);
            }
          }, child: Text('OK'))
        ],
      ));
  }
}
