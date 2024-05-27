import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/habit_data.dart';
import '../components/monthlysummary.dart';

HabitData data = HabitData();
final db = Hive.box("Habit_data");

//Klase siltuma kartei statistikas lapā
class HeatMap extends StatefulWidget {
  const HeatMap({super.key});

  @override
  State<HeatMap> createState() => _HeatMapState();
}

class _HeatMapState extends State<HeatMap> {

  @override
  void initState() {
    data.loadData();
    data.updateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListView(
          children:[
          //Iegūtā siltuma karte
          MonthlySummary(
            datasets: data.heatMapDataSet,
            startDate: db.get("Start_date"),
          )
          ]
          ),
      )
    );
  }
}
