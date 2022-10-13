import 'dart:io';
import 'package:app_1/Utils/Utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_1/ui/widget/Button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
class uploadimage extends StatefulWidget {
  const uploadimage({Key? key}) : super(key: key);

  @override
  State<uploadimage> createState() => _uploadimageState();
}

class _uploadimageState extends State<uploadimage> {
  File? image;
  bool loading = false;
  final storage = FirebaseStorage.instance;
  UploadTask? uploadTask;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Upload Image'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: InkWell(
                  onTap: () {
                    uploadgalleryimage();
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black,
                      width: 2)
                    ),
                    child: image !=null?Image.file(image!,fit: BoxFit.cover,)  :  Center(
                      child: Icon(
                        Icons.image
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 80,),
              Roundbutton(
                isloading: loading,
                title: 'Upload', tap:() async {
                  setState(() {
                    loading= true;
                  });
                 String id = DateTime.now().millisecond.toString();
                 Reference mref = FirebaseStorage.instance
        .ref('/zeeshan/'+id.toString());
       
         uploadTask = mref.putFile(image!);
         
         var database = FirebaseDatabase.instance.ref('Image');
         await Future.value(uploadTask).then((value) async {
          setState(() {
            loading=false;
          });
          var newUrl = await mref.getDownloadURL();
           database.child(id).set({
          'id': id,
          'image': newUrl.toString()

         }).then((value) => utils().toastMessage('successfully uploaded')).onError((error, e) {
           utils().toastMessage(e.toString());
           debugPrint(e.toString());
         },);
   
         });
        
         
                
              },)
            ],
          ),
        ),
      ),
    );
  }

Future uploadgalleryimage()async{
   
  final pickimage = ImagePicker();
  final  pimage= await pickimage.pickImage(source: ImageSource.gallery,imageQuality: 80);
  if(pimage!=null){

  setState(() {
     image = File(pimage.path);
  });

  }
 
 


}


}