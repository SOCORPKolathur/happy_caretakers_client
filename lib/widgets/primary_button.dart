import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happy_caretakers_client/constants.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({super.key, required this.title, required this.onTap});

  final String title;
  final Function onTap;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return InkWell(
      onTap: (){
        widget.onTap();
      },
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: Constants.primaryAppColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: GoogleFonts.poppins(
              color: Constants.primaryWhite,
              fontSize: width/20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
