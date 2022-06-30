import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

class MyList extends StatefulWidget {
  const MyList({Key? key}) : super(key: key);

  @override
  State<MyList> createState() => _MyListState();
}

class _MyListState extends State<MyList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          "habda ",
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
                    onPressed: () {},
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
               height: MediaQuery.of(context).size.height*0.7,
               margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.068),

                 child: ListView(
               scrollDirection: Axis.horizontal,
children: [
  mylistStream(),
  mylistStream()
],                 ),
               )           
          ],
        ),
      ),
    );
  }

  // streaming lists of the board
  mylistStream(){
   return Container(
        width: MediaQuery.of(context).size.width*0.75,

     margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.12),
   
   
   
   decoration:BoxDecoration(
   
     color: Color.fromARGB(255, 225, 242, 255),
   
     borderRadius: BorderRadius.circular(15)
   
   ),
   
   child: Container(
    margin: EdgeInsets.symmetric(vertical:  MediaQuery.of(context).size.height*0.02,horizontal:  MediaQuery.of(context).size.width*0.04),

     child: Column(
     
     
     
     
       children: [
     
     
     
       Container(
     
     
         child: Row(
     
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
     
           children: [
     
           Text(
     
                "List 1",
     
                               style: TextStyle(
     
                                   color: Color.fromARGB(255, 18, 131, 223),
     
                                   fontSize: 20,
     
                                  ),
     
                             ),
     
           InkWell(
            onTap: (){},
             child: Image.asset("assets/images/list-interface-symbol -horizental.png",
                
             width: MediaQuery.of(context).size.width*0.06,
                
             
                
             ),
           )
     
         ],),
     
       ),
     Expanded(
      
       child: ListView(
                   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.015),
          
     children: [  
           streamtasks(),
     ],     ),
     )
     ]),
   ),
   
   );

  }
  streamtasks(){
    return Container(
      
      height: MediaQuery.of(context).size.height*0.26,
    decoration:BoxDecoration(
      
      borderRadius: BorderRadius.circular(15),
      color: Colors.white),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        Container(
         margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.027 , vertical:  MediaQuery.of(context).size.height*0.023),
            width: MediaQuery.of(context).size.width*0.5,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             
             
               
               Text("Find Your Dream",style: TextStyle(color: Color.fromARGB(255, 18, 131, 223),fontSize: 22,fontWeight: FontWeight.bold),),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  margin: EdgeInsets.only( top: MediaQuery.of(context).size.width*0.03),
                  child:ListView(
                    padding: EdgeInsets.all(0),
                    children: [ Text("Find Your Dream fkfkmfm krmkmekfmvklmldmv dkflmvld",style: TextStyle(color: Colors.grey,fontSize: 16,),)],)),
                Container(
                   margin: EdgeInsets.only( top: MediaQuery.of(context).size.width*0.01),

                  child: Row(
                    
                    children: [
                    Icon(Icons.flag,
                    color: Colors.grey,
                    ),
                    Text("date")
                  ],),
                ),
                Row(children: [
                  Container(
                    width:MediaQuery.of(context).size.width * 0.0999,
                  child: ClipPolygon(
                    
                    sides: 6,
                     borderRadius: 10.0, // Default 0.0 degrees
                      rotate: 180.0, 
                    child:Container(color: Colors.red), 
                 
                    ),
                ), 

                ],)
          
          ],),
        )
          ,
            Container(
               margin: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.width*0.009 , vertical:  MediaQuery.of(context).size.height*0.01),
              child: Column(
                children: [
                  InkWell(
                  onTap: (){
                  },
                    child: Image.asset("assets/images/list-interface-symbol copy.png",
                    
                    width:  MediaQuery.of(context).size.width*0.055,
                    height:  MediaQuery.of(context).size.width*0.05),
                           ),
                           
                ],
              ),
            )
        ],
      ),
    );

  }

  
 
  
}
