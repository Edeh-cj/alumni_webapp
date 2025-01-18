import 'package:alumni_webapp/controllers/_.dart';
import 'package:alumni_webapp/controllers/donations_controller.dart';
import 'package:alumni_webapp/ui/app_loading_overlay.dart';
import 'package:alumni_webapp/ui/colors.dart';
import 'package:alumni_webapp/ui/custom_app_bar.dart';
import 'package:alumni_webapp/ui/donation_history_page.dart';
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
    List<Alumni> members = context.watch<Controller>().members;
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
                padding: EdgeInsets.only(left: 48.0/r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    searchBar,
                    spacing(32/r),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            members.length, 
                            (index) => alumniListCard(members[index])
                          ),
                        ),
                      ),
                    )

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
                    
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context)=> const DonationHistoryPage())
                        );
                      },
                      child: donationBox)
                  ],
                ),
              )
            ),
            
          ],
        ),
      )
    );
    
  }

  spacing(double height)=> SizedBox(height: height,);

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

  Widget get searchBar {
    double r = MediaQuery.of(context).devicePixelRatio;
    return TextField(
      decoration: InputDecoration(
        fillColor:const Color.fromRGBO(221, 221, 221, 0.2),
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none
        ), 
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),     
        constraints: BoxConstraints.tight(Size(double.maxFinite, 50/r))
      ),
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
                    height: 1.3
                  ),
                ),
                Text(
                  alumni.occupation,
                  style: TextStyle(
                    fontSize: 16/r,
                    color: Colors.black,
                    height: 1.3
                  ),
                ),
                Text(
                  '${alumni.department} - ${alumni.yearOfGraduation}',
                  style: TextStyle(
                    fontSize: 16/r,
                    color: Colors.black,
                    height: 1.3
                  ),
                ),
                Text(
                  alumni.email,
                  style: TextStyle(
                    fontSize: 16/r,
                    color: Colors.black,
                    height: 1.3
                  ),
                ),
                
              ],
            )
          ),
          SizedBox(width: 16/r,),

          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStatePropertyAll<EdgeInsets>(EdgeInsets.symmetric(vertical: 16/r, horizontal: 24/r)),
              side: MaterialStatePropertyAll<BorderSide>(BorderSide(color: AppColors.mainGreen)),
              shape: const MaterialStatePropertyAll<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
              elevation: const MaterialStatePropertyAll<double>(0),
              backgroundColor: const MaterialStatePropertyAll<Color>(Colors.transparent)
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

  Widget get donationBox {
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
            child: FutureBuilder<int>(
              future: context.read<Controller>().getTotalDonations(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ) {
                  return SizedBox(
                    height: 80/r,
                    width: 200,
                    child: const Center(
                      child: SizedBox.square(
                        dimension: 30,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                  
                } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return Text(
                    'N${formatIntWithCommas(context.watch<Controller>().totalDonations)}',
                    style: TextStyle(
                      fontSize: 48/r,
                      color: AppColors.mainGreen,
                      height: 1.2
                    ),
                  );
                } else {
                  return Text(
                    'error',
                    style: TextStyle(
                      fontSize: 16/r,
                      color: Colors.red
                    ),
                  );
                }
              }
            ),
          )
        ],
      ),
    );
  } 
}