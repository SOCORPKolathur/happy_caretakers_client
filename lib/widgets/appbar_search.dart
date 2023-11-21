import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';

class AppBarSearchWidget extends StatefulWidget {
  AppBarSearchWidget({super.key, required this.controller, required this.onTap,required this.onSubmitted,required this.onChanged});
  TextEditingController controller;
  Function onTap;
  Function onSubmitted;
  Function onChanged;

  @override
  State<AppBarSearchWidget> createState() => _AppBarSearchWidgetState();
}

class _AppBarSearchWidgetState extends State<AppBarSearchWidget> {
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Constants.primaryWhite,
      ),
      child: Center(
        child: TextFormField(
          onFieldSubmitted: (val){
            widget.onSubmitted();
          },
          onChanged: (val){
            widget.onChanged();
          },
          controller: widget.controller,
          decoration: InputDecoration(
            contentPadding:  EdgeInsets.symmetric(vertical:height/126 ,horizontal: width/72),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(
                  Icons.search,
                  color: Constants.lightGrey,
              ),
              onPressed: () {
                widget.onTap();
              },
            ),
            hintText: 'Search any type professionals',
            hintStyle: GoogleFonts.poppins(
              color: Constants.lightGrey,
              fontSize: width/25.7142,
            ),
            labelStyle: GoogleFonts.poppins(
              color: Constants.lightGrey,
              fontSize: width/25.7142,
            ),
          ),
        ),
      ),
    );
  }
}
