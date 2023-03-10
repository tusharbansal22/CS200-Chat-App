import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  final supabase = Supabase.instance.client;
  var username = "";
  var pass = "";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Chat App'),
        backgroundColor: Colors.grey.shade900,
      ),
      body: Container(
        width: double.infinity,
        color: Colors.grey.shade700,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    labelText: "Username", border: InputBorder.none),
                onChanged: (value) {
                  username = value;
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 70,
              decoration: BoxDecoration(
                  color: Colors.grey.shade500,
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
              child: TextFormField(
                onChanged: (value) {
                  pass = value;
                },
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    labelText: "Password", border: InputBorder.none),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
              child: TextButton(
                onPressed: () async {},
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
