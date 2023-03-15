import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:magicmeals202/pages/comments_page.dart';
import 'package:magicmeals202/utils/colors.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../classes/recipe.dart';

class RecipeDetailed extends StatefulWidget {
  const RecipeDetailed({Key? key}) : super(key: key);

  @override
  _RecipeDetailedState createState() => _RecipeDetailedState();
}



class _RecipeDetailedState extends State<RecipeDetailed> {
  @override
  int _ratingValue = 0;
  int count = 0;
  int activeIndex = 0;
  String recID = "lol";
  int newRating = 0;
  int newRatingCount = 0;
  bool rated = false;
  int ratingsnapshot = 0;


  Future<void> readData() async {
    var url = "https://magicmeals202-default-rtdb.europe-west1.firebasedatabase.app/recipes/"+recID+".json";
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      newRating = extractedData['ratings'];
      newRatingCount = extractedData['ratingCount'];
      print(newRating);
    } catch (error) {

      print(error);
      throw error;
    }
  }

  Widget build(BuildContext context) {
    final recipe = Provider.of<Recipe>(context, listen: false);
    DatabaseReference ref = FirebaseDatabase.instance.ref("recipes/");
    count = recipe.ratingCount;
    return Scaffold(
      backgroundColor: Color(0xff121421),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Column(
                  children: <Widget> [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 10.0, 0, 8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              recipe.title,//
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                                color: athens_gray,
                                shadows: [
                                  Shadow(
                                    blurRadius: 3.0,
                                    color: Colors.black,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: Color(0xFFF6F6F9),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child:
                      rated
                          ? Text('⭐ '+ ((recipe.ratings+ratingsnapshot)/(recipe.ratingCount+1)).toStringAsFixed(2) + ' (' + (recipe.ratingCount+1).toString() + ')', style: const TextStyle(color: Color(0xFFF6F6F9), fontSize: 15),)//snapshot
                          :
                        Text(
                        '⭐ ' + (_ratingValue/recipe.ratingCount).toStringAsFixed(2) + ' (' + count.toString() + ')' != null
                            ?  '⭐ '+ (recipe.ratings/recipe.ratingCount).toStringAsFixed(2) + ' (' + count.toString() + ')'
                            : 'Rate it!',
                        style: const TextStyle(color: Color(0xFFF6F6F9), fontSize: 15),
                      ),
                    ),
                    SizedBox(height: 15,),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 220,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index),
                      ),
                      items: [
                        Container(
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(recipe.imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(recipe.imageUrl1),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(recipe.imageUrl2),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(recipe.imageUrl3),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 1,
                          child: RatingBar(
                              initialRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              ratingWidget: RatingWidget(
                                  full: const Icon(Icons.star,
                                      size: 15, color: Color(0xFFF6F6F9)),
                                  half: const Icon(
                                    Icons.star_half,
                                    size: 15,
                                    color: Color(0xFFF6F6F9),
                                  ),
                                  empty: const Icon(
                                    Icons.star_outline,
                                    size: 15,
                                    color: Color(0xFFF6F6F9),
                                  )),
                              onRatingUpdate: (value) {
                                setState(() {
                                  _ratingValue = value.toInt();
                                });
                              }),
                        ),
                        SizedBox(width: 1,),
                        TextButton(
                            onPressed: (){
                              setState((){
                                if (_ratingValue != null) {
                                  ref.child("/" + recipe.id)
                                    ..child("ratings").set(
                                        ServerValue.increment(_ratingValue));
                                  ref.child("/" + recipe.id)
                                    ..child("ratingCount").set(
                                        ServerValue.increment(1));
                                  recID = recipe.id;
                                  ratingsnapshot = _ratingValue;
                                  rated = true;
                                  //newRating = recipe.ratings;
                                  //newRatingCount = recipe.ratingCount;
                                  //readData();
                                  //Navigator.pop(context);
                                }
                              });
                            },
                            child: const Text("Rate this recipe!")),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFFF6F6F9).withOpacity(0.1),
                          ),
                          alignment: Alignment.center,
                        child:   Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 0.0, right: 8.0, bottom: 8.0),
                          child: Column(
                            children: [

                              const Center(
                                child: Text(
                                  'Description',
                                  style: TextStyle(
                                    color: athens_gray,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                recipe.description,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: manatee,
                                ),
                              ),
                            ],
                          ),
                        ),

                        ),

                      ],
                    ),
                    const SizedBox(height: 2),
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFFF6F6F9).withOpacity(0.1),
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 0.0, right: 8.0, bottom: 8.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 15),
                                const Text(
                                  'Ingredients',
                                  style: TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    color: athens_gray,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                recipe.ingredients != null
                                    ? Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: Text(
                                      recipe.ingredients,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal,
                                        color: manatee,
                                      ),
                                    ),
                                  ),
                                )
                                    : const Text(
                                  '',
                                ),
                              ],
                            ),
                          ),
                        ),


                      ],
                    ),

                    const SizedBox(height: 2),
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xFFF6F6F9).withOpacity(0.1),
                          ),
                          alignment: Alignment.center,
                          child:   Padding(
                            padding: const EdgeInsets.only(left: 8.0, top: 0.0, right: 8.0, bottom: 8.0),
                            child: Center(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Text(
                                    'Preparation',
                                    style: TextStyle(
                                      color: athens_gray,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    recipe.preparation,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: manatee,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    IconButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommentPage(recID: recipe.id)));
                      },
                      icon: const Icon(
                        Icons.chat,
                        color: Color(0xFFF6F6F9),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
