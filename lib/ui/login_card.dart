import 'package:alumni_webapp/controllers/auth_controller.dart';
import 'package:alumni_webapp/ui/colors.dart';
import 'package:alumni_webapp/ui/display_failure.dart';
import 'package:alumni_webapp/ui/display_success.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/_.dart';
import 'button.dart';

class LoginCard extends StatefulWidget {
  const LoginCard({super.key});

  @override
  State<LoginCard> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {

  final emailCtrl = TextEditingController();

  final passKeyCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    double r = MediaQuery.of(context).devicePixelRatio;

    final modelRead = context.read<Controller>();

    final spacing = SizedBox(height: 10/r,);

    textfield(String label, TextEditingController controller) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            height: 0.7,
            fontFamily: 'Roboto',
            color: Colors.black,
            fontSize: 16/r
          ),
        ),
        SizedBox(height: 12/r,),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            constraints: BoxConstraints.tight(Size(double.maxFinite, 54/r)),
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            filled: true,
            fillColor: AppColors.textfieldGray,
          ),
          validator: (value) {
            if (value!=null && value.isNotEmpty) {
              return null;
            } else {
              return 'This Field must not be null';
            }
          },
        )

      ],
    ); 
    
    return Container(
      width: 408/r,
      padding: EdgeInsets.all(24/r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        border: Border.all(color: Colors.black.withOpacity(0.15))
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8/r),
              child: Text.rich(
                TextSpan(
                  text: 'Login ',
                  style: TextStyle(
                    fontSize: 16/r,
                    color: AppColors.mainGreen.withOpacity(0.8),
                    height: 0.7,
                    fontFamily: "Roboto"
                  ),
                  children: [
                    TextSpan(
                      text: 'As Admin',
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8)
                      )
                    )
                  ]
                )
              ),
            ),
            spacing,
            textfield('Email Address', emailCtrl),
            spacing,
            textfield('Key', passKeyCtrl),      
            spacing,
            AppButton(
              label: 'Continue', 
              onPressed: () async{
                if (_formKey.currentState!.validate()) {
                  await modelRead.loginAdmin(
                    emailCtrl.text,
                    passKeyCtrl.text
                  ).catchError((error)=> displayFailure(context));
                }
              }
            )
      
          ],
        ),
      ),
    );
  }
}