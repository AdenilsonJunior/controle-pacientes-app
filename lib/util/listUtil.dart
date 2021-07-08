class ListUtil {

  ListUtil._();

  static List<String> parseToListString(List<dynamic> list) {
    if (list != null && list.isNotEmpty) {
      return list.map((e) => e as String).toList(growable: true);
    } else  {
      return List.empty(growable: true);
    }
  }
}