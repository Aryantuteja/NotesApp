import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

double h1 = 28;
double h2 = 24;
double h3 = 19;
double h4 = 17;
double h5 = 15;
double h6 = 13;
bool isDownScaled = false;
bool oneTimeDownScaled = false;
bool oneTimeUpScaled = false;

bool fontDownScaler() {
  var scalingAtribute = 3;
  h1 -= scalingAtribute;
  h2 -= scalingAtribute;
  h3 -= scalingAtribute;
  h4 -= scalingAtribute;
  h5 -= scalingAtribute;
  h6 -= scalingAtribute;
  return true;
}

bool fontScaler() {
  var scalingAtribute = 3;
  h1 += scalingAtribute;
  h2 += scalingAtribute;
  h3 += scalingAtribute;
  h4 += scalingAtribute;
  h5 += scalingAtribute;
  h6 += scalingAtribute;
  return false;
}

TextStyle poppins(Color col, [double? x, FontWeight? weight]) {
  return GoogleFonts.poppins(textStyle: TextStyle(height: 1.5, letterSpacing: -0.5, fontWeight: weight ?? FontWeight.bold, color: col, fontSize: x ?? h5));
}

TextStyle tt(Color col, [double? x, FontWeight? weight]) {
  return GoogleFonts.notoSerif(textStyle: TextStyle(height: 1.5, fontWeight: weight ?? FontWeight.bold, color: col, fontSize: x ?? h5));
}
