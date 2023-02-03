import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_todo/component/my_button.dart';

class TodoTile extends StatelessWidget {
  final String todoname;
  final bool todoComplet;
  Function(bool?)? onChanged;
  Function(BuildContext) onDelet;
  TodoTile(
      {super.key,
      required this.todoname,
      required this.todoComplet,
      required this.onChanged,required this.onDelet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24, top: 24),
      child: Slidable(
        endActionPane: ActionPane(
          motion:const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onDelet,
              icon: Icons.delete,
              backgroundColor:Colors.red.shade300,
              borderRadius: BorderRadius.circular(13),
            )
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Row(
            children: [
              Checkbox(
                value: todoComplet,
                onChanged: onChanged,
                activeColor: Colors.black,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                todoname,
                style: TextStyle(
                    decoration: todoComplet
                        ? TextDecoration.lineThrough
                        : TextDecoration.none),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
