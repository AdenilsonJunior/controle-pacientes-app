import 'package:intl/intl.dart';

class DateUtil {

  DateUtil._();

  static String getDateFormatted(DateTime dateTime) {
    String day;
    String month;
    String year = dateTime.year.toString();

    if (dateTime.day < 10) {
      day = '0' + dateTime.day.toString();
    } else {
      day = dateTime.day.toString();
    }

    if (dateTime.month < 10) {
      month = '0' + dateTime.month.toString();
    } else {
      month = dateTime.month.toString();
    }

    return day + "/" + month + "/" + year;
  }

  static String getCurrentTime(DateTime date) {
    return DateFormat.Hm().format(date);
  }
}
