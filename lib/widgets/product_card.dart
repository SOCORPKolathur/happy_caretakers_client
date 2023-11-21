import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';

import 'kText.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.title, required this.price, required this.imgUrl});

  final String imgUrl;
  final String title;
  final double price;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {

    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Container(
          height: height/3.78,
          width: width/2.307,
          child: Stack(
            children: [
              Positioned(
                top: 7,
                right: 0,
                child: Container(
                  height: height/3.9789,
                  width: width/2.571,
                  decoration: BoxDecoration(
                    color: Constants.primaryWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding:  EdgeInsets.only(top: height/7.2,left: width/36.0,right: width/36.0,bottom: height/75.6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: height/37.8,
                          width: width/ 3,
                          child: KText(
                            text: widget.title,
                            style: GoogleFonts.poppins(
                              fontSize: width/21.1764,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          height: height/37.8,
                          width: width/6,
                          child: Text(
                            "₹ ${widget.price}",
                            style: GoogleFonts.poppins(
                              fontSize: width/25.714,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            KText(
                              text:'See Details',
                              style: GoogleFonts.poppins(
                                fontSize: width/30,
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.green,
                              child: RotatedBox(
                                quarterTurns: 2,
                                  child: Icon(
                                      Icons.arrow_back_ios_outlined,
                                    size: 12,
                                    color: Constants.primaryWhite,
                                  )
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Constants.primaryWhite,
                    border: Border.all(color: Constants.primaryAppColor),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(widget.imgUrl),
                  )
                ),
              )
            ],
          )
        ),
      ],
    );
  }
}
