// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app_poc/cubit/app_cubits.dart';
import 'package:travel_app_poc/widgets/app_text.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? height;
  String? text;
  Color? color;
  Function? function;

  ResponsiveButton({
    Key? key,
    this.text,
    this.function,
    this.color,
    this.isResponsive,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      // fit: FlexFit.tight,
      child: Container(
        // width: width,
        height: height,
        child: ElevatedButton(
            onPressed:() => BlocProvider.of<AppCubits>(context).getData(),
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: color),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppText(
                  text: text!,
                  size: 18,
                  color: Colors.white,
                  weight: FontWeight.w600,
                ),
                SizedBox(
                  width: 20,
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            )),
      ),
    );
  }
}
