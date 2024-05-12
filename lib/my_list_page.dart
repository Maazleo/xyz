import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MyListPage extends StatefulWidget {
  const MyListPage({Key? key}) : super(key: key);

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  List<dynamic> myListItems = [];

  @override
  void initState() {
    super.initState();
    loadMyList();
  }

  Future<void> loadMyList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> myList = prefs.getStringList('myList') ?? [];
    setState(() {
      myListItems = myList.map((item) => json.decode(item)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My List'),
        backgroundColor: Colors.blueAccent,
      ),
      body: myListItems.isNotEmpty
          ? ListView.builder(
        itemCount: myListItems.length,
        itemBuilder: (context, index) {
          var item = myListItems[index];
          return Card(
            color: Colors.grey[800],
            child: ListTile(
              title: Text(
                item['title'],
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                item['genre'],
                style: const TextStyle(color: Colors.white70),
              ),
              leading: Image.network(
                item['img_link'],
                width: 100,
                fit: BoxFit.cover,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  setState(() {
                    myListItems.removeAt(index);
                  });
                  final prefs = await SharedPreferences.getInstance();
                  List<String> updatedList = myListItems.map((item) => json.encode(item)).toList();
                  await prefs.setStringList('myList', updatedList);
                },
              ),
            ),
          );
        },
      )
          : const Center(
        child: Text(
          'No items in My List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
