import 'package:flutter/material.dart';
import 'package:notesapp/fonts.dart';
import 'package:notesapp/models/notesmodel.dart';

import 'main.dart';

class Notes extends StatefulWidget {
  String? title;
  String? content;
  int? index;
  Color? color;
  int? colorIndex;
  Notes({
    this.title,
    this.content,
    this.index,
    this.color,
    this.colorIndex,
    Key? key}) : super(key: key);

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {

  String title = "";
  String content = "";
  var colorString ='none';
  bool isChanged = false;
  @override
  Widget build(BuildContext context) {
    Widget circleSelect(double r, Color x, String b) {
      return Container(
        margin: EdgeInsets.only(left:10,right: 10),
        child: InkWell(
          onTap: () {

            if(colors[b] == widget.color){
              setState(() {
                widget.color = colors['none'];
              });
              colorString = 'none';
              isChanged = true;
            }
            else{
              setState(() {
                widget.color = colors[b];
              });
              colorString = b;
            }



          },
          child: CircleAvatar(
            maxRadius: r + 0.5,
            backgroundColor: Colors.grey.shade600,
            child: CircleAvatar(
              maxRadius: r,
              backgroundColor: x,
            ),
          ),
        ),
      );
    }
    return Scaffold(

      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.grey.shade300,
        child: Icon(Icons.save,color: Colors.grey.shade600,),
        onPressed: (){
          if(widget.index == -1){
            var newModel = NotesModel();
            newModel.title = widget.title.toString();
            newModel.content = widget.content.toString();
            newModel.index = allNotes.length;
            newModel.color = colorString;

            if(colorString == 'red'){
              newModel.colorIndex = red.length;
              red.add(newModel);
            }
            else  if(colorString == 'green'){
              newModel.colorIndex = green.length;
              green.add(newModel);
            }
            else  if(colorString == 'blue'){
              newModel.colorIndex = blue.length;
              blue.add(newModel);
            }
            else  if(colorString == 'yellow'){
              newModel.colorIndex = yellow.length;
              yellow.add(newModel);
            }
            allNotes.add(newModel);

            print("new model added to all notes");
            print(allNotes.length);

          }
          else{
            var newModel = NotesModel();
            newModel.title = widget.title.toString();
            newModel.content = widget.content.toString();
            newModel.index = widget.index!.toInt();
            var prevailed = '';
            for(int i = 0; i < colors.keys.length; i++){
              if(colors[colors.keys.toList()[i]] == widget.color){
                prevailed = colors.keys.toList()[i];
                break;
              }
            }










            newModel.color = isChanged? colorString : prevailed;



            if(colorString == 'red' || prevailed == 'red'){
              if(widget.colorIndex == -1){
                newModel.colorIndex = red.length;
                red.add(newModel);
              }
              else{
                red[widget.colorIndex!] = newModel;
              }
            }


            if(colorString == 'green' || prevailed == 'green'){
              if(widget.colorIndex == -1){
                newModel.colorIndex = green.length;
                green.add(newModel);
              }
              else{
                green[widget.colorIndex!] = newModel;
              }
            }


            if(colorString == 'yellow' ||prevailed == 'yellow'){
              if(widget.colorIndex == -1){
                newModel.colorIndex = yellow.length;
                yellow.add(newModel);
              }
              else{
                yellow[widget.colorIndex!] = newModel;
              }
            }


            if(colorString == 'blue' || prevailed == 'blue'){
              if(widget.colorIndex == -1){
                newModel.colorIndex = blue.length;
                blue.add(newModel);
              }
              else{
                blue[widget.colorIndex!] = newModel;
              }
            }
            allNotes[widget.index!.toInt()] = newModel;
            print("value passed");
          }
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
        },
      ),
      backgroundColor: widget.color,
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.grey.shade700
        ),
        toolbarHeight: 50,
        elevation: 0,
        backgroundColor: widget.color,
        actions: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              children: [
                circleSelect(12, Colors.red.shade200, "red"),
                circleSelect(12, Colors.blue.shade200, "blue"),
                circleSelect(12, Colors.yellow.shade200, "yellow"),
                Container(
                    margin: EdgeInsets.only(right: 30),
                    child: circleSelect(12, Colors.green.shade200, "green")),
              ],
            ),
          )

        ],
      ),
      body: ListView(
        children:  [
          Container(
            margin: EdgeInsets.only(left:15,right: 15,top: 15),
            child: TextFormField(
              style: poppins(Colors.grey.shade700,h2,FontWeight.w600),
              onChanged: (val){
                widget.title = val;
              },
              initialValue: widget.title,
              decoration:const InputDecoration(
                border: InputBorder.none,
                hintText: 'Title',
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15),
            child: TextFormField(
              maxLines: 10000,
              initialValue: widget.content,
              onChanged: (val){
                widget.content = val;
              },
              style: poppins(Colors.grey.shade700,h3,FontWeight.w600),
              decoration:const InputDecoration(
                border: InputBorder.none,
                hintText: 'Content',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
