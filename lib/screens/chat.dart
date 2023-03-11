import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chat/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  String message = "";
  final messageTextController = TextEditingController();
  final supabase = Supabase.instance.client;
  String email = "";
  Future _getData() async {
    final User? user = supabase.auth.currentUser;
    if (user != null) {
      email = user.email!;
      print(email);
    }
    final data = await supabase.from('chats').select();
    print(data);
    return data;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                // getStream();
                //Implement logout functionality
                await supabase.auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body:SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var messages = snapshot.data as List ?? [];
                      // print(1);
                      // print(messages);
                      List<MessageBubble> messageBubbles = [];
                      for (var message in messages.reversed) {
                        var messageContent = message['message_content'];
                        var messageSender = message['sender_mail'];
                        MessageBubble messageBubble = MessageBubble(
                          text: messageContent,
                          sender: messageSender,
                        );
                        messageBubbles.add(messageBubble);
                      }
                      return Expanded(
                        child: ListView(
                          reverse: true,
                          children: messageBubbles,
                        ),
                      );
                    } else {
                      return CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                      );
                    }
                  }),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        controller: messageTextController,
                        onChanged: (value) {
                          //Do something with the user input.
                          message = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        //Implement send functionality.
                        await supabase.from('chats').insert(
                            {'user': '${email}', 'msg': '${message}'});
                        setState(() {
                          messageTextController.clear();
                          message = "";
                        });
                      },
                      child: Text(
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
      ),
    );
  }
}



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;
User loggedUser = supabase.auth.currentUser!;
bool senderIsMe = true;

class _ChatScreenState extends State<ChatScreen> {
  // final _userInstance = FirebaseFirestore.instance;

  // final _auth = FirebaseAuth.instance;
  final messageTextController = TextEditingController();
  late String message;
  late final _stream;

  void getUser() {
    loggedUser = supabase.auth.currentUser!;
    // print(loggedUser.email);
  }

  // void getMessages() async {
  //   var messages = await supabase.from("Messages").select('message_content');
  //   // for (var message in messages) {
  //   //   print(message);
  //   // }
  //   print(messages);
  // }

  // void getStream() async {
  //   await for (var snapshot
  //       in _userInstance.collection("messages").snapshots().listen((event) {
  //     for (var message in event.docs) {
  //       print(message);
  //     }
  //   })) {}
  //   ;
  // }

  // void getStream() async {
  //   await supabase
  //       .from('Messages')
  //       .stream(primaryKey: ['id']).listen((List<Map<String, dynamic>> data) {
  //     // Do something awesome with the data
  //     print(data);
  //   });
  // }

  void initState() {
    super.initState();
    getUser();
    _stream = supabase.from('Messages').stream(primaryKey: ['id']);
    // getMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () async {
                // getStream();
                //Implement logout functionality
                await supabase.auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              StreamBuilder(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var messages = snapshot.data as List ?? [];
                      // print(1);
                      // print(messages);
                      List<MessageBubble> messageBubbles = [];
                      for (var message in messages.reversed) {
                        var messageContent = message['message_content'];
                        var messageSender = message['sender_mail'];
                        MessageBubble messageBubble = MessageBubble(
                          text: messageContent,
                          sender: messageSender,
                        );
                        messageBubbles.add(messageBubble);
                      }
                      return Expanded(
                        child: ListView(
                          reverse: true,
                          children: messageBubbles,
                        ),
                      );
                    } else {
                      return CircularProgressIndicator(
                        backgroundColor: Colors.blueAccent,
                      );
                    }
                  }),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        controller: messageTextController,
                        onChanged: (value) {
                          //Do something with the user input.
                          message = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        //Implement send functionality.
                        await supabase.from('chats').insert(
                            {'user': '${email}', 'msg': '${message}'});
                        setState(() {
                          messageTextController.clear();
                          message = "";
                        });
                      },
                      child: Text(
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
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.sender});

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: loggedUser.email == sender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(color: Colors.grey, fontSize: 10),
          ),
          Material(
            borderRadius: loggedUser.email == sender
                ? BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))
                : BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            elevation: 5.0,
            color:
            loggedUser.email == sender ? Colors.lightBlue : Colors.purple,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

