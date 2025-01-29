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
  @override
  void initState() {
    super.initState();
    model = LocalChatableModel();
  }

  @override
  Widget build(BuildContext context) {
    final messages = [
      Message(
          content: "Hi, I am TinyLlama_v1.1_chinese.i1-IQ1_S.",
          source: MessageSource.ai),
      Message(content: "Hi, I am a user", source: MessageSource.user)
    ];
    final colorScheme = Theme.of(context).colorScheme;
    return Stack(
      fit: StackFit.expand,
      children: [
        ListView.builder(
          padding: EdgeInsets.only(left: 4, right: 4, bottom: 80),
          reverse: true,
          itemCount: messages.length,
          itemBuilder: (BuildContext context, int index) {
            return MessageWidget(
              message: messages[messages.length - index - 1],
            );
          },
        ),
        Positioned.fill(
          child: Container(
              padding: EdgeInsets.all(8),
              alignment: Alignment.bottomCenter,
              child: TextField(
                style: TextStyle(fontSize: 18),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Hi...",
                  suffixIcon: Padding(
                    padding: EdgeInsets.all(8),
                    child: IconButton.filled(
                      color: colorScheme.surfaceContainerLowest,
                      onPressed: () {
                        model.chat((text, status) {
                          print(text);
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
