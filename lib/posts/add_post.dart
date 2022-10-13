import 'package:app_1/Utils/Utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../ui/widget/Button.dart';
class addpost extends StatefulWidget {
  const addpost({Key? key}) : super(key: key);

  @override
  State<addpost> createState() => _addpostState();
}

class _addpostState extends State<addpost> {
  final mykey = GlobalKey<FormState>(); 
  final postcontroller = TextEditingController();
  final firebase = FirebaseDatabase.instance.ref('Post');
  bool iloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Post'),
      centerTitle: true,),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 30,right: 30,top: 50),
            child: Column(
              children: [
                Form(
                  key: mykey,
                  child: 
                TextFormField(
                  controller: postcontroller,
                  keyboardType: TextInputType.text,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'write post....',
                    
                    border: OutlineInputBorder()
                  ),
                validator: (value) {
                  if(value!.isEmpty){
                         return 'enter text';
                  }
                },)
                
                ),
                SizedBox(
         height: 40,
      
                ),
                Roundbutton(
                  tap: () {
                    if(mykey.currentState!.validate())
                    {
                      setState(() {
                        iloading=true;
                      });
                      var id = DateTime.now().millisecondsSinceEpoch.toString();
                       firebase.child(
                        
                        id).set({
                        'id': id,
                        'post': postcontroller.text.toString()
                       }).then((value) {
                        setState(() {
                          iloading = false;
                        });
                         utils().toastMessage('sucessfully add post');
                       },);
                    }
                  },
                  title: 'Add' ,
                  isloading: iloading,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}