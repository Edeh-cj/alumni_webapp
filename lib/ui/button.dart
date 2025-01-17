import 'package:alumni_webapp/ui/colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final double? width;
  const AppButton({super.key, required this.label, required this.onPressed, this.width, });

  @override
  Widget build(BuildContext context) {
    final r = MediaQuery.of(context).devicePixelRatio;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0/r),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainGreen,
          fixedSize: Size(width?? double.maxFinite, 54/r),
          side: BorderSide.none,
          elevation: 0,
          shape: const BeveledRectangleBorder()
        ),
        onPressed: onPressed, 
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16/r

          ),
        )
      ),
    );
  }
}