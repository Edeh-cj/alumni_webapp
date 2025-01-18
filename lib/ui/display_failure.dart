import 'package:flutter/material.dart';


displayFailure(BuildContext context){
  double r = MediaQuery.of(context).devicePixelRatio;
  showDialog(
    barrierColor: Colors.transparent,
    context: context, builder: (context){
      Future.delayed(const Duration(milliseconds: 1500)).then((value) => Navigator.of(context).pop());
      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cancel_outlined , size: 70, color: Colors.red,),
          Text('Failed', style: TextStyle(
            fontSize: 20/r,
            color: Colors.red,
            height: 1.2
          ),)
        ],
      );
    }
  );
}