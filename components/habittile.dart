import 'package:flutter/material.dart';

//Klase uzdevuma formatējumam sarakstā ar pogām
class HabitTile extends StatelessWidget {
  const HabitTile({
    super.key, 
    required this.habitName, 
    required this.habitCompleted,
    required this.habitCategory, 
    required this.onChanged,
    required this.editHabitPressed,
    required this.deleteHabitPressed,
    });

  final String habitName;
  final bool habitCompleted;
  final String habitCategory;
  final Function(bool?)? onChanged;
  final void Function()? editHabitPressed;
  final void Function()? deleteHabitPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      //Atzīmēšanas kastīte ar uzdevuma nosaukumu
                      Checkbox(
                        value: habitCompleted,
                        onChanged: onChanged
                        ),
                      Text(habitName),
                      ],
                    ),
                  ),
                ),
              SizedBox(width:2),
              //Uzdevuma rediģēšanas poga
              SizedBox(
                height: 72,
                width: 72,
                child: IconButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        )
                      ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Theme.of(context).colorScheme.secondary,
                        )
                    ),
                  onPressed: editHabitPressed, 
                  icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.onSecondary),
                  ),
                ),
              SizedBox(width:2),
              //Uzdevuma dzēšanas poga
              SizedBox(
                height: 72,
                width: 72,
                child: IconButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        )
                      ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 156, 67, 60),
                        )
                      ),
                onPressed: deleteHabitPressed, 
                icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.onSecondary),
                ),
              ),
            ], 
          ),
        ),
      SizedBox(height: 10),
      ],
    );
  }
} 
