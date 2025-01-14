import 'package:alumni_webapp/screens/app_loading_overlay.dart';
import 'package:alumni_webapp/screens/colors.dart';
import 'package:alumni_webapp/screens/join_card.dart';
import 'package:alumni_webapp/screens/login_card.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  bool showLogin = false;

  @override
  Widget build(BuildContext context) {

    final r = MediaQuery.of(context).devicePixelRatio;

    return Scaffold(
      body: appLoadingOverlay(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0/r),
                child: SizedBox(
                  height: 52/r,
                  width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: showLogin,
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              showLogin = false;
                            });
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 32/r,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: !showLogin,
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              showLogin = true;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(4/r),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black.withOpacity(0.5)
                              ),
                              borderRadius: BorderRadius.circular(50)
                            ),                            
                            child: Icon(
                              Icons.admin_panel_settings,
                              color: AppColors.mainGreen,
                              size: 32/r,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0,) + EdgeInsets.only(top: 105/r) ,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 320/r,
                              child: Image.asset(
                                'assets/logo.png'
                              ),
                            ),
                            SizedBox(height: 40/r,),
                            SizedBox(
                              width: 851/r,
                              height: 116,
                              child: Text.rich(
                                TextSpan(
                                  text: 'Reconnect, Network, and Rediscover your passion for the ',
                                  style: TextStyle(
                                    fontSize: 48/r,
                                    fontFamily: 'Inter',
                                    height: 1.15
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'LIONS',
                                      style: TextStyle(color: AppColors.mainGreen)
                                    )
                                  ]
                                )
                              )
                            )
                          ],
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(167/r, 58/r),
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            shape: const BeveledRectangleBorder(side: BorderSide(width: 0.5)),
                          ),
                          onPressed: (){
                        
                        
                          }, 
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Donate',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16/r,
                                ),
                              ),
                              const Icon(Icons.favorite, color: Color.fromRGBO(245, 15, 15, 1),)
                            ],
                          )
                        ),
                      ],
                    ),
              
                    Align(
                      alignment: Alignment.topRight,
                      child: showLogin? const LoginCard() : const JoinCard()
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}