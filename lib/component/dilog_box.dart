import 'package:flutter/material.dart';
import 'package:my_todo/component/my_button.dart';

class DilogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DilogBox(
      {super.key,
      required this.onSave,
      required this.onCancel,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[200],
      content: SizedBox(
        height: 140,
        child: Column(
          children: [
             TextFormField(
              controller: controller,
              decoration:const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add New Task',
                  fillColor: Colors.black,
                  focusColor: Colors.black),
                 
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyButton(text: 'Save', onPressed: onSave),
                const SizedBox(
                  width: 12,
                ),
                MyButton(text: 'Cancel', onPressed:onCancel),
              ],
            )
          ],
        ),
      ),
    );
  }
}
