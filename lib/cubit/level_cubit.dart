import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:vimigo_app/cubit/app_state.dart';

import '../model/level.dart';

part 'level_state.dart';

class LevelCubit extends Cubit<LevelState> {
  final List<Level>? level;
  LevelCubit({this.level})
      : super(LevelState(
            isLoading: false, isInitialize: false, level_selected: false)) {
    init();
  }

  init() {
    if (level != null) {
      _checkLevel();
    } else {
      print('no data gotten');
    }
  }

  void _checkLevel() {
    emit(state.copyWith(level_selected: level?.isNotEmpty));
  }
}
