import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_favorite_places/models/place.dart';
import 'package:provider/provider.dart';

import 'my_fav_places.dart';

import '../widgets/location_input.dart';
import '../widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = '/add-place';

  const AddPlaceScreen({super.key});

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  final _notesController = TextEditingController();
  File? _pickedImage;
  PlaceLocation? _pickedLocation;
  final _formKey = GlobalKey<FormState>();

  void _selectImage(File pickedImage) {
    setState(() {
      _pickedImage = pickedImage;
    });
  }

  void _selectPlace(double latitude, double longitute) {
    _pickedLocation = PlaceLocation(latitude: latitude, longitude: longitute);
  }

  Future<void> _savePlace() async {
    !_formKey.currentState!.validate();
    if (_titleController.text.isEmpty ||
        _pickedImage!.path.isEmpty ||
        _pickedLocation!.longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Something is missing!'),
        ),
      );
    } else {
      await Provider.of<MyFavoritePlaces>(context, listen: false).addPlace(
        _pickedImage,
        _titleController.text,
        _pickedLocation,
        _notesController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Place'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter name for your place';
                          }
                          return null;
                        },
                        decoration:
                            const InputDecoration(labelText: 'Place name'),
                        controller: _titleController,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                    const SizedBox(height: 10),
                    LocationInput(_selectPlace),
                    Card(
                      elevation: 2,
                      child: TextFormField(
                        controller: _notesController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          label:
                              Text('Write your notes here'), //Adding notes here
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Add new place'),
            onPressed: _savePlace,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
