import 'package:flutter/material.dart';
class Roundbutton extends StatelessWidget {
  final String title;
  final VoidCallback tap;
  final bool isloading;
  const Roundbutton({Key? key,required this.title,required this.tap,
  this.isloading = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: tap,
      child: Container(
    height: 50,
    width: size.width*0.9 ,
    decoration: BoxDecoration(
      color: Colors.deepPurple,
      borderRadius: BorderRadius.circular(12),
    
    ),
    child: Center(child:isloading? CircularProgressIndicator(backgroundColor: Colors.white,): Text(title,style: TextStyle(color: Colors.white,fontSize: 20),)),
      ),
    );
  }
}