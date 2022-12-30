import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:vimigo_app/cubit/level_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimigo_app/model/level.dart';
import 'package:vimigo_app/service/LevelService.dart';

const List<String> list = <String>[
  'Level 1',
  'Level 2',
  'Level 3',
  'Level 4',
  'Level 5'
];
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String dropdownValue = list.first;
  Level datalevel = Level();
  List<Level> levelLists = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    dynamic result = await LevelService().checkLevel();

    if (result == null) {
      print('Unable to retrieve');
    } else {
      setState(() {
        levelLists = result;
      });
      print(levelLists);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              Center(
                  child: Text("VIMISALES",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Card(
                  color: Colors.pinkAccent,
                  child: SizedBox(
                    width: double.infinity,
                    height: 200,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          BlocProvider(
                            create: (context) => LevelCubit(),
                            child: BlocBuilder<LevelCubit, LevelState>(
                              builder: (context, state) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    border: Border.all(
                                        style: BorderStyle.solid, width: 0.80),
                                  ),
                                  width: 350,
                                  child: Center(
                                    child: DropdownButtonFormField<String>(
                                      isExpanded: true,
                                      value: state.,
                                      icon: const Icon(
                                          Icons.arrow_drop_down_sharp,
                                          color: Colors.blueAccent),
                                      elevation: 16,
                                      style:
                                          const TextStyle(color: Colors.black),
                                      onChanged: (String? value) {
                                        // This is called when the user selects an item.
                                        setState(() {
                                          dropdownValue = value!;
                                        });
                                      },
                                      items: list.map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text("1,000,000.00 Day(s)",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(width: 50),
                              Text("#0",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text("Current Sales Achievement",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w100)),
                              SizedBox(width: 100),
                              Text("Rank",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w100)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Stack(
                children: [
                  SingleChildScrollView(),
                ],
              ),
            ],
          ),
        ));
  }
}
