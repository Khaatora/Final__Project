import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_pro/modules/List/Back_End/List_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

import 'Back_End/Boardcontroller.dart';
import 'Task_Screen.dart';

class MyList extends StatefulWidget {
  DocumentSnapshot? ds;
  MyList(DocumentSnapshot ds) {
    this.ds = ds;
  }
  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  final TextEditingController nameoflist = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.024,
            vertical: MediaQuery.of(context).size.height * 0.04),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: (() => Get.back()),
                  child: Image.asset(
                    "assets/images/right-arrows copy.png",
                    width: MediaQuery.of(context).size.width * 0.045,
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.height * 0.041),
                        child: Text(
                         widget.ds!["name"],
                          style: TextStyle(
                              color: Color.fromARGB(255, 18, 131, 223),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.06,
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.016),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(238, 238, 238, 1),
                        borderRadius: BorderRadius.circular(14)),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            cursorWidth: 1.5,
                            cursorColor: Colors.blue[400],
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search...',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        MaterialButton(
                          minWidth: 0,
                          padding: EdgeInsets.all(0),
                          onPressed: () {},
                          child: Container(
                            child: Image.asset(
                              "assets/images/free-search-icon-3076-thumb.png",
                              width: MediaQuery.of(context).size.width * 0.09,
                            ),
                            height: MediaQuery.of(context).size.width * 0.07,
                          ),
                        )
                      ],
                    )),
                Container(
                  child: MaterialButton(
                    minWidth: 0,
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      showDialog(
                        barrierColor: Colors.white.withOpacity(0.0),
                        context: context,
                        builder: (context) {
                          return _diagBoard();
                        },
                      );
                    },
                    child: Image.asset(
                      "assets/images/list-interface-symbol.png",
                      width: MediaQuery.of(context).size.width * 0.08,
                      height: MediaQuery.of(context).size.height * 0.033,
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.74,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.056),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  if (widget.ds!['visibility'] == 0)
                  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: (widget.ds?["visibility"]==1 ? List_Controller(ds: widget.ds).PReadLists() : List_Controller(ds: widget.ds).TReadLists()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.symmetric(vertical: 0),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot listDoc =
                                  snapshot.data!.docs[index];
                              return mylistStream(listDoc);
                            });
                      } else {
                        return Container();
                      }
                    },
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 225, 242, 255),
                            borderRadius: BorderRadius.circular(14)),
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.66,
                        child: InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              barrierColor: Colors.black.withOpacity(0.5),
                              builder: (context) {
                                return _Addlist();
                              },
                            );
                          },
                          child: Center(
                            child: Text(
                              '+ Add List ',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // streaming lists of the board
  mylistStream(DocumentSnapshot listDoc) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.12),
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
          horizontal: MediaQuery.of(context).size.width * 0.04),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 225, 242, 255),
          borderRadius: BorderRadius.circular(15)),
      child: Column(children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                listDoc.get("title"),
                style: TextStyle(
                  color: Color.fromARGB(255, 18, 131, 223),
                  fontSize: 20,
                ),
              ),
              GestureDetector(
                onTap: () {
                  _showPopupMenulist();
                },
                child: Image.asset(
                  "assets/images/list-interface-symbol -horizental.png",
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.015),
            children: [
              streamtasks(),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              child: Text(
                '+ Add task ',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        )
      ]),
    );
  }

  streamtasks() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.24,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.027,
                    right: MediaQuery.of(context).size.width * 0.027,
                    top: MediaQuery.of(context).size.height * 0.023),
                width: MediaQuery.of(context).size.width * 0.46,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Find Your Dream",
                      style: TextStyle(
                          color: Color.fromARGB(255, 18, 131, 223),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.03),
                        child: ListView(
                          padding: EdgeInsets.all(0),
                          children: [
                            Text(
                              "Find Your Dream fkfkmfm krmkmekfmvklmldmv dkflmvld",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            )
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.width * 0.015),
                      child: Row(
                        children: [
                          Icon(
                            Icons.flag,
                            color: Colors.grey,
                            size: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01,
                          ),
                          Text("date")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.009,
                    vertical: MediaQuery.of(context).size.height * 0.01),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () => _showmenutask(),
                      child: Image.asset(
                          "assets/images/list-interface-symbol copy.png",
                          width: MediaQuery.of(context).size.width * 0.055,
                          height: MediaQuery.of(context).size.width * 0.05),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    Text("data")
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.03),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.006,
                      ),
                      child: Stack(
                          children: List.generate(3, (index) {
                        return Positioned(
                            left: index * 12,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.098,
                              child: ClipPolygon(
                                sides: 6,
                                borderRadius: 15.0, // Default 0.0 degrees
                                rotate: 180.0,
                                child: Container(color: Colors.red),
                              ),
                            ));
                      })),
                    ),
                  ),
                  Icon(
                    Icons.chat,
                    size: 15,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("5"),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.check_box,
                    size: 15,
                  ),
                  Text("1/5"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showPopupMenulist() async {
    await showMenu(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      context: context,
      position: RelativeRect.fromLTRB(200, 115, 95, 100),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.27),
      items: [
        PopupMenuItem<String>(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.022,
                vertical: MediaQuery.of(context).size.width * 0.006),
            height: 0,
            onTap: () {},
            textStyle: TextStyle(color: Colors.grey),
            child: Text('Add Task'),
            value: 'Add Task'),
        PopupMenuItem<String>(
            height: 0,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.022,
                vertical: MediaQuery.of(context).size.width * 0.006),
            onTap: () {},
            textStyle: TextStyle(color: Colors.grey),
            child: Text('Copy lists'),
            value: 'Copy list '),
        PopupMenuItem<String>(
            height: 0,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.022,
                vertical: MediaQuery.of(context).size.width * 0.006),
            onTap: () {},
            textStyle: TextStyle(
              color: Colors.grey,
            ),
            child: Text('Move Tasks to done'),
            value: 'Move Tasks to done'),
        PopupMenuItem<String>(
            height: 0,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.022,
                vertical: MediaQuery.of(context).size.width * 0.006),
            onTap: () {},
            textStyle: TextStyle(color: Colors.grey),
            child: Text('Clear list'),
            value: 'Clear list'),
        PopupMenuItem<String>(
            height: 0,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.022,
                vertical: MediaQuery.of(context).size.width * 0.006),
            onTap: () {},
            textStyle: TextStyle(color: Colors.grey),
            child: Text('Delete list'),
            value: 'Add Task'),
      ],
      elevation: 18.0,
    );
  }

  void _showmenutask() async {
    await showMenu(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      context: context,
      position: RelativeRect.fromLTRB(200, 160, 110, 200),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.27),
      items: [
        PopupMenuItem<String>(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: MediaQuery.of(context).size.width * 0.006),
            height: 0,
            onTap: () {},
            textStyle: TextStyle(color: Colors.grey),
            child: Text('Copy Task'),
            value: 'Copy Task'),
        PopupMenuItem<String>(
            height: 0,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: MediaQuery.of(context).size.width * 0.006),
            onTap: () {},
            textStyle: TextStyle(color: Colors.grey),
            child: Text('Move to Done'),
            value: 'Move to Done'),
        PopupMenuItem<String>(
            height: 0,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: MediaQuery.of(context).size.width * 0.006),
            onTap: () {},
            textStyle: TextStyle(color: Colors.grey),
            child: Text('Delete task'),
            value: 'Delete task'),
      ],
      elevation: 18.0,
    );
  }

  _diagBoard() {
    return Material(
      color: Colors.white.withOpacity(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(color: Colors.white),
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: MediaQuery.of(context).size.height * 0.02),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Board name",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.017,
              ),
              InkWell(
                child: Text(
                  "Invite to Board",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.013,
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "Member",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.013,
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "Copy Board",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.013,
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "Clear Board",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.013,
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "Delete  Board",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
    );
  }

  _Addlist() {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width * 0.7,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                  vertical: MediaQuery.of(context).size.height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    "Add List",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontStyle: FontStyle.italic),
                  )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Inputfield(
                    hint: "List name",
                    controller: nameoflist,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  InkWell(
                    onTap: () async {
                      // add list
                      await List_Controller(ds: widget.ds)
                          .addList(nameoflist.text);
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
}
