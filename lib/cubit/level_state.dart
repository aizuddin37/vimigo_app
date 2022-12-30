part of 'level_cubit.dart';

class LevelState extends AppState {
  final bool? level_selected;

  LevelState(
      {required bool isLoading,
      required bool isInitialize,
      required this.level_selected})
      : super(isLoading: isLoading, isInitialize: isInitialize);

  @override
  copyWith({bool? isLoading, bool? isInitialize, bool? level_selected}) {
    return LevelState(
        isLoading: isLoading ?? this.isLoading,
        isInitialize: isInitialize ?? this.isInitialize,
        level_selected: level_selected ?? this.level_selected);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, isInitialize, level_selected];
}
