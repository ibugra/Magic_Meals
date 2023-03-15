import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magicmeals202/widgets/recipe_card.dart';
import 'package:http/http.dart' as http;

import '../classes/recipe.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<String> idList = [];
  List<String> titleList = [];
  List<String> imageList = [];
  List<String> imageList1 = [];
  List<String> imageList2 = [];
  List<String> imageList3 = [];
  List<String> descriptionList = [];
  List<String> ingredientsList = [];
  List<String> preparationList = [];
  List<int> ratingsList = [];
  List<int> ratingCountList = [];
  //List<List<Comment>> commentsList = [];

  Future<void> readData() async {
    var url = "https://magicmeals202-default-rtdb.europe-west1.firebasedatabase.app/recipes.json";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String,dynamic>;
      print(extractedData);
      if (extractedData == null) {
        return;
      }

      extractedData.forEach((blogId, blogData) {
        idList.add(blogData["id"]);
        titleList.add(blogData["title"]);
        imageList.add(blogData["imageURL"]);
        imageList1.add(blogData["imageURL1"]);
        imageList2.add(blogData["imageURL2"]);
        imageList3.add(blogData["imageURL3"]);
        descriptionList.add(blogData["description"]);
        ingredientsList.add(blogData["ingredients"]);
        preparationList.add(blogData["preparation"]);
        ratingsList.add(blogData["ratings"]);
        ratingCountList.add(blogData["ratingCount"]);

      });
      setState(() {
        isLoading = false;
      });
    } catch (error) {

      print(error);
      throw error;
    }
  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121421),
      appBar: AppBar(
        backgroundColor: const Color(0xff121421),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            onPressed: () {

            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/add_recipe');
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profile_page');
            },
            icon: const Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
          ),
        ],
        title: const Text(
          "Home Page",
          style: TextStyle(),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.separated(
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemCount: titleList.length,
          itemBuilder: (BuildContext context, int index) {
            return RecipeCard(
                idList[index],
                titleList[index],
                imageList[index],
                imageList1[index],
                imageList2[index],
                imageList3[index],
                descriptionList[index],
                ingredientsList[index],
                preparationList[index],
                ratingsList[index],
                ratingCountList[index],
                200,
                100,
            );
          }),
    );
  }
}
