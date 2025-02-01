// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      content: json['content'] as String,
      source: $enumDecode(_$MessageSourceEnumMap, json['source']),
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'content': instance.content,
      'source': _$MessageSourceEnumMap[instance.source]!,
    };

const _$MessageSourceEnumMap = {
  MessageSource.user: 'user',
  MessageSource.assistant: 'assistant',
  MessageSource.system: 'system',
};
