import 'package:action_slider/action_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/Widgets/kText.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/models/care_takers_model.dart';

import '../widgets/primary_button.dart';
import '../widgets/secondary_button.dart';

class ProfileDetailsView extends StatefulWidget {
  const ProfileDetailsView({super.key, required this.id});

  final String id;

  @override
  State<ProfileDetailsView> createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends State<ProfileDetailsView> with SingleTickerProviderStateMixin{
  double pi = 3.14;
  bool slidefinish = false;

  late AnimationController? animationController;
  Animation<double>? opacityAnimation;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1),reverseDuration: const Duration(seconds: 1),animationBehavior: AnimationBehavior.preserve);
    opacityAnimation = CurvedAnimation(
        parent: Tween<double>(begin: 1, end: 0).animate(animationController!),
        curve: Curves.easeInOutExpo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Constants.appBackgroundolor,
      appBar: AppBar(
        backgroundColor: Constants.appBackgroundolor,
        title: KText(
          text: "Profile Details",
          style: GoogleFonts.poppins(
            color: Constants.darkGrey,
          ),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(
          vertical: height/58.1538,
          horizontal: width/27.6923
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FutureBuilder(
            future: FirebaseFirestore.instance.collection('CareTakers').doc(widget.id).get(),
            builder: (ctx,snap){
              if(snap.hasData){
                CareTakersModel careTaker = CareTakersModel.fromJson(snap.data!.data() as Map<String,dynamic>);
                double rating = 0.0;
                careTaker.rating.forEach((element) {
                  rating += element.rating!;
                });
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: height/9.45,
                          width: width/4.5,
                          decoration: BoxDecoration(
                            color: Constants.primaryAppColor,
                            image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    careTaker.imgUrl
                                )
                            ),
                            borderRadius: BorderRadius.circular(100),
                          ),
                        ),
                         SizedBox(width: width/18),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: "${careTaker.firstName} ${careTaker.lastName}",
                              style: GoogleFonts.poppins(
                                  color: Constants.darkGrey,
                                  fontSize: width/15.652,
                                  fontWeight: FontWeight.w700),
                            ),
                            KText(
                              text: "${careTaker.position} at ${careTaker.workingAt}",
                              style: GoogleFonts.poppins(
                                  color: Constants.darkGrey,
                                  fontSize: width/30,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: height/37.8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Material(
                          elevation: 10,
                          color: Constants.primaryWhite,
                          borderRadius: BorderRadius.circular(15),
                          shadowColor: Colors.black12,
                          child: Container(
                            height: height/11.6307,
                            width: width/1.3846,
                            decoration: BoxDecoration(
                                color: Constants.primaryWhite,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: width/45),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      KText(
                                        text: "Rating",
                                        style: GoogleFonts.poppins(
                                            color: Constants.semiGrey,
                                            fontSize: width/24,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      KText(
                                        text: (rating/careTaker.rating.length).toString(),
                                        style: GoogleFonts.poppins(
                                            color: Constants.darkGrey,
                                            fontSize: width/32.727,
                                            fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height/63, bottom: height/63),
                                  child: VerticalDivider(thickness: 1),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    KText(
                                      text: "Experience",
                                      style: GoogleFonts.poppins(
                                          color: Constants.semiGrey,
                                          fontSize: width/24,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    KText(
                                      text: "${careTaker.yearsOfExperience} yrs+",
                                      style: GoogleFonts.poppins(
                                          color: Constants.darkGrey,
                                          fontSize: width/32.727,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: height/63, bottom: height/63),
                                  child: VerticalDivider(thickness: 1),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: width/45),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      KText(
                                        text: "Work on",
                                        style: GoogleFonts.poppins(
                                            color: Constants.semiGrey,
                                            fontSize: width/24,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      KText(
                                        text: "${careTaker.totalWorks}+",
                                        style: GoogleFonts.poppins(
                                            color: Constants.darkGrey,
                                            fontSize:width/ 32.727,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Material(
                          elevation: 10,
                          color: Constants.primaryWhite,
                          borderRadius: BorderRadius.circular(15),
                          shadowColor: Colors.black12,
                          child: Container(
                              height: height/11.630,
                              width: width/5.538,
                              decoration: BoxDecoration(
                                  color: Constants.primaryWhite,
                                  borderRadius: BorderRadius.circular(15)),
                              padding:  EdgeInsets.symmetric(
                                horizontal: width/22.5,
                                vertical: height/47.25
                              ),
                              child: Icon(
                                Icons.bookmark_border,
                                color: Constants.primaryAppColor,
                                size: 40,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: height/37.8),
                    KText(
                      text: "Experience",
                      style: GoogleFonts.poppins(
                          color: Constants.darkGrey,
                          fontSize: width/18,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: height/37.8),
                    SizedBox(
                      width: size.width,
                      child: KText(
                        text: careTaker.workExperience,
                        style: GoogleFonts.poppins(
                          color: Constants.lightGrey,
                          fontSize: width/24,
                        ),
                      ),
                    ),
                    SizedBox(height: height/37.8),
                    Divider(thickness: 2),
                    SizedBox(height: height/37.8),
                    KText(
                      text: "Contact Details",
                      style: GoogleFonts.poppins(
                          color: Constants.darkGrey,
                          fontSize: width/18,
                          fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: height/37.8),
                    SizedBox(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Material(
                            elevation: 10,
                            color: Constants.primaryWhite,
                            borderRadius: BorderRadius.circular(15),
                            shadowColor: Colors.black12,
                            child: Container(
                              height: 50,
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Constants.primaryWhite,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: width/18),
                                    child: Icon(
                                      Icons.phone,
                                      color: Constants.primaryAppColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width/36.0,
                                  ),
                                  KText(
                                    text: "+91 82XXX XXXX",
                                    style: GoogleFonts.poppins(
                                        color: Constants.lightGrey,
                                        fontSize: width/24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Material(
                            elevation: 10,
                            color: Constants.primaryWhite,
                            borderRadius: BorderRadius.circular(15),
                            shadowColor: Colors.black12,
                            child: Container(
                              height: 50,
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Constants.primaryWhite,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: width/18),
                                    child: Icon(
                                      Icons.email_outlined,
                                      color: Constants.primaryAppColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width/36.0,
                                  ),
                                  KText(
                                    text: "shirXXXX@XXX.com",
                                    style: GoogleFonts.poppins(
                                        color: Constants.lightGrey,
                                        fontSize: width/24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Material(
                            elevation: 10,
                            color: Constants.primaryWhite,
                            borderRadius: BorderRadius.circular(15),
                            shadowColor: Colors.black12,
                            child: Container(
                              height: 50,
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: Constants.primaryWhite,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(left: width/18),
                                    child: Icon(
                                      Icons.location_pin,
                                      color: Constants.primaryAppColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width/36.0,
                                  ),
                                  KText(
                                    text: "Connect to View location",
                                    style: GoogleFonts.poppins(
                                        color: Constants.lightGrey,
                                        fontSize: width/24,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            transitionAnimationController: animationController,
                            builder: (builder) {
                              return Container(
                                height: 490,
                                decoration: BoxDecoration(
                                    color: Constants.primaryWhite,
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                    )
                                ),
                                padding:  EdgeInsets.symmetric(horizontal: width/24),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(top: height/75.6),
                                      child: Center(
                                        child: KText(
                                          text: "Contact Details",
                                          style: GoogleFonts.poppins(
                                            color: Constants.darkGrey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: width/18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        KText(
                                          text: "Name :",
                                          style: GoogleFonts.poppins(
                                            color: Constants.darkGrey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: width/20,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        KText(
                                          text: "${careTaker.firstName} ${careTaker.lastName}",
                                          style: GoogleFonts.poppins(
                                            color: Constants.darkGrey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: width/25.714,
                                          ),
                                        ),
                                        Divider(thickness: 1,)
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        KText(
                                          text: "Phone No :",
                                          style: GoogleFonts.poppins(
                                            color: Constants.darkGrey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: width/20,
                                          ),
                                        ),
                                         SizedBox(height: height/75.6),
                                        KText(
                                          text: careTaker.phone,
                                          style: GoogleFonts.poppins(
                                            color: Constants.darkGrey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: width/25.714,
                                          ),
                                        ),
                                        Divider(thickness: 1,)
                                      ],
                                    ),
                                     SizedBox(height: height/75.6),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        KText(
                                          text: "Location :",
                                          style: GoogleFonts.poppins(
                                            color: Constants.darkGrey,
                                            fontWeight: FontWeight.w600,
                                            fontSize:  width/20,
                                          ),
                                        ),
                                         SizedBox(height: height/75.6),
                                        KText(
                                          text: careTaker.address,
                                          style: GoogleFonts.poppins(
                                            color: Constants.darkGrey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: width/25.7142,
                                          ),
                                        ),
                                        Divider(thickness: 1,)
                                      ],
                                    ),
                                     SizedBox(height: height/75.6),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        KText(
                                          text: "Mail ID :",
                                          style: GoogleFonts.poppins(
                                            color: Constants.darkGrey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: width/20,
                                          ),
                                        ),
                                         SizedBox(height: height/75.6),
                                        KText(
                                          text: careTaker.email,
                                          style: GoogleFonts.poppins(
                                            color: Constants.darkGrey,
                                            fontWeight: FontWeight.w600,
                                            fontSize: width/25.7142,
                                          ),
                                        ),
                                        Divider(thickness: 1,)
                                      ],
                                    ),
                                     SizedBox(height: height/37.8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        SecondaryButton(
                                            title: 'Cancel',
                                            onTap: (){
                                              Navigator.pop(context);
                                            }
                                        ),
                                        PrimaryButton(
                                            title: 'Call Now',
                                            onTap: (){
                                              Navigator.pop(context);
                                            }
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              );
                            });
                      },
                      child: Container(
                        height: 50,
                        width: size.width*0.9,
                        decoration: BoxDecoration(
                          color: Constants.primaryAppColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: width/36.0),
                            child: CircleAvatar(
                              backgroundColor: Constants.primaryWhite,
                              child: Center(
                                child: Transform.rotate(
                                  angle: -0.05,
                                  child: Image.asset(
                                    "assets/fast-forward.png",
                                    height: 18,
                                    width: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(horizontal: width/18),
                            child: Text(
                                'Connect Now',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  fontSize: width/18
                                ),
                              ),
                          ),
                          ],
                        ),
                      ),
                    )

                    // ActionSlider.dual(
                    //   backgroundBorderRadius: BorderRadius.circular(100),
                    //   foregroundBorderRadius: BorderRadius.circular(100),
                    //   width: 330.0,
                    //   backgroundColor: const Color(0xff2663FF),
                    //   toggleColor: Colors.white,
                    //   onTap: (ActionSlidercontroller, value) {
                    //     showModalBottomSheet(
                    //         context: context,
                    //         isScrollControlled: true,
                    //         transitionAnimationController: animationController,
                    //         builder: (builder) {
                    //           return Container(
                    //             height: 490,
                    //             decoration: BoxDecoration(
                    //                 color: Constants.primaryWhite,
                    //                 borderRadius: const BorderRadius.only(
                    //                   topRight: Radius.circular(20),
                    //                   topLeft: Radius.circular(20),
                    //                 )
                    //             ),
                    //             padding: const EdgeInsets.symmetric(horizontal: 15),
                    //             child: Column(
                    //               children: [
                    //                 Padding(
                    //                   padding: const EdgeInsets.only(top: 10),
                    //                   child: Center(
                    //                     child: Text(
                    //                       "Contact Details",
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 20,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //                 const SizedBox(height: 10),
                    //                 Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       "Name :",
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 18,
                    //                       ),
                    //                     ),
                    //                     const SizedBox(height: 10),
                    //                     Text(
                    //                       "${careTaker.firstName} ${careTaker.lastName}",
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 14,
                    //                       ),
                    //                     ),
                    //                     Divider(thickness: 1,)
                    //                   ],
                    //                 ),
                    //                 const SizedBox(height: 10),
                    //                 Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       "Phone No :",
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 18,
                    //                       ),
                    //                     ),
                    //                     const SizedBox(height: 10),
                    //                     Text(
                    //                       careTaker.phone,
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 14,
                    //                       ),
                    //                     ),
                    //                     Divider(thickness: 1,)
                    //                   ],
                    //                 ),
                    //                 const SizedBox(height: 10),
                    //                 Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       "Location :",
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 18,
                    //                       ),
                    //                     ),
                    //                     const SizedBox(height: 10),
                    //                     Text(
                    //                       careTaker.address,
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 14,
                    //                       ),
                    //                     ),
                    //                     Divider(thickness: 1,)
                    //                   ],
                    //                 ),
                    //                 const SizedBox(height: 10),
                    //                 Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: [
                    //                     Text(
                    //                       "Mail ID :",
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 18,
                    //                       ),
                    //                     ),
                    //                     const SizedBox(height: 10),
                    //                     Text(
                    //                       careTaker.email,
                    //                       style: GoogleFonts.poppins(
                    //                         color: Constants.darkGrey,
                    //                         fontWeight: FontWeight.w600,
                    //                         fontSize: 14,
                    //                       ),
                    //                     ),
                    //                     Divider(thickness: 1,)
                    //                   ],
                    //                 ),
                    //                 const SizedBox(height: 20),
                    //                 Row(
                    //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //                   children: [
                    //                     SecondaryButton(
                    //                         title: 'Cancel',
                    //                         onTap: (){
                    //                           Navigator.pop(context);
                    //                         }
                    //                     ),
                    //                     PrimaryButton(
                    //                         title: 'Call Now',
                    //                         onTap: (){
                    //                           Navigator.pop(context);
                    //                         }
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 const SizedBox(height: 10),
                    //               ],
                    //             ),
                    //           );
                    //         });
                    //   },
                    //   endChild: Text(
                    //     'Connect Now',
                    //     style: GoogleFonts.poppins(
                    //         color: Colors.white, fontWeight: FontWeight.w600),
                    //   ),
                    //   icon: Padding(
                    //     padding: const EdgeInsets.only(right: 2.0),
                    //     child: Transform.rotate(
                    //         angle: -0.05,
                    //         child: Image.asset(
                    //           "assets/fast-forward.png",
                    //           height: 18,
                    //           width: 18,
                    //         )),
                    //   ),
                    //   // startAction: (controller) async {
                    //   //   controller.loading(); //starts loading animation
                    //   //   await Future.delayed(const Duration(seconds: 3));
                    //   //   controller.success(); //starts success animation
                    //   //   await Future.delayed(const Duration(seconds: 1));
                    //   //   controller.reset(); //resets the slider
                    //   // },
                    //   endAction: (controller) async {
                    //     //controller.loading(); //starts loading animation
                    //     // await Future.delayed(const Duration(seconds: 3));
                    //     // controller.success(); //starts success animation
                    //     // await Future.delayed(const Duration(seconds: 1));
                    //
                    //     setState(() {
                    //       slidefinish=true;
                    //     });
                    //     controller.reset(); //resets the slider
                    //   },
                    // ),

                  ],
                );
              }return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
