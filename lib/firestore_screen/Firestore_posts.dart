import 'package:app_1/Utils/Utils.dart';
import 'package:app_1/firestore_screen/firestore_addpost.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import'package:flutter/material.dart';

import '../ui/auth/login_screen.dart';

class firestorepost extends StatefulWidget {
   firestorepost({Key? key}) : super(key: key);

  @override
  State<firestorepost> createState() => _firestorepostState();
}

class _firestorepostState extends State<firestorepost> {
   FirebaseAuth _auth = FirebaseAuth.instance;

   final searchfilter = TextEditingController();
   //List<dynamic> list = [];

   final dref = FirebaseFirestore.instance.collection('Post').snapshots();
  final updatecontroller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    searchfilter.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      floatingActionButton:FloatingActionButton(onPressed: () {
         Navigator.push(context,
                         MaterialPageRoute(builder: (context) =>
                         firestoreaddpost()
                         
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
        title: Text('Firestore Posts'),
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
      StreamBuilder<QuerySnapshot>(
        stream: dref,
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {

          if(snapshot.connectionState==ConnectionState.waiting)
            return  Center(
              child: CircularProgressIndicator(),
            );
          
         if(snapshot.hasError)
      return Text('snapshot has error');
        
         List<dynamic>  list = snapshot.data!.docs.toList();
        // Map<dynamic,dynamic> map = snapshot.data!.snapshot.value as dynamic;
        // List<dynamic> list = map.values.toList();
return  Expanded(
        
  child:   ListView.builder(
  
            itemCount: list.length,
  
            itemBuilder: (context, index) {
             
            final mpost = list[index]['post'].toString();
             final mid = list[index]['id'].toString();
            if(searchfilter.text.isEmpty){
             
               return Card(
  
               child: ListTile(
  
                title: Text(list[index]['post'].toString()),
                     subtitle: Text(list[index]['id'].toString()),
               ),
  
             );
             
            }
            else if (mpost.toLowerCase().contains(searchfilter.text.toLowerCase().toString())){
              return Card(
  
               child: ListTile(
  
                title: Text(list[index]['post'].toString()),
                     subtitle: Text(list[index]['id'].toString()),
               ),
  
             );
            }
            else{
             
              return Container();
            }
             
             
  
            
  
           },),
);
      
      
       }

      ,),
      

     
      
      // )
      // Expanded(
      //   child: FirebaseAnimatedList(query: dref, 
      //   itemBuilder: (context, snapshot, animation, index) {
          
      //     final title = snapshot.child('post').value.toString();
      //      final id = snapshot.child('id').value.toString();
      //     if(searchfilter.text.isEmpty){
      //       return Card(
      //             child: ListTile(
                    
      //               title: 
      //             Text(snapshot.child('post').value.toString()),
      //             subtitle: Text(snapshot.child('id').value.toString()),
      //             trailing: PopupMenuButton(itemBuilder: (context) => [
      //               PopupMenuItem(
      //                 value: 1,
      //                 child:ListTile(
      //                   onTap: () {
      //                     Navigator.pop(context);
      //                 showmydialog(id);
      //                 updatecontroller.text=title;
      //               },
      //                   title: Text('Edit'),
      //                   leading: Icon(Icons.edit)), ),
      //                    PopupMenuItem(
      //                 value: 2,
      //                 child:ListTile(
      //                   onTap: () {
      //                     dref.child(id).remove().then((value) {
      //                       utils().toastMessage('Successfuly Deleted');
      //                       Navigator.pop(context);
      //                     });
      //                   },
      //                   title: Text('Delete'),
      //                   leading: Icon(Icons.delete)), )
      //             ],
      //               icon: Icon(Icons.more_vert)),),
      //           );
      //     }
      //     else if(title.toLowerCase().contains(searchfilter.text.toLowerCase().toString())){
      //               return Card(
      //             child: ListTile(title: 
      //             Text(snapshot.child('post').value.toString()),
      //             subtitle: Text(snapshot.child('id').value.toString()),
      //             ),
      //           );
      //     }
      //     else{
      //       return Container();
      //     }
                
      
      //   } ,),
      // )
    



    ],
  ),
),

    );
  }
// Future<void> showmydialog(var id)async{
//   return showDialog(
//     context: context,
//      builder: (context) {
//       return AlertDialog(
//         title: Text('Update'),
//         content: Container(
//           child: TextFormField(
//             controller: updatecontroller,
//             decoration: InputDecoration(
              
//             ),
//           ),
//         ),
//         actions: [
          
//            TextButton(onPressed: () {
//              Navigator.pop(context);
            
//           }, child: Text('Cancel')),
//           TextButton(onPressed: () {
//            dref.child(id).update({
//                 'post':updatecontroller.text.toString()
//            }).then((value) => utils().toastMessage('Successfuly Updated'));
//            Navigator.pop(context);
            
//           }, child: Text('Update')),
//         ],
//       );
       
//      },);
// }

}