import 'package:flutter/material.dart';

displayFailure(BuildContext context){
  showDialog(
    barrierColor: Colors.black.withOpacity(0.2),
    context: context, builder: (context){
      return const FlutterLogo(size: 70,);
    }
  );
}