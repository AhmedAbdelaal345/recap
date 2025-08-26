import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Message {
  final String message;
  final String email;
   var time;
  Message(this.message, this.email, this.time);

  factory Message.fromJson(jsonData) {
    return Message(
      jsonData["message"],
      jsonData["email"],
      jsonData["time"],
    );
  }
}
