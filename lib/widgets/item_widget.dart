import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devis_social_shop/screens/item_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../constants.dart';
import 'icon_button_widget.dart';

class ItemWidget extends StatefulWidget {
  ItemWidget({Key? key}) : super(key: key);

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  final user = FirebaseAuth.instance.currentUser!;

  String _imagePath = '';

  final ImagePicker _picker  =ImagePicker();

  Future _takePhoto() async {
    XFile? selectedFile = await _picker.pickImage(source: ImageSource.gallery,);
    if (selectedFile == null) return;

    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImage.child(uniqueFileName);


    try{
      await referenceImageToUpload.putFile(File(selectedFile.path));
      _imagePath = await referenceImageToUpload.getDownloadURL();
    }catch(e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('timeLine').orderBy('addedDate', descending: true).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final item = snapshot.data?.docs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ItemScreen(
                            item: item,
                          )));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.78,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: kRed,
                              radius: 22,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(snapshot.data?.docs[index].get('avatar')),
                                radius: 20,
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Column(
                              children: [
                                Text(snapshot.data?.docs[index].get('name'), style: kMainStyle),
                                Text(snapshot.data?.docs[index].get('place'), style: kShadeStyle),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: (){
                                  _takePhoto();
                                  FirebaseFirestore.instance
                                      .collection(user.email!)
                                      .doc(snapshot.data?.docs[index].id)
                                      .update({'avatar': _imagePath});
                                  FirebaseFirestore.instance
                                      .collection('timeLine')
                                      .doc(snapshot.data?.docs[index].id)
                                      .update({'avatar': _imagePath});
                                },
                                icon: const Icon(Icons.menu_rounded, color: Colors.white,))
                          ],
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 200 / 200,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.5,
                          width: MediaQuery.of(context).size.width,
                          child: Image.network(
                            snapshot.data?.docs[index].get('image'),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            IconButtonWidget(
                              onTap: () {
                                print('like');
                              },
                              imagePassive: 'like_white',
                              imageActive: 'like_red',
                              ),
                            const SizedBox(width: 8,),
                            IconButtonWidget(
                                onTap: () {
                                  print('message');
                                },
                                imageActive: 'chat',),
                            const SizedBox(width: 8,),
                            IconButtonWidget(
                              onTap: () {
                                print('telegram');
                              },
                              imageActive: 'telegram',),
                            const Spacer(),
                            IconButtonWidget(
                              onTap: () {
                                print('bookmark');
                              },
                              imageActive: 'bookmark_red',
                              imagePassive: 'bookmark_white',),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/images/avatar.png'),
                              radius: 10,
                            ),
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/images/avatar.png'),
                              radius: 10,
                            ),
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/images/avatar.png'),
                              radius: 10,
                            ),
                            const SizedBox(width: 8,),
                            RichText(
                              text: TextSpan(
                                text: 'Liked by ', style: kShadeStyle,
                                children: [
                                  TextSpan(text: 'Devis', style: kMainStyle),
                                  TextSpan(text: ' and ', style: kShadeStyle),
                                  TextSpan(text: '12 others', style: kMainStyle),
                                ]
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: 'Devis ', style: kMainStyle,
                                  children: [
                                    TextSpan(text: 'The best cakes in the world', style: kShadeStyle),
                                  ]
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/images/avatar.png'),
                              radius: 10,
                            ),
                            const SizedBox(width: 8,),
                            Text('Add a comment...', style: kShadeStyle,),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
