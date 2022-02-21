import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundonotes/models/notes.dart';
import 'package:fundonotes/screens/editnote.dart';

class NoteCard extends StatefulWidget {
  Notes note;
  NoteCard({Key? key, required this.note}) : super(key: key);

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (context) => EditNote(
              note: widget.note,
            ),
          ))
              .then((value) {
            setState(() {});
          });
        },
        child: Card(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black54.withOpacity(0.2),
                      ),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey.shade100,
                            blurRadius: 1,
                            spreadRadius: 0.0,
                            offset: const Offset(2.0, 2.0))
                      ]),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.note.title ?? "",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 5,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          widget.note.description ?? "",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        )
                      ]),
                ))));
  }
}
