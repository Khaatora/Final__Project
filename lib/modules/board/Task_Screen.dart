import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';
import 'Back_End/Boardcontroller.dart';
import 'Back_End/Mydata.dart';

class funn extends StatefulWidget {
  const funn({Key? key}) : super(key: key);

  @override
  State<funn> createState() => _funnState();
}

class _funnState extends State<funn> {
  String endtime = "Due date...";
  String starttime = "start date...";
  PlatformFile? pickedfile;
  final List items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
  ];
  String? selectedValue;

  boardcontroll bb = boardcontroll();

  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.06),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.58,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                  vertical: MediaQuery.of(context).size.height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    "Add Task",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontStyle: FontStyle.italic),
                  )),
                  Text("Board",
                      style: TextStyle(
                        color: Colors.grey[500],
                      )),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      customItemsHeight: 18,
                      icon: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey[400],
                      ),
                      buttonDecoration: BoxDecoration(),
                      iconSize: 30,
                      isDense: true,
                      hint: Text(
                        'Select Board',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 156, 151, 151),
                        ),
                      ),
                      items: boardcontroll.list1
                          .map((doc) => DropdownMenuItem<String>(
                                value: doc["name"],
                                child: Text(
                                  doc["name"],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color:
                                          Color.fromARGB(255, 156, 151, 151)),
                                ),
                              ))
                          .toList(),
                      value: selectedValue,
                      onChanged: (String? value) {
                        setState(() {
                          selectedValue = value;
                        });
                      },
                      buttonHeight: MediaQuery.of(context).size.height * 0.05,
                      buttonWidth: MediaQuery.of(context).size.width,
                      itemHeight: MediaQuery.of(context).size.width * 0.1,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: MediaQuery.of(context).size.width * 0.0013,
                            color: Color.fromARGB(255, 186, 180, 180))),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text("List",
                      style: TextStyle(
                        color: Colors.grey[500],
                      )),
                  DropdownButtonHideUnderline(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: boardcontroll().PReadBoard(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var ds = snapshot.data!.docs;
                            return DropdownButton2(
                              customItemsHeight: 18,
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.grey[400],
                              ),
                              buttonDecoration: BoxDecoration(),
                              iconSize: 30,
                              isDense: true,
                              hint: Text(
                                'Select List',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 156, 151, 151),
                                ),
                              ),
                              items: ds
                                  .map((doc) => DropdownMenuItem<String>(
                                        value: doc["name"],
                                        child: Text(
                                          doc["name"],
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 156, 151, 151)),
                                        ),
                                      ))
                                  .toList(),
                              value: selectedValue,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              },
                              buttonHeight:
                                  MediaQuery.of(context).size.height * 0.05,
                              buttonWidth: MediaQuery.of(context).size.width,
                              itemHeight:
                                  MediaQuery.of(context).size.width * 0.1,
                            );
                          }
                          return Container();
                        }),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: MediaQuery.of(context).size.width * 0.0013,
                            color: Color.fromARGB(255, 186, 180, 180))),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Inputfield(
                    hint: 'Task name',
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Inputfield(
                    hint: 'Description',
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height * 0.01),
                        height: MediaQuery.of(context).size.height * 0.025,
                        width: MediaQuery.of(context).size.width * 0.04,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                "assets/images/calendar.png",
                              )),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.04),
                        child: Column(children: [
                          InkWell(
                            onTap: () => gettime(check: true),
                            child: Text(
                              starttime,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 156, 151, 151),
                                  fontSize: 16),
                            ),
                          ),
                          InkWell(
                            onTap: () => gettime(check: false),
                            child: Text(endtime,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 156, 151, 151),
                                    fontSize: 16)),
                          ),
                        ]),
                      )
                    ],
                  ),
                  Container(
                    child: Row(children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.height * 0.005,
                            top: MediaQuery.of(context).size.height * 0.009),
                        height: MediaQuery.of(context).size.height * 0.023,
                        width: MediaQuery.of(context).size.width * 0.035,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                "assets/images/attachment.png",
                              )),
                        ),
                      ),
                      if (pickedfile != null)
                        Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.009,
                          ),
                          child: InkWell(
                            onTap: () => _pickFile(),
                            child: Text(
                              pickedfile!.name,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ),
                        ),
                      if (pickedfile == null)
                        Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.009,
                          ),
                          child: InkWell(
                              onTap: () => _pickFile(),
                              child: Text("Attachement...",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 16))),
                        ),
                    ]),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Color.fromARGB(255, 3, 138, 248)),
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.05),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.053,
                        child: Center(
                          child: Text(
                            'OK',
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  gettime({required bool check}) async {
    var timing = await showtime();
    String formated = timing.format(context);
    if (timing == null) {
      print("cancel");
    } else if (check == true) {
      setState(() {
        starttime = formated;
      });
    } else if (check == false) {
      setState(() {
        endtime = formated;
      });
    }
  }

  showtime() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(hour: 9, minute: 10));
  }

  Future _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);

    // if no file is picked
    if (result == null) return;

    // we get the file from result object
    setState(() {
      pickedfile = result.files.first;
    });
  }
}

