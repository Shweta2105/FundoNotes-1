import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class DisplayCard extends StatelessWidget {
  final Function onTap;
  final Widget child;
  final double size;
  final Color color;
  final String text;
  final FocusNode node;
  final String hintText;
  final TextEditingController controller;
  final bool isvalid;

  const DisplayCard(
      {Key? key,
      required this.size,
      required this.onTap,
      required this.child,
      required this.color,
      required this.text,
      required this.node,
      required this.hintText,
      required this.controller,
      required this.isvalid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var widget;
    return Container(
      height: 100,
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 0),
      child: TextField(
        controller: widget.controller,
        focusNode: widget.node,
        onChanged: (value) {
          widget.isvalid = value.length <= 15;
        },
        style: TextStyle(
          fontStyle: FontStyle.normal,
          fontSize: 20,
          color: HexColor('#606E74'),
        ),
        decoration: InputDecoration(
            labelText: widget.text,
            errorStyle: const TextStyle(fontSize: 15),
            labelStyle: TextStyle(
                color: widget.node.hasFocus
                    ? isvalid
                        ? Colors.amberAccent
                        : Colors.red
                    : HexColor('#658292')),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: HexColor('#658292'))),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              borderSide: widget.node.hasFocus
                  ? const BorderSide(color: Colors.amber, width: 1.2)
                  : BorderSide(color: HexColor('#658292')),
            )),
      ),
    );
  }
}
