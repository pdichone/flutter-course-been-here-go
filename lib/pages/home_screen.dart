import 'dart:io';

import 'package:been_here_go/components/camera_button.dart';
import 'package:been_here_go/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  XFile? _selectedImage;

  void _takePicture() async {
    final imagePicker = ImagePicker();
    final XFile? imageFile =
        await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 450);

    if (imageFile == null) {
      return;
    }

    setState(() {
      _selectedImage = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
        onPressed: _takePicture,
        icon: const Icon(Icons.camera_alt_outlined),
        label: const Text('Take a Picture'));

    if (_selectedImage != null) {
      content = GestureDetector(
        onTap: _takePicture,
        child: SizedBox(
          height: 200,
          width: double.infinity,
          child: Image.file(
            File(_selectedImage!.path),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).signOut();
              },
              icon: const Icon(Icons.logout))
        ],
        title: const Text('BeenHere'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                Text(
                  'Maine County, 87904',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            // camera and button area
            CameraButton(content: content),
          ],
        ),
      ),
    );
  }
}
