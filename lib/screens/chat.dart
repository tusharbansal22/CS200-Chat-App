import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  final supabase = Supabase.instance.client;
  Future _getData() async{
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
              children = <Widget>[
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount:(snapshot.data).length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin:EdgeInsets.symmetric(horizontal: 15,vertical: 2),
                                child: Text('${snapshot.data[index]['user']}',style: TextStyle(fontSize: 12),)),
                            Container(
                              width: double.infinity,
                              margin:EdgeInsets.symmetric(horizontal: 15,vertical: 2),
                              padding:EdgeInsets.symmetric(horizontal: 5,vertical: 20),
                              decoration:BoxDecoration(color: Colors.blueGrey.shade400,borderRadius: BorderRadius.circular(10)),
                              child: Text('${snapshot.data[index]['msg']}'),
                            )
                          ],
                        );
                    }
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: children,
              );
          },
        ),
      ),
    );
  }
}
