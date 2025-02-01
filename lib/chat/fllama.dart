import 'package:fllama/fllama.dart';
import 'package:flutter/foundation.dart';

const chatZephyrTemplate = '''
{%- for message in messages -%}
<|{{ message.role }}|>
<s>{{ message.content }}</s>
{% endfor %}
<|assistant|>''';

const chatZephyrEosToken = "</s>";
const chatZephyrBosToken = "<s>";


Future<int> fllamaChatWithTemplate(
  OpenAiRequest request,
  FllamaInferenceCallback callback, {
  required String eosToken,
  required String bosToken,
  required String chatTemplate,
}) async {
  final String text;
  final template = fllamaSanitizeChatTemplate(
      await fllamaChatTemplateGet(request.modelPath), request.modelPath);
  final begin = await fllamaBosTokenGet(request.modelPath);
  final end = await fllamaEosTokenGet(request.modelPath);
  debugPrint('''
bos: $begin
eos: $end
''');
  text = fllamaApplyChatTemplate(
    chatTemplate: chatTemplate.isEmpty ? template : chatTemplate,
    bosToken: begin.isEmpty ? bosToken : begin,
    eosToken: end.isEmpty ? eosToken : end,
    request: request,
  );
  debugPrint("text: $text");
  final String grammar;
  if (request.tools.isNotEmpty) {
    if (request.tools.length > 1) {
      // ignore: avoid_print
      print(
          '[fllama] WARNING: More than one tool was specified. No grammar will be enforced. (via fllamaChat)');
      grammar = '';
    } else {
      grammar = request.tools.first.grammar;
      // ignore: avoid_print
      print('[fllama] Grammar to be enforced: $grammar');
    }
  } else {
    // ignore: avoid_print
    print('[fllama] No tools were specified. No grammar will be enforced.');
    grammar = '';
  }
  final inferenceRequest = FllamaInferenceRequest(
    contextSize: request.contextSize,
    input: text,
    maxTokens: request.maxTokens,
    modelPath: request.modelPath,
    modelMmprojPath: request.mmprojPath,
    numGpuLayers: request.numGpuLayers,
    penaltyFrequency: request.frequencyPenalty,
    penaltyRepeat: request.presencePenalty,
    temperature: request.temperature,
    topP: request.topP,
    grammar: grammar,
    logger: request.logger,
    eosToken: eosToken,
  );
  return fllamaInference(inferenceRequest, callback);
}
