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
    final isSystem = message.source == MessageSource.system;

    final content = SelectableText(
      message.content,
      style: DefaultTextStyle.of(context)
          .style
          .copyWith(fontSize: 16, color: isSystem ? Colors.grey : null),
    );
    final screenWidth = MediaQuery.of(context).size.width;
    return UnconstrainedBox(
      alignment: isSystem
          ? Alignment.center
          : isUser
              ? Alignment.centerRight
              : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: screenWidth * 0.8),
        padding: EdgeInsets.symmetric(vertical: 8),
        child: isSystem
            ? content
            : isUser
                ? Card(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: content,
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(8),
                    child: content,
                  ),
      ),
    );
  }
}
