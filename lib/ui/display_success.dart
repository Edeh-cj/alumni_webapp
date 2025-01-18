import 'package:alumni_webapp/ui/colors.dart';
import 'package:flutter/material.dart';

displaySuccess(BuildContext context){
  double r = MediaQuery.of(context).devicePixelRatio;
  showDialog(
    barrierColor: Colors.transparent,
    context: context, builder: (context){
      Future.delayed(const Duration(milliseconds: 1500)).then((value) => Navigator.of(context).pop());
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.check_circle_outline_rounded, size: 70, color: AppColors.mainGreen,),
          Text('success!', style: TextStyle(
            fontSize: 20/r,
            color: AppColors.mainGreen,
            height: 1.2
          ),)
        ],
      );
    }
  );
}