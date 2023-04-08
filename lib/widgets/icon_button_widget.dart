import 'package:flutter/material.dart';

class IconButtonWidget extends StatefulWidget {

  final String imageActive;
  final String? imagePassive;
  void Function() onTap;

  IconButtonWidget({Key? key,
    required this.onTap,
    required this.imageActive,
    this.imagePassive
  }) : super(key: key);

  @override
  State<IconButtonWidget> createState() => _IconButtonWidgetState();
}

class _IconButtonWidgetState extends State<IconButtonWidget> {
  bool isActive = false;

  void _isActive() {
    setState(() {
      isActive = !isActive;
    });
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        _isActive();
      },
      child: SizedBox(
        width: 30,
        height: 30,
        child: Image.asset('assets/icons/${isActive ? widget.imageActive : widget.imagePassive ?? widget.imageActive}.png'),
      ),
    );
  }
}
