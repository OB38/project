import 'package:flutter/material.dart';

//Klase jauna uzdevuma pievienošanas pogai
class newHabitButton extends StatelessWidget {
  const newHabitButton({
    super.key, 
    required this.onPressed,
    });

  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Icon(Icons.add),
      );
  }
}
