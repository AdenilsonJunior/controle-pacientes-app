import 'package:controle_pacientes/model/currentUser.dart';
import 'package:controle_pacientes/model/section.dart';

class SectionVM {
  List<Section> sections;
  CurrentUser user;

  SectionVM(this.user, this.sections);
}