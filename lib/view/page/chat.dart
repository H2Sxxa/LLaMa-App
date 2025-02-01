import 'dart:math';

import 'package:flutter/material.dart';
import 'package:llamapp/chat/common.dart';
import 'package:llamapp/chat/local.dart';
import 'package:llamapp/model/message.dart';
import 'package:llamapp/view/widget/message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final ChatableModel model;
  late final List<Message> messages;
  late final TextEditingController controller;

  bool busy = false;
  String result = "";
  double? fieldHeight = 0;

  @override
  void initState() {
    super.initState();
    model = LocalChatableModel(modelPath: "tinyllama.gguf");
    messages = [];
    controller = TextEditingController();
  }

  @override
  void dispose() {
    model.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      fit: StackFit.expand,
      children: [
        ListView.builder(
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
            bottom: max(56 + 32, (fieldHeight ?? 56) + 32),
          ),
          reverse: true,
          itemCount: messages.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Visibility(
                replacement: Visibility(
                  visible: busy,
                  child: ListTile(
                    leading: CircularProgressIndicator(),
                    title: Text("Model is Thinking..."),
                  ),
                ),
                visible: result.isNotEmpty,
                child: MessageWidget(
                  message: Message(
                    content: result,
                    source: MessageSource.assistant,
                  ),
                ),
              );
            }

            return MessageWidget(
              message: messages[messages.length - index],
            );
          },
        ),
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.bottomCenter,
            child: Builder(
              builder: (context) => ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 120),
                child: TextField(
                  maxLines: null,
                  controller: controller,
                  onChanged: (value) => setState(() {
                    fieldHeight = context.size?.height;
                  }),
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: colorScheme.surfaceContainerLowest,
                    border: OutlineInputBorder(),
                    hintText: "Hi...",
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(8),
                      child: busy
                          ? IconButton.filled(
                              color: colorScheme.surfaceContainerLowest,
                              onPressed: () {
                                model.cancel();
                                busy = false;
                              },
                              icon: Icon(Icons.stop),
                            )
                          : IconButton.filled(
                              color: colorScheme.surfaceContainerLowest,
                              onPressed: controller.text.isEmpty
                                  ? null
                                  : () {
                                      setState(() {
                                        messages.add(
                                          Message(
                                              content: controller.text,
                                              source: MessageSource.user),
                                        );
                                        busy = true;
                                      });

                                      controller.clear();
                                      model.chat((text, done) {
                                        setState(() {
                                          if (!done) {
                                            result = text;
                                          } else {
                                            busy = false;
                                            messages.add(Message(
                                                content: result,
                                                source:
                                                    MessageSource.assistant));
                                            result = "";
                                          }
                                        });
                                      }, messages);
                                    },
                              icon: Icon(Icons.arrow_upward),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
