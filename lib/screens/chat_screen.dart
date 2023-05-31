import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

late User loggedInUser;
final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

class ChatScreen extends StatefulWidget {
  static const id = 'chat_screen';

  const ChatScreen({super.key});
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String messageText = '';
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print("User Email: ${loggedInUser.email}");
        print("User UID: ${loggedInUser.uid}");
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   for (var i in messages.docs) {
  //     print(i.data());
  //   }
  // }

  // void messageStream() async {
  //   await for (var snapshots in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapshots.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
              icon: const Icon(
                Icons.logout_rounded,
              ),
              onPressed: () async {
                //Implement logout functionality
                await _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStream(
              firestore: _firestore,
              scrollController: scrollController,
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      keyboardType: TextInputType.multiline,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Implement send functionality.
                      _firestore.collection('messages').add({
                        'text': messageText,
                        'sender': loggedInUser.email,
                        'timestamp': FieldValue.serverTimestamp(),
                      });
                      messageController.clear();
                      scrollController.animateTo(
                        scrollController.position.maxScrollExtent + 70.0,
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeOut,
                      );
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({super.key, required this.firestore, required this.scrollController});

  final FirebaseFirestore firestore;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore
          .collection('messages')
          .orderBy('timestamp', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<MessageBubble> messageList = [];
        for (var i in messages) {
          final messageText = i.get('text');
          final messageSender = i.get('sender');
          final messageWidget = MessageBubble(
            text: messageText,
            sender: messageSender,
          );
          messageList.add(messageWidget);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            controller: scrollController,
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            children: messageList,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final String sender;
  const MessageBubble({super.key, required this.text, required this.sender});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: sender == loggedInUser.email
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            sender.substring(0, sender.indexOf('@')),
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Material(
            borderRadius:
                sender == loggedInUser.email ? kSenderBorder : kReceiverBorder,
            elevation: 6.0,
            color: sender == loggedInUser.email
                ? Colors.lightBlueAccent
                : Colors.redAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
