import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devis_social_shop/screens/item_screen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
        .collection('items')
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
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)
                  => ItemScreen(item: item,)));
                },
                child: Container(
                  margin: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: kGreyBlue,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(width: 1, color: kRed)
                                      ),
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                          child: Text(snapshot.data?.docs[index].get('name'))),
                                    ),
                                  ),
                                  const SizedBox(height: 5,),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                          color: kGreyBlue,
                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                          border: Border.all(width: 1, color: kRed)
                                      ),
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(snapshot.data?.docs[index].get('price'))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 5,),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: kGreyBlue,
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(width: 1, color: kRed)
                                ),
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(snapshot.data?.docs[index].get('description'))),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        left: 30,
                        child: Container(
                          width: 100,
                          height: 160,
                          decoration: BoxDecoration(
                              color: kGreyBlue,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(width: 2, color: kRed)
                          ),
                          child: Image.network(snapshot.data?.docs[index].get('image')),
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
