import 'package:flutter/material.dart';

class LogRegister extends StatefulWidget {
  const LogRegister({Key? key}) : super(key: key);

  @override
  State<LogRegister> createState() => _LogRegisterState();
}

class _LogRegisterState extends State<LogRegister> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent.shade700,
        title: Text("Course Chat App", style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Card(
                surfaceTintColor: Colors.black54,
                shadowColor: Colors.black,
                elevation: 1,
                child: Container(
                  width: 220,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "login");
                    },
                    child: Text("Login", style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.tealAccent.shade700,
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Card(
              surfaceTintColor: Colors.black54,
              shadowColor: Colors.black,
              elevation: 1,
              child: Container(
                width: 220,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "register");
                  },
                  child: Text("Register", style: TextStyle(color: Colors.white),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.tealAccent.shade700,
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
