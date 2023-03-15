

import 'package:flutter/material.dart';
import 'package:magicmeals202/utils/colors.dart';
import 'package:provider/provider.dart';

import '../classes/recipe.dart';

class RecipeCard extends StatelessWidget {
  final String id;
  final String title;
  final String imgURL;
  final String imgURL1;
  final String imgURL2;
  final String imgURL3;//url for now
  final String description;
  final String ingredients;
  final String preparation;
  final int ratings;
  final int ratingCount;
  final double height;
  final double width;

   const RecipeCard(
      this.id,
      this.title,
      this.imgURL,
      this.imgURL1,
      this.imgURL2,
      this.imgURL3,
      this.description,
      this.ingredients,
      this.preparation,
      this.ratings,
      this.ratingCount,
      this.height,
      this.width,
      );



  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<Recipe>(context, listen: false).id=id;
        Provider.of<Recipe>(context, listen: false).title=title;
        Provider.of<Recipe>(context, listen: false).imageUrl=imgURL;
        Provider.of<Recipe>(context, listen: false).imageUrl1=imgURL1;
        Provider.of<Recipe>(context, listen: false).imageUrl2=imgURL2;
        Provider.of<Recipe>(context, listen: false).imageUrl3=imgURL3;
        Provider.of<Recipe>(context, listen: false).description=description;
        Provider.of<Recipe>(context, listen: false).ingredients=ingredients;
        Provider.of<Recipe>(context, listen: false).preparation=preparation;
        Provider.of<Recipe>(context, listen: false).ratings=ratings;
        Provider.of<Recipe>(context, listen: false).ratingCount=ratingCount;


        Navigator.pushNamed(context, '/detailed_page');
      },
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.network(imgURL,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

          ),
          Container(
            alignment: Alignment.center,
            height: 25,
            width: double.infinity,
            color: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: Container(
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                  color: vermilion,
                  shadows: [
                    Shadow(
                      blurRadius: 5.0,
                      color: Colors.black,
                      offset: Offset(3.0, 3.0),
                    ),
                  ],
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}

