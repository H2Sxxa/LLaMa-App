import 'package:json_annotation/json_annotation.dart';
import 'package:llamapp/model/message.dart';

part 'conversation.g.dart';

@JsonSerializable()
class Conversation {
  final List<Message> messages;

  const Conversation({required this.messages});
  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationToJson(this);
}