class Inputfield extends StatelessWidget {
  const Inputfield({Key? key, this.controller, required this.hint, this.widget})
      : super(key: key);
  final hint;
  final TextEditingController? controller;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  cursorWidth: 1.5,
                  cursorColor: Colors.blue[400],
                  controller: controller,
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Color.fromARGB(255, 156, 151, 151),
                      fontSize: 20),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '$hint',
                    hintStyle: TextStyle(
                        color: Color.fromARGB(255, 150, 147, 147),
                        fontSize: 20),
                    isDense: true,
                    contentPadding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.002),
                  ),
                ),
              ),
              widget == null
                  ? Container()
                  : Container(
                      child: widget,
                    )
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                  width: MediaQuery.of(context).size.width * 0.0013,
                  color: Color.fromARGB(255, 158, 155, 155))),
        ),
      ],
    );
  }
}

class board extends StatefulWidget {
  const board({Key? key}) : super(key: key);

  @override
  State<board> createState() => _boardState();
}

class _boardState extends State<board> {
  final TextEditingController nameofboard = TextEditingController();
  FirebaseFirestore firebase = FirebaseFirestore.instance;
  bool isVisible = false;
  int selectcolor = 2;
  int num = 0;
  int currentpage = 0;
  PageController cont = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.065),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.4,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                  vertical: MediaQuery.of(context).size.height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    "Add Board",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontStyle: FontStyle.italic),
                  )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  Inputfield(
                    hint: "Board name",
                    controller: nameofboard,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text("Visibility",
                      style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 15,
                          fontStyle: FontStyle.italic)),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.002),
                          child: Column(
                              children: List<Widget>.generate(2, (int index) {
                            return Container(
                              margin: EdgeInsets.only(
                                  bottom: MediaQuery.of(context).size.width *
                                      0.025),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectcolor = index;
                                  });
                                },
                                child: Container(
                                  height: MediaQuery.of(context).size.width *
                                      0.03446,
                                  width: MediaQuery.of(context).size.width *
                                      0.03446,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: AssetImage(
                                            "assets/images/bold-Vexels.jpg",
                                          ))),
                                  child: ClipPolygon(
                                    sides: 6,
                                    child: Container(
                                      color: selectcolor == index
                                          ? Colors.blue
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.01,
                                bottom:
                                    MediaQuery.of(context).size.height * 0.023),
                            child: Column(
                              children: [
                                Text(
                                  "Teams",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: selectcolor == 0
                                        ? Colors.blue
                                        : Colors.grey,
                                  ),
                                ),
                                Text(
                                  "private",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: selectcolor == 1
                                          ? Colors.blue
                                          : Colors.grey),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      DateTime starttime = DateTime.now();
                      await ADD(starttime);
                      Get.back();
                    },
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: Color.fromARGB(255, 3, 138, 248)),
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.028),
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.053,
                        child: Center(
                          child: Text(
                            ' Ok',
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //TODO task add backend

  ADD(DateTime Time) async {
    await boardcontroll().addBoard(
      board: Board(
          name: nameofboard.text, Visibility: selectcolor, priority: Time),
    );
  }
}
