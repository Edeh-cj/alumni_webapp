import 'package:alumni_webapp/controllers/_.dart';
import 'package:alumni_webapp/controllers/donations_controller.dart';
import 'package:alumni_webapp/ui/display_failure.dart';
import 'package:alumni_webapp/ui/display_success.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:provider/provider.dart';

import 'button.dart';
import 'colors.dart';

class PaymentDetailsForm extends StatefulWidget {
  const PaymentDetailsForm({super.key});

  @override
  State<PaymentDetailsForm> createState() => _PaymentDetailsFormState();
}

class _PaymentDetailsFormState extends State<PaymentDetailsForm> {
  final _detailFormKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: ColorFiltered(
        colorFilter: ColorFilter.mode(
                  context.read<Controller>().isLoading
                      ? Colors.black.withOpacity(0.1)
                      : Colors.transparent,
                  BlendMode.darken),
              child: detailForm)),
      Visibility(
        visible: context.watch<Controller>().isLoading,
        child: const Center(
          child:
            SizedBox.square(dimension: 40, child: CircularProgressIndicator()),
      ))
    ]);
  }

  Container get detailForm {
    double r = MediaQuery.of(context).devicePixelRatio;
    return Container(
      width: 408 / r,
      padding: EdgeInsets.all(24 / r),
      decoration: BoxDecoration(
          color: AppColors.cardBackground,
          border: Border.all(color: Colors.black.withOpacity(0.15))),
      child: Form(
        key: _detailFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spacing(10 / r),
            nameField,
            spacing(10 / r),
            emailField,
            spacing(10 / r),
            amountField,
            spacing(10 / r),
            AppButton(
                label: 'Continue',
                onPressed: () async {
                  if (_detailFormKey.currentState!.validate()) {
                    await context
                        .read<Controller>()
                        .onDonateClick(
                          nameCtrl.text,
                          emailCtrl.text,
                          int.parse(amountCtrl.text)
                          )
                        .onError((error, stackTrace) => displayFailure(context));
                  }
                }
              )
          ],
        ),
      ),
    );
  }

  spacing(double height) => SizedBox(
        height: height,
      );

  Widget get nameField {
    double r = MediaQuery.of(context).devicePixelRatio;
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: TextStyle(
                height: 0.7,
                fontFamily: 'Roboto',
                color: Colors.black,
                fontSize: 16 / r),
          ),
          SizedBox(
            height: 12 / r,
          ),
          TextFormField(
            controller: nameCtrl,
            style: TextStyle(
                height: 1.4,
                fontFamily: 'Roboto',
                color: Colors.black.withOpacity(0.7),
                fontSize: 16 / r),
            decoration: InputDecoration(
              hintText: 'Nnabuike Ugwu',
              constraints: BoxConstraints.tight(Size(double.maxFinite, 54 / r)),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              filled: true,
              fillColor: AppColors.textfieldGray,
            ),
            validator: (value) {
              if (value != null
                  ) {
                return null;
              } else {
                return 'Invalid input';
              }
            },
          )
        ],
      ),
    );
  }

   Widget get emailField {
    double r = MediaQuery.of(context).devicePixelRatio;
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: TextStyle(
                height: 0.7,
                fontFamily: 'Roboto',
                color: Colors.black,
                fontSize: 16 / r),
          ),
          SizedBox(
            height: 12 / r,
          ),
          TextFormField(
            controller: emailCtrl,
            style: TextStyle(
                height: 1.4,
                fontFamily: 'Roboto',
                color: Colors.black.withOpacity(0.7),
                fontSize: 16 / r),
            decoration: InputDecoration(
              hintText: 'nnabuike@gmail.com',
              constraints: BoxConstraints.tight(Size(double.maxFinite, 54 / r)),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              filled: true,
              fillColor: AppColors.textfieldGray,
            ),
            validator: (value) {
              if (value != null
                  ) {
                return null;
              } else {
                return 'Invalid input';
              }
            },
          )
        ],
      ),
    );
  }

  Widget get amountField {
    double r = MediaQuery.of(context).devicePixelRatio;
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Amount',
            style: TextStyle(
                height: 0.7,
                fontFamily: 'Roboto',
                color: Colors.black,
                fontSize: 16 / r),
          ),
          SizedBox(
            height: 12 / r,
          ),
          TextFormField(
            controller: amountCtrl,
            style: TextStyle(
                height: 1.4,
                fontFamily: 'Roboto',
                color: Colors.black.withOpacity(0.7),
                fontSize: 16 / r),
            decoration: InputDecoration(
              hintText: 'N 0.00',
              constraints: BoxConstraints.tight(Size(double.maxFinite, 54 / r)),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              filled: true,
              fillColor: AppColors.textfieldGray,
            ),
            validator: (value) {
              if (value != null ) {
                return null;
              } else {
                return 'Invalid input';
              }
            },
          )
        ],
      ),
    );
  }

}
