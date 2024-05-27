import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../data/habit_data.dart';
import '../data/globals.dart' as globals;
import '../components/habitbox.dart';
import '../components/habittile.dart';
import '../components/newhabitbutton.dart';


//Klase "Habits" lapai
class HabitsPage extends StatefulWidget {
  const HabitsPage({super.key});

  @override
  State<HabitsPage> createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {

  HabitData data = HabitData();
  final db = Hive.box("Habit_Data");
  final habitNameController = TextEditingController();
  bool habitCompleted = false;

  //Atverot lapu tiek ielādēti dati no datubāzes
  @override
  void initState() {
    /*Ja nav iepriekšējo datu jeb aplikācija atvērta pirmo 
    reizi, tiek izveidoti paraugdati*/
    if (db.get("Current_habit_list") == null) {
      data.createData();
    }
    else {
      data.loadData();
    }

    data.updateData();
    super.initState();
  }

  //Funkcija uzdevuma izpildei
  void checkBoxChanged(bool? value, int index) {
    setState((){
      data.habitList[index][1] = value;
    });
    data.updateData();
  }

  //Funkcija jauna uzdevuma izveidei
  void createNewHabit() {
    showDialog(
      context: context, 
      builder: (context) {
        return habitNameBox(
          controller: habitNameController,
          onSave: saveNewHabit, 
          hintText: "Enter habit name here",
        );
    },);
  }

  //Funkcija jaunā uzdevuma saglabāšanai
  void saveNewHabit() {
    setState((){
      data.habitList.add([habitNameController.text, false, globals.selectedCategory]);
    });
    data.updateData();
    habitNameController.clear();
    Navigator.of(context).pop();
    globals.selectedCategory = globals.categoryOptions[0];
  }

  //Funkcija uzdevuma rediģēšanai
  void editHabit(int index) {
    showDialog(context: context, builder: (context) {
      return habitNameBox(
        controller: habitNameController,
        onSave: () => saveEditedHabitName(index),
        hintText: data.habitList[index][0], 
      );
    },);
  }

  //Funkcija rediģētā uzdevuma saglabāšanā
  void saveEditedHabitName(int index) {
    setState(() {
      data.habitList[index][0] = habitNameController.text;
      data.habitList[index][2] = globals.selectedCategory;
    });
    data.updateData();
    habitNameController.clear();
    Navigator.of(context).pop();
    globals.selectedCategory = globals.categoryOptions[0];

  }

  //Funkcija uzdevuma dzēšanai
  void deleteHabit(int index) {
    setState(() {
      data.habitList.removeAt(index);
    });
    data.updateData();
  }

  //"Habits" lapas uzbūve
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: newHabitButton(
        onPressed: createNewHabit,
      ),
      body: ListView(
        children: [
          for (var category in globals.categoryOptions)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (category != 'Select a category')
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(category, style: DefaultTextStyle.of(context).style.apply(
                  fontSizeFactor: 1.5, 
                  fontWeightDelta: 3,
                  color: Theme.of(context).colorScheme.primary,
                )),
              ),
              if(category == 'Select a category')
              Padding(
                padding: EdgeInsets.all(8),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: data.habitList.length,
                itemBuilder: (context, index) {
                  if(data.habitList[index][2] == category) {
                    return HabitTile(
                    habitName: data.habitList[index][0],
                    habitCompleted: data.habitList[index][1],
                    habitCategory: data.habitList[index][2],
                    onChanged: (value) => checkBoxChanged(value, index), 
                    editHabitPressed: () => editHabit(index),
                    deleteHabitPressed: () => deleteHabit(index),
                  );
                  }else{return SizedBox(height: 0);}
                },
              ),
              Divider(
                color: Theme.of(context).colorScheme.secondary,
                thickness: 5,
                indent: 5,
                endIndent: 5,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
