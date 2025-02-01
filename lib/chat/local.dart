import 'package:llamapp/chat/common.dart';
import 'package:fllama/fllama.dart';
import 'package:llamapp/chat/fllama.dart';
import 'package:llamapp/func/disposable.dart';
import 'package:llamapp/model/message.dart' as app;

DisposableValue<Function>? _request;

class LocalChatableModel extends ChatableModel {
  /// Only GGUF Support Now
  final String modelPath;
  const LocalChatableModel({required this.modelPath});

  @override
  void chat(Function(String result, bool status) callback,
      [List<app.Message>? messages]) async {
    final request = OpenAiRequest(
      modelPath: modelPath,
      messages: messages?.map((e) => e.convert()).toList() ?? [],
    );
    final requestId = await fllamaChat(request, callback);
    _request = disposableValue(() => fllamaCancelInference(requestId));
  }

  @override
  void cancel() {
    _request?.call()?.call();
  }
}
