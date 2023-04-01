import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MainItem extends ChangeNotifier{



  void addToBase(String name, String price, String description, String place, String imagePath) {
    FirebaseFirestore.instance.collection('items').add({
      'name': name,
      'price': price,
      'description': description,
      'place': place,
      'image': imagePath,
    });
  }
}