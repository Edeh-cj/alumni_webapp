import 'package:alumni_webapp/controllers/_.dart';
import 'package:alumni_webapp/controllers/auth_controller.dart';
import 'package:alumni_webapp/ui/colors.dart';
import 'package:alumni_webapp/ui/donation_history_page.dart';
// import 'package:alumni_webapp/screens/send_invite_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

customAppBar (String title, )=> Builder(
  builder: (context){
    double r =MediaQuery.of(context).devicePixelRatio;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12/r),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.05)))
      ),
      height: 52/r,
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PopupMenuButton(
                icon: Icon(
                  Icons.menu,
                  color: AppColors.mainGreen,
                  size: 32/r,
                ),
                itemBuilder: (context)=>[
                  PopupMenuItem(
                    onTap: () => context.read<Controller>().signout(),
                    child: Text(
                      'SignOut',
                      style: TextStyle(
                        fontSize: 16/r,
                        color: Colors.black,
                      ),
                    )
                  ),
                  PopupMenuItem(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const DonationHistoryPage())),
                    child: Text(
                      'Donation History',
                      style: TextStyle(
                        fontSize: 16/r,
                        color: Colors.black,
                      ),
                    )
                  ),
                ]
              ),
              SizedBox(width: 16/r,),
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24/r,
                ),  
              )
            ],
          ),
        ],
      ),
    );
  }
);