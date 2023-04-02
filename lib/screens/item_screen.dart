import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'catalog_screen.dart';

class ItemScreen extends StatefulWidget {

  QueryDocumentSnapshot? item;

  ItemScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {

  void _addToBasket(String name, String price, String description, String place, String imagePath) {
    FirebaseFirestore.instance.collection('basket').add({
      'name': name,
      'price': price,
      'description': description,
      'place': place,
      'image': imagePath,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.item?.get('name')),
            Text(widget.item?.get('description')),
            Text(widget.item?.get('price')),
            Text(widget.item?.get('place')),
            SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                child: Image.network(widget.item?.get('image'))),
            IconButton(
              onPressed: () {
                _addToBasket(
                    widget.item?.get('name'),
                    widget.item?.get('price'),
                    widget.item?.get('description'),
                    widget.item?.get('place'),
                    widget.item?.get('image'));
              },
              icon: const Icon(Icons.shopping_basket_outlined),

            ),
            const SizedBox(height: 20,),
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
