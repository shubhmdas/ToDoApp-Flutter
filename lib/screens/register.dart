import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/services/auth.dart';
import 'package:todo_app/widgets/form_error.dart';
import 'package:todo_app/widgets/loading.dart';
import 'package:todo_app/widgets/ui_elements.dart';

import '../constants.dart';
import '../screen_arguments.dart';

class Register extends StatefulWidget {
  late final FirebaseAuth auth;
  late final FirebaseFirestore firestore;
  final List<String> errors = [];

  Register({Key? key, required this.auth, required this.firestore}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final isKeyboardUp = MediaQuery.of(context).viewInsets.bottom != 0;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(children: [
              Column(
                children: [
                  !isKeyboardUp
                      ? Container(
                          height: constraints.maxHeight * .20,
                          width: constraints.maxWidth,
                          padding: const EdgeInsets.all(15.0),
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: constraints.maxWidth / 6,
                            height: constraints.maxHeight / 10,
                          ),
                        )
                      : Container(
                          height: constraints.maxHeight * .06,
                        ),
                  Container(
                    height: constraints.maxHeight * .50,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 16),
                    width: constraints.maxWidth,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight * .08,
                              child: buildNameFormField(
                                  constraint: constraints,
                                  controller: _nameController)),
                          SizedBox(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight * .08,
                              child: buildEmailFormField(
                                  constraint: constraints,
                                  controller: _emailController)),
                          SizedBox(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight * .08,
                              child: buildPasswordFormField(
                                  constraint: constraints,
                                  controller: _passwordController)),
                          widget.errors.isEmpty
                              ? SizedBox(
                                  height: constraints.maxHeight * .05,
                                )
                              : FormError(
                                  errors: widget.errors,
                                  constraints: constraints),
                          InkWell(
                              onTap: () async {
                                FocusManager.instance.primaryFocus!.unfocus();
                                setState(() => isLoading = true);
                                if (_formKey.currentState!.validate()) {
                                  var result = await Auth(auth: widget.auth)
                                      .createUser(
                                          email: _emailController.text.trim(),
                                          password:
                                              _passwordController.text.trim());

                                  if (result == 'Success') {
                                    setState(() => isLoading = false);
                                    Navigator.pushNamed(context, '/home',
                                        arguments: ScreenArguments(
                                            widget.auth, widget.firestore));
                                  } else {
                                    if (result !=
                                        'Given String is empty or null') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
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
                                setState(() => isLoading = false);
                              },
                              child: CustomButton(
                                  constraint: constraints, text: 'Sign Up')),
                          SizedBox(
                            width: constraints.maxWidth,
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
                    padding: const EdgeInsets.fromLTRB(40, 0, 40, 20),
                    height: constraints.maxHeight * .30,
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
                                    fontSize: constraints.maxHeight * .02),
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
                        SizedBox(
                          height: constraints.maxHeight * .018,
                        ),
                        Facebook(constraint: constraints, text: 'Log In'),
                        Google(constraint: constraints, text: 'Log In'),
                        SizedBox(
                          height: constraints.maxHeight * .016,
                        ),
                        SizedBox(
                          width: constraints.maxWidth,
                          height: constraints.maxHeight * .02,
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
                              InkWell(
                                onTap: () => Navigator.pushNamed(context, '/login', arguments: ScreenArguments(widget.auth, widget.firestore)),
                                child: Text(
                                  ' Log In',
                                  style: TextStyle(
                                    fontFamily: 'Muli',
                                    color: const Color.fromRGBO(116, 119, 224, 1),
                                    fontWeight: FontWeight.w300,
                                    fontSize: constraints.maxHeight / 52,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (isLoading) const Loading(),
            ]);
          },
        ),
      ),
    );
  }

  buildNameFormField({constraint, controller}) {
    return TextFormField(
      validator: (val) {
        val!.isEmpty && !widget.errors.contains(emptyNameError)
            ? widget.errors.add(emptyNameError)
            : null;
        val.isNotEmpty && widget.errors.contains(emptyNameError)
            ? widget.errors.remove(emptyNameError)
            : null;
      },
      controller: controller,
      style: const TextStyle(color: Colors.black87, fontFamily: 'Muli'),
      decoration: InputDecoration(
          hintText: 'Name',
          filled: true,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromRGBO(116, 119, 224, 1), width: 2)),
          enabledBorder: InputBorder.none,
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

  buildEmailFormField({constraint, controller}) {
    return TextFormField(
      validator: (val) {
        val!.isEmpty && !widget.errors.contains(emptyEmailError)
            ? widget.errors.add(emptyEmailError)
            : null;
        val.isNotEmpty && widget.errors.contains(emptyEmailError)
            ? widget.errors.remove(emptyEmailError)
            : null;
      },
      controller: controller,
      style: const TextStyle(color: Colors.black87, fontFamily: 'Muli'),
      decoration: InputDecoration(
          hintText: 'Email',
          filled: true,
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromRGBO(116, 119, 224, 1), width: 2)),
          enabledBorder: InputBorder.none,
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

  buildPasswordFormField({constraint, controller}) {
    return TextFormField(
      obscureText: true,
      validator: (val) {
        val!.isEmpty && !widget.errors.contains(emptyPassError)
            ? widget.errors.add(emptyPassError)
            : null;
        val.isNotEmpty && widget.errors.contains(emptyEmailError)
            ? widget.errors.remove(emptyPassError)
            : null;
      },
      controller: controller,
      style: const TextStyle(color: Colors.black87, fontFamily: 'Muli'),
      decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromRGBO(116, 119, 224, 1), width: 2)),
          enabledBorder: InputBorder.none,
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
