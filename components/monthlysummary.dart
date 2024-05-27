import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import '../data/date_time.dart';

//Klase siltuma kartes grafika veidošanai
class MonthlySummary extends StatelessWidget {
  final Map<DateTime, int>? datasets;
  final String startDate;

  const MonthlySummary({
    super.key,
    required this.datasets,
    required this.startDate,
  });

  //Grafika formatējums
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(30),
          child: HeatMap(
            startDate: createDateTimeObject(startDate),
            endDate: DateTime.now().add(Duration(days: 0)),
            datasets: datasets,
            colorMode: ColorMode.color,
            defaultColor: Colors.grey[200],
            textColor: Colors.black,
            showColorTip: false,
            showText: true,
            scrollable: true,
            size: 50,
            colorsets: const {
              1: Color.fromARGB(20, 2, 179, 8),
              2: Color.fromARGB(40, 2, 179, 8),
              3: Color.fromARGB(60, 2, 179, 8),
              4: Color.fromARGB(80, 2, 179, 8),
              5: Color.fromARGB(100, 2, 179, 8),
              6: Color.fromARGB(120, 2, 179, 8),
              7: Color.fromARGB(150, 2, 179, 8),
              8: Color.fromARGB(180, 2, 179, 8),
              9: Color.fromARGB(220, 2, 179, 8),
              10: Color.fromARGB(255, 2, 179, 8),
            },
          ),
        ),
      ],
    );
  }
}
