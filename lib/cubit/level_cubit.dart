import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:vimigo_app/cubit/app_state.dart';

import '../model/level.dart';
import '../service/LevelService.dart';

part 'level_state.dart';

class LevelCubit extends Cubit<LevelState> {
  late final List<Level>? level;

  LevelCubit({this.level})
      : super(LevelState(isLoading: false, isInitialize: false, level: [])) {
    init();
  }

  init() {
    _checkLevel();
    return Future.value();
  }

  Future _checkLevel() async {
    emit(state.copyWith(isLoading: true));
    List<Level>? level = await LevelService().checkLevel();
    if (level != null) {
      emit(state.copyWith(level: level, isLoading: false));

      print("the levels " + state.level.toString());
    } else {
      print(e);
    }
  }

  Future onLevelSelected(String levelchoosed) async {
    emit(state.copyWith(isLoading: true));
    if (levelchoosed == 'level 5' ||
        levelchoosed == 'level 4' ||
        levelchoosed == 'level 3' ||
        levelchoosed == 'level 2' ||
        levelchoosed == 'level 1') {
      var levelnum = int.parse(levelchoosed.substring(6, 7));

      for (int i = 0; i < levelnum; i++) {
        final updateSnapshot = FirebaseFirestore.instance
            .collection('levels')
            .doc('level ${levelnum - i}');

        updateSnapshot.update({
          'level_selected': true,
        });
      }
      emit(state.copyWith(isLoading: false));
    }

    emit(state.copyWith(isLoading: false));
  }

  void refresh() {
    emit(state.copyWith(isInitialize: false, isLoading: true));

    init();
  }
}
