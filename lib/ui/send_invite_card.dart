import 'dart:typed_data';

import 'package:alumni_webapp/controllers/_.dart';
import 'package:alumni_webapp/controllers/alumni_controller.dart';
import 'package:alumni_webapp/models/alumni.dart';
import 'package:alumni_webapp/ui/app_loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'button.dart';
import 'colors.dart';

class SendInviteCard extends StatefulWidget {
  const SendInviteCard({super.key});

  @override
  State<SendInviteCard> createState() => _SendInviteCardState();
}

class _SendInviteCardState extends State<SendInviteCard> {

  final _formKey = GlobalKey<FormState>();
  final titleCtrl = TextEditingController();
  final messageCtrl = TextEditingController();
  Uint8List? attachmentFile;
  Alumni? memberValue;
  bool isSendToAll = false;

  @override
  Widget build(BuildContext context) {
    double r = MediaQuery.of(context).devicePixelRatio;
    return appLoadingOverlay(child: Container(
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
            SizedBox(
              width: 181/r,
              child: Material(
                child: Text.rich(
                  TextSpan(
                    text: 'Create/Send ',
                    style: TextStyle(
                      fontSize: 16/r,
                      color: AppColors.mainGreen,
                      height: 1.2,
                      fontFamily: "Roboto"
                    ),
                    children: const [
                      TextSpan(
                        text: 'Invitations To Alumni',
                        style: TextStyle(
                          color: Colors.black
                        )
                      )
                    ]
                  )
                ),
              ),
            ),
            spacing(10/r),

            titleField,
            spacing(10/r),

            messageField ,
            spacing(10/r),

            attachmentField,
            spacing(10/r),  

            membersField,
            spacing(10/r),

            AppButton(
              label: 'Continue', 
              onPressed: (){
                if (_formKey.currentState!.validate()) {
                  context.read<Controller>().sendMail(
                  alumni: isSendToAll? context.read<Controller>().members : [memberValue!], 
                    title: titleCtrl.text, 
                    message: messageCtrl.text, 
                    attachment: attachmentFile
                    
                  );
                }
            })
            
          ],
        ),
      ),      
    ));
  }

  spacing (double height)=> SizedBox(height: height,);

  Widget get titleField{
    double r = MediaQuery.of(context).devicePixelRatio;
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Title',
            style: TextStyle(
              height: 0.7,
              fontFamily: 'Roboto',
              color: Colors.black,
              fontSize: 16/r
            ),
          ),
          SizedBox(height: 12/r,),
          TextFormField(
            controller: titleCtrl,
            style: TextStyle(
              height: 1.4,
              fontFamily: 'Roboto',
              color: Colors.black.withOpacity(0.7),
              fontSize: 16/r
            ),
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
      ),
    );
  }

  Widget get messageField{
    double r = MediaQuery.of(context).devicePixelRatio;
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Message',
            style: TextStyle(
              height: 0.7,
              fontFamily: 'Roboto',
              color: Colors.black,
              fontSize: 16/r
            ),
          ),
          SizedBox(height: 12/r,),
          TextFormField(
            minLines: 4,
            maxLines: 4,
            controller: messageCtrl,
            style: TextStyle(
              height: 1.4,
              fontFamily: 'Roboto',
              color: Colors.black.withOpacity(0.7),
              fontSize: 16/r
            ),
            decoration: InputDecoration(
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
      ),
    );
  }

  Widget get attachmentField{
    double r = MediaQuery.of(context).devicePixelRatio;
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Attachments',
            style: TextStyle(
              height: 0.7,
              fontFamily: 'Roboto',
              color: Colors.black,
              fontSize: 16/r
            ),
          ),
          SizedBox(height: 12/r,),
          Container(
            padding: EdgeInsets.all(24/r),
            height: 120/r,
            width: double.maxFinite,
            decoration: BoxDecoration(
              color: AppColors.textfieldGray,
              image: attachmentFile == null ? null : DecorationImage(
                fit: BoxFit.cover,
                opacity: 0.8,
                image: MemoryImage(attachmentFile!)
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () async{
                    final imagePicker = ImagePicker();
                    final xfile = await imagePicker.pickImage(source: ImageSource.gallery);

                    if (xfile != null) {
                      Uint8List imageBytes = await xfile.readAsBytes(); 
                      setState(() {
                        attachmentFile = imageBytes;
                      });
                    }

                  }, 
                  icon: Icon(
                    Icons.attach_file_outlined,
                    color: Colors.grey.shade800,
                  )
                )
              ],
            ),
          )
    
        ],
      ),
    );
  }

  Widget get membersField{
    double r = MediaQuery.of(context).devicePixelRatio;
    List<Alumni> options = context.read<Controller>().members;
    return Material(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Members',
                style: TextStyle(
                  height: 0.7,
                  fontFamily: 'Roboto',
                  color: Colors.black,
                  fontSize: 16/r
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'To All?',
                    style: TextStyle(
                      fontSize: 14/r,
                      fontWeight: FontWeight.w300
                    ),
                  ),
    
                  Checkbox(
                    value: isSendToAll, 
                    onChanged: (value){
                      setState(() {
                        isSendToAll = value!;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    side: BorderSide(
                      color: AppColors.mainGreen,
                      width: 1/r
                    ),
                  )
                ],
              )
            ],
          ),
          SizedBox(height: 4/r,),
          DropdownButtonFormField<Alumni?>(
            style: TextStyle(
              height: 1.4,
              fontFamily: 'Roboto',
              color: Colors.black.withOpacity(0.7),
              fontSize: 16/r
            ),
            decoration: InputDecoration(
              constraints: BoxConstraints.tight(Size(double.maxFinite, 54/r)),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              filled: true,
              fillColor: AppColors.textfieldGray,
            ),
            value: memberValue,
            items: List.generate(
              options.length, 
              (index) => DropdownMenuItem(
                value: options[index],
                child: Text(
                  options[index].name, 
                  style: TextStyle(
                    fontSize: 16/r,
                  ),
                )
              )
            ), 
            onChanged: (value){
              setState(() {
                memberValue = value;
              });
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
      ),
    );
  }
}