import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:police_office/pages/details_page.dart';
import 'package:police_office/pages/home_page.dart';
import 'package:police_office/pages/login_page.dart';

import 'firebase_options.dart';
import 'pages/all_users_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:  StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
           print("Snapshort:::::::::::${snapshot.data?.uid}");
          //  return const DetailsPage();
           return const HomePage();
          }
          else{
            //  return const RegisterPage(title: 'Police Report Sign Up');
             return const LoginPage();

          }
        },
        ),
        routes: {
          '/login_page/': (context) => const LoginPage(),
          '/all_users_page/': (context) => const AllUsersPage(),
          '/home_page/': (context) => const HomePage(),
          
        },
    );
  }
}

