import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DetailModal extends StatelessWidget {
  final Map<String, dynamic> detail;

  const DetailModal({super.key, required this.detail});

  Future<void> addToMyList(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> myList = prefs.getStringList('myList') ?? [];
    final itemJson = json.encode(detail);
    if (!myList.contains(itemJson)) {
      myList.add(itemJson);
      await prefs.setStringList('myList', myList);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${detail['title']} added to My List')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${detail['title']} is already in My List')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text(
        detail['title'],
        style: const TextStyle(color: Colors.black),
      ),
      content: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              detail['img_link'],
              width: 100,
              height: 150,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 150,
                  color: Colors.black,
                  child: const Center(
                    child: Icon(Icons.error, color: Colors.red),
                  ),
                );
              },
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Year: ${detail['year']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Genre: ${detail['genre']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'IMDb: ${detail['imdb']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    detail['description'],
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
          child: const Text('Close'),
        ),
        ElevatedButton(
          onPressed: () {
            addToMyList(context);
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[900],
          ),
          child: const Text('Add to My List'),
        ),
      ],
    );
  }
}
