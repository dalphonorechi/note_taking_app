import 'package:flutter/material.dart';
import 'package:note_taking_app/data/data.dart';

import 'AllNotes.dart';
import 'new_note.dart';

class Note extends StatefulWidget {
  final Map note;
  const Note({Key? key, required this.note}) : super(key: key);

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          title: Text(widget.note["title"]),
          backgroundColor: widget.note["color"],
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => NewNote(
                                from: "edit",
                                note: widget.note,
                              ))));
                },
                icon: const Icon(Icons.edit)),
            IconButton(
                onPressed: () {
                  Notes.removeWhere(
                      (element) => element["id"] == widget.note["id"]);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const AllNotes()));
                },
                icon: const Icon(Icons.delete))
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Text(widget.note["note"],
                style: const TextStyle(fontSize: 24))),
      ),
    );
  }
}
