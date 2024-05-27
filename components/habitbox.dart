import 'package:flutter/material.dart';
import '../data/globals.dart' as globals;

//Klase uznirstošajam logam uzdevuma izveidei, rediģēšanai
class habitNameBox extends StatelessWidget {
  habitNameBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.hintText,
    });

  final controller;
  final VoidCallback onSave;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            decoration: InputDecoration(hintText: hintText),
            ),
          SizedBox(height: 20),
          SizedBox(
            width: 300,
            child: categoryDropDown()
          ),
        ]
      ),
      actions: [
        MaterialButton(
          onPressed: onSave,
          color: Theme.of(context).colorScheme.secondaryContainer,
          child: Text("Save", style: TextStyle(color: Theme.of(context).colorScheme.onSecondaryContainer))
          ),
      ],
    );
  }
}

//Klase kategoriju izvēlnei
class categoryDropDown extends StatefulWidget {
  const categoryDropDown({super.key});

  @override
  State<categoryDropDown> createState() => _categoryDropDownState();
}

class _categoryDropDownState extends State<categoryDropDown> {

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: globals.selectedCategory, 
      items: globals.categoryOptions.map((item) => DropdownMenuItem<String>(
        value: item,
        child: Text(item)
        )).toList(),
        onChanged: (item) => setState(() => globals.selectedCategory = item!) 
      );
  }
}
