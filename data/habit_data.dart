import 'package:habit_tracker/data/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

final db = Hive.box("Habit_data");

//Saraksts ar visiem uzdevumiem
class HabitData {
  //habitName, habitCompleted, habitCategory
  List habitList = [];
  //Kopa siltuma kartes veidošanai
  Map<DateTime, int> heatMapDataSet = {};

  /*Funkcija paraugdatu izveidošanai, ja nav iepriekšējo 
  datu jeb aplikācija atvērta pirmo reizi*/
  void createData() {
    habitList = [
      ["Coffee", false, "Energy"],
      ["Running", false, "Strength"],
      ["Study", false, "Intelligence"],
    ];

    /*Programmatūras pirmās palaišanas datums,
    pirmais datums siltuma kartei*/
    db.put("Start_date", todaysDateFormatted());
  }

  //Funkcija datu ielādei, esošo uzdevumu atgriešanai
  void loadData() {
    /*Ja jauna diena, atiestata izpildītos uzdevumus
    uz neizpildītiem*/
    if(db.get(todaysDateFormatted()) == null) {
      habitList = db.get("Current_habit_list");
      for (int i = 0; i < habitList.length; i++) {
        habitList[i][1] = false;
      }
    }
    else {
      habitList = db.get(todaysDateFormatted());
    }
  }

  //Funkcija datu atjaunināšanai pēc datu ievades vai izmaiņām
  void updateData() {
    db.put(todaysDateFormatted(), habitList);
    db.put("Current_habit_list", habitList);
    habitCompletionPercentage();
    loadHeatMap();
  }

  //Funkcija uzdevumu izpildes aprēķināšanai
  void habitCompletionPercentage() {
    int completedCount = 0;
    for (int i = 0; i < habitList.length; i++) {
      if (habitList[i][1] == true) {
        completedCount++;
      }
    }

    String completedPercentage = 
    habitList.isEmpty ? '0.0'
    : (completedCount / habitList.length).toStringAsFixed(1);

    //Saglabā konkrētās dienas izpildīto uzdevumu attiecību
    db.put("Percentage_summary_${todaysDateFormatted()}", completedPercentage);
  }

  //Funkcija siltuma kartes ielādei
  void loadHeatMap() {
    //Datums, no kura sākas siltuma karte
    DateTime startDate = createDateTimeObject(db.get("Start_date"));
    int daysSinceStart = DateTime.now().difference(startDate).inDays;


    for (int i = 0; i < daysSinceStart + 1; i++) {
      String yyyymmdd = convertDateTimeToString(startDate.add(Duration(days: i)));

      //Siltuma kartes lauciņa spilgtums
      double heatPercent = double.parse(db.get("Percentage_summary_$yyyymmdd") ?? "0.0");

      //Katrs lauciņš kopš sākuma datuma
      int year = startDate.add(Duration(days: i)).year;

      int month = startDate.add(Duration(days: i)).month;

      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day) : (10 * heatPercent).toInt(),
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
    }
  }
}
