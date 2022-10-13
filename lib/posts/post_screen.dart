import 'package:app_1/Utils/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import'package:flutter/material.dart';

import '../ui/auth/login_screen.dart';
import 'add_post.dart';
class postscreen extends StatefulWidget {
   postscreen({Key? key}) : super(key: key);

  @override
  State<postscreen> createState() => _postscreenState();
}

class _postscreenState extends State<postscreen> {
   FirebaseAuth _auth = FirebaseAuth.instance;

   final searchfilter = TextEditingController();

   final dref = FirebaseDatabase.instance.ref('Post');
  final updatecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton:FloatingActionButton(onPressed: () {
         Navigator.push(context,
                         MaterialPageRoute(builder: (context) =>
                         addpost()
                         
                         ));
      },
      child: Icon(Icons.add),),
      
      appBar: AppBar(
        actions: [
         IconButton(onPressed: () {
          _auth.signOut();
           Navigator.push(context,
                         MaterialPageRoute(builder: (context) =>
                          LoginScreen()
                         
                         ));
           
         }, icon: Icon(Icons.logout_outlined),
          ),
          SizedBox(width: 20,)
          
        ],
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text('Posts'),
      ),
body: Container(
  child: Column(
    
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 20,left: 30,right: 30),
        child: TextFormField(
          controller: searchfilter,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        
        hintText: 'search here...'
      ),onChanged: (String value) {
       setState(() {
         
       });
      },
     
        ),
      ),
      /**show data from firebase database in the form of listview by stream method */
      // Expanded(
      
      //   child:StreamBuilder(
      //     stream: dref.onValue,
      //     builder: (context,AsyncSnapshot<DatabaseEvent> snapshot) {

      //       if(!snapshot.hasData){
      //         return  Text('Loading...');
      //       }
      //    else{
      //     Map<dynamic,dynamic> map = snapshot.data!.snapshot.value as dynamic;
      //     List<dynamic> list = map.values.toList();
      //     return ListView.builder(
      //     itemCount: list.length,
          
      //     itemBuilder: (context, index) {
           
      //      return Card(
      //        child: ListTile(
      //         title: Text(list[index]['post'].toString()),
      //        ),
      //      );
      //    },);
      //    }

      // },), 
      
      
      
      
      
      // )
      Expanded(
        child: FirebaseAnimatedList(query: dref, 
        itemBuilder: (context, snapshot, animation, index) {
          
          final title = snapshot.child('post').value.toString();
           final id = snapshot.child('id').value.toString();
          if(searchfilter.text.isEmpty){
            return Card(
                  child: ListTile(
                    
                    title: 
                  Text(snapshot.child('post').value.toString()),
                  subtitle: Text(snapshot.child('id').value.toString()),
                  trailing: PopupMenuButton(itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child:ListTile(
                        onTap: () {
                          Navigator.pop(context);
                      showmydialog(id);
                      updatecontroller.text=title;
                    },
                        title: Text('Edit'),
                        leading: Icon(Icons.edit)), ),
                         PopupMenuItem(
                      value: 2,
                      child:ListTile(
                        onTap: () {
                          dref.child(id).remove().then((value) {
                            utils().toastMessage('Successfuly Deleted');
                            Navigator.pop(context);
                          });
                        },
                        title: Text('Delete'),
                        leading: Icon(Icons.delete)), )
                  ],
                    icon: Icon(Icons.more_vert)),),
                );
          }
          else if(title.toLowerCase().contains(searchfilter.text.toLowerCase().toString())){
                    return Card(
                  child: ListTile(title: 
                  Text(snapshot.child('post').value.toString()),
                  subtitle: Text(snapshot.child('id').value.toString()),
                  ),
                );
          }
          else{
            return Container();
          }
                
      
        } ,),
      )
    ],
  ),
),

    );
  }
Future<void> showmydialog(var id)async{
  return showDialog(
    context: context,
     builder: (context) {
      return AlertDialog(
        title: Text('Update'),
        content: Container(
          child: TextFormField(
            controller: updatecontroller,
            decoration: InputDecoration(
              
            ),
          ),
        ),
        actions: [
          
           TextButton(onPressed: () {
             Navigator.pop(context);
            
          }, child: Text('Cancel')),
          TextButton(onPressed: () {
           dref.child(id).update({
                'post':updatecontroller.text.toString()
           }).then((value) => utils().toastMessage('Successfuly Updated'));
           Navigator.pop(context);
            
          }, child: Text('Update')),
        ],
      );
       
     },);
}

}