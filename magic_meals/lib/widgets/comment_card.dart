

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String commenter;
  final String comment;
  const CommentCard({Key? key, required this.commenter, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
          child: ListTile(
            leading: Container(
              height: 50.0,
              width: 50.0,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: const CircleAvatar(
                  radius: 50,
              ),
            ),
            title: Text(commenter),
            subtitle: Text(
                comment
            ),
            isThreeLine: true,
          ),
    );
  }
}

