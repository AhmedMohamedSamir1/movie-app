// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

import '../components/components.dart';

class FireBaseClass{


  //-------- start upload image --------------
  // static Future upLoadImage ({
  //   required File image,
  //   required childName,
  // })async
  // {
  //
  //    return await firebase_storage.FirebaseStorage.instance
  //        .ref()
  //        .child('$childName${Uri.file(image.path).pathSegments.last }')
  //        .putFile(image);
  // }
  //-------- end upload image --------------

  //-------------start get image url---------------
  static Future<String> getImageUrl(value)async
  {
    return await value.ref.getDownloadURL();
  }
  //-------------end get image url-----------------


  //-----start upload image and get urlImage----------
  // static Future<String> upLoadImageAndGetUrl ({
  //   required File image,
  //   required childName,
  // })async
  // {
  //
  //   dynamic val =  await firebase_storage.FirebaseStorage.instance
  //       .ref()
  //       .child('$childName${Uri.file(image.path).pathSegments.last }')
  //       .putFile(image).catchError((onError){
  //
  //         print(onError.toString());
  //   });
  //   return await val.ref.getDownloadURL();
  //
  // }
  //-----end upload image and get ImageURL----------


//------- start register by email and password --------
  static Future<UserCredential> registerByEmailAndPass({
    required String email,
    required String password,
  })async{

   return await  FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email,
       password: password
   );
  }
//--------- end register by email and password -------

//--------------start sign-in by email and pass --------------

  static Future<UserCredential> userLogInByEmailAndPass({
    required String email,
    required String password,
  })async{

    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
//--------------end sign-in by email and pass --------------

//------------- start verify email address  --------------
  static Future<void> verifyEmailAddress()
  async {
    await FirebaseAuth.instance.currentUser!.sendEmailVerification();
    toastMessage(textMessage: "check your email", toastState: ToastStates.SUCCESS);
  }
//------------- end verify email address  ----------------

//------------start add to fire store -------------
  static Future<void> addToFireSore({

    required String collectionName,
    required String docName,
    required Map<String, dynamic> model,
  })async
  {

    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(docName)
        .set(model).then((value) {

    }).catchError((error){
      print(error.toString());
    });
  }
//-------- end add to fire store----------

//------------start update to fire store -------------
  static Future<void> updateFireSoreData({

    required String collectionName,
    required String docName,
    required Map<String, dynamic> model,
  })async
  {

    return await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(docName)
        .update(model).then((value) {

    }).catchError((error){
      print(error.toString());
    });
  }
  //-------- end update to fire store----------

  //-------- start get from fire store -------
  static Future getDataFromFireStore({
    required String collectionName,
    required String docName,

  })async {

    return await FirebaseFirestore.instance.collection(collectionName).doc(docName).get()
        .catchError((onError){
          print(onError.toString());
    });
  }
  //-------- end get from fire store -------


  //-------- start add to fire store WithAutomaticDoc -----------

  static Future addToFireStoreWithAutomaticDoc({

    required Map<String, dynamic> model,
    required String collectionName,

  })async
  {
    return await FirebaseFirestore.instance.collection(collectionName)
        .add(model).then((value) {

    }).catchError((onError){
      print(onError.toString());
    });

  }
  //------------end add to fire store WithAutomaticDoc ------------

  //-------- start get all collection docs from fire store ----------
  static Future<QuerySnapshot<Map<String, dynamic>>> getCollectionDocsFromFireStore({
    required String collectionName
  })async
  {
    return await FirebaseFirestore.instance.collection(collectionName).get();
  }
  //----- end get all collection docs from fire store----------------

  //-------- start get all collection docs from fire store in order descending or ascending-------
  static Future<QuerySnapshot<Map<String, dynamic>>> getCollectionDocsFromFireStoreInOrder({

    required String collectionName,
    required String orderBy,
    required bool descendingOrder,

  })
  async {

    return await FirebaseFirestore.instance
        .collection(collectionName)
        .orderBy(orderBy,descending: descendingOrder)
        .get();
  }

  //-------- end get all collection docs from fire store in order descending or ascending-------

//------start Register with google--------

  // static Future<User?> signInWithGoogle({
  //   required context
  // }) async
  // {
  //
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   User? user;
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //
  //   final GoogleSignInAccount? googleSignInAccount =
  //   await googleSignIn.signIn();
  //
  //   if (googleSignInAccount != null) {
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //     await googleSignInAccount.authentication;
  //
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //
  //     try {
  //       final UserCredential userCredential =
  //       await auth.signInWithCredential(credential);
  //
  //       user = userCredential.user;
  //     } on FirebaseAuthException catch (e) {
  //       if (e.code == 'account-exists-with-different-credential') {
  //         toastMessage(textMessage: 'account-exists-with-different-credential', toastState: ToastStates.ERROR);
  //         // handle the error here
  //       }
  //       else if (e.code == 'invalid-credential') {
  //         toastMessage(textMessage: 'invalid-credential', toastState: ToastStates.ERROR);
  //       }
  //     } catch (e) {
  //       // handle the error here
  //     }
  //   }
  //
  //   return user;
  // }
//------end Register with google--------

//--------start sign out from google-------
//   static Future<void> signOutFromGoogle({
//     required BuildContext context
//   }) async
//   {
//     final GoogleSignIn googleSignIn = GoogleSignIn();
//
//     try {
//       if (!kIsWeb) {
//         await googleSignIn.signOut();
//       }
//       await FirebaseAuth.instance.signOut();
//     } catch (e) {
//       toastMessage(textMessage: 'Error signing out. Try again.', toastState:ToastStates.ERROR );
//
//     }
//   }
//--------end sign out from google-------

//-----start sign out from emailPassword------
//   static Future<void> logOut() async
//   {
//       await FirebaseAuth.instance.signOut();
//   }
//-----end sign out from emailPassword------

//----start send email to user--------

// static Future<void> sendEmail({
//     required String emailSubject,
//     required String emailBody,
//     required List<String> recipients,
//     List<String> cc = const [],
//     List<String> bcc = const [],
//
// }) async {
//
//   final Email email = Email(
//     subject: emailSubject,
//     body: emailBody,
//     recipients: recipients,
//
//     cc: cc,   // if You want to send a copy of your email to your manager.
//     bcc: bcc,
//     //attachmentPaths: ['/path/to/attachment.zip'],
//      isHTML: false,
//   );
//    await FlutterEmailSender.send(email);
// }
//----end send email to user--------

//---- sign in by facebook-----

  // static Future<UserCredential> signInWithFacebook() async {
  //   // Trigger the sign-in flow
  //   final LoginResult loginResult = await FacebookAuth.instance.login();
  //
  //   // Create a credential from the access token
  //   final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
  //
  //   // Once signed in, return the UserCredential
  //   return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  // }
  //https://tazkarti-bdd8b.firebaseapp.com/__/auth/handler
//---- sign in by facebook-----

}



