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
  final _tokenFormKey = GlobalKey<FormState>();
  final cardNumberCtrl = TextEditingController();
  final cvvCtrl = TextEditingController();
  final expiryCtrl = TextEditingController();
  final amountCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final tokenCtrl = TextEditingController();

  late Widget display = detailForm;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(child: ColorFiltered(
        colorFilter: ColorFilter.mode(
                  context.read<Controller>().isLoading
                      ? Colors.black.withOpacity(0.1)
                      : Colors.transparent,
                  BlendMode.darken),
              child: display)),
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
            cardNumberField,
            spacing(10 / r),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: cvvField,
                ),
                SizedBox(
                  width: 24 / r,
                ),
                Expanded(
                  flex: 1,
                  child: expiryField,
                ),
              ],
            ),
            spacing(10 / r),
            amountField,
            spacing(10 / r),
            passwordField,
            spacing(10 / r),
            AppButton(
                label: 'Continue',
                onPressed: () async {
                  if (!_detailFormKey.currentState!.validate()) {
                    await context
                        .read<Controller>()
                        .makeDonations(
                          cardNumber: int.parse(cardNumberCtrl.text), 
                          cvv: int.parse(cardNumberCtrl.text), 
                          expiryDate: int.parse(expiryCtrl.text), 
                          amount: int.parse(amountCtrl.text), 
                          cardPin: int.parse(passwordCtrl.text)
                          )
                        .then((value) {
                      setState(() {
                        display = tokenForm;
                      });
                    }).onError((error, stackTrace) => displayFailure(context));
                  }
                })
          ],
        ),
      ),
    );
  }

  Widget get tokenForm {
    double r = MediaQuery.of(context).devicePixelRatio;
    return Container(
      width: 408 / r,
      padding: EdgeInsets.all(24 / r),
      decoration: BoxDecoration(
          color: AppColors.cardBackground,
          border: Border.all(color: Colors.black.withOpacity(0.15))),
      child: Form(
        key: _tokenFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spacing(10 / r),
            tokenField,
            spacing(10 / r),
            AppButton(
              label: 'Submit',
              onPressed: () async {
                if (!_tokenFormKey.currentState!.validate()) {
                  await context
                      .read<Controller>()
                      .sendPaymentToken(
                        int.parse(tokenCtrl.text)
                      )
                      .then((value) {
                        displaySuccess(context);
                  }).onError((error, stackTrace) => displayFailure(context));
                }
              })
          ],
        ),
      ),
    );
  }

  spacing(double height) => SizedBox(
        height: height,
      );

  Widget get cardNumberField {
    double r = MediaQuery.of(context).devicePixelRatio;
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Card Number',
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
            controller: cardNumberCtrl,
            maxLength: 16,
            buildCounter: (context,
                    {required currentLength, required isFocused, maxLength}) =>
                null,
            style: TextStyle(
                height: 1.4,
                fontFamily: 'Roboto',
                color: Colors.black.withOpacity(0.7),
                fontSize: 16 / r),
            inputFormatters: [CreditCardNumberInputFormatter()],
            decoration: InputDecoration(
              hintText: 'XXXX XXXX XXXX XXXX',
              constraints: BoxConstraints.tight(Size(double.maxFinite, 54 / r)),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              filled: true,
              fillColor: AppColors.textfieldGray,
            ),
            validator: (value) {
              if (value != null &&
                  value.contains(RegExp(r'^[0-9]+$')) &&
                  value.length < 16) {
                return null;
              } else {
                return 'This Field must be Numeric and not null';
              }
            },
          )
        ],
      ),
    );
  }

  Widget get cvvField {
    double r = MediaQuery.of(context).devicePixelRatio;
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CVV',
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
            controller: cvvCtrl,
            maxLength: 3,
            buildCounter: (context,
                    {required currentLength, required isFocused, maxLength}) =>
                null,
            style: TextStyle(
                height: 1.4,
                fontFamily: 'Roboto',
                color: Colors.black.withOpacity(0.7),
                fontSize: 16 / r),
            inputFormatters: [CreditCardCvcInputFormatter()],
            decoration: InputDecoration(
              hintText: 'XXX',
              constraints: BoxConstraints.tight(Size(double.maxFinite, 54 / r)),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              filled: true,
              fillColor: AppColors.textfieldGray,
            ),
            validator: (value) {
              if (value != null &&
                  value.contains(RegExp(r'^(0-9)+$')) &&
                  value.length == 3) {
                return null;
              } else {
                return 'This Field must not be null';
              }
            },
          )
        ],
      ),
    );
  }

  Widget get expiryField {
    double r = MediaQuery.of(context).devicePixelRatio;
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expiry Date',
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
            controller: expiryCtrl,
            maxLength: 3,
            buildCounter: (context,
                    {required currentLength, required isFocused, maxLength}) =>
                null,
            style: TextStyle(
                height: 1.4,
                fontFamily: 'Roboto',
                color: Colors.black.withOpacity(0.7),
                fontSize: 16 / r),
            inputFormatters: [CreditCardCvcInputFormatter()],
            decoration: InputDecoration(
              hintText: 'XX/XX',
              constraints: BoxConstraints.tight(Size(double.maxFinite, 54 / r)),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              filled: true,
              fillColor: AppColors.textfieldGray,
            ),
            validator: (value) {
              if (value != null &&
                  value.contains(RegExp(r'^(0-9)+$')) &&
                  value.length == 4) {
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
            inputFormatters: [
              CurrencyInputFormatter(
                  thousandSeparator: ThousandSeparator.Comma,
                  leadingSymbol: 'N',
                  mantissaLength: 2,
                  useSymbolPadding: true)
            ],
            decoration: InputDecoration(
              hintText: 'N 0.00',
              constraints: BoxConstraints.tight(Size(double.maxFinite, 54 / r)),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              filled: true,
              fillColor: AppColors.textfieldGray,
            ),
            validator: (value) {
              if (value != null &&
                  value.contains(RegExp(r'^(0-9)+$')) &&
                  value.length == 4) {
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

  Widget get passwordField {
    double r = MediaQuery.of(context).devicePixelRatio;
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
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
            controller: expiryCtrl,
            maxLength: 4,
            obscureText: true,
            buildCounter: (context,
                    {required currentLength, required isFocused, maxLength}) =>
                null,
            style: TextStyle(
                height: 1.4,
                fontFamily: 'Roboto',
                color: Colors.black.withOpacity(0.7),
                fontSize: 16 / r),
            inputFormatters: [CreditCardCvcInputFormatter()],
            decoration: InputDecoration(
              hintText: '****',
              constraints: BoxConstraints.tight(Size(double.maxFinite, 54 / r)),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              filled: true,
              fillColor: AppColors.textfieldGray,
            ),
            validator: (value) {
              if (value != null &&
                  value.contains(RegExp(r'^(0-9)+$')) &&
                  value.length == 4) {
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

  Widget get tokenField {
    double r = MediaQuery.of(context).devicePixelRatio;
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '6-Digit Pin From Email',
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
            controller: cvvCtrl,
            maxLength: 3,
            buildCounter: (context,
                    {required currentLength, required isFocused, maxLength}) =>
                null,
            style: TextStyle(
                height: 1.4,
                fontFamily: 'Roboto',
                color: Colors.black.withOpacity(0.7),
                fontSize: 16 / r),
            inputFormatters: [CreditCardNumberInputFormatter()],
            decoration: InputDecoration(
              hintText: 'XXX XXX',
              constraints: BoxConstraints.tight(Size(double.maxFinite, 54 / r)),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              filled: true,
              fillColor: AppColors.textfieldGray,
            ),
            validator: (value) {
              if (value != null &&
                  value.contains(RegExp(r'^(0-9)+$')) &&
                  value.length == 3) {
                return null;
              } else {
                return 'This Field must not be null';
              }
            },
          )
        ],
      ),
    );
  }
}
