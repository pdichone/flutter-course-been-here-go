import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddPlaceFrom extends StatefulWidget {
  final String latitude;
  final String longitude;
  final String currentAddress;

  final XFile? imageFile;

  const AddPlaceFrom({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.currentAddress,
    this.imageFile,
  });

  @override
  State<AddPlaceFrom> createState() => _AddPlaceFromState();
}

class _AddPlaceFromState extends State<AddPlaceFrom> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _thoughtsController = TextEditingController();
  double _rating = 1;

  void _savePlace(String currentUserId) async {
    if (_formKey.currentState!.validate()) {
      //save the place
      if (widget.imageFile != null) {
        try {
          // save to storage
        } catch (e) {}
      }
      // 1. Save the image file to storage

      // 2. Once the image is saved, we can request the image url
      // 3. Instantiate our place object to which we pass the image url
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _thoughtsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Place Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a name';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a description';
                    } else {
                      return null;
                    }
                  },
                ),
                TextFormField(
                  controller: _thoughtsController,
                  decoration: const InputDecoration(
                    labelText: 'Thoughts',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your thoughts';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Slider(
                    value: _rating,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: 'Rating: $_rating',
                    onChanged: (double value) {
                      setState(() {
                        _rating = value;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      // save place
                    },
                    child: Text('Save Place'))
              ],
            ),
          ),
        ));
  }
}
