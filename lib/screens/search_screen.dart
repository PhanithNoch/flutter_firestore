import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<QueryDocumentSnapshot> lstSearchResult = [];

  void _search(String keyword) {
    print(keyword);
    FirebaseFirestore.instance
        .collection('users')
        .where('full_name', isEqualTo: keyword)
        .get()
        .then((value) {
      setState(() {
        lstSearchResult = [];
        lstSearchResult.addAll(value.docs);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Screen"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: TextFormField(
                onFieldSubmitted: (String newValue) {
                  _search(newValue);
                },
                controller: _searchController,
                decoration: InputDecoration(hintText: "Search ...."),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: lstSearchResult.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                      title: Text(lstSearchResult[index]['full_name']),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
