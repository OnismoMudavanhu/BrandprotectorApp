import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;


class Pharmacist extends StatefulWidget {
  final String pageText;
  Pharmacist(this.pageText);

  @override
  PharmacistState createState() {
    return new PharmacistState();
  }
}
//key
var _formKeyPhar = GlobalKey<FormState>();


class PharmacistState extends State<Pharmacist> {
  String result = "Press below button to Scan";
  String qrResult;
  String msgg="Response here";

  //dialog pop up for correct result
void _showDialogPhar(){
        showDialog(
          context: context,
          builder: (BuildContext context){
            //return object of type Dialog
            return AlertDialog(
              title: new Text("Verification details"),
              content: new Text(msgg),
              actions: <Widget>[
              //usually buttons at the bottom
              new FlatButton(
                child: new Text("Close"),
                onPressed:(){
                  Navigator.of(context).pop();
                }
              )
            ],);
          }
        );
        }
    //dialog for error
    _showErrorDialogPhar(){
          showDialog(
          context: context,
          builder: (BuildContext context){
            //return object of type Dialog
            return AlertDialog(
              title: new Text("Error Details"),
              content: new Text("Sorry,no connection check connection details", 
              style: TextStyle(
                color: Colors.redAccent,
              ),),
              actions: <Widget>[
              //usually buttons at the bottom
              new FlatButton(
                child: new Text("Close"),
                onPressed:(){
                  Navigator.of(context).pop();
                }
              )
            ],);
          }
        );
    }

    
  //end of dialogs

  String url = "http://192.168.1.4:5000/verify_package";//"http://10.0.2.2:5000/verify_package" & 192.168.137.1
  Future<List> _verifyPackage() async{
    try {
      final resp=
                  await http.post(Uri.encodeFull(url), body:{
                    "package_no":qrResult,
                    
                  });
                  print(qrResult);
            msgg = json.decode(resp.body);

            if(msgg.length==0){
              print("no data returned");
            }else{
              _showDialogPhar();
            }
      
    } catch (e) {
      print("could not get to db");
      _showErrorDialogPhar();
    }
  }
//end of verify package

  Future _scanQR() async{
    try{
      qrResult =await BarcodeScanner.scan();
      setState(() {
        result ="Thank you for verifying with us";

        
        //show dialogbox        
        void _showDialogConfirm(){
                showDialog(
                  context: context,
                  builder: (BuildContext context){
                    //return object of type Dialog
                    return AlertDialog(
                      title: new Text("Confirm details"),
                      content: Form(
                      key: _formKeyPhar,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                        /*  Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(initialValue: qrResult,),
                          ),
                          */
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              child: Text("Continue"),
                              onPressed: (){
                                if(_formKeyPhar.currentState.validate()){
                                  _verifyPackage();
                                }
                                //close after
                                Navigator.of(context).pop();
                              },
                            ),
                          )
                        ],
                      ),
                      ),
                      actions: <Widget>[
                      //usually buttons at the bottom
                      
                      new FlatButton(
                        child: new Text("Close"),
                        onPressed:(){
                          Navigator.of(context).pop();
                        }
                      )
                    ],);
                  }
                );
                }//end of show dialogbx
                //calling _showDialogConfirm
                _showDialogConfirm();

      });
      //_verifyPackage();

    }on PlatformException catch(e){
      if(e.code == BarcodeScanner.CameraAccessDenied){
        setState(() {
          result = "Camera permission was denied";
        });  
      }else{
        setState(() {
         result = "Unknown Error $e"; 
        });
      }
    }on FormatException{
      setState(() {
       result = "You pressed the back button before scanning"; 
      });
    }catch (e){
      setState(() {
         result = "Unknown Error $e"; 
        });
    }

    //inside scan method
    /*void_showDialogPhar(){
      showDialog(
        context: context,
        builder: (BuildContext context){

        });
    }
    */
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Pharmacist"),
        backgroundColor: Colors.deepPurple,),
      body: new Center(
        child: new Text(result, 
        style: TextStyle(
          
          fontSize: 20.0
        ) ,),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        backgroundColor: Colors.deepPurpleAccent,
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}