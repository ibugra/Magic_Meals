
import 'dart:convert';
import 'package:magicmeals202/classes/comment.dart';

import 'package:flutter/cupertino.dart';

/*class Recipe with ChangeNotifier {
  String id;
  String title;
  String imageUrl;
  String description;
  String ingredients;
  String preparation;
  double ratings;
  int ratingCount;
  List<Map<String, dynamic>> comments = <Map<String,dynamic>> [
      {
      'commenter': '',
      'comment' : '',
      }
    ];

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.preparation,
    required this.imageUrl,
    required this.ratings,
    required this.ratingCount
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      ingredients : json['ingredients'] as String,
      preparation: json['preparation'] as String,
      imageUrl: json['imageURL'] as String,
      ratings: json['ratings'] as double,
      ratingCount: json['ratingCount'] as int,
    );
  }

}
*/
/*
RecipeClass RecipeClassFromJson(String str) => RecipeClass.fromJson(json.decode(str));

String RecipeClassToJson(RecipeClass data) => json.encode(data.toJson());

class RecipeClass {
  RecipeClass({
    required this.recipes,
  });

  Map<String, Recipe> recipes;

  factory RecipeClass.fromJson(Map<String, dynamic> json) => RecipeClass(
    recipes: Map.from(json["recipes"]).map((k, v) => MapEntry<String, Recipe>(k, Recipe.fromJson(v))),
  );

  Map<String, dynamic> toJson() => {
    "recipes": Map.from(recipes).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
  };
}

 */

class Recipe with ChangeNotifier {
  Recipe({
    required this.comments,
    required this.description,
    required this.id,
    required this.imageUrl,
    required this.imageUrl1,
    required this.imageUrl2,
    required this.imageUrl3,
    required this.ingredients,
    required this.preparation,
    required this.ratingCount,
    required this.ratings,
    required this.title,
  });

  Map<dynamic,dynamic> comments;
  String description;
  String id;
  String imageUrl;
  String imageUrl1;
  String imageUrl2;
  String imageUrl3;
  String ingredients;
  String preparation;
  int ratingCount;
  int ratings;
  String title;

  /*factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    description: json["description"],
    id: json["id"] == null ? null : json["id"],
    imageUrl: json["imageURL"],
    imageUrl1: json["imageURL1"],
    imageUrl2: json["imageURL2"],
    imageUrl3: json["imageURL3"],
    ingredients: json["ingredients"],
    preparation: json["preparation"],
    ratingCount: json["ratingCount"],
    ratings: json["ratings"],
    title: json["title"],
  );
*/
 /* Map<String, dynamic> toJson() => {
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    "description": description,
    "id": id == null ? null : id,
    "imageURL": imageUrl,
    "imageURL1": imageUrl1,
    "imageURL2": imageUrl2,
    "imageURL3": imageUrl3,
    "ingredients": ingredients,
    "preparation": preparation,
    "ratingCount": ratingCount,
    "ratings": ratings,
    "title": title,
  };
  */
}

