

import 'package:flutter/material.dart';

import '../firebase_servises/splash_servises.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    SplashServises splashscreen =   SplashServises();
  @override
  void initState() {
  splashscreen.islogin(context);
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('splash screen', style: TextStyle(
          fontSize: 20,
          color: Colors.black
        ),),
      ),

      
    );
  }
}