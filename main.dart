import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../pages/habitspage.dart';
import '../pages/statisticspage.dart';

//Datubāzes ielāde atverot aplikāciju
void main() async {
  await Hive.initFlutter();
  await Hive.openBox("Habit_Data");

  runApp(const MyApp());
}

//Aplikācijas klase
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LPISR',
      home: StartPage(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF00FF00)),
        primarySwatch: Colors.green,
      ),
    );
  }
}

//Sākumlapas klase
class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {

  var selectedPage = 0;

  /*Lapas izvēle atkarība no noklikšķinātās pogas
  kreisajā malā*/
  @override
  Widget build(BuildContext context) {

    Widget page;
    switch(selectedPage) {
      case 0:
        page = Placeholder(); //Turētājs "Home" lapai
        break;
      case 1:
        page = Placeholder(); //Turētājs "Profile" lapai
        break;
      case 2:
        page = HabitsPage(); //"Habits" lapa
        break;
      case 3:
        page = HeatMap(); //Grafiskais attēlojums "Statistics" lapā
        break;
      case 4:
        page = Placeholder(); //Turētājs "Calendar" laipai
        break;
      default:
        throw UnimplementedError('no widget for &selectedPage');
    }

//Sākumlapas uzbūve
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              //Kreisās malas uzbūve
              SafeArea(
                child: NavigationRail(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  indicatorColor: Theme.of(context).colorScheme.secondaryContainer,
                  extended: constraints.maxWidth >= 600,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.face),
                      label: Text('Profile'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.workspace_premium),
                      label: Text('Habits'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.trending_up),
                      label: Text('Statistics'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.event),
                      label: Text('Calendar'),
                    ),
                  ],
                  selectedIndex: selectedPage,
                  onDestinationSelected: (value) {
                    setState((){
                      selectedPage = value;
                    });
                  },
                ),
              ),
              //Visa pārējā zona, kas satur atvērto lapu
              Expanded(
                child: Container(
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
