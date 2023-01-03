import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:vimigo_app/cubit/level_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vimigo_app/model/level.dart';
import 'package:vimigo_app/service/LevelService.dart';
import 'package:vimigo_app/service/levelNotifier.dart';
import 'package:vimigo_app/shared/color-helper.dart';
import 'package:vimigo_app/shared/loadingcontroller.dart';

const List<String> list = <String>[
  'level 1',
  'level 2',
  'level 3',
  'level 4',
  'level 5'
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
  List levelLists = [];

  final LevelCubit _levelcube = LevelCubit();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<LevelCubit>(create: (context) => LevelCubit()..init()),
        Provider(create: (context) => LevelNotifier()),
      ],
      child: Scaffold(
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
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    width: double.infinity,
                    child: Card(
                      color: primaryColor,
                      child: SizedBox(
                        width: double.infinity,
                        height: 200,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: [
                              BlocBuilder<LevelCubit, LevelState>(
                                builder: (context, state) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(
                                          style: BorderStyle.solid,
                                          width: 0.80),
                                    ),
                                    width: 350,
                                    child: Center(
                                      child: DropdownButtonFormField<String>(
                                        isExpanded: true,
                                        value: dropdownValue,
                                        icon: const Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: Colors.blueAccent),
                                        elevation: 16,
                                        style: const TextStyle(
                                            color: Colors.black),
                                        onChanged: (String? value) {
                                          setState(() {
                                            dropdownValue = value!;
                                            print(dropdownValue);
                                          });
                                          context
                                              .read<LevelCubit>()
                                              .onLevelSelected(dropdownValue);
                                        },
                                        items: list
                                            .map<DropdownMenuItem<String>>(
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
                ),
                Expanded(
                  child: BlocBuilder<LevelCubit, LevelState>(
                    builder: (context, state) => RefreshIndicator(
                      onRefresh: () {
                        context.read<LevelCubit>().refresh();
                        return Future.value(true);
                      },
                      child: ListView.builder(
                        itemCount: state.level.length,
                        itemBuilder: (context, index) {
                          final level_stage = state.level.elementAt(index);

                          if (index == 1 || index == 3 || index == 5) {
                            return Card(
                              child: ListTile(
                                onTap: () {},
                                leading: InkWell(
                                  customBorder: CircleBorder(),
                                  onTap: () {
                                    level_stage.level_selected == true
                                        ? showBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SizedBox(
                                                height: 200,
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        width: double.infinity,
                                                        color: primaryColor,
                                                        child: Center(
                                                          child: Text('Detail',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      Text(
                                                          '${level_stage.level_name}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      SizedBox(height: 20),
                                                      Text(
                                                          '${level_stage.content}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('Exit',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                        : print(
                                            "Cannot show unhighlighted level");
                                  },
                                  child: Card(
                                    color: level_stage.level_selected
                                        ? lightYellow
                                        : Colors.white,
                                    shape: CircleBorder(),
                                    elevation: 3,
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: state.isLoading
                                          ? LoadingController(
                                              size: 15,
                                              color: level_stage.level_selected
                                                  ? Colors.black
                                                  : null)
                                          : Icon(
                                              Icons.star,
                                              color: level_stage.level_selected
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                    ),
                                  ),
                                ),
                                title: Text('${level_stage.level_name} '),
                                subtitle:
                                    Text('content: ${level_stage.content}'),
                              ),
                            );
                          } else {
                            return Card(
                              child: ListTile(
                                trailing: InkWell(
                                  customBorder: CircleBorder(),
                                  onTap: () {
                                    level_stage.level_selected == true
                                        ? showBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return SizedBox(
                                                height: 200,
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        width: double.infinity,
                                                        color: primaryColor,
                                                        child: Center(
                                                          child: Text('Detail',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                        ),
                                                      ),
                                                      SizedBox(height: 20),
                                                      Text(
                                                          '${level_stage.level_name}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      SizedBox(height: 20),
                                                      Text(
                                                          '${level_stage.content}',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text('Exit',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            })
                                        : print(
                                            "Cannot show unhighlighted level");
                                  },
                                  child: Card(
                                    color: level_stage.level_selected
                                        ? lightYellow
                                        : Colors.white,
                                    shape: CircleBorder(),
                                    elevation: 3,
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: state.isLoading
                                          ? LoadingController(
                                              size: 15,
                                              color: level_stage.level_selected
                                                  ? Colors.white
                                                  : null)
                                          : Icon(
                                              Icons.star,
                                              color: level_stage.level_selected
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                    ),
                                  ),
                                ),
                                title: Text('${level_stage.level_name} '),
                                subtitle:
                                    Text('content: ${level_stage.content}'),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future<void> refresh() async {
    context.read<LevelCubit>().init();
  }
}
