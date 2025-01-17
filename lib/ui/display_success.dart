import 'package:flutter/material.dart';

displaySuccess(BuildContext context){
  showDialog(
    barrierColor: Colors.transparent,
    context: context, builder: (context){
      Future.delayed(const Duration(milliseconds: 1500)).then((value) => Navigator.of(context).pop());
      return const Icon(Icons.check_circle_outline_rounded, size: 70, color: Colors.blueAccent,);
    }
  );
}