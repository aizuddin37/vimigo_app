import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'level.g.dart';

@JsonSerializable()
class Level extends Equatable {
  final String? level_name;
  final String? content;
  final bool? level_selected;
  Level({this.level_name, this.level_selected, this.content});

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelToJson(this);

  factory Level.fromMap(Map<dynamic, dynamic> map) {
    return Level(
      level_name: map['level_name'] ?? '',
      content: map['content'] ?? '',
      level_selected: map['level_selected'] ?? false,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [level_name, content, level_selected];
}
