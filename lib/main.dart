
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/route_generator.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/screens/login.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/screens/welcome_screen.dart';
import 'package:todo_app/services/auth.dart';
import 'package:todo_app/widgets/loading.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const Root());
}

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: StreamBuilder(
        stream: Auth(auth: _auth).user,
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            // checks if connection is active
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.data?.uid == null) {
                return WelcomeScreen(auth: _auth, firestore: _firestore);
              } else {
                return Home(auth: _auth, firestore: _firestore,);
              }
            } else {
              return const Loading();
            }
          },
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

