import 'package:devis_social_shop/auth_screens/auth_screen.dart';
import 'package:devis_social_shop/auth_screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../widgets/item_widget.dart';
import 'add_item_screen.dart';
import 'basket_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.08,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 40,),
                    Image.asset('assets/images/logo.gif'),
                    IconButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          // Navigator.of(context).push(MaterialPageRoute(builder: (context)
                          // => const AuthScreen()));
                        },
                        icon: const Icon(Icons.exit_to_app_outlined,
                          color: Colors.deepOrange, size: 30,)),
                  ] ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: ItemWidget(),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.06,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)
                        // => const BasketScreen()));
                      },
                      icon: const Icon(Icons.shopping_basket_rounded, color: Colors.deepOrange, size: 30,)),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)
                        => const AddItemScreen()));
                      },
                      icon: const Icon(Icons.add_circle, color: Colors.deepOrange, size: 30,)),
                ],
              ),
            )
          ]
        ),
      ),
    );
  }
}
