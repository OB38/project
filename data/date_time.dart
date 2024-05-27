//Datuma formatēšana uz formātu yyyymmdd
String todaysDateFormatted() {
  //Šodienas datums
  var dateTimeObject = DateTime.now();

  //Gads => yyyy
  String year = dateTimeObject.year.toString();

  //Mēnesis => mm
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  //Diena => dd
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  //Parformatētais datums
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}

//Pārvērst yyyymmdd fromatējumu uz DateTime objektu
DateTime createDateTimeObject(String yyyymmdd) {
  int yyyy = int.parse(yyyymmdd.substring(0, 4));
  int mm = int.parse(yyyymmdd.substring(4, 6));
  int dd = int.parse(yyyymmdd.substring(6, 8));

  DateTime dateTimeObject = DateTime(yyyy, mm, dd);
  return dateTimeObject;
}

//Pārvērst DateTime objektu uz yyyymmdd formatējumu
String convertDateTimeToString(DateTime dateTime) {
  //Gads => yyyy
  String year = dateTime.year.toString();

  //Mēnesis => mm
  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  //Diena => dd
  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  //Pārformatētais datums
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}
