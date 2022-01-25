import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notesapp/fonts.dart';
import 'package:notesapp/models/notesmodel.dart';

import 'notes.dart';

void main() {
  runApp(const MyApp());
}

bool e = false;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var color = Colors.white;

  Widget circleSelect(double r, Color x, String b) {
    return Material(
      type: MaterialType.transparency,
      borderOnForeground: false,
      child: Container(
        margin: EdgeInsets.all(10),
        color: Colors.grey.shade100,
        child: InkWell(
          onTap: () {
            setState(() {
              color = colors[b];
              state = b;
            });
            Navigator.pop(context);
          },
          child: CircleAvatar(
            maxRadius: r + 1,
            backgroundColor: Colors.grey.shade300,
            child: CircleAvatar(
              maxRadius: r,
              backgroundColor: x,
            ),
          ),
        ),
      ),
    );
  }

  void showDialog() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.15),
      transitionDuration: Duration(milliseconds: 450),
      context: context,
      pageBuilder: (_, __, ___) {
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 190,
            child: Column(
              children: [
                Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {
                      if (state == 'allnotes') {
                        setState(() {
                          state = 'archived';
                        });
                      } else {
                        setState(() {
                          state = 'allnotes';
                        });
                      }

                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      margin: EdgeInsets.only(left: 15, right: 15, top: 40),
                      child: Text(
                        state,
                        style: poppins(
                            Colors.grey.shade700, h4, FontWeight.normal),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      circleSelect(12, Colors.red.shade200, "red"),
                      circleSelect(12, Colors.blue.shade200, "blue"),
                      circleSelect(12, Colors.yellow.shade200, "yellow"),
                      circleSelect(12, Colors.green.shade200, "green"),
                      //circleSelect(12, Colors.orange.shade200, "Orange"),
                      //circleSelect(12, Colors.grey.shade200, "Grey"),
                      //circleSelect(12, Colors.grey.shade700, "None"),
                    ],
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  offset: Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                )
              ],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }

  int flag = 0;

  var state = 'allnotes';
  @override
  Widget build(BuildContext context) {
    var arr = {
      'archived': StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: archived.length,
        itemBuilder: (BuildContext context, int index) => DismissibleWidget(
          item: archived[index],
          onDismissed: (direction) {
            switch (direction) {
              case DismissDirection.endToStart:
                setState(() {


                  archived.removeAt(index);
                });
                final snackBar = SnackBar(
                  content: Text(
                    'Note Deleted.',
                    style: poppins(Colors.white, h4, FontWeight.bold),
                  ),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                break;
              case DismissDirection.startToEnd:
                var curr = archived.length;
                var temp = archived[index];
                temp.index = curr;
                allNotes.add(temp);
                final snackBar = SnackBar(
                  content: Text(
                    'Note moved out of archived',
                    style: poppins(Colors.white, h4, FontWeight.bold),
                  ),
                  backgroundColor: Colors.green,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                setState(() {
                  if(archived[index].colorIndex != -1){
                    if(archived[index].color == 'red'){
                      archived[index].colorIndex = red.length;
                      red.add(archived[index]);
                    }
                    else  if(archived[index].color == 'green'){
                      archived[index].colorIndex = green.length;
                      green.add(archived[index]);
                    }
                    else  if(archived[index].color == 'blue'){
                      archived[index].colorIndex = blue.length;
                      blue.add(archived[index]);
                    }
                    else  if(archived[index].color == 'yellow'){
                      archived[index].colorIndex = yellow.length;
                      yellow.add(archived[index]);
                    }
                  }
                  archived.removeAt(index);
                });

                break;
              case DismissDirection.vertical:
                print("12");
                break;
              case DismissDirection.horizontal:
                print("12");
                break;
              case DismissDirection.up:
                print("12");
                break;
              case DismissDirection.down:
                print("12");
                break;
              case DismissDirection.none:
                print("12");
                break;
            }
          },
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => archived[index].getView()));
              },
              child: archived[index].getSmallView()),
        ),
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 2 : 2),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      'allnotes': StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: allNotes.length,
        itemBuilder: (BuildContext context, int index) => DismissibleWidget(
          item: allNotes[index],
          onDismissed: (direction) {
            switch (direction) {
              case DismissDirection.endToStart:
                setState(() {
                  if (allNotes[index].colorIndex != -1) {
                    if (allNotes[index].color == 'red') {
                      red.removeAt(allNotes[index].colorIndex);
                    } else if (allNotes[index].color == 'green') {
                      green.removeAt(allNotes[index].colorIndex);
                    } else if (allNotes[index].color == 'blue') {
                      blue.removeAt(allNotes[index].colorIndex);
                    } else if (allNotes[index].color == 'yellow') {
                      yellow.removeAt(allNotes[index].colorIndex);
                    }
                  }
                  allNotes.removeAt(index);
                });
                final snackBar = SnackBar(
                  content: Text(
                    'Note Deleted.',
                    style: poppins(Colors.white, h4, FontWeight.bold),
                  ),
                  backgroundColor: Colors.red,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                break;
              case DismissDirection.startToEnd:
                var curr = archived.length;
                var temp = allNotes[index];
                temp.index = curr;
                archived.add(temp);
                final snackBar = SnackBar(
                  content: Text(
                    'Note moved to archived',
                    style: poppins(Colors.white, h4, FontWeight.bold),
                  ),
                  backgroundColor: Colors.green,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                setState(() {
                  if (allNotes[index].colorIndex != -1) {
                    if (allNotes[index].color == 'red') {
                      red.removeAt(allNotes[index].colorIndex);
                    } else if (allNotes[index].color == 'green') {
                      green.removeAt(allNotes[index].colorIndex);
                    } else if (allNotes[index].color == 'blue') {
                      blue.removeAt(allNotes[index].colorIndex);
                    } else if (allNotes[index].color == 'yellow') {
                      yellow.removeAt(allNotes[index].colorIndex);
                    }
                  }
                  allNotes.removeAt(index);
                });

                break;
              case DismissDirection.vertical:
                print("12");
                break;
              case DismissDirection.horizontal:
                print("12");
                break;
              case DismissDirection.up:
                print("12");
                break;
              case DismissDirection.down:
                print("12");
                break;
              case DismissDirection.none:
                print("12");
                break;
            }
          },
          child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => allNotes[index].getView()));
              },
              child: allNotes[index].getSmallView()),
        ),
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 2 : 2),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      'red': StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: red.length,
        itemBuilder: (BuildContext context, int index) => InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => red[index].getView()));
            },
            child: red[index].getSmallView()),
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 2 : 2),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      'blue': StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: blue.length,
        itemBuilder: (BuildContext context, int index) => InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => blue[index].getView()));
            },
            child: blue[index].getSmallView()),
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 2 : 2),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      'yellow': StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: yellow.length,
        itemBuilder: (BuildContext context, int index) => InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => yellow[index].getView()));
            },
            child: yellow[index].getSmallView()),
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 2 : 2),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      'green': StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: green.length,
        itemBuilder: (BuildContext context, int index) => InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => green[index].getView()));
            },
            child: green[index].getSmallView()),
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 2 : 2),
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
    };

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            state,
            style: poppins(Colors.grey.shade700, h3, FontWeight.bold),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.grey.shade700,
              ),
              onPressed: () {
                showDialog();
              },
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          mini: true,
          backgroundColor: Colors.grey.shade300,
          child: Icon(
            Icons.add,
            color: Colors.grey.shade700,
          ),
          onPressed: () {
            var n = NotesModel();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => n.getView()));
          },
        ),
        body: arr[state]);
  }
}

class DismissibleWidget<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;

  const DismissibleWidget({
    required this.item,
    required this.child,
    required this.onDismissed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Dismissible(
        key: ObjectKey(item),
        background: buildSwipeActionLeft(),
        secondaryBackground: buildSwipeActionRight(),
        child: child,
        onDismissed: onDismissed,
      );

  Widget buildSwipeActionLeft() => Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 5),
        //margin: EdgeInsets.only(left: 10, top: 15, bottom: 15, right: 10),
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.8),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
        ),
        child: Row(
          children: [
            Icon(Icons.archive, color: Colors.white),
            Text(
              "Archive",
              style: poppins(Colors.white, h3, FontWeight.w500),
            )
          ],
        ),
      );

  Widget buildSwipeActionRight() => Container(
        alignment: Alignment.centerRight,
        //margin: EdgeInsets.only(left: 10, top: 15, bottom: 15, right: 10),
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.9),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(Icons.delete, color: Colors.white),
            Text(
              "Delete",
              style: poppins(Colors.white, h3, FontWeight.w500),
            )
          ],
        ),
      );
}
