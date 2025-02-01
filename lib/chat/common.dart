import 'package:flutter/foundation.dart';
import 'package:llamapp/model/message.dart';

@immutable
abstract class ChatableModel {
  const ChatableModel();
  void chat(Function(String result, bool status) callback,
      [List<Message>? messages]);
  void cancel();
}
