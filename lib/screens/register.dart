import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/widgets/ui_elements.dart';

class Register extends StatelessWidget {
  late FirebaseAuth auth;
  late FirebaseFirestore firestore;
  Register({Key? key, required this.auth, required this.firestore }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            boxConstraints = constraints;
            return Column(
              children: [
                Container(
                  height: constraints.maxHeight * .25,
                  width: constraints.maxWidth,
                  padding: const EdgeInsets.all(15.0),
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: constraints.maxWidth / 6,
                    height: constraints.maxHeight / 10,
                  ),
                ),
                Container(
                  height: constraints.maxHeight * .4,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 16),
                  width: constraints.maxWidth,
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: constraints.maxWidth > 700 ? 700 : constraints.maxWidth,
                            height: constraints.maxHeight / 17,
                            child: CustomFormField(
                                constraint: constraints, text: 'Full Name',
                                controller: _nameController)),
                        SizedBox(
                            width: constraints.maxWidth > 700 ? 700 : constraints.maxWidth,
                            height: constraints.maxHeight / 17,
                            child: CustomFormField(
                                constraint: constraints, text: 'Email',
                                controller: _emailController)),
                        SizedBox(
                            width: constraints.maxWidth > 700 ? 700 : constraints.maxWidth,
                            height: constraints.maxHeight / 17,
                            child: CustomFormField(
                                constraint: constraints, text: 'Password',
                                controller: _passwordController)),
                        CustomButton(constraint: constraints, text: 'Sign Up'),
                        SizedBox(
                          width: constraints.maxWidth > 700 ? 700 : constraints.maxWidth,
                          height: constraints.maxHeight / 30,
                          child: Center(
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontFamily: 'Muli',
                                color: const Color.fromRGBO(116, 119, 224, 1),
                                fontWeight: FontWeight.w300,
                                fontSize: constraints.maxHeight / 52,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 0),
                  height: constraints.maxHeight * .35,
                  width: constraints.maxWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: constraints.maxWidth > 700 ? 700 : constraints.maxWidth,
                        height: constraints.maxHeight / 40,
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 12,),
                            Text('or', style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Muli',
                                fontSize: constraints.maxHeight / 52),
                            ),
                            const SizedBox(width: 12,),
                            const Expanded(
                              child: Divider(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Facebook(constraint: constraints, text: 'Log In'),
                      Google(constraint: constraints, text: 'Log In'),
                      SizedBox(height: constraints.maxHeight / 50,),
                      SizedBox(
                        width: constraints.maxWidth > 700 ? 700 : constraints.maxWidth,
                        height: constraints.maxHeight / 30,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                fontFamily: 'Muli',
                                color: Colors.grey.shade600,
                                fontSize: constraints.maxHeight / 52,
                              ),
                            ),
                            Text(
                              ' Log In',
                              style: TextStyle(
                                fontFamily: 'Muli',
                                color: const Color.fromRGBO(116, 119, 224, 1),
                                fontWeight: FontWeight.w300,
                                fontSize: constraints.maxHeight / 52,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: constraints.maxHeight / 40,)
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
