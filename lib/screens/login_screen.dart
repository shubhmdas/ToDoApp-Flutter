import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screen_arguments.dart';
import 'package:todo_app/services/auth.dart';
import 'package:todo_app/widgets/ui_elements.dart';

class LoginScreen extends StatelessWidget {

  late FirebaseAuth auth;
  late FirebaseFirestore firestore;
  LoginScreen({Key? key, required this.auth, required this.firestore }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    final _formKey = GlobalKey<FormState>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            boxConstraints = constraints;
            return Column(
              children: [
                Container(
                    height: constraints.maxHeight / 3,
                    width: constraints.maxWidth,
                    padding: const EdgeInsets.all(15.0),
                    alignment: Alignment.bottomCenter,
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: constraints.maxWidth / 6,
                      height: constraints.maxHeight / 10,
                    )),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 16),
                  height: constraints.maxHeight / 3,
                  width: constraints.maxWidth,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        InkWell(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              await Auth(auth: auth).signIn(email: _emailController.text.trim(), password: _passwordController.text.trim());
                              Navigator.pushNamed(context, '/home', arguments: ScreenArguments(auth, firestore));
                            }
                          },
                            child: CustomButton(constraint: constraints, text: 'Log In')),
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
                  height: constraints.maxHeight / 3,
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
                              'Don\'t have an account?',
                              style: TextStyle(
                                fontFamily: 'Muli',
                                color: Colors.grey.shade600,
                                fontSize: constraints.maxHeight / 52,
                              ),
                            ),
                            Text(
                              ' Sign Up',
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
                  )
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
