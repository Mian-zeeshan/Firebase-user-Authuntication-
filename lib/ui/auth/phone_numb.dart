import 'package:app_1/posts/post_screen.dart';
import 'package:app_1/ui/auth/otp.dart';
import 'package:app_1/ui/auth/signup_screen.dart';
import 'package:app_1/ui/splash_screen.dart';
import 'package:app_1/ui/widget/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Utils/Utils.dart';


class phone extends StatefulWidget {
   phone({ Key? key }) : super(key: key);

  @override
  State<phone> createState() => _phoneState();
}

class _phoneState extends State<phone> {
    final phcontroller=TextEditingController();
    
    final _formkey = GlobalKey<FormState>();
    bool loading=false;
      FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Phone Number Verification'),centerTitle: true,),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                
               
                children: [
                  Container(
                    width: size.width*0.9,
                    child: Column(
                      children: [
                        Form(
                          key: _formkey,
                          child: Column(
                          children: [
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                             
                                  controller: phcontroller,                    decoration: InputDecoration(
                           prefixIcon: Icon(Icons.phone),
                          hintText: '+92 341 3445032'
                        ),
              
                        validator: (value) {
                          if(value!.isEmpty){
                            return'enter Phone No';
                          }
                        },
                              ),
                             
                            
                          ],
                        )),
                      ],
                    ),
                  ),
                    
              
               SizedBox(height: 40,),
              
                 Roundbutton(title: 'Login', tap: () {
                  if(_formkey.currentState!.validate()){

                    if(utils().isMobileNumberValid(phcontroller.text.toString())){
                      _auth.verifyPhoneNumber(
                      phoneNumber: phcontroller.text,
                      verificationCompleted: (_){

                      }, 
                      verificationFailed: (e) {
                        utils().toastMessage(e.toString());
                        
                      },
                       codeSent: (verificationId, Token) {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => otpverify(verificationId: verificationId),));
                         
                       }, 
                       codeAutoRetrievalTimeout: (e) {
                          utils().toastMessage(e.toString());
                       },);

                       utils().toastMessage('Send OTP');
                    }
                    else{
                                utils().toastMessage('Invalid Phone No format');
                    }

                    
                      
                  }
                   
                 },),
                 
                
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}