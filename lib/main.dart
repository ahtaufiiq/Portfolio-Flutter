import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase/supabase.dart';
import 'package:uuid/uuid.dart';

const SUPABASE_URL = '';
const SUPABASE_KEY = '';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: UploadImage());
  }
}

class UploadImage extends StatefulWidget {
  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? _image;
  final picker = ImagePicker();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future _imgFromCamera() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future _imgFromGallery() async {
    final pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        print("Masuk");
        _image = File(pickedFile.path);
        print(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  void uploadPhoto() async {
    if (_image != null) {
      setState(() {
        isLoading = true;
      });
      final client = SupabaseClient(SUPABASE_URL, SUPABASE_KEY);

      final imgName = "public/${Uuid().v4()}" + ".jpg";
      final storageResponse =
          await client.storage.from('post').upload(imgName, _image!);
      if (storageResponse.data != null) {
        final urlResponse =
            await client.storage.from('post').createSignedUrl(imgName, 60);
        print('download url : ${urlResponse.data}');
      } else {
        print(storageResponse.error);
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 24, right: 24),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () => _showPicker(context),
                        child: _image != null
                            ? Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(_image!),
                                        fit: BoxFit.cover),
                                    color: Color(0xFFC4C4C4),
                                    border: Border.all(
                                        color: Color(0xFFEFEFEF), width: 5),
                                    borderRadius: BorderRadius.circular(21)),
                              )
                            : Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: Color(0xFFC4C4C4),
                                    border: Border.all(
                                        color: Color(0xFFEFEFEF), width: 5),
                                    borderRadius: BorderRadius.circular(21)),
                                child: Text("blm ada photo"),
                              )),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("PROFILE PICTURE"),
                        SizedBox(
                          height: 12,
                        ),
                        GestureDetector(
                          onTap: () => uploadPhoto(),
                          child: isLoading
                              ? Container(
                                  child: CircularProgressIndicator(),
                                  width: 16,
                                  height: 16,
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xFF888888),
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 8, bottom: 8),
                                  child: Text("Upload")),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 29,
              ),
              Divider(
                thickness: 1,
                color: Color(0xFFE5E5E5),
              )
            ],
          ),
        ),
      ),
    );
  }
}
