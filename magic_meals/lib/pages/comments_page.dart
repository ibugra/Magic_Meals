import 'dart:convert';

import 'package:comment_box/comment/comment.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:magicmeals202/utils/colors.dart';
import 'package:magicmeals202/utils/globalvars.dart';
import 'package:magicmeals202/widgets/comment_card.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../classes/recipe.dart';

class CommentPage extends StatefulWidget {
  final String recID;
  const CommentPage({Key? key, required this.recID}) : super(key: key);
  //const CommentPage({Key? key}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  bool isLoading = true;
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List filedata = [];
  List<String> commentList = [];
  List<String> commenterList = [];
  final _formKey = GlobalKey<FormState>();
  TextEditingController commentCont = TextEditingController();

  Future<void> readData() async {
    var url = "https://magicmeals202-default-rtdb.europe-west1.firebasedatabase.app/recipes/"+widget.recID+"/comments.json";
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      //print(response.body);
      final extractedData = json.decode(response.body) as Map<String,dynamic>;
      //final extractedData = extractedDataList[0];
      print(extractedData);
      //print(extractedDataList);
      if (extractedData == null) {
        return;
      }
      extractedData.forEach((blogId, blogData) {
        commenterList.add(blogData["commenter"]);
        commentList.add(blogData["comment"]);
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

/*
  Widget commentChild(data) {
    return ListView(
      children: [
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(data[i]['pic'] + "$i")),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
            ),
          )
      ],
    );
  }

*/

  @override
  Widget build(BuildContext context) {

    DatabaseReference ref = FirebaseDatabase.instance.ref("recipes/"+widget.recID+"/comments");
    //DatabaseReference newCommentRef = ref.push();
    //final recipe = Provider.of<Recipe>(context, listen: false);
    //print(widget.recID);
    return Scaffold(
      backgroundColor: Color(0xff121421),
      appBar: AppBar(
        title: Text("Comment Page"),
        backgroundColor: Color(0xff121421),
      ),
      body:
      isLoading
          ? const Center(child: CircularProgressIndicator())
          :Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => const Divider(
                color: Colors.white,
              ),
              itemCount: commentList.length,
              itemBuilder: (BuildContext context, int index) {
                return CommentCard(
                    commenter: commenterList[index],
                    comment: commentList[index]
                );
              },

            ),
          ),
          SizedBox(height: 15,),
          Form(

            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: commentCont,
                  style: const TextStyle(color: Colors.white),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                    decoration: InputDecoration(
                      labelText: "Enter your comment",
                      labelStyle: TextStyle(
                          color: Colors.white
                      ),
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: athens_gray,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 1.0,
                        ),
                      ),
                    ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xFFF4F4F8),
                    ),
                    onPressed: () async {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {

                        setState(() {
                          commentList.add(commentCont.text);
                          commenterList.add(GlobalVars.currentUsername);
                        });
                        String? newkey = ref.push().key;
                        print(newkey);
                        await ref.child(newkey!).set(
                            {
                              'comment' : commentCont.text,
                              'commenter' : GlobalVars.currentUsername,
                            }
                        );
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Comment posted!')),
                        );
                      }
                    },
                    child: const Text('Submit', style: TextStyle(color: Color(0xff121421)),),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}




/*

class CommentForm extends StatefulWidget {
  const CommentForm({Key? key}) : super(key: key);

  @override
  CommentFormState createState() {
    return CommentFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class CommentFormState extends State<CommentForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  TextEditingController commentCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(

      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: commentCont,
            style: const TextStyle(color: Colors.white),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(

              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {

                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}



 */

/*
CommentBox(
          userImage:
          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
          child: commentChild(filedata),
          labelText: 'Write a comment...',
          withBorder: false,
          errorText: 'Comment cannot be blank',
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              setState(() {
                var value = {
                  'name': 'New User',
                  'pic':
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                  'message': commentController.text
                };
                filedata.insert(0, value);
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        ),

 */