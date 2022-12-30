// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Level _$LevelFromJson(Map<String, dynamic> json) => Level(
      level_name: json['level_name'] as String?,
      level_selected: json['level_selected'] as bool?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$LevelToJson(Level instance) => <String, dynamic>{
      'level_name': instance.level_name,
      'content': instance.content,
      'level_selected': instance.level_selected,
    };
