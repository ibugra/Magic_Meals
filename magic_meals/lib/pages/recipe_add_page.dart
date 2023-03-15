import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Homepage.dart';

class RecipeAdd extends StatefulWidget {
  const RecipeAdd({Key? key}) : super(key: key);

  @override
  _RecipeAddState createState() => _RecipeAddState();
}

class _RecipeAddState extends State<RecipeAdd> {
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlFocusNode1 = FocusNode();
  final _imageUrlFocusNode2 = FocusNode();
  final _imageUrlFocusNode3 = FocusNode();
  List controllers = List.generate(8, (index) => TextEditingController());
  String URL = "";
  final _form = GlobalKey<FormState>();
  List names = ["Title", "Description", "Ingredients", "Preparation"];
  String temp_title ="";
  String temp_desc ="";
  String temp_ingre ="";
  String temp_prep ="";
  String temp_url ="";
  String temp_url1 ="";
  String temp_url2 ="";
  String temp_url3 ="";

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    _imageUrlFocusNode1.addListener(_updateImageUrl1);
    _imageUrlFocusNode2.addListener(_updateImageUrl2);
    _imageUrlFocusNode3.addListener(_updateImageUrl3);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode1.removeListener(_updateImageUrl1);
    _imageUrlFocusNode2.removeListener(_updateImageUrl2);
    _imageUrlFocusNode3.removeListener(_updateImageUrl3);
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode1.dispose();
    _imageUrlFocusNode2.dispose();
    _imageUrlFocusNode3.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!controllers[4].text.startsWith('http') &&
          !controllers[4].text.startsWith('https')) ||
          (!controllers[4].text.endsWith('.png') &&
              !controllers[4].text.endsWith('.jpg') &&
              !controllers[4].text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _updateImageUrl1() {
    if (!_imageUrlFocusNode1.hasFocus) {
      if ((!controllers[5].text.startsWith('http') &&
          !controllers[5].text.startsWith('https')) ||
          (!controllers[5].text.endsWith('.png') &&
              !controllers[5].text.endsWith('.jpg') &&
              !controllers[5].text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _updateImageUrl2() {
    if (!_imageUrlFocusNode2.hasFocus) {
      if ((!controllers[6].text.startsWith('http') &&
          !controllers[6].text.startsWith('https')) ||
          (!controllers[6].text.endsWith('.png') &&
              !controllers[6].text.endsWith('.jpg') &&
              !controllers[6].text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _updateImageUrl3() {
    if (!_imageUrlFocusNode3.hasFocus) {
      if ((!controllers[7].text.startsWith('http') &&
          !controllers[7].text.startsWith('https')) ||
          (!controllers[7].text.endsWith('.png') &&
              !controllers[7].text.endsWith('.jpg') &&
              !controllers[7].text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference ref = FirebaseDatabase.instance.ref("recipes/");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff121421),
        title: const Text("Add Recipe"),
        actions: [
          IconButton(
            onPressed: () async {
              temp_title = controllers[0].text;
              temp_desc = controllers[1].text;
              temp_ingre = controllers[2].text;
              temp_prep = controllers[3].text;
              temp_url = controllers[4].text;
              temp_url1 = controllers[5].text;
              temp_url2 = controllers[6].text;
              temp_url3 = controllers[7].text;
              String? newkey = ref.push().key;
              await ref.child(newkey!).set({
                'id' : newkey,
                'title' :temp_title,
                'description' : temp_desc,
                'ingredients' : temp_ingre,
                'preparation' : temp_prep,
                'imageURL' : temp_url,
                'imageURL1' : temp_url1,
                'imageURL2' : temp_url2,
                'imageURL3' : temp_url3,
                'ratings': 5,
                'ratingCount' : 1,
                'comments' :
                {
                  'start':
                    {
                      'commenter': 'Magic Meals',
                      'comment': 'Leave a comment!',
                    }

                }
              });
              dispose();
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: names.length - 1,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a value.';
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp("[-]"))
                      ],
                      decoration: InputDecoration(
                        hintText: names[index],
                      ),
                      controller: controllers[index],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  maxLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please provide a description.';
                    }
                    if (value.length < 10) {
                      return 'Should be at least 10 characters long.';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: names[3],
                  ),
                  controller: controllers[3],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: controllers[4].text.isEmpty
                              ? const Text('Enter a URL')
                              : FittedBox(
                            child: Image.network(
                              controllers[4].text,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            onChanged: (_) {
                              _updateImageUrl();
                            },
                            decoration:
                            const InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: controllers[4],
                            focusNode: _imageUrlFocusNode,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an image URL.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL.';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Please enter a valid image URL.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: controllers[5].text.isEmpty
                              ? const Text('Enter a URL')
                              : FittedBox(
                            child: Image.network(
                              controllers[5].text,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            onChanged: (_) {
                              _updateImageUrl();
                            },
                            decoration:
                            const InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: controllers[5],
                            focusNode: _imageUrlFocusNode1,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an image URL.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL.';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Please enter a valid image URL.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: controllers[6].text.isEmpty
                              ? const Text('Enter a URL')
                              : FittedBox(
                            child: Image.network(
                              controllers[6].text,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            onChanged: (_) {
                              _updateImageUrl();
                            },
                            decoration:
                            const InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: controllers[6],
                            focusNode: _imageUrlFocusNode2,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an image URL.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL.';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Please enter a valid image URL.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(
                            top: 8,
                            right: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.grey,
                            ),
                          ),
                          child: controllers[7].text.isEmpty
                              ? const Text('Enter a URL')
                              : FittedBox(
                            child: Image.network(
                              controllers[7].text,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextFormField(
                            onChanged: (_) {
                              _updateImageUrl();
                            },
                            decoration:
                            const InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: controllers[7],
                            focusNode: _imageUrlFocusNode3,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an image URL.';
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return 'Please enter a valid URL.';
                              }
                              if (!value.endsWith('.png') &&
                                  !value.endsWith('.jpg') &&
                                  !value.endsWith('.jpeg')) {
                                return 'Please enter a valid image URL.';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
