import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devis_social_shop/screens/catalog_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';


class AddItemScreen extends StatefulWidget {
  const AddItemScreen({Key? key}) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {

  late String _name;
  late String _price;
  late String _description;
  late String _place;
  String _imagePath = '';
  var _tempImage;

  final user = FirebaseAuth.instance.currentUser!;

  void _addToBase(String name, String price, String description, String place, String imagePath) {
    FirebaseFirestore.instance.collection(user.email!).add({
      'name': name,
      'price': price,
      'description': description,
      'place': place,
      'image': imagePath,
      'isLiked': '0',
      'isBookmark': '0',
      'avatar': '',
      'addedDate': DateTime.now()
    });
    FirebaseFirestore.instance.collection('timeLine').add({
      'name': name,
      'price': price,
      'description': description,
      'place': place,
      'image': imagePath,
      'isLiked': '0',
      'isBookmark': '0',
      'avatar': '',
      'addedDate': DateTime.now()
    });
  }



  final ImagePicker _picker  =ImagePicker();

  Future _takePhoto() async {
    XFile? selectedFile = await _picker.pickImage(source: ImageSource.gallery,);
    if (selectedFile == null) return;

    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImage.child(uniqueFileName);

    setState(() {
      _tempImage = selectedFile;
    });

    try{
      await referenceImageToUpload.putFile(File(selectedFile.path));
      _imagePath = await referenceImageToUpload.getDownloadURL();
    }catch(e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Stack(
            children: [
              Row(
                children: [
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(width: 1, color: Colors.black)
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextField(
                            decoration: const InputDecoration(
                                hintText: 'Name'
                            ),
                            onChanged: (String value) {
                              _name = value;
                            },
                          ),
                          TextField(
                            decoration: const InputDecoration(
                                hintText: 'Price'
                            ),
                            onChanged: (String value) {
                              _price = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            border: Border.all(width: 1, color: Colors.black)
                        ),
                      child: Column(
                        children: [
                          TextField(
                            decoration: const InputDecoration(
                              hintText: 'Description'
                            ),
                            onChanged: (String value) {
                              _description = value;
                            },
                          ),
                          TextField(
                            decoration: const InputDecoration(
                                hintText: 'Place'
                            ),
                            onChanged: (String value) {
                              _place = value;
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                  onPressed: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)
                                    => const CatalogScreen()));
                                  },
                                  child: const Text('Cancel')),
                              ElevatedButton(
                                  onPressed: (){
                                    _addToBase(_name, _price, _description, _place, _imagePath);
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context)
                                    => const CatalogScreen()));
                                  },
                                  child: const Text('Submit')),
                            ],
                          )
                        ],
                      )
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(5, 5, 20, 5),
                  width: MediaQuery.of(context).size.width / 2 - 10,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: 1, color: Colors.black)
                  ),
                  child: Stack(
                    children: [
                      _tempImage == null ? Image.asset('assets/images/logo.gif') : Image.file(File(_tempImage.path)),
                      Center(
                        child: IconButton(
                            onPressed: (){
                              _takePhoto();
                            },
                            icon: const Icon(Icons.photo_camera)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
