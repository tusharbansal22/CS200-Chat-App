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
  var email = "";
  var pass = "";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Course Chat App',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[900],
      ),
      body: Container(
        width: double.infinity,
        color: Colors.deepPurple,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70,
              margin: EdgeInsets.symmetric(horizontal: 20),
              // decoration: BoxDecoration(
              //     color: Colors.grey.shade500,
              //     borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  fillColor: Colors.white70,
                  filled: true,
                  enabledBorder: OutlineInputBorder().copyWith(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.black)),
                  labelText: 'Enter your Email ID',
                ),
                onChanged: (value) {
                  email = value;
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 70,
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                onChanged: (value) {
                  pass = value;
                },
                obscureText: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  fillColor: Colors.white70,
                  filled: true,
                  enabledBorder: OutlineInputBorder().copyWith(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.black)),
                  labelText: 'Enter your Password',
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, fixedSize: Size(100, 40)),
                onPressed: () async {
                  final AuthResponse res =
                      await supabase.auth.signInWithPassword(
                    email: email,
                    password: pass,
                  );
                  Navigator.pushNamed(context, 'chat');
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.deepPurple),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
