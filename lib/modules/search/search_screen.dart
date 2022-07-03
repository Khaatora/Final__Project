


import 'package:flutter/material.dart';

class Search extends SearchDelegate<String>{
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(onPressed: (){},icon: Icon(Icons.search),);
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
  
  
  
  
}