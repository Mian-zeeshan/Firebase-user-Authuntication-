import 'package:app_1/posts/post_screen.dart';
import 'package:app_1/ui/auth/signup_screen.dart';
import 'package:app_1/ui/splash_screen.dart';
import 'package:app_1/ui/widget/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Utils/Utils.dart';


class otpverify extends StatefulWidget {
  final String verificationId;
   otpverify({ Key? key,required this.verificationId }) : super(key: key );

  @override
  State<otpverify> createState() => _otpverifyState();
}

class _otpverifyState extends State<otpverify> {
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
        title: Text('OPT Verification'),centerTitle: true,),
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
                                  
                                  keyboardType: TextInputType.number,
                             
                                  controller: phcontroller,                    decoration: InputDecoration(
                           prefixIcon: Icon(Icons.phone),
                          hintText: '123 456'
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
              
                 Roundbutton(title: 'Verify', tap: () async{
                  if(_formkey.currentState!.validate()){
                    final credantial= PhoneAuthProvider.credential(
                      verificationId: widget.verificationId, smsCode:phcontroller.text.toString() );

                      try{
                        await  _auth.signInWithCredential(credantial);
                         Navigator.push(context, MaterialPageRoute(builder: (context) => postscreen(),));
                      utils().toastMessage('Sucessfully login');
                      }
                      catch(e){
                            utils().toastMessage('incorrect OTP');
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