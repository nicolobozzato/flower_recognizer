import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  File _image;
  List _output;
  final picker = ImagePicker();
  Color mainColor = Colors.orangeAccent;
  Color backgroundColor = Colors.green;
  Color textColor = Colors.white;

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 5,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model.tflite', labels: 'assets/labels.txt');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Tflite.close();
  }

  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.004, 1],
            colors: [Color(0xFFa8e063), Color(0xFF56ab2f)],
          ),
        ),
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 50),
                Text(
                  'Detect Flowers',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 28),
                ),
                Text(
                  'Custom Tensorflow CNN',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 28),
                ),
                SizedBox(height: 40),
                Container(
                    padding: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7)
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: _loading
                                ? Container(
                                    width: 300,
                                    child: Column(children: <Widget>[
                                      Image.asset('assets/flower.png'),
                                      SizedBox(height: 30),
                                    ]),
                                  )
                                : Container(
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 300,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(_image),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        _output != null
                                            ? Text(
                                                'Prediction is: ${_output[0]['label']}',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20))
                                            : Container(),
                                        SizedBox(height: 30),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: pickImage,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 180,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 17),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF56ab2f),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Text(
                                    'Take a photo',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              GestureDetector(
                                onTap: pickGalleryImage,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width - 180,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 17),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF56ab2f),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Text(
                                    'Pick from Gallery',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            )),
      ),
    );
  }
}
