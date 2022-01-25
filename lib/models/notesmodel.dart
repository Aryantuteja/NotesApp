import "package:auto_size_text/auto_size_text.dart";
import 'package:flutter/material.dart';
import 'package:notesapp/fonts.dart';

import '../notes.dart';


var allNotes = [];
var archived = [];
var red = [];
var blue = [];
var yellow = [];
var green = [];

Map colors = {
  'red':Colors.red.shade200,
  'blue':Colors.blue.shade200,
  'yellow':Colors.yellow.shade200,
  'green':Colors.green.shade200,
  'none':Colors.white
};

class NotesModel{
  // Model
  String title = "";
  String content = "";
  String color = "None";
  bool isImportant = false;
  int index = -1;
  int colorIndex = -1;

  //view
  Notes notesView = Notes();
  getView(){
    notesView.title = this.title;
    notesView.content = this.content;
    notesView.index = this.index;
    notesView.colorIndex = this.colorIndex;
    notesView.color = colors[color];
    return notesView;
  }
  getSmallView(){
    return

      Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: colors[color],
        border: Border.all(color: Colors.grey.shade400,width: 0.5),
        borderRadius: BorderRadius.circular(15)
      ),
        child: Column(
          children: [
            title == ""? Container(): Container(
                alignment: Alignment.bottomLeft,
                child: AutoSizeText(title,style: poppins(Colors.black,h3,FontWeight.bold),)),
            content == ""? Container(): Container( alignment: Alignment.bottomLeft,child: AutoSizeText(

              content,style: poppins(Colors.black,h5,FontWeight.w500),
            maxLines: 6,))
          ],
        ),
    );
  }


}