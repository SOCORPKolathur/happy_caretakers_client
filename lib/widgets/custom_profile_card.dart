import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';
import 'package:happy_caretakers_client/models/care_takers_model.dart';
import 'package:readmore/readmore.dart';
import 'custom_paint_profile_card.dart';
import 'kText.dart';

class CustomProfileCard extends StatefulWidget {
  const CustomProfileCard({super.key, required this.onTap, required this.careTaker});

  final Function onTap;
  final CareTakersModel careTaker;

  @override
  State<CustomProfileCard> createState() => _CustomProfileCardState();
}

class _CustomProfileCardState extends State<CustomProfileCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CustomPaint(
          painter: CustomPaintProfileCard(),
          size: Size(size.width, 220),
        ),
        SizedBox(
          height: 220,
          width: size.width,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                    width: size.width * 0.62,
                    decoration: const BoxDecoration(
                      //color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    padding:  EdgeInsets.symmetric(vertical: height/151.2),
                    child: Row(
                      children: [
                        SizedBox(width: width/36.0),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Constants.lightGrey,
                          backgroundImage: NetworkImage(widget.careTaker.imgUrl),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            KText(
                              text: "${widget.careTaker.firstName} ${widget.careTaker.lastName}",
                              style: GoogleFonts.poppins(
                                fontSize: width/21.176,
                                fontWeight: FontWeight.w600,
                                color: Constants.darkGrey,
                              ),
                            ),
                            KText(
                              text: widget.careTaker.position,
                              style: GoogleFonts.poppins(
                                fontSize: width/27.692,
                                fontWeight: FontWeight.normal,
                                color: Constants.darkGrey,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 10,
                    width: size.width,
                    decoration: BoxDecoration(
                      //color: Constants.primaryWhite,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                      ),
                    ),
                    padding:  EdgeInsets.only(left: width/12,right: width/3),
                    child: Center(
                        child: Divider(
                          color: Constants.darkGrey,
                          thickness: 1.5,
                        )
                    ),
                  ),
                  Container(
                    height: 150,
                    width: size.width,
                    decoration: BoxDecoration(
                        //color: Constants.primaryWhite,
                        borderRadius: const BorderRadius.only(
                          //topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        // boxShadow: const [
                        //   BoxShadow(
                        //       color: Colors.black26,
                        //       offset: Offset(0, 2),
                        //       blurRadius: 2
                        //   )
                        // ]
                    ),
                    child: Column(
                      children: [
                        Expanded(
                            child: Container(
                              width: size.width,
                              decoration: BoxDecoration(
                                  //color: Constants.primaryWhite,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                  )
                              ),
                              padding:  EdgeInsets.symmetric(
                                horizontal: width/36.0,
                                vertical: height/75.6
                              ),
                              child: ReadMoreText(
                                widget.careTaker.about,
                                style: GoogleFonts.poppins(
                                  color: Constants.semiGrey,
                                  fontWeight: FontWeight.w500,
                                ),
                                trimLines: 4,
                                colorClickableText: Colors.pink,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: 'Read More',
                                trimExpandedText: 'Show less',
                                moreStyle: GoogleFonts.poppins(
                                    decoration: TextDecoration.underline,
                                    color: Constants.primaryAppColor,
                                    fontSize: width/25.7142,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                        ),
                        Container(
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Constants.primaryAppColor,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Constants.primaryWhite,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(
                                    vertical: height/94.5,
                                    horizontal: width/45
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.location_on,color: Constants.primaryAppColor,),
                                      SizedBox(width: 5),
                                      KText(
                                        text:widget.careTaker.city,
                                        style: GoogleFonts.poppins(
                                          color: Constants.semiGrey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Constants.primaryWhite,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(
                                      vertical: height/94.5,
                                      horizontal: width/45
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.school,color: Constants.primaryAppColor,),
                                      SizedBox(width: 5),
                                      KText(
                                        text: "${widget.careTaker.yearsOfExperience} years",
                                        style: GoogleFonts.poppins(
                                          color: Constants.semiGrey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Constants.primaryWhite,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(
                                      vertical: height/94.5,
                                      horizontal: width/45
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.lock_clock,color: Constants.primaryAppColor,),
                                      SizedBox(width: 5),
                                      KText(
                                        text: widget.careTaker.workPreparence,
                                        style: GoogleFonts.poppins(
                                          color: Constants.semiGrey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                top: 15,
                right: -1,
                child: InkWell(
                  onTap: (){
                    widget.onTap();
                  },
                  child: Container(
                    height: 38,
                    width: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xff2B2B2B),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        KText(
                          text: 'View',
                          style: GoogleFonts.poppins(
                            color: Constants.primaryWhite,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          CupertinoIcons.arrow_up_right_circle,
                          color: Constants.primaryWhite,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
