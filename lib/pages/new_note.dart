import 'package:flutter/material.dart';
import 'package:note_taking_app/data/data.dart';

class NewNote extends StatefulWidget {
  const NewNote({Key? key}) : super(key: key);

  @override
  State<NewNote> createState() => _NewNoteState();
}

class _NewNoteState extends State<NewNote> {
  var color = Colors.blue;
  Map newNote = {};
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(backgroundColor: color, actions: [
        IconButton(
            onPressed: () {
              Notes.add({
                "title": titleController.text,
                "note": noteController.text,
                "color": color
              });
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
                decoration: const InputDecoration(hintText: "Title"),
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
                  decoration: const InputDecoration(
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
