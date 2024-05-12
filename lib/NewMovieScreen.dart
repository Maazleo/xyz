import 'package:flutter/material.dart';

import 'FirebaseFunctions.dart';
import 'MoviesClass.dart'; // Import your Movie class
class CreateMovieScreen extends StatefulWidget {
  @override
  _CreateMovieScreenState createState() => _CreateMovieScreenState();
}

class _CreateMovieScreenState extends State<CreateMovieScreen> {
  final FirebaseFunctions firebaseFunctions = FirebaseFunctions();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Movie'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextFormField(
              controller: _imageController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            TextFormField(
              controller: _durationController,
              decoration: InputDecoration(labelText: 'Duration'),
            ),
            TextFormField(
              controller: _urlController,
              decoration: InputDecoration(labelText: 'URL'),
            ),
            TextFormField(
              controller: _typeController,
              decoration: InputDecoration(labelText: 'Type'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Create a new movie object using the entered details
                Movie newMovie = Movie(
                  name: _nameController.text,
                  image: _imageController.text,
                  duration: _durationController.text,
                  url: _urlController.text,
                  type: _typeController.text,
                );
                // Call the Firebase upload function to upload the new movie
                FirebaseFunctions firebaseService = FirebaseFunctions();
                await firebaseService.uploadMovie(newMovie);

                // Once the movie is uploaded, you can navigate back to the previous screen
                Navigator.pop(context, newMovie);
              },
              child: Text('Create Movie'),
            ),
          ],
        ),
      ),
    );
  }
}