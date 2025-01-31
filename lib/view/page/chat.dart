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
  String result = "";
  @override
  void initState() {
    super.initState();
    model = LocalChatableModel();
    messages = [
      Message(content: 'You are a chatbot.', source: MessageSource.system),
    ];
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      fit: StackFit.expand,
      children: [
        ListView.builder(
          padding: EdgeInsets.only(left: 12, right: 12, bottom: 80),
          reverse: true,
          itemCount: messages.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Visibility(
                visible: result.isNotEmpty,
                child: MessageWidget(
                  message: Message(content: result, source: MessageSource.ai),
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
              child: TextField(
                controller: controller,
                onChanged: (value) => setState(() {}),
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: colorScheme.surfaceContainerLowest,
                  border: OutlineInputBorder(),
                  hintText: "Hi...",
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(8),
                    child: IconButton.filled(
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
                              });

                              controller.clear();
                              model.chat((text, done) {
                                setState(() {
                                  if (!done) {
                                    result = text;
                                  } else {
                                    messages.add(Message(
                                        content: result,
                                        source: MessageSource.ai));
                                    result = "";
                                  }
                                });
                              }, messages);
                            },
                      icon: Icon(Icons.arrow_upward),
                    ),
                  ),
                ),
              )),
        )
      ],
    );
  }
}
