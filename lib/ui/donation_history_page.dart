import 'package:alumni_webapp/controllers/donations_controller.dart';
import 'package:alumni_webapp/models/donation_record.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controllers/_.dart';
import 'app_loading_overlay.dart';
import 'colors.dart';
import 'custom_app_bar.dart';
import 'send_invite_card.dart';

class DonationHistoryPage extends StatefulWidget {
  const DonationHistoryPage({super.key});

  @override
  State<DonationHistoryPage> createState() => _DonationHistoryPageState();
}

class _DonationHistoryPageState extends State<DonationHistoryPage> {
  @override
  Widget build(BuildContext context) {
    double r = MediaQuery.of(context).devicePixelRatio;
    return appLoadingOverlay(
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: customAppBar('Donation History'),
        ),
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 36.0/r),
                child: donationHistoryTable
              )
            ),
            SizedBox(width: 36/r,),
            Padding(
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
            ),
            
          ],
        ),
      )
    );
    
  }

  spacing(double height)=> SizedBox(height: height,);

  Widget get donationHistoryTable{
    double r = MediaQuery.of(context).devicePixelRatio;
    return Expanded(
      child: FutureBuilder<List<DonationRecord>>(
        future: context.read<Controller>().getDonationHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ) {
            return Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 16/r),
                child: const SizedBox.square(
                  dimension: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
            
          } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            final data = snapshot.data!;
            return Table(

              children: [tableHeader]+List.generate(
                data.length, 
                (index) => TableRow(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black.withOpacity(0.2),
                      )
                    )
                  ),
                  children: [
                    SizedBox(
                      height: 54/r,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 12.0/r),
                          child: Text(
                            data[index].name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16/r,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 54/r,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data[index].email,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16/r,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 54/r,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          DateFormat('d MMM, yyyy').format(data[index].time),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16/r,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 54/r,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'N${formatIntWithCommas(data[index].amount)}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16/r,
                          ),
                        ),
                      ),
                    ),
                  ]
                )
              ),
            );
          } else {
            return Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: 16/r),
                child: Text(
                  'error ${snapshot.error}',
                  style: TextStyle(
                    fontSize: 16/r,
                    color: Colors.red
                  ),
                ),
              ),
            );
          }
        },
      )
    );
  }

  TableRow get tableHeader{
    double r = MediaQuery.of(context).devicePixelRatio;
    return TableRow(
      decoration: BoxDecoration(
        color: AppColors.mainGreen.withOpacity(0.23)
      ),
      children: [
        SizedBox(
          height: 54/r,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 12.0/r),
              child: Text(
                'Name',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16/r,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 54/r,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Email',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16/r,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 54/r,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Time',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16/r,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 54/r,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Amount',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16/r,
              ),
            ),
          ),
        ),
      ]
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

  formatIntWithCommas(int b){
    final formatter = NumberFormat("#,###");
    return formatter.format(b);
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
            child: FutureBuilder<int>(
              future: context.read<Controller>().getTotalDonations(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ) {
                  return SizedBox(
                    height: 80/r,
                    width: 200/r,
                    child: const Center(
                      child: SizedBox.square(
                        dimension: 30,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                  
                } else if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                  return Text(
                    'N${formatIntWithCommas(snapshot.data!)}',
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