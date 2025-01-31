import 'package:llamapp/chat/common.dart';
import 'package:fllama/fllama.dart';
import 'package:llamapp/model/message.dart' as llamapp;

class LocalChatableModel extends ChatableModel {
  const LocalChatableModel();

  @override
  void chat(Function(String result, bool status) callback,
      [List<llamapp.Message>? messages]) {
    final request = OpenAiRequest(
      modelPath: "tinyllama-1.1b-chat-v1.0.Q2_K.gguf",
      messages: messages?.map((e) => e.convert()).toList() ?? [],
    );
    fllamaChat(request, callback);
  }
}
