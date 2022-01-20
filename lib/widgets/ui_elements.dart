import 'package:flutter/material.dart';

late BoxConstraints boxConstraints;

class CustomFormField extends StatefulWidget {

  late BoxConstraints constraint;
  late String text;
  late TextEditingController controller;

  CustomFormField({Key? key, required this.constraint, required this.text, required this.controller}) : super(key: key);

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {

  bool isPassHidden = true;
  @override
  Widget build(BuildContext context) {
    if (widget.text == 'Password') {
      return TextFormField(
        obscureText: isPassHidden,
        validator: (val) => val!.isEmpty ? '* Required' : null,
        controller: widget.controller,
        style: const TextStyle(color: Colors.black87, fontFamily: 'Muli'),
        decoration: InputDecoration(
          suffixIcon: InkWell(
            onTap: () => setState(() => isPassHidden = !isPassHidden),
              child: const Icon(Icons.visibility)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(116, 119, 224, 1), width: 2)
          ),
          hintText: widget.text,
          filled: true,
          fillColor: const Color.fromRGBO(241, 244, 251, 1),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(width: 0)),
          contentPadding: const EdgeInsets.only(left: 12.0),
          hintStyle: TextStyle(
              fontSize: widget.constraint.maxHeight / 50,
              color: Colors.grey,
              fontFamily: 'Muli',
              fontWeight: FontWeight.w400)),
      );
    } else {
      return TextFormField(
        expands: true,
        maxLines: null,
        minLines: null,
        validator: (val) => val!.isEmpty ? '* Required' : null,
        controller: widget.controller,
        style: const TextStyle(color: Colors.black87, fontFamily: 'Muli'),
        decoration: InputDecoration(
            hintText: widget.text,
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
                fontSize: widget.constraint.maxHeight / 50,
                color: Colors.grey,
                fontFamily: 'Muli',
                fontWeight: FontWeight.w400)),
      );
    }
  }
}

class CustomButton extends StatelessWidget {

  late BoxConstraints constraint;
  late String text;
  CustomButton({Key? key, required this.constraint, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (text == 'welcome') {
      return Container(
        width: constraint.maxWidth > 700 ? 700 : constraint.maxWidth,
        height: constraint.maxHeight / 17,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(style: BorderStyle.solid,
              color: const Color.fromRGBO(67, 97, 238, 1), width: 1.8),
        ),
        child: Center(
          child: Text(
            'Log In',
            style: TextStyle(
              fontFamily: 'Muli',
              color: const Color.fromRGBO(67, 97, 238, 1),
              fontWeight: FontWeight.w500,
              fontSize: constraint.maxHeight / 38,
            ),
          ),
        ),
      );
    } else {
      return Container(
        width: constraint.maxWidth > 700 ? 700 : constraint.maxWidth,
        height: constraint.maxHeight / 17,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(67, 97, 238, 1),
              Color.fromRGBO(63, 55, 201, .6),
            ])),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'Muli',
              color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: constraint.maxHeight / 38,
            ),
          ),
        ),
      );
    }
  }
}

class Facebook extends StatelessWidget {

  late BoxConstraints constraint;
  late String text;
  Facebook({Key? key, required this.constraint, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraint.maxWidth > 700 ? 700 : constraint.maxWidth,
      height: constraint.maxHeight / 17,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
        color:const Color.fromRGBO(74, 110, 168, 1),
      ),
      child: Row(
        children: [
          Container(
            width: constraint.maxHeight / 17,
            height: constraint.maxHeight / 17,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
              color: Color.fromRGBO(59, 89, 152, 1),
            ),
      // Icon from: <a href="https://www.flaticon.com/free-icons/facebook" title="facebook icons">Facebook icons created by vidyavidz - Flaticon</a>
            child: Image.asset('assets/images/facebook.png'),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
                color: Color.fromRGBO(74, 110, 168, 1),
              ),
              alignment: Alignment.center,
              child: Text(
                '$text with Facebook',
                style: TextStyle(
                  fontFamily: 'Muli',
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: constraint.maxHeight / 38,
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}

class Google extends StatelessWidget {
  late BoxConstraints constraint;
  late String text;
  Google({Key? key, required this.constraint, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: constraint.maxWidth > 700 ? 700 : constraint.maxWidth,
        height: constraint.maxHeight / 17,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(style: BorderStyle.solid,
                color: Colors.grey.shade200, width: 2)
        ),
        child: Row(
          children: [
            Container(
              width: constraint.maxHeight / 17,
              height: constraint.maxHeight / 17,
              decoration: BoxDecoration(
                  border: Border(right: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.grey.shade200,
                      width: 2)
                  )
              ),
// Icon from: <a href="https://www.flaticon.com/free-icons/google" title="google icons">Google icons created by Driss Lebbat - Flaticon</a>
              child: Image.asset('assets/images/google.png', scale: 20,),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '$text with Google',
                  style: TextStyle(
                    fontFamily: 'Muli',
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                    fontSize: constraint.maxHeight / 38,
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
