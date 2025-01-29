import 'package:flutter/material.dart';
import 'package:llamapp/model/message.dart';

class MessageWidget extends StatelessWidget {
  final Message message;
  const MessageWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final isUser = message.source == MessageSource.user;

    final content = Text(
      message.content,
      style: DefaultTextStyle.of(context).style.copyWith(fontSize: 16),
    );
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      constraints: BoxConstraints(maxWidth: screenWidth * 0.7),
      child: isUser
          ? Card(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: content,
              ),
            )
          : Card.outlined(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: content,
              ),
            ),
    );
  }
}
