import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';

import 'kText.dart';

class CategoryCardProduct extends StatefulWidget {
  const CategoryCardProduct({super.key, required this.name, required this.icon});

  final String name;
  final IconData icon;

  @override
  State<CategoryCardProduct> createState() => _CategoryCardProductState();
}

class _CategoryCardProductState extends State<CategoryCardProduct> {



  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Container(
      height: height/7.56,
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(
              vertical: height/94.5,
              horizontal: width/45
            ),
            child: Container(
              height: height/15.12,
              width: width/6,
              decoration: BoxDecoration(
                color: Constants.primaryAppColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  widget.icon,
                  color: Constants.primaryWhite,
                  size: 40,
                ),
              ),
            ),
          ),
          KText(
            text: widget.name,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: width/25.7142,
            ),
          ),
        ],
      ),
    );
  }
}
