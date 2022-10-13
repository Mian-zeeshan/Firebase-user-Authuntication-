import 'dart:async';

import 'package:app_1/posts/post_screen.dart';
import 'package:app_1/ui/auth/login_screen.dart';
import 'package:app_1/ui/upload_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../firestore_screen/Firestore_posts.dart';
class SplashServises{
  void islogin( BuildContext context){
 FirebaseAuth _auth = FirebaseAuth.instance;
 final user = _auth.currentUser;
 if(user!=null){
  Timer(Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(builder: ((context) => uploadimage())));
      
    },);
 }
 else{
  Timer(Duration(seconds: 2), () {
      Navigator.push(context, MaterialPageRoute(builder: ((context) => LoginScreen())));
      
    },);
 }
  
  }
}