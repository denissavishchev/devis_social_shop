import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'catalog_screen.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {

  List basketList = [];
  String total = '';

  String calculate() {
    double totalPrice = 0;
    for (int i = 0; i < (basketList.length); i++) {
        totalPrice += double.parse(basketList[i]);
    }
    print('totalPrice: $totalPrice');
      total = totalPrice.toStringAsFixed(2);
      // basketList.clear();
    return totalPrice.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40,),
          Center(
            child: Container(
              width: 100,
              height: 50,
              child: Text(calculate()),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.7,
            color: kBlue.withOpacity(0.4),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('basket')
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      basketList.add(snapshot.data?.docs[index].get('price'));
                      print(basketList);
                      return Container(
                        margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                        decoration: const BoxDecoration(
                          color: kBlue,
                          borderRadius: BorderRadius.all(Radius.circular(14))
                        ),
                        child: ListTile(
                          title: Text(snapshot.data?.docs[index].get('name')),
                          subtitle: Text(snapshot.data?.docs[index].get('price')),
                          leading: CircleAvatar(
                            radius: 40,
                              child: Image.network(snapshot.data?.docs[index].get('image'))),
                          trailing: IconButton(
                            onPressed: () {
                              FirebaseFirestore.instance.collection('basket').doc(snapshot.data?.docs[index].id).delete();
                            },
                            icon: const Icon(Icons.cancel, color: kRed,),
                          ),
                        ),
                      );
                    });
              },
            ),
          ),
          const SizedBox(height: 20,),
          ElevatedButton(
              onPressed: (){
                calculate();
                // basketList.clear();

              },
              child: const Text('Calculate')),
          const SizedBox(height: 20,),
          ElevatedButton(
              onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)
                => const CatalogScreen()));
              },
              child: const Text('Catalog')),
        ],
      ),
    );
  }
}
