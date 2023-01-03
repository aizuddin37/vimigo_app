import 'package:vimigo_app/model/level.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LevelService {
  List<Level> levelList = [];

  // Stream<List<Level>> readLevel() => FirebaseFirestore.instance
  //     .collection('levels')
  //     .snapshots()
  //     .map((snapshot) => snapshot.docs.map((doc) => Level.fromJson(doc.data())).toList());

  checkLevel() async {
    QuerySnapshot levelsSnapshot =
        await FirebaseFirestore.instance.collection('levels').get();

    levelsSnapshot.docs.forEach((document) {
      Level level = Level.fromMap(document.data() as Map<String, dynamic>);
      levelList.add(level);
    });

    print("levelList :" + levelList.toString());
    return this.levelList;
  }

  updateLevel() async {
    final updateSnapshot = FirebaseFirestore.instance
        .collection('levels')
        .doc('HMVUMd6qqfQDqjiMTvUn');

    updateSnapshot.update({
      'level_selected': true,
    });

    print("levelList : updated");
    return this.levelList;
  }
}
