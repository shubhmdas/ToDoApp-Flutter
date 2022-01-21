import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(43, 43, 43, .64),
      child: const Center(
        child: SpinKitCircle(
          color: Color.fromRGBO(67, 97, 238, 1),
          size: 50.0,
        ),
      ),
    );
  }
}