import 'package:flutter/material.dart';
import 'package:todo_app/screen_arguments.dart';
import 'package:todo_app/widgets/ui_elements.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WelcomeScreen extends StatelessWidget {

  late FirebaseAuth auth;
  late FirebaseFirestore firestore;
  WelcomeScreen({Key? key, required this.auth, required this.firestore }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            var height = constraints.maxHeight;
            var width = constraints.maxWidth;
            return Column(
              children: [
                Container(
                  height: constraints.maxHeight / 2,
                  width: constraints.maxWidth,
                  padding: const EdgeInsets.all(20.0),
                  alignment: Alignment.bottomCenter,

                  child: Image.asset('assets/images/logo.png', width: constraints.maxWidth / 6, height: constraints.maxHeight / 10,)
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 0),
                  height: constraints.maxHeight / 2,
                  width: constraints.maxWidth,
                  child: Column(
                    children: [
                      Wrap(
                        children: [
                        Text(
                        'Be even more productive with our ToDo app',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontFamily: 'Muli', fontSize: constraints.maxHeight / 32, color: Colors.black54, fontWeight: FontWeight.w600))
                        ],
                      ),
                      SizedBox(height: constraints.maxHeight / 7,),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/register', arguments: ScreenArguments(auth, firestore));
                            },
                              child: CustomButton(constraint: constraints, text: 'Sign Up')),
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/login', arguments: ScreenArguments(auth, firestore));
                            },
                              child: CustomButton(constraint: constraints, text: 'welcome')),
                        ],
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
