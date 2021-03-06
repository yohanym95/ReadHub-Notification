import 'package:firebase_auth/firebase_auth.dart';

String name;
String email;
String imageUrl;
String userId;

final FirebaseAuth _auth = FirebaseAuth.instance;


Future<FirebaseUser> signIn(String email, String password) async {
  // TODO: implement signIn
  AuthResult result =
      await _auth.signInWithEmailAndPassword(email: email, password: password);
  FirebaseUser user = result.user;

  return user;
}

Future<void> signOut() async {
  // TODO: implement signOut
 
  return _auth.signOut();
}

Future<String> signUp(String email, String password) async {
  // TODO: implement signUp
  AuthResult result = await _auth.createUserWithEmailAndPassword(
      email: email, password: password);

  FirebaseUser user = result.user;
  return user.uid;
}

Future<FirebaseUser> getCurrentUser() async {
  // TODO: implement getCurrentUser
  FirebaseUser user = await _auth.currentUser();
  return user;
}


// //google sign In
// Future<FirebaseUser> signInWithGoogle() async {
//   final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
//   final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;

//   final AuthCredential credential = GoogleAuthProvider.getCredential(
//       accessToken: googleSignInAuthentication.accessToken,
//       idToken: googleSignInAuthentication.idToken);

//   final AuthResult authResult = await _auth.signInWithCredential(credential);
//   final FirebaseUser user = authResult.user;

//   // Checking if email and name is null
//   assert(user.email != null);
//   assert(user.displayName != null);
//   assert(user.photoUrl != null);

//   name = user.displayName;
//   email = user.email;
//   imageUrl = user.photoUrl;
//   userId = user.uid;

//   // Only taking the first part of the name, i.e., First Name
//   // if (name.contains(" ")) {
//   //   name = name.substring(0, name.indexOf(" "));
//   // }

//   assert(!user.isAnonymous);
//   assert(await user.getIdToken() != null);

//   final FirebaseUser currentUser = await _auth.currentUser();
//   assert(user.uid == currentUser.uid);

//   return user;
// }

// void signOutGoogle() async {
//   await _googleSignIn.signOut();
//   // print("User Sign Out");
// }