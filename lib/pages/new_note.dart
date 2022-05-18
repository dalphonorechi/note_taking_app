import 'package:flutter/material.dart';
import 'package:note_taking_app/data/data.dart';
import 'package:note_taking_app/pages/AllNotes.dart';

class NewNote extends StatefulWidget {
  final Map? note;
  final String from;
  const NewNote({Key? key, this.note, required this.from}) : super(key: key);

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  var color = Colors.blue;
  Map? newNote = {};
  final titleController = TextEditingController();
  final noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    newNote = widget.from == "edit"
        ? widget.note
        : {"id": Notes.length, "title": "", "note": "", "color": color};
    if (widget.note == null) {
    } else {
      titleController.text = widget.note!["title"] ?? "";
      noteController.text = widget.note!["note"] ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(backgroundColor: newNote!["color"], actions: [
        IconButton(
            onPressed: () {
              if (widget.from == "edit") {
                int index = Notes.indexWhere(
                    (element) => element["id"] == widget.note!["id"]);
                Notes.removeAt(index);
                Notes.insert(index, {
                  "id": widget.note!["id"],
                  "title": titleController.text,
                  "note": noteController.text,
                  "color": color
                });
              } else {
                Notes.add({
                  "id": Notes.length,
                  "title": titleController.text,
                  "note": noteController.text,
                  "color": color
                });
              }

              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const AllNotes()));
            },
            icon: const Icon(Icons.save))
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                    colors.length,
                    (index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              color = colors[index];
                            });
                          },
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: colors[index],
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(5.0),
                color: color,
                child: TextField(
                  controller: noteController,
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                  decoration: InputDecoration(
                      hintText: "Your Note ...",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none),
                  minLines: 20,
                  maxLines: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
