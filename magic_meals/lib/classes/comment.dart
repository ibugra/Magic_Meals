// To parse this JSON data, do
//
//     final magicmeals202DefaultRtdbExport = magicmeals202DefaultRtdbExportFromJson(jsonString);

import 'dart:convert';


class Comment {
  Comment({
    required this.comment,
    required this.commenter,
  });

  String comment;
  String commenter;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    comment: json["comment"],
    commenter: json["commenter"],
  );

  Map<String, dynamic> toJson() => {
    "comment": comment,
    "commenter": commenter,
  };
}
