import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'catalog_screen.dart';

class ItemScreen extends StatelessWidget {

  QueryDocumentSnapshot? item;

  ItemScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(item?.get('name')),
            Text(item?.get('description')),
            Text(item?.get('price')),
            Text(item?.get('place')),
            Image.network(item?.get('image')),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)
                => const CatalogScreen()));
              },
              icon: const Icon(Icons.back_hand),

            ),
          ],
        ),
      ),
    );
  }
}
