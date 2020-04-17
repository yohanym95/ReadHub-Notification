
import 'package:firebase_database/firebase_database.dart';

class PostDetails{
  Future<bool> addPost(postData,context,key) async {
    FirebaseDatabase.instance
        .reference()
        .child('Posts')
        .push()
        .set(postData)
        .then((onValue) {
      return false;
    }).catchError((onError) {
      return false;
    });

    return false;
  }

}