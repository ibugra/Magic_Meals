import 'package:firebase_auth/firebase_auth.dart';
import 'package:magicmeals202/utils/globalvars.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signIn(String email, String password) async {
    var user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return user.user;
  }

  signOut() async {
    return await _auth.signOut();
  }

  Future<User?> createPerson(String name, String email, String password) async {

    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    GlobalVars.currentUsername = name;


    /*await _firestore
        .collection("Person")
        .doc(user.user!.uid)
        .set({'userName': name, 'email': email});*/

    return user.user;
  }
}