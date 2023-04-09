import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devis_social_shop/screens/item_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'icon_button_widget.dart';

class ItemWidget extends StatelessWidget {
  ItemWidget({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('timeLine')
          .orderBy('addedDate', descending: true)
          .snapshots(),
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
                            const CircleAvatar(
                              backgroundColor: kRed,
                              radius: 22,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/avatar.png'),
                                // NetworkImage(snapshot.data?.docs[index].get('avatar')),
                                radius: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                Text(snapshot.data?.docs[index].get('name'),
                                    style: kMainStyle),
                                Text(snapshot.data?.docs[index].get('place'),
                                    style: kShadeStyle),
                              ],
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.menu_rounded,
                                  color: Colors.white,
                                ))
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
                            const SizedBox(
                              width: 8,
                            ),
                            IconButtonWidget(
                              onTap: () {
                                print('message');
                              },
                              imageActive: 'chat',
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            IconButtonWidget(
                              onTap: () {
                                print('telegram');
                              },
                              imageActive: 'telegram',
                            ),
                            const Spacer(),
                            IconButtonWidget(
                              onTap: () {
                                print('bookmark');
                              },
                              imageActive: 'bookmark_red',
                              imagePassive: 'bookmark_white',
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/avatar.png'),
                              radius: 10,
                            ),
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/avatar.png'),
                              radius: 10,
                            ),
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/avatar.png'),
                              radius: 10,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Liked by ',
                                  style: kShadeStyle,
                                  children: [
                                    TextSpan(text: 'Devis', style: kMainStyle),
                                    TextSpan(text: ' and ', style: kShadeStyle),
                                    TextSpan(
                                        text: '12 others', style: kMainStyle),
                                  ]),
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
                                  text: 'Devis ',
                                  style: kMainStyle,
                                  children: [
                                    TextSpan(
                                        text: 'The best cakes in the world',
                                        style: kShadeStyle),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/avatar.png'),
                              radius: 10,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Add a comment...',
                              style: kShadeStyle,
                            ),
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
