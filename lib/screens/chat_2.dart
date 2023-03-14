import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  String message = "";
  final messageTextController = TextEditingController();
  String email = "";
  final _stream =
  supabase.from('chats').stream(primaryKey: ['id']).order('created_at');
  @override
  void initState() {
    final User? user = supabase.auth.currentUser;
    if (user != null) {
      email = user.email!;
      print(_stream);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: AppBar(title: Text("Logs"),actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () async {
                    // getStream();
                    //Implement logout functionality
                    await supabase.auth.signOut();
                    Navigator.pop(context);
                  }),
            ],backgroundColor: Colors.pinkAccent.shade700,centerTitle: true,elevation: 1.5,titleTextStyle: TextStyle(color: Colors.white,fontSize: 16,fontStyle: FontStyle.normal)))
        , body: SafeArea(
        child: StreamBuilder(
            stream: _stream,
            builder: (context, snapshot) {
              List<Widget> children;
              if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text('Stack trace: ${snapshot.stackTrace}'),
                  ),
                ];
              } else {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    children = const <Widget>[
                      Icon(
                        Icons.info,
                        color: Colors.blue,
                        size: 60,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Select a lot'),
                      ),
                    ];
                    break;
                  case ConnectionState.waiting:
                    children = const <Widget>[
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16),
                        child: Text('Awaiting bids...'),
                      ),
                    ];
                    break;
                  case ConnectionState.active:
                    children = <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: ListView.builder(
                              reverse: true,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: (snapshot.data)?.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: (snapshot.data![index]
                                  ['user'] !=
                                      '${email}')
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 2),
                                        child: Text(
                                          '${snapshot.data![index]['user']}',
                                          style: TextStyle(fontSize: 12,color: Colors.white),
                                        )),
                                    Card(
                                      elevation:100,
                                      color: Colors.transparent,
                                      child: Container(
                                        constraints: BoxConstraints(
                                            minWidth: 80, maxWidth: 200),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 2),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 15),
                                        decoration: BoxDecoration(
                                            boxShadow:[BoxShadow(blurRadius: 0)],
                                            color: (snapshot.data![index]
                                            ['user'] !=
                                                '${email}')
                                                ?Colors.black87
                                                : Colors.pinkAccent.shade700,
                                            borderRadius:(snapshot.data![index]
                                            ['user'] !=
                                                '${email}')?
                                            BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(0),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)):BorderRadius.only(topRight: Radius.circular(0),topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Text(
                                            '${snapshot.data![index]['msg']}',
                                            style: TextStyle(
                                                color: (snapshot.data![index]
                                                ['user'] !=
                                                    '${email}')
                                                    ? Colors.white
                                                    : Colors.white),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: TextField(
                                  decoration: InputDecoration(hintText: "Enter your message",hintStyle: TextStyle(color: Colors.blue.shade100,fontStyle: FontStyle.italic,letterSpacing: 1.25,fontSize: 12)),
                                  style: TextStyle(color: Colors.white),
                                  controller: messageTextController,
                                  onChanged: (change) {
                                    setState(() {
                                      message = change;
                                    });
                                  },
                                ),
                              ),
                            ),
                            OutlinedButton(
                                onPressed: () async {
                                  await supabase.from('chats').insert({
                                    'user': '${email}',
                                    'msg': '${message}'
                                  });
                                  setState(() {
                                    messageTextController.clear();
                                    message = "";
                                  });
                                },
                                child:
                                Icon(Icons.arrow_back_ios_new_outlined))
                          ],
                        ),
                      )
                    ];
                    break;
                  case ConnectionState.done:
                    children = <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: ListView.builder(
                              reverse: true,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: (snapshot.data)?.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return Column(
                                  crossAxisAlignment: (snapshot.data![index]
                                  ['user'] !=
                                      '${email}')
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 2),
                                        child: Text(
                                          '${snapshot.data![index]['user']}',
                                          style: TextStyle(fontSize: 12),
                                        )),
                                    Container(
                                      constraints: BoxConstraints(
                                          minWidth: 80, maxWidth: 200),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 2),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 20),
                                      decoration: BoxDecoration(
                                          color: (snapshot.data![index]
                                          ['user'] !=
                                              '${email}')
                                              ? Colors.redAccent
                                              : Colors.blueGrey.shade400,
                                          borderRadius:(snapshot.data![index]
                                          ['user'] !=
                                              '${email}')?
                                          BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(0),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)):BorderRadius.only(topRight: Radius.circular(0),topLeft: Radius.circular(10),bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: Text(
                                          '${snapshot.data![index]['msg']}',
                                          style: TextStyle(
                                              color: (snapshot.data![index]
                                              ['user'] !=
                                                  '${email}')
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 250,
                              child: TextField(
                                style: TextStyle(color: Colors.white,backgroundColor: Colors.white),
                                decoration: InputDecoration(fillColor: Colors.white),
                                controller: messageTextController,
                                onChanged: (change) {
                                  setState(() {
                                    message = change;
                                  });
                                },
                              ),
                            ),
                            OutlinedButton(
                                onPressed: () async {
                                  await supabase.from('chats').insert({
                                    'user': '${email}',
                                    'msg': '${message}'
                                  });
                                  setState(() {
                                    messageTextController.clear();
                                    message = "";
                                  });
                                },
                                child:
                                Icon(Icons.arrow_back_ios_new_outlined))
                          ],
                        ),
                      )
                    ];
                    break;
                }
              }
              return Container(
                color: Colors.black87,
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: children),
              );
            })));
  }
}