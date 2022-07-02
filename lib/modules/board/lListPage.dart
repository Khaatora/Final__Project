import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_pro/modules/List/Back_End/List_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

import 'Back_End/Boardcontroller.dart';
import 'Boards_Screen.dart';
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
        margin: EdgeInsets.only(  top: MediaQuery.of(context).size.height * 0.05,right:  MediaQuery.of(context).size.width * 0.04,
            left: MediaQuery.of(context).size.width * 0.024,
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
Center(
               child: Container(
                margin: EdgeInsets.all(10),
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
             ),
            // get lists from database
            Container(
              height: MediaQuery.of(context).size.height * 0.72,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.00),
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: widget.ds?["visibility"] == 1
                  ? List_Controller(ds: widget.ds).PReadLists()
                  : List_Controller(ds: widget.ds).TReadLists(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                           scrollDirection: Axis.horizontal,
                         
                          padding: EdgeInsets.symmetric(vertical: 0),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot listDoc =
                                snapshot.data!.docs[index];
                            return mylistStream(listDoc);
                          }),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
             ,
          ],
        ),
      ),
    );
  }

  // the front of one list
  mylistStream(DocumentSnapshot listDoc) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.12),
     
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 225, 242, 255),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
        Container(
       padding: EdgeInsets.only(
         left:MediaQuery.of(context).size.width * 0.05,
         right:MediaQuery.of(context).size.width * 0.02 ),       
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
               BUTTON_LIST(),
            ],
          ),
        ),
        Expanded(
          child: Container(
             padding: EdgeInsets.symmetric(
              
            horizontal: MediaQuery.of(context).size.width * 0.04),
            child: ListView(
            
              padding: EdgeInsets.all(0),
              children: [
                streamtasks(),
              ],
            ),
          ),
        ),
        Container(
          padding:EdgeInsets.all( MediaQuery.of(context).size.width*0.02),
          child: Row(
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
          ),
        )
      ]),
    );
  }

//the front of on Task
  streamtasks() {
    return InkWell(
      
      onTap: (){},
      child: Material(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 20,
        color: Colors.white,
        child: Container(
          
          height: MediaQuery.of(context).size.height * 0.24,
          
         
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
                                  "Find Your Dream ",
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
                  ),
                    child: Column(
                      children: [
                        BUTTON_Task(),
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
        ),
      ),
    );
  }
   
   
    // show menu for list
   BUTTON_LIST()  {
    return PopupMenuButton(
    
     elevation: 18.0,
    icon: Container(
    child: Image.asset( "assets/images/list-interface-symbol -horizental.png"),   width: MediaQuery.of(context).size.width*0.07, 

),
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
     constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.28,
          maxHeight: MediaQuery.of(context).size.height * 0.24
          ),
          
    itemBuilder:(context) => [
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
            onTap: () {

            },
            textStyle: TextStyle(color: Colors.grey),
            child: Text('Delete list'),
            value: 'Add Task'),
      ],
    );
  }
 
 // show menu for task
 BUTTON_Task(){

 return  Container(
  height: MediaQuery.of(context).size.height*0.04,

   child: PopupMenuButton(
     elevation: 18.0,
    icon: Icon(Icons.more_vert,color: Color.fromARGB(255, 29, 136, 224),),
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.3,
              maxHeight: MediaQuery.of(context).size.height * 0.24
              ),
            
                  itemBuilder:(context) => [
         
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
        
                    
                    
                  ]
                  
              ),
 );
}
  
//   Checkbox screen in a board
  _diagBoard() {
    return Material(
      color: Colors.white.withOpacity(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.35,
            height: MediaQuery.of(context).size.height * 0.96,
            decoration: BoxDecoration(color: Colors.white),
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: MediaQuery.of(context).size.height * 0.024),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
              widget.ds!['name'],
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.036,
              ),
              if(widget.ds!['visibility']==0)
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
          if(widget.ds!['visibility']==0)

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
                onTap: () {
                   List_Controller(ds: widget.ds).clearBoard();
                  showDialog(
                       context: context,
                       barrierColor: Colors.black.withOpacity(0.5),
                       builder: (context) {
                         return deletelist();
                       },
                     );
                 
             
                },
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
                onTap: () {
                      List_Controller(ds: widget.ds).deleteBoard();
                  Get.back();
                showDialog(
                       context: context,
                       barrierColor: Colors.black.withOpacity(0.5),
                       builder: (context) {
                         return deletetboard();
                       },
                     );
                 
                },
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

//  dialog to add list
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
  

// delete dilog
deletetboard() {
    return Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                  vertical: MediaQuery.of(context).size.height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Text(
                    "Are you sure you want to delete your board ?",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontStyle: FontStyle.italic),
                  )),
                 
                   Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.015),
                     child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Container(
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(13),
                               color: Color.fromARGB(255, 3, 138, 248)),
                           margin: EdgeInsets.only(
                               top: MediaQuery.of(context).size.height * 0.028),
                           width: MediaQuery.of(context).size.width * 0.2,
                           height: MediaQuery.of(context).size.height * 0.053,
                           child: InkWell(
                            onTap: ()=>Get.back(),
                             child: Center(
                               child: Text(
                                 ' No',
                                 style: TextStyle(
                                   fontSize: 21,
                                   color: Colors.white,
                                 ),
                               ),
                             ),
                           ),
                         ),
                          Container(
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(13),
                               color: Color.fromARGB(255, 3, 138, 248)),
                           margin: EdgeInsets.only(
                               top: MediaQuery.of(context).size.height * 0.028),
                           width: MediaQuery.of(context).size.width * 0.2,
                           height: MediaQuery.of(context).size.height * 0.053,
                           child: InkWell(
                            onTap: () {
                              List_Controller(ds:widget.ds).deleteBoard();
                              Navigator.push(
                        context, MaterialPageRoute(builder: (context) => fun()));
                            },
                             child: Center(
                               child: Text(
                                 ' Yes',
                                 style: TextStyle(
                                   fontSize: 21,
                                   color: Colors.white,
                                 ),
                               ),
                             ),
                           ),
                         )
                       ],
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
  deletelist(){
 return   Material(
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width * 0.6,
            height: MediaQuery.of(context).size.height * 0.2,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                  vertical: MediaQuery.of(context).size.height * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: Row(
                        children: [
                          Icon(Icons.delete,color: Colors.blue,),
                          Text(
                    "List Cleared Successfully",
                    style: TextStyle(
                            color: Color.fromARGB(255, 30, 124, 202),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            fontStyle: FontStyle.italic),
                  ),
                        ],
                      )),
                 
                   Center(
                     child: Container(
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.015),
                       child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Container(
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(13),
                                 color: Color.fromARGB(255, 3, 138, 248)),
                             margin: EdgeInsets.only(
                                 top: MediaQuery.of(context).size.height * 0.028),
                             width: MediaQuery.of(context).size.width * 0.2,
                             height: MediaQuery.of(context).size.height * 0.053,
                             child: InkWell(
                              onTap: (){
                             Get.back();
                                     },
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
                           
                         ],
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