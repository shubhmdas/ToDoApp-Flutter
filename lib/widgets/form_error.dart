import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class FormError extends StatelessWidget {
  
  late List<String> errors;
  late BoxConstraints constraints;
  FormError({Key? key, required this.errors, required this.constraints }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
        List<Widget>.generate(errors.length, (index) {
          return fromErrorToText(errors[index]);
        }),
    );
  }

  fromErrorToText(String error) {
    return Row(
      children: [
        SvgPicture.asset('assets/images/error.svg', height: constraints.maxHeight * .018,),
        const SizedBox(width: 5,),
        Text(error, style: TextStyle(fontFamily: 'Muli', color: Colors.red.shade300, fontSize: constraints.maxHeight * .018),),
      ],
    );
  }
}
