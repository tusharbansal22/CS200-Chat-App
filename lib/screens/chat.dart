import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  String message="";
  final supabase = Supabase.instance.client;
  String email="";
  Future _getData() async{
    final User? user = supabase.auth.currentUser;
    if(user != null){
      email=user.email!;
      print(email);
    }
    final data = await supabase
        .from('chats')
        .select();
    print(data);
    return data;
  }



  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: FutureBuilder<dynamic>(
          future: _getData(), // a previously-obtained Future<String> or null
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            List<Widget> children;
            if (snapshot.hasData) {
              print(snapshot.data.length);
              children = <Widget>[
                ListView.builder(
                  reverse: true,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount:(snapshot.data).length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                          crossAxisAlignment: (snapshot.data[(snapshot.data).length-index-1]['user']!='email')?CrossAxisAlignment.start:CrossAxisAlignment.end,
                          children: [
                            Container(
                                margin:EdgeInsets.symmetric(horizontal: 15,vertical: 2),
                                child: Text('${snapshot.data[(snapshot.data).length-index-1]['user']}',style: TextStyle(fontSize: 12),)),
                            Container(
                              constraints: BoxConstraints(minWidth: 80, maxWidth: 200),
                              margin:EdgeInsets.symmetric(horizontal: 15,vertical: 2),
                              padding:EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                              decoration:BoxDecoration(color: (snapshot.data[(snapshot.data).length-index-1]['user']!='email')?Colors.blue.shade900:Colors.blueGrey.shade400,borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                child: Text('${snapshot.data[(snapshot.data).length-index-1]['msg']}',style: TextStyle(color: (snapshot.data[(snapshot.data).length-index-1]['user']!='email')?Colors.white:Colors.black),),
                              ),
                            )
                          ],
                        );
                    }
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 250,
                        child: TextField(onChanged: (change){
                          message=change;
                        },),
                      ),
                      OutlinedButton(onPressed: ()async{
                        await supabase
                            .from('chats')
                            .insert({'user':'${email}','msg':'${message}'});
                      }, child: Icon(Icons.arrow_back_ios_new_outlined))
                    ],
                  ),
                )
              ];
            } else if (snapshot.hasError) {
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
              ];
            } else {
              children = const <Widget>[
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('Awaiting result...'),
                ),
              ];
            }
            return  Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: children,
              );
          },
        ),
      ),
    );
  }
}
