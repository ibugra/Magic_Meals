import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:magicmeals202/pages/Homepage.dart';
import 'package:magicmeals202/pages/comments_page.dart';
import 'package:magicmeals202/pages/intro_page.dart';
import 'package:magicmeals202/pages/login_input_page.dart';
import 'package:magicmeals202/pages/login_page.dart';
import 'package:magicmeals202/pages/profile.dart';
import 'package:magicmeals202/pages/recipe_detailed_page.dart';
import 'package:magicmeals202/pages/recipe_add_page.dart';
import 'package:magicmeals202/services/notification_service.dart';
import 'package:magicmeals202/widgets/recipe_card.dart';
import 'package:provider/provider.dart';
import 'classes/recipe.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService notif_handler = NotificationService();
  var list = ['Burger','Manti','Pizza','Salad','Pasta','Soup'];
  var randomItem = (list.toList()..shuffle()).first;
  notif_handler.init();
  notif_handler.periodicNotification(randomItem);
  //notif_handler.scheduledNotifications(randomItem);
  runApp(MyApp(
  ));
  
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider<Recipe>(create: (_) => Recipe(
          id: "",
          title: "Default Food",
          imageUrl: "No URL Provided",
          imageUrl1: "No URL Provided",
          imageUrl2: "No URL Provided",
          imageUrl3: "No URL Provided",
          description: "Default Description",
          ingredients: "Default Ingredients",
          preparation: "Default Preparation",
          ratingCount: 0,
          ratings: 0,
          comments:
          {

          },
        )),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "/detailed_page": (ctx) => const RecipeDetailed(),
          "/add_recipe": (ctx) => const RecipeAdd(),
          "/login_page": (ctx) => LoginScreen(),
          "/home_page": (ctx) => const HomePage(),
          "/login_input_page": (ctx) => LoginInputScreen(),
          "/profile_page": (ctx) => ProfilePage(),
          //"/comments_page": (ctx) => CommentPage(),

        },
        home: FutureBuilder(
            future: _fbApp,
            builder: (context,snapshot){
              if (snapshot.hasError){
                return Text("An error occured");
              }
              else if (snapshot.hasData){
                return IntroScreen();
              }
              else {
                return CircularProgressIndicator();
              }
            }
        ),
      ),
    );
  }
}
