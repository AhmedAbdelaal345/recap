import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recap/models/message_model.dart';

import '../constans.dart';

class ChatBubble extends StatelessWidget {
  ChatBubble({required this.message, required this.email});
  Message message;
  String email;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          message.email == email ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        padding: EdgeInsets.symmetric(vertical: 32, horizontal: 8),
        decoration: BoxDecoration(
          color:
              message.email == email
                  ? Constans.primiryColor
                  : Constans.fourthColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
            bottomRight:
                message.email == email
                    ? Radius.circular(15)
                    : Radius.circular(0),
            bottomLeft:
                message.email == email
                    ? Radius.circular(0)
                    : Radius.circular(15),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${message.message ?? "ahmed"}",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              SizedBox(height: 5),
              Text(
                "Sent at :  ${DateFormat('hh:mm a').format(message.time.toDate())}",
                style: TextStyle(color: Colors.grey.shade300, fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
