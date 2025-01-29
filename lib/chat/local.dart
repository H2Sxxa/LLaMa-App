import 'package:llamapp/chat/common.dart';
import 'package:fllama/fllama.dart';
import 'package:llamapp/model/message.dart' as llamapp;

class LocalChatableModel extends ChatableModel {
  const LocalChatableModel();

  @override
  void chat(Function(String result, bool status) callback,
      [List<llamapp.Message>? messages]) {
    final request = OpenAiRequest(
      modelPath:
          "D:/WorkSpace/dart/llamapp/TinyLlama_v1.1_chinese.i1-IQ1_S.gguf",
      messages: messages?.map((e) => e.convert()).toList() ?? [],
      
    );
    fllamaChat(request, callback);
  }
}
