import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/services/auth.dart';
import 'package:todo_app/widgets/loading.dart';

class Login extends StatefulWidget {

  late FirebaseAuth auth;
  late FirebaseFirestore firestore;

  Login({Key? key,  required this.auth, required this.firestore }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {

    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    final _formKey = GlobalKey<FormState>();
    bool loading = false;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(fontFamily: 'Muli', fontWeight: FontWeight.bold),),
        centerTitle: true,
        elevation: 0,
      ),
      body: loading ? const Loading() : Center(
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Builder(builder: (BuildContext context) {
            return Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (val) => val!.isEmpty ? '* Required' : null,
                    key: const ValueKey("email"),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: "Email"),
                    controller: _emailController,
                  ),
                  TextFormField(
                    validator: (val) => val!.isEmpty ? '* Required' : null,
                    key: const ValueKey("password"),
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(hintText: "Password"),
                    controller: _passwordController,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    key: const ValueKey("signIn"),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => loading = true);
                        final String? result = await Auth(auth: widget.auth).signIn(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );

                        if (result == 'Success') {
                          _emailController.clear();
                          _passwordController.clear();
                        } else {
                          setState(() => loading = true);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result ?? 'An error occurred!'))
                          );
                        }
                      }
                    },
                    child: const Text("Sign In"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    key: const ValueKey("createAccount"),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final String? result = await Auth(auth: widget.auth).createUser(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );

                        if (result == 'Success') {
                          _emailController.clear();
                          _passwordController.clear();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(result ?? 'An error occurred!', style: const TextStyle(fontFamily: 'Muli'),),
                              )
                          );
                        }
                      }
                    },
                    child: const Text("Create Account"),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
