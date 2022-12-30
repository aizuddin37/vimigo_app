// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:vimigo_app/cubit/level_cubit.dart';

// class BodyView extends StatelessWidget {
//   const MyWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LevelCubit, LevelState>(
//       builder: (context, state) {
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               Container(
//                 width: double.infinity,
//                 child: Card(
//                   color: Colors.pinkAccent,
//                   child: SizedBox(
//                     width: double.infinity,
//                     height: 200,
//                     child: Padding(
//                       padding: EdgeInsets.all(10),
//                       child: Column(
//                         children: [
//                           Container(
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(15.0),
//                               border: Border.all(
//                                   style: BorderStyle.solid, width: 0.80),
//                             ),
//                             width: 350,
//                             child: Center(
//                               child: DropdownButtonFormField<String>(
//                                 isExpanded: true,
//                                 value: state.content,
//                                 icon: const Icon(Icons.arrow_drop_down_sharp,
//                                     color: Colors.blueAccent),
//                                 elevation: 16,
//                                 style: const TextStyle(color: Colors.black),
//                                 onChanged: (String? value) {
//                                   // This is called when the user selects an item.
//                                   setState(() {
//                                     var select = state.content;
//                                      select= value!;
//                                   });
//                                 },
//                                 items: state.level,
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           Row(
//                             children: [
//                               Text("1,000,000.00 Day(s)",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 25,
//                                       fontWeight: FontWeight.bold)),
//                               SizedBox(width: 50),
//                               Text("#0",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 25,
//                                       fontWeight: FontWeight.bold)),
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           Row(
//                             children: [
//                               Text("Current Sales Achievement",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w100)),
//                               SizedBox(width: 100),
//                               Text("Rank",
//                                   style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 15,
//                                       fontWeight: FontWeight.w100)),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Stack(
//                 children: [
//                   SingleChildScrollView(),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//     // This trailing comma makes auto-formatting nicer for build methods.
//   }
// }
