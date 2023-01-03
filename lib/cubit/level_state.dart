part of 'level_cubit.dart';

class LevelState extends AppState {
  final List<Level> level;

  LevelState(
      {required bool isLoading,
      required bool isInitialize,
      required this.level})
      : super(isLoading: isLoading, isInitialize: isInitialize);

  @override
  copyWith(
      {bool? isLoading,
      bool? isInitialize,
      bool? level_selected,
      List<Level>? level}) {
    return LevelState(
        isLoading: isLoading ?? this.isLoading,
        isInitialize: isInitialize ?? this.isInitialize,
        level: level ?? this.level);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, isInitialize, level];

  popUpDialog({bool? isLoading}) => SheetState(
      isInitialize: isInitialize,
      isLoading: isLoading ?? this.isLoading,
      level: level);
}

class SheetState extends LevelState {
  SheetState(
      {required bool isLoading,
      required bool isInitialize,
      required List<Level> level})
      : super(isLoading: isLoading, isInitialize: isInitialize, level: level);
}
