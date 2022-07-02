


import 'package:flutter/material.dart';

class Search extends SearchDelegate<String>{
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(onPressed: (){},icon: Icon(Icons.clear),);
    throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
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