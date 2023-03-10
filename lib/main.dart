import 'package:chat/screens/chat.dart';
import 'package:chat/screens/home.dart';
import 'package:chat/screens/login.dart';
import 'package:chat/screens/logreg.dart';
import 'package:chat/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://qzllztxvkogyfjebfpjr.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InF6bGx6dHh2a29neWZqZWJmcGpyIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzgyMTYwMjQsImV4cCI6MTk5Mzc5MjAyNH0.sGtNZqRvtiR3I1rAgcMeiuAzIvpsCxxc_uEEC9lAWH4',
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      routes: {
        'home': (context) => Home(),
        'login': (context) => Login(),
        'register': (context) => RegisterScreen(),
        'logreg': (context)=> LogRegister(),
        'chat': (context)=> ChatScreen()
      },
      initialRoute: supabase.auth.currentUser != null ? 'chat' : 'logreg',
      // initialRoute: 'register',
    );
  }
}
