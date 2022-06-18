// ignore_for_file: prefer_const_constructors


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_pro/modules/board/lListPage.dart';
import 'package:get/get.dart';
import 'package:polygon_clipper/polygon_clipper.dart';  // Import package for ClipPolygon
import 'package:animated_button_bar/animated_button_bar.dart';  
import 'package:flutter/material.dart';
import 'Boardcontroller.dart';
import 'task.dart';
import 'package:firebase_core/firebase_core.dart';
 


class fun extends StatefulWidget   {


  @override
  State<fun> createState() => _funState();
}

class _funState extends State<fun> with TickerProviderStateMixin {
   final boardcontroll  controll = Get.put(boardcontroll());
     FirebaseFirestore firebase = FirebaseFirestore.instance;

 bool isVisible = false;
  bool showTboard = true;
  bool showPboard = true;

       late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }
  @override
  Widget build(BuildContext
   context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
  children: [

     Visibility(
            visible: isVisible,
            child: Container(
              height: MediaQuery.of(context).size.height*0.045,
                width: MediaQuery.of(context).size.width*0.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)), color: Colors.blue,),
              child: MaterialButton(
      onPressed: () {
       showDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(0.5),
        builder: (context) {
         
        return funn();
      
        
        },
        );
        
                },
                  
                  child: Text('Task',style:TextStyle(color: Colors.white,fontSize: 17)),
                  ),
          
              
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height*0.01),
           Visibility(
            visible: isVisible,
            child: Container(
              
              height: MediaQuery.of(context).size.height*0.045,
                width: MediaQuery.of(context).size.width*0.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)), color: Colors.blue,),
              child: MaterialButton(
      onPressed: ()async {
      await showDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(0.5),
        builder: (context) {
         
        return  board();
        
        

        
        },
        );
         
      },
                  
                  child: Text('Board',style:TextStyle(color: Colors.white,fontSize: 17)),
                  ),
          
              
            ),
          ),
    Container(
                height: MediaQuery.of(context).size.height*0.09,
                 width: MediaQuery.of(context).size.width*0.17,
            child: FloatingActionButton(
              elevation: 0,
              backgroundColor: Colors.white,
              onPressed: ()=>setState(() {
                                       
                                        isVisible = !isVisible;

              }),
          
         
                child: ClipPolygon(  
                     sides: 6,
              
                   borderRadius: 8.0,
                
                    rotate: 180.0, 
             child: Container(
               color: Colors.blue,
               
               child: Icon(
                 Icons.add,
                 color:Colors.white,

                 size: 35,
               ),
               
               )
                                            ),
            )
          ),
  ],
      ),
      body:Column(
    crossAxisAlignment: CrossAxisAlignment.start,

        children: [
           Container(
          margin: EdgeInsets.only(  top:MediaQuery.of(context).size.height*0.02),
          child: Row(
            
            children: [
          
       Container(
           height: MediaQuery.of(context).size.height*0.09,
         width: MediaQuery.of(context).size.width*0.14,
           child: ClipPolygon(  
            sides: 6, 
            borderRadius: 8.0,// Default 0.0 degrees
            rotate: 180.0, // Default 0.0 degrees
            
            child: Container(color: Colors.red),
           ),
          
       ),
         
          
        Expanded(
      child: Container(
          height:MediaQuery.of(context).size.height*0.07 ,
          margin: EdgeInsets.only(top: 10),
          padding:EdgeInsets.only(left: 10) ,
          decoration: BoxDecoration(
                    color: Color.fromRGBO(238, 238, 238, 1),
                    borderRadius: BorderRadius.circular(20)
        
          ),
          child:Row(
            children: [
        
      Expanded(
        child: TextField(
        cursorWidth:1.5,
        cursorColor:Colors.blue[400],
        
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
      IconButton(
       icon: Icon(Icons.search,color: Colors.blue[400], ),onPressed:()=>{} ,
        
        
      ),
        
          ],
          )
      ),
      ), 
      
          
          
          ],
          
          )
          ,
        ),
           
           
          
           Container(
                                  margin:  EdgeInsets.only(top:MediaQuery.of(context).size.height*0.02 ) ,           
                                    height: MediaQuery.of(context).size.height*0.06,
                                           decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                               
                                  color: Color.fromARGB(255, 233, 229, 229)),
                               
                                    child: TabBar(
                                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width*0.01),
                                                   labelColor: Colors.blue,
                                                    unselectedLabelColor: Colors.grey,
                                                    controller: tabController, 
                                                    indicator:BoxDecoration(
                                                   borderRadius: BorderRadius.circular(15),
                                                   color: Colors.white
                                                    ),
                                                  
                                                tabs: [
                                          
                                     
                                                      Text('boards'),
                                                      Text('My Tasks'),
                                                    
                                                  
                                              ],),
                                  ),
        
      
          
         Expanded(
           child: DefaultTabController(
             length: 2,
            child: TabBarView(
              controller: tabController,
              children: [
            myboard(),
           mytask()
            ]),
            ),
         ),
      ],)

 
    
    
        
       
      
    );
  
  }



  
  

   
   
  theboard(DocumentSnapshot ds, int index){
  return MaterialButton(
   padding: EdgeInsets.all(0),
    onPressed: (){ Navigator.push(context,MaterialPageRoute(builder: (context)=>MyList()));
},
    child: Row(
       children: [
         Container(
             height: MediaQuery.of(context).size.height*0.09,
           width: MediaQuery.of(context).size.width*0.14,
             child: ClipPolygon(  
              sides: 6, 
              borderRadius: 8.0,// Default 0.0 degrees
              rotate: 180.0, // Default 0.0 degrees
              
              child: Container(color: Color.fromARGB(255, 21, 139, 235),
              child: Center(
                child: Text(
                          ""   ,
                         style: TextStyle(color: Colors.white,fontSize: 25),
                ),
                
              ),
              ),
             ),
             
            
         ),
         Text(ds['Name'],style: TextStyle(fontSize: 22,color: Color.fromARGB(255, 173, 169, 169)),),
         Expanded(
           
           child:MaterialButton(
             color: Colors.red,
             onPressed:(){
            firebase.collection("Boards").doc(ds.id).delete();
            
             }
  
           )
            ),
       ],
  
    ),
  );
}
  
 myboard(){
   return   ListView(
              
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.03),
                  children: [
                  
               Container(
                 margin:EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01,right:MediaQuery.of(context).size.width*0.04 ) ,
                child: Row(
                 
                  children: [
                Container(
                       height: MediaQuery.of(context).size.height*0.03,
                       width: MediaQuery.of(context).size.width*0.045,
                       margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),
                         decoration: BoxDecoration(
                       image: DecorationImage(
                 
                       fit: BoxFit.fill,
                       image:AssetImage("assets/images/bold-Vexels.jpg",))
                         ),
                  
                  
                 ),
                  
                 InkWell(
                 onTap:()=>setState(() {
                 showPboard=!showPboard;
               
                 }) ,
                 child: Text("Private Board",style: TextStyle(color: Colors.grey[500],fontStyle: FontStyle.italic,fontSize: 17 ),),
                 
                 )
               ,
               Expanded(
                 child: Container(
                 margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),
                 decoration: BoxDecoration(
               border: Border.all(
                 color: Color.fromARGB(255, 207, 197, 197),
                 width: 1,
                 
               )
                 ),
                 ),
               ),
               
                 
                 
                 ],),
                 )
                , SizedBox(height: MediaQuery.of(context).size.height*0.018,) , 
                 
                 
                  Visibility(
                  visible: showPboard,
                  child:StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:controll.ReadBoard(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                        padding:EdgeInsets.symmetric(vertical: 0) ,
                      itemCount: snapshot.data!.docs.length,
                       itemBuilder: (context,index){
                         DocumentSnapshot ds = snapshot.data!.docs[index];
                                      
                         if(ds["visibilty"]==1){
                            return theboard(ds,index);
                         }
                         else return Container();
                     }
                     
                     );
                  }
                  else{
                    return Container();
                  }
                },
                
                
                 ),
                  
                  )

                     ,SizedBox(height: MediaQuery.of(context).size.height*0.018,)             
                  ,  Container(
                 margin:EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02,right:MediaQuery.of(context).size.width*0.04 ) ,
                child: Row(
                 
                  children: [
                Container(
                       height: MediaQuery.of(context).size.height*0.03,
                       width: MediaQuery.of(context).size.width*0.045,
                       margin: EdgeInsets.only(right: MediaQuery.of(context).size.width*0.01),
                         decoration: BoxDecoration(
                       image: DecorationImage(
                 
                       fit: BoxFit.fill,
                       image:AssetImage("assets/images/bold-Vexels.jpg"))
                         ),
                  
                  
                 ),
                  
                 InkWell(
                 onTap:()=>setState(() {
                 showTboard=!showTboard;
               
                 }) ,
                 child: Text("Teams Board",style: TextStyle(color: Colors.grey[500],fontStyle: FontStyle.italic,fontSize: 17 ),),
                 
                 )
               ,
               Expanded(
                 child: Container(
                 margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.01),
                 decoration: BoxDecoration(
               border: Border.all(
                 color: Color.fromARGB(255, 207, 197, 197),
                 width: 1,
                 
               )
                 ),
                 ),
               ),
               
                 
                 
                 ],),
                 )
                 , SizedBox(height: MediaQuery.of(context).size.height*0.018,)  ,
                 
                 Visibility(
                  visible: showTboard,
                  child:StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:controll.ReadBoard(),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      shrinkWrap: true,
                       physics: NeverScrollableScrollPhysics(),
                        padding:EdgeInsets.symmetric(vertical:0) ,
                      itemCount: snapshot.data!.docs.length,
                       itemBuilder: (context,num){
                         DocumentSnapshot ds = snapshot.data!.docs[num];
                                      
                         if(ds["visibilty"]==0){
                            return theboard(ds,num);
                         }
                         else return Container();
                     }
                     
                     );
                  }
                  else{
                    return Container();
                  }
                },
                
                
                 ),
                  
                  )
                  ],
                );  
   
      
 }

 mytask(){

   return Column();
 }
}




   










