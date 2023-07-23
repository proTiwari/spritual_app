import 'dart:math';

import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';

import '../widgets/responsive.dart';



class EventManager extends StatefulWidget {
  const EventManager({Key? key}) : super(key: key);

  @override
  State<EventManager> createState() => _EventManagerState();
}

class _EventManagerState extends State<EventManager> {
  double _scrollPosition = 0;

  double _opacity = 0;

  late ScrollController _scrollController;


  @override
  Widget build(BuildContext context) {
    TextEditingController addTextController = TextEditingController();
    TextEditingController updateTextController = TextEditingController();
    var screenSize = MediaQuery.of(context).size;
    _opacity = _scrollPosition < screenSize.height * 0.40
        ? _scrollPosition / (screenSize.height * 0.40)
        : 1;
    var box = Hive.box('box');

// Add Data
    Future<void> addData() async {
      int key = box.length;

      if (addTextController.text != '') {
        key++;
        setState(() {
          box.put(key, addTextController.text);
        });
        addTextController.clear();
        Navigator.pop(context);
      } else {
        Fluttertoast.showToast(msg: 'Write Something to Add');
      }
    }

    // Edit Data
    void editData(int index) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Update Data'),
              content: TextFormField(
                controller: updateTextController,
                autofocus: true,
                enableSuggestions: true,
                decoration: InputDecoration(
                    hintText: box.getAt(index),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      if (updateTextController.text != '') {
                        setState(() {
                          box.putAt(index, updateTextController.text);
                        });
                        Navigator.pop(context);
                        updateTextController.clear();
                      } else {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                            msg: 'Write Something to Update');
                      }
                    },
                    child: const Text('Update'))
              ],
            );
          });
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
        backgroundColor:
        Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
        elevation: 0,
        centerTitle: true,
        actions: [
          Visibility(
            visible: false,
            child: IconButton(
              icon: Icon(Icons.brightness_6),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                EasyDynamicTheme.of(context).changeTheme();
              },
            ),
          ),
        ],
        title:  Image.asset('assets/images/logo-side-crop.png',
            width: screenSize.width / 6,
            height: screenSize.width / 12
        ),
      ): PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: PreferredSize(
          preferredSize: Size(screenSize.width, 1000),
          child: Container(
            color: Theme.of(context).bottomAppBarColor.withOpacity(_opacity),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /* Text(
                'EXPLORE',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),*/
                  Image.asset('assets/images/logo-side-crop.png',
                      width: screenSize.width / 6,
                      height: screenSize.width / 12
                  ),
                  SizedBox(
                    width: screenSize.width / 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: box.isEmpty
          ? const Center(
        child: Text(
          'No Data',
          style: TextStyle(fontSize: 30),
        ),
      )
          : SafeArea(
        child: ListView.builder(
            reverse: true,
            shrinkWrap: true,
            itemCount: box.length,
            itemBuilder: (context, index) {
              return Card(
                color: Colors.primaries[index % Colors.primaries.length],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(box.getAt(index)),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      //Edit Button
                      children: [
                        IconButton(
                            onPressed: () {
                              editData(index);
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),

                        //delete Button
                        IconButton(
                            onPressed: () {
                              setState(() {
                                box.deleteAt(index);
                              });
                            },
                            icon: const Icon(Icons.delete,
                                color: Colors.white))
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
      // Add new item button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        'Add Data',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.primaries[
                            Random().nextInt(Colors.primaries.length)]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        onEditingComplete: addData,
                        autofocus: true,
                        controller: addTextController,
                        decoration: InputDecoration(
                            labelText: 'Write Something',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialButton(
                          height: 45,
                          color: Colors.primaries[
                          Random().nextInt(Colors.primaries.length)],
                          onPressed: () {
                            addData();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              Text(
                                'Add Data',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        },
        backgroundColor:
        Colors.primaries[Random().nextInt(Colors.primaries.length)],
        child: const Icon(Icons.add),
      ),
    );
  }
}