

import 'package:flutter/cupertino.dart';

final RegExp emailValidatorRegExp =
RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

const String emptyNameError = "Please enter your name";
const String emptyEmailError = "Please enter your email";
const String emptyPassError = "Please enter your password";

const Color primaryColor = Color.fromRGBO(80, 87, 222, 1.0);

Size getConstraints(BuildContext context) {
  MediaQueryData queryData;
  queryData = MediaQuery.of(context);
  return queryData.size;
}