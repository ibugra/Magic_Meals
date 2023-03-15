
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:magicmeals202/utils/globalvars.dart';
import 'package:magicmeals202/widgets/comment_card.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Uint8List? _image;
  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }
  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    // set state because we need to display the image we selected on the circle avatar
    setState(() {
      _image = im;
    });
  }
  @override
  Widget build(BuildContext context) {

    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff121421),
        actions: <Widget>[

          IconButton(
            onPressed: () {
                Navigator.pushNamed(context, '/edit_recipe');


            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
        title: const Text(
          "Profile",
          style: TextStyle(),
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 60),

          Center(

            child: Stack(


              children: [

                _image != null
                    ? Center(
                      child: CircleAvatar(
                  radius: 64,
                  backgroundImage: MemoryImage(_image!),
                  backgroundColor: Colors.red,
                ),
                    )
                    : const CircleAvatar(
                  radius: 64,
                  backgroundImage: NetworkImage(
                      'https://i.stack.imgur.com/l60Hf.png'),
                  backgroundColor: Colors.red,
                ),
                Positioned(
                  bottom: -10,
                  left: 200,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                  ),
                )

              ],
            ),
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),

          const SizedBox(height: 24),
          buildAbout(user),
        ],
      ),
    );
  }

  Widget buildName(User user) => Column(
    children: [
      Text(
        user.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text("")
    ],
  );



  Widget buildAbout(User user) => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About Me',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          user.about,
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}


class User {
  final String imagePath;
  final String name;
  final String about;
  final bool isDarkMode;

  const User({
    required this.imagePath,
    required this.name,

    required this.about,
    required this.isDarkMode,
  });
}

class UserPreferences {
  static const myUser = User(
    imagePath:
    'https://www.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
    name: 'Magic Meals Cooker',

    about:
    'Certified Personal Trainer and Nutritionist with years of experience in creating effective diets and training plans focused on achieving individual customers goals in a smooth way.',
    isDarkMode: false,
  );
}
class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: StadiumBorder(),
      onPrimary: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
    ),
    child: Text(text),
    onPressed: onClicked,
  );
}


class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),

        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }



  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}



