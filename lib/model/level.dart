import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'level.g.dart';

@JsonSerializable()
class Level extends Equatable {
  String level_name;
  final String? content;
  final bool level_selected;
  Level({this.level_name = "", this.level_selected = false, this.content});

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelToJson(this);

  factory Level.fromMap(Map<dynamic, dynamic> data) {
    return Level(
      level_name: data['level_name'] ?? '',
      content: data['content'] ?? '',
      level_selected: data['level_selected'] ?? false,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [level_name, content, level_selected];
}
