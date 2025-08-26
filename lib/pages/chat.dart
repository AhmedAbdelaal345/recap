import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recap/constans.dart';
import 'package:recap/models/message_model.dart';
import 'package:recap/pages/login.dart';
import 'package:recap/widgets/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});
  static const String id = "ChatPage";
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = ScrollController();
  CollectionReference messages = FirebaseFirestore.instance.collection(
    Constans.collection,
  );

  String? message;
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(Constans.time, descending: true).snapshots(),

      builder: (context, snapshot) {
        List<Message> messageList = [];

        if (snapshot.hasData) {
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginPage.id);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                ),
                backgroundColor: Constans.primiryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Constans.image,
                      width: MediaQuery.of(context).size.width / 5,
                      height: MediaQuery.of(context).size.height / 5,
                    ),
                    const Text(
                      "Scholar Chat",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Pacifico-Regular",
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _controller,
                      itemBuilder: (context, index) {
                        return ChatBubble(
                          message: messageList[index],
                          email: email as String,
                        );
                        // Check if the message is from the current user or a friend
                      },
                      itemCount: messageList.length,
                      shrinkWrap: true,
                      reverse: true,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller,
                      cursorColor: Constans.ScondaryColor,
                      onChanged: (value) {
                        setState(() {
                          message = value;
                        });
                      },
                      decoration: InputDecoration(
                        fillColor: Constans.ScondaryColor,
                        suffixIcon: IconButton(
                          onPressed: sendMessage,
                          icon: Icon(Icons.send, color: Constans.primiryColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Constans.ScondaryColor,
                            width: 1.2,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1.5,
                          ),
                        ),
                      ),
                      onSubmitted: (value) {
                        sendMessage();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text(
                "Loading......",
                style: TextStyle(color: Constans.primiryColor, fontSize: 25),
              ),
            ),
          );
        }
      },
    );
  }

  void sendMessage() {
    if (controller.text.trim().isNotEmpty) {
      messages.add({
        Constans.message: controller.text,
        Constans.time: DateTime.now(),
        "email": ModalRoute.of(context)!.settings.arguments,
      });
      controller.clear();
      setState(() {
        message = null;
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_controller.hasClients) {
        _controller.animateTo(
          _controller
              .position
              .minScrollExtent, // For normal ListView, scroll to bottom
          duration: Duration(seconds: 1),
          curve: Curves.fastEaseInToSlowEaseOut,
        );
      }
    });
  }
}
