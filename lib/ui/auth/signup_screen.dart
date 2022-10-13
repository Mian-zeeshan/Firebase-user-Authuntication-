import 'package:app_1/Utils/Utils.dart';
import 'package:app_1/ui/splash_screen.dart';
import 'package:app_1/ui/widget/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';


class signup extends StatefulWidget {
   signup({ Key? key }) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
    final emailcontroller=TextEditingController();
    final passcontroller=TextEditingController();
    final _formkey = GlobalKey<FormState>();
     bool loading = false;
    FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Signup'),centerTitle: true,),
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
                  isloading: loading,
                  tap: () async{
                    setState(() {
                      loading=true;
                    });
                    if(_formkey.currentState!.validate()){
        try {
   await _auth.createUserWithEmailAndPassword(email: 
                      emailcontroller.text.toString(), password: passcontroller.text.toString());
            setState(() {
              loading = false;
            });
 utils().toastMessage('Successfuly Regetserd user');
} 
on FirebaseAuthException catch (e) {
  setState(() {
    loading = false;
  });
      switch (e.code) {
        case "weak-password":
        utils().toastMessage('weak password');
          //return 'Your username or password is incorrect. Please try again.';
          break;
          case "email-already-in-use":
        utils().toastMessage('Already regesterd Account');
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
                    Text("Already have an account?"),
                   
                    TextButton(
                      onPressed: () {
                        Navigator.push(context,
                         MaterialPageRoute(builder: (context) =>
                          LoginScreen()
                         
                         ));
                        
                      },
                      child:Text('Login') ,
                      
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      
    );
  }
}