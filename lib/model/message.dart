import 'package:fllama/misc/openai.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:fllama/fllama.dart' as fllama;
part 'message.g.dart';

@JsonSerializable()
class Message {
  final String content;
  final MessageSource source;
  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  const Message({
    required this.content,
    required this.source,
  });

  Map<String, dynamic> toJson() => _$MessageToJson(this);

  fllama.Message convert() {
    switch (source) {
      case MessageSource.assistant:
        return fllama.Message(Role.assistant, content);
      case MessageSource.system:
        return fllama.Message(Role.system, content);
      case MessageSource.user:
        return fllama.Message(Role.user, content);
    }
  }
}



@JsonEnum()
enum MessageSource {
  user,
  assistant,
  system,
}
