import 'package:alumni_webapp/screens/colors.dart';
// import 'package:alumni_webapp/screens/send_invite_card.dart';
import 'package:flutter/material.dart';

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
              InkWell(
                onTap: (){},
                child: Icon(
                  Icons.menu,
                  color: AppColors.mainGreen,
                  size: 32/r,
                ),
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
          // InkWell(
          //   onTap: () {
          //     showDialog(
          //       barrierColor: Colors.black.withOpacity(0.2),
          //       context: context,
          //       builder: (context) => const Center(
          //         child: SendInviteCard(),
          //       ),
          //     );              
          //   },
          //   child: Row(
          //     mainAxisSize: MainAxisSize.min,
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Text(
          //         '+',
          //         style: TextStyle(
          //           color: AppColors.mainGreen,
          //           fontSize: 24/r,
          //           height: 0.7
          //         ),
          //       ),
          //       SizedBox(width: 16/r,),
          //       Text(
          //         'New Invitations',
          //         style: TextStyle(
          //           color: AppColors.mainGreen,
          //           fontSize: 16/r,
          //           height: 0.7
          //         ),
          //       )
          
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }
);