import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = '';
  String password = '';
  String repassword = '';
  String rollNo = '';
  bool wrongPass = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Course Chat App',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepPurple[900],
          centerTitle: true,
        ),
        body: Container(
          color: Colors.deepPurple,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (value) {
                    email = value;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    fillColor: Colors.white70,
                    filled: true,
                    enabledBorder: OutlineInputBorder().copyWith(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            const BorderSide(width: 2, color: Colors.black)),
                    labelText: 'Enter your Email Address',
                  ),
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (value) {
                    password = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white70,
                    filled: true,
                    enabledBorder: OutlineInputBorder().copyWith(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            const BorderSide(width: 2, color: Colors.black)),
                    labelText: 'Enter a strong password',
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                  child: wrongPass
                      ? Text(
                          'The re-entered password does not match. Please retype it.',
                          style: TextStyle(color: Colors.red),
                        )
                      : null),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (value) {
                    repassword = value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white70,
                    filled: true,
                    enabledBorder: OutlineInputBorder().copyWith(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10.0)),
                        borderSide:
                            const BorderSide(width: 2, color: Colors.black)),
                    labelText: 'Re-enter your password',
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  if (password != repassword) {
                    setState(() {
                      wrongPass = true;
                    });
                  } else {
                    setState(() {
                      wrongPass = false;
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, fixedSize: Size(100, 40)),
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.deepPurple),
                ),
              )
            ],
          ),
        ));
  }
}
