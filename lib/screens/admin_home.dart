import 'package:alumni_webapp/controllers/_.dart';
import 'package:alumni_webapp/screens/app_loading_overlay.dart';
import 'package:alumni_webapp/screens/colors.dart';
import 'package:alumni_webapp/screens/custom_app_bar.dart';
import 'package:alumni_webapp/screens/join_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/alumni.dart';
import 'send_invite_card.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    double r = MediaQuery.of(context).devicePixelRatio;
    return appLoadingOverlay(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: customAppBar('Administrative Page'),
        ),
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //create searchBar

                  ],
                ),
              )
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(right: 48/r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0/r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textButton(
                            'New Invitations', 
                            (){
                            showDialog(
                                barrierColor: Colors.black.withOpacity(0.2),
                                context: context,
                                builder: (context) => const Center(
                                  child: SendInviteCard(),
                                ),
                              );  
                          }),
                          SizedBox(height: 16/r),
                          textButton(
                            'Create Notifications', 
                            (){
                            showDialog(
                                barrierColor: Colors.black.withOpacity(0.2),
                                context: context,
                                builder: (context) => const Center(
                                  child: SendInviteCard(),
                                ),
                              );  
                          }),
                        ],
                      ),
                    ),

                    SizedBox(height: 24/r,),
                    
                    donationBox
                  ],
                ),
              )
            ),
            
          ],
        ),
      )
    );
    
  }

  Widget textButton( String title ,Function() onTap) {
    return Builder(
      builder: (context) {
        double r = MediaQuery.of(context).devicePixelRatio;
        return InkWell(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '+',
                style: TextStyle(
                  color: AppColors.mainGreen,
                  fontSize: 24/r,
                  height: 0.7
                ),
              ),
              SizedBox(width: 16/r,),
              Text(
                title,
                style: TextStyle(
                  color: AppColors.mainGreen,
                  fontSize: 16/r,
                  height: 0.7
                ),
              )
        
            ],
          ),
        );
      }
    );
  }

  Widget alumniListCard(Alumni alumni){
    double r = MediaQuery.of(context).devicePixelRatio;
    return Container(
      constraints: BoxConstraints(
        minWidth: 800/r,
        maxWidth: 1000/r
      ),
      padding: EdgeInsets.symmetric(vertical: 16/r, horizontal: 24/r),
      margin: EdgeInsets.only(bottom: 16/r),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black.withOpacity(0.05)
        )
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 20/r,
          ),
          SizedBox(width: 16/r,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alumni.name,
                  style: TextStyle(
                    fontSize: 16/r,
                    color: Colors.black,
                    height: 0.9
                  ),
                ),
                
              ],
            )
          ),
          SizedBox(width: 16/r,),

          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(vertical: 16/r, horizontal: 24/r)),
              side: MaterialStatePropertyAll<BorderSide>(BorderSide(color: AppColors.mainGreen))
            ),
            onPressed: (){}, 
            child: Text(
              'Send Mail',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14/r,
                height: 0.8
              ),
            )
          )
        ],
      ),

    );
  }
  Widget  get donationBox {
    double r = MediaQuery.of(context).devicePixelRatio;
    formatIntWithCommas(int b){
      final formatter = NumberFormat("#,###");
      return formatter.format(b);
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 28/r, vertical: 18/r),
      decoration: BoxDecoration(
        border: Border.all()
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'donations:',
            style: TextStyle(
              color: Colors.black,
              fontSize: 14/r,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0/r),
            child: Text(
              'N${formatIntWithCommas(context.watch<Controller>().totalDonations)}',
              style: TextStyle(
                fontSize: 48/r,
                color: AppColors.mainGreen,
                height: 1.2
              ),
            ),
          )
        ],
      ),
    );
  } 
}