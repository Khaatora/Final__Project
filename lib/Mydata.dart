class Board{
  String? name;
  int? Visibility;
    Board({this.name,this.Visibility});
Map<String, dynamic> tomap(){
     final Map<String,dynamic> data =new Map<String,dynamic>();
     
      data['Name']=this.name;
      data['visibilty']=this.Visibility;
      return data;
   }
}

