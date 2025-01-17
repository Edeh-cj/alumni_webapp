import 'package:alumni_webapp/constants.dart';
import 'package:alumni_webapp/controllers/alumni_controller.dart';
import 'package:alumni_webapp/models/alumni.dart';
import 'package:alumni_webapp/ui/button.dart';
import 'package:alumni_webapp/ui/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/_.dart';

class JoinCard extends StatefulWidget {
  const JoinCard({super.key});

  @override
  State<JoinCard> createState() => _JoinCardState();
}

class _JoinCardState extends State<JoinCard> {

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final occupationCtrl = TextEditingController();
  String? degreeCtrl ;
  String? deptCtrl ;
  String? yrOfGradCtrl ;
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
            if (value!=null) {
              return null;
            } else {
              return 'This Field must not be null';
            }
          },
        )

      ],
    ); 

    dropDownField(String label, List<String> listOptions, String? fieldValue, void Function(String?) onChange)=> Column(
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
        DropdownButtonFormField(
          decoration: InputDecoration(
            constraints: BoxConstraints.tight(Size(double.maxFinite, 54/r)),
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            filled: true,
            fillColor: AppColors.textfieldGray,
          ),
          value: fieldValue,
          items: List.generate(
            listOptions.length, 
            (index) => DropdownMenuItem(child: Text(
                listOptions[index], 
                style: TextStyle(
                  fontSize: 16/r,
                ),
              )
            )
          ), 
          onChanged: (value){
            onChange(value);
          },
          validator: (value) {
            if (value!=null) {
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
                  text: 'Join ',
                  style: TextStyle(
                    fontSize: 16/r,
                    color: AppColors.mainGreen,
                    height: 0.7,
                    fontFamily: "Roboto"
                  ),
                  children: const [
                    TextSpan(
                      text: 'The Alumni Network',
                      style: TextStyle(
                        color: Colors.black
                      )
                    )
                  ]
                )
              ),
            ),
            spacing,
            textfield('Name', nameCtrl),
            spacing,
            textfield('Email Address', emailCtrl),
            spacing,
            textfield('Occupation', occupationCtrl),
            spacing,
            dropDownField(
              'Degree', 
              degrees, 
              degreeCtrl, 
              (p0) {setState(() {
                degreeCtrl = p0;
              }); }
            ),
            spacing,
            dropDownField(
              'Department & Faculty', 
              departments, 
              deptCtrl, 
              (p0) {setState(() {
                deptCtrl = p0;
              }); }
            ),
            spacing,
            dropDownField(
              'Year Of Graduation', 
              yearOfGrads, 
              yrOfGradCtrl, 
              (p0) {setState(() {
                yrOfGradCtrl = p0;
              }); }
            ),
            spacing,
            AppButton(
              label: 'Continue', 
              onPressed: (){
                if (_formKey.currentState!.validate()) {
                  modelRead.createAlumni(
                    Alumni(
                      id: null,
                      name: nameCtrl.text,
                      email: emailCtrl.text,
                      occupation: occupationCtrl.text,
                      degree: degreeCtrl!,
                      department: deptCtrl!,
                      yearOfGraduation: yrOfGradCtrl!

                    )
                  );
                }
            })
          ],
        ),
      ),

    );
  }

  
}