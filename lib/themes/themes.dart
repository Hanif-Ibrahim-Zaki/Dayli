import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supercharged/supercharged.dart';

TextStyle welcomeTextSyle = GoogleFonts.poppins(
    fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black);
TextStyle subWelcomeTextStyle = GoogleFonts.poppins(
    fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black);
TextStyle hintTextStyle = GoogleFonts.poppins(
    fontSize: 14, fontWeight: FontWeight.w500, color: Colors.white);

// Colors
final colorPrimary = '1D1C36FF'.toColor();
final important = '970900FF'.toColor();
final baseColor = '212121FF'.toColor();
//App Management
Widget Appname(description){
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Day', style: GoogleFonts.poppins(
              fontSize: 70, fontWeight: FontWeight.w600, color: Colors.yellow[700]),),
          Text('li', style: GoogleFonts.poppins(
              fontSize: 70, fontWeight: FontWeight.w600, color: Colors.white),),
        ],
      ),
      Text(description, style: GoogleFonts.poppins(
          fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),),
    ],
  );
}
Widget miniAppname(description){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text('Day', style: GoogleFonts.poppins(
              fontSize: 37, fontWeight: FontWeight.w600, color: Colors.yellow[700]),),
          Text('li', style: GoogleFonts.poppins(
              fontSize: 37, fontWeight: FontWeight.w600, color: Colors.white),),
        ],
      ),
      Text(description, style: GoogleFonts.poppins(
          fontSize: 7, fontWeight: FontWeight.w400, color: Colors.white),),
    ],
  );
}