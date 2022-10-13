import 'package:app_1/posts/post_screen.dart';
import 'package:app_1/ui/auth/phone_numb.dart';
import 'package:app_1/ui/auth/signup_screen.dart';
import 'package:app_1/ui/splash_screen.dart';
import 'package:app_1/ui/widget/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Utils/Utils.dart';


class LoginScreen extends StatefulWidget {
   LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
    final emailcontroller=TextEditingController();
    final passcontroller=TextEditingController();
    final _formkey = GlobalKey<FormState>();
    bool loading=false;
      FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login'),centerTitle: true,),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
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
                                controller: emailcontroller,                    decoration: InputDecoration(
                         prefixIcon: Icon(Icons.email_outlined),
                        hintText: 'Enter Email'
                      ),
            
                      validator: (value) {
                        if(value!.isEmpty){
                          return'enter email';
                        }
                      },
                            ),
                            SizedBox(height: 20,),
                            TextFormField(
                              
                              controller: passcontroller,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_open_outlined),
                        hintText: 'Enter Password'
                      ),
                      validator: (value) {
                        if(value!.isEmpty){
                          return'enter password';
                        }
                      },
                            ),
                        ],
                      )),
                    ],
                  ),
                ),
                  
            
             SizedBox(height: 70,),
            
                Roundbutton(
                  isloading: loading ,
                  tap: () async{
                    
                    if(_formkey.currentState!.validate()){
setState(() {
                      loading = true;
                    });
                      try{
 await _auth.signInWithEmailAndPassword(
                          email: emailcontroller.text.toString(), password: 
                          passcontroller.text.toString()).then((value) {
                            setState(() {
                      loading = false;
                    });
                             utils().toastMessage('Login Successfully');
                             Navigator.push(context,
                         MaterialPageRoute(builder: (context) =>
                          postscreen()
                         
                         ));

                          },);
                    
                      }on FirebaseAuthException catch (e) {
                        setState(() {
                      loading = false;
                    });
                        debugPrint('zeeshan zeeshan zeeshan'+e.toString());
  // setState(() {
  //   loading = false;
  // });
      switch (e.code) {
        case "wrong-password":
        utils().toastMessage('Incorrect Password');
          //return 'Your username or password is incorrect. Please try again.';
          break;
          case "user-not-found":
        utils().toastMessage('User not exist');
          //return 'Your username or password is incorrect. Please try again.';
          break;
          case "invalid-email":
        utils().toastMessage('Invalid Email');
          //return 'Your username or password is incorrect. Please try again.';
          break;
     }
   }
                       
                                
                    }
                  },
                  title: 'Login',
            
                  
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                   
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                         MaterialPageRoute(builder: (context) =>
                           signup())
                        );
                      },
                      child:Text('Signup') ,
                      
                    )
                  ],
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => phone(),));
                  },
                  child: Container(
                    height: 50,
                    width: size.width*0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      border: Border.all(
                        width: 1.6,
                        color: Colors.black
                      )
                      
                    ),
                    child: Center(child: Text('Sign in With Phone'),),
                  ),
                )
              ],
            ),
          ),
        ),
      
    );
  }
}