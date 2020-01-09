import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

class CameraWidget extends StatefulWidget {
  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<CameraWidget> {
  List<CameraDescription> cameras;
  CameraController controller;
  bool isReady = false;

  @override
  void initState() {
    super.initState();
    setupCameras();
  }

  Future<void> setupCameras() async {
    try {
      cameras = await availableCameras();
      controller = cameras.length < 1 ? new CameraController(cameras[0], ResolutionPreset.medium) : '';
      await controller.initialize();
    } on CameraException catch (_) {
      setState(() {
        isReady = false;
      });
    }
    setState(() {
      isReady = true;
    });
  }

  Widget build(BuildContext context) {
    if (!isReady) {
      return Container(
        child: Center(
          child: new Text("Please Allow Camera"),
        ),
      );
    }
    return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: Stack(
          children: <Widget>[
            CameraPreview(controller),
            Positioned(00797318
              top: 20,
              child: FlatButton(
                onPressed: () {
                  print('exit');
                  Navigator.pop(context);
                },
                child: Container(
                  child: new Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Positioned(
            //   top: 100,
            //   child: Center(
            //       child: Container(
            //         width: MediaQuery.of(context).size.width,
            //     padding: EdgeInsets.all(5),
            //     decoration: BoxDecoration(
            //       color: Colors.white70,
            //       borderRadius: new BorderRadius.all(Radius.circular(30.0)),
            //     ),
            //     child: new Text(
            //         'Cature Vehicle',
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //             fontSize: 25.0,
            //             color: Colors.black,
            //             fontWeight: FontWeight.bold,
            //             decoration: TextDecoration.none
            //             ),
            //       ),
            //     ),
            //   ),
            // ),
           
            Positioned(
              bottom: 50,
              child: new Container(
                width: MediaQuery.of(context).size.width - 40,
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: new BorderRadius.all(Radius.circular(30.0)),
                ),
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Colors.white,
                      onPressed: () {
                        print('clicked');
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 20.0),
                        child: new Text(
                          'Capture!',
                          style: TextStyle(fontSize: 15.0, color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 20.0),
                      child: new Text(
                        'Scan QR Code',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
