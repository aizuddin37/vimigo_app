import 'package:vimigo_app/model/level.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LevelService {
  List<Level> levelList = [];

  // Stream<List<Level>> readLevel() => FirebaseFirestore.instance
  //     .collection('levels')
  //     .snapshots()
  //     .map((snapshot) => snapshot.docs.map((doc) => Level.fromJson(doc.data())).toList());

  checkLevel() async {
    final levelsSnapshot = await FirebaseFirestore.instance
        .collection('levels')
        .get()
        .then((snapshot) => snapshot.docs.forEach((element) {
              print(element.data());
            }));

    try {
      for (var element in levelList) {
        final values = levelsSnapshot as Map<dynamic, dynamic>;
        values.forEach((key, values) {
          levelList.add(Level.fromMap(values));
        });
        return levelList;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
