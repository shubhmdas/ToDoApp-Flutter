import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/screen_arguments.dart';
import 'package:todo_app/services/auth.dart';
import 'package:todo_app/widgets/form_error.dart';
import 'package:todo_app/widgets/loading.dart';
import 'package:todo_app/widgets/ui_elements.dart';

class LoginScreen extends StatefulWidget {
  late FirebaseAuth auth;
  late FirebaseFirestore firestore;
  bool isLoading = false;
  final List<String> errors = [];

  LoginScreen({Key? key, required this.auth, required this.firestore})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final isKeyboardUp = MediaQuery.of(context).viewInsets.bottom != 0;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(alignment: Alignment.center, children: [
              Column(
                children: [
                  !isKeyboardUp ? Container(
                      height: constraints.maxHeight * .25,
                      width: constraints.maxWidth,
                      padding: const EdgeInsets.fromLTRB(20, 40, 20, 10),
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: constraints.maxWidth * .20,
                        height: constraints.maxHeight * .20,
                      )) : Container(height: constraints.maxHeight * .08,),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 16),
                    height: constraints.maxHeight * .40,
                    width: constraints.maxWidth,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight * .07,
                              child: buildEmailFormField(
                                  constraint: constraints,
                                  controller: _emailController)),
                          SizedBox(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight * .07,
                              child: buildPasswordFormField(
                                  constraint: constraints,
                                  controller: _passwordController)),
                          widget.errors.isEmpty ? SizedBox(height: constraints.maxHeight * .036 + 5)
                              : FormError(constraints: constraints, errors: widget.errors),
                          InkWell(
                              onTap: () async {
                                FocusManager.instance.primaryFocus!.unfocus();
                                setState(() => widget.isLoading = true);
                                if (_formKey.currentState!.validate()) {
                                  var result = await Auth(auth: widget.auth)
                                      .signIn(
                                          email: _emailController.text.trim(),
                                          password:
                                              _passwordController.text.trim());

                                  if (result == 'Success') {
                                    setState(() => widget.isLoading = false);
                                    Navigator.pushNamed(context, '/home',
                                        arguments: ScreenArguments(
                                            widget.auth, widget.firestore));
                                  } else {
                                    if (result != 'Given String is empty or null') {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              result!,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                            backgroundColor: Colors.black,
                                            elevation: 2,
                                          ));
                                    }
                                  }
                                }
                                setState(() => widget.isLoading = false);
                              },
                              child: CustomButton(
                                  constraint: constraints,
                                  text: 'Log In')),
                          SizedBox(
                            width: constraints.maxWidth > 700
                                ? 700
                                : constraints.maxWidth,
                            height: constraints.maxHeight * .04,
                            child: Center(
                              child: Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  fontFamily: 'Muli',
                                  color: const Color.fromRGBO(116, 119, 224, 1),
                                  fontWeight: FontWeight.w300,
                                  fontSize: constraints.maxHeight * .02,
                                )))),
                        ]))),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 0),
                      height: constraints.maxHeight * .35,
                      width: constraints.maxWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: constraints.maxWidth > 700
                                ? 700
                                : constraints.maxWidth,
                            height: constraints.maxHeight / 40,
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                const Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  'or',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: 'Muli',
                                      fontSize: constraints.maxHeight / 52),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                const Expanded(
                                  child: Divider(
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Facebook(constraint: constraints, text: 'Log In'),
                          Google(constraint: constraints, text: 'Log In'),
                          SizedBox(
                            height: constraints.maxHeight / 50,
                          ),
                          SizedBox(
                            width: constraints.maxWidth > 700
                                ? 700
                                : constraints.maxWidth,
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
                                  ' Sign Up', style: TextStyle(
                                    fontFamily: 'Muli',
                                    color:
                                        const Color.fromRGBO(116, 119, 224, 1),
                                    fontWeight: FontWeight.w300,
                                    fontSize: constraints.maxHeight / 52,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight / 40,
                          )
                        ],
                      ))
                ],
              ),
              if (widget.isLoading) const Loading(),
            ]);
          },
        )));
  }


  buildEmailFormField({ constraint, controller }) {
    return TextFormField(
      validator: (val) {
        val!.isEmpty && !widget.errors.contains(emptyEmailError) ? widget.errors.add(emptyEmailError) : null;
        val.isNotEmpty && widget.errors.contains(emptyEmailError) ? widget.errors.remove(emptyEmailError) : null;
      },
      controller: controller,
      style: const TextStyle(color: Colors.black87, fontFamily: 'Muli'),
      decoration: InputDecoration(
          hintText: 'Email',
          filled: true,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(116, 119, 224, 1), width: 2)
          ),
          fillColor: const Color.fromRGBO(241, 244, 251, 1),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(width: 0)),
          contentPadding: const EdgeInsets.only(left: 12.0),
          hintStyle: TextStyle(
              fontSize: constraint.maxHeight / 50,
              color: Colors.grey,
              fontFamily: 'Muli',
              fontWeight: FontWeight.w400)),
    );
  }

  buildPasswordFormField({constraint , controller}) {
    return TextFormField(
      obscureText: true,
      validator: (val) {
        val!.isEmpty && !widget.errors.contains(emptyPassError) ? widget.errors.add(emptyPassError) : null;
        val.isNotEmpty && widget.errors.contains(emptyEmailError) ? widget.errors.remove(emptyPassError) : null;
        },
      controller: controller,
      style: const TextStyle(color: Colors.black87, fontFamily: 'Muli'),
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(116, 119, 224, 1), width: 2)
          ),
          hintText: 'Password',
          filled: true,
          fillColor: const Color.fromRGBO(241, 244, 251, 1),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(width: 0)),
          contentPadding: const EdgeInsets.only(left: 12.0),
          hintStyle: TextStyle(
              fontSize: constraint.maxHeight / 50,
              color: Colors.grey,
              fontFamily: 'Muli',
              fontWeight: FontWeight.w400)),
    );
  }
}
