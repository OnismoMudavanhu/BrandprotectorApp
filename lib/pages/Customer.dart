import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

class Customer extends StatefulWidget {
  final String pageText;
  
  Customer(this.pageText);

  @override
  CustomerState createState() {
    return new CustomerState();
  }
}
var _formKey = GlobalKey<FormState>();

class CustomerState extends State<Customer> {
DateTime _dataInfo;

 TextEditingController username = new TextEditingController();
 TextEditingController email = new TextEditingController();
 TextEditingController phone = new TextEditingController();
 TextEditingController location = new TextEditingController();
 TextEditingController prod = new TextEditingController(); 
 String msg="result here";

//dialog pop up for correct result
void _showDialog(){
        showDialog(
          context: context,
          builder: (BuildContext context){
            //return object of type Dialog
            return AlertDialog(
              title: new Text("Verification details"),
              content: new Text(msg),
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
    _showErrorDialog(){
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

    //

String url = "http://192.168.1.4:5000/add_customer";//http://10.0.2.2:5000/add_customer&192.168.137.1  
 Future<List> _verify() async {
   String data = _dataInfo.toString();
   try {

     final response =
        await http.post(Uri.encodeFull(url), body: {
          "name":username.text,
          "email":email.text,
          "phone_no":phone.text,
          "dob":data,
          "location":location.text,
          "prod_id":prod.text,
          });

        msg =json.decode(response.body);

        if(msg.length == 0){
          print("no data returned");
        }
        else{
          //dialog box func
        _showDialog();
        }
     
   } catch (e) {
     print(e);
     _showErrorDialog();
   }
   
        
        
   
 }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      
      appBar: AppBar(
        title: new Text(widget.pageText),
        backgroundColor: Colors.deepPurple,),
      
      
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
           /* //styled header
            Container(
              
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/4.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end:Alignment.bottomCenter,
                  colors: [
                    Colors.deepPurple,Colors.purpleAccent
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90)
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: new Image.asset('assets/bp.png', width: 120, height: 120,),
                  ),

                  Align(
                    alignment: Alignment.center,
                    child: Text('Brand Protector', style: TextStyle(
                      fontSize: 25.0, 
                      color: Colors.white),),
                  )

                ],
              ),
            ), 
              */

            //container start for all form items
            Container(
              height: MediaQuery.of(context).size.height/1,//form container
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 30),
            //column for form items  
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[

                    //1st text field
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 45,
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.only(
                        top: 4, left: 16, right: 16, bottom: 4
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5
                          )
                        ]
                      ),
                      child: TextFormField(
                      controller: username,  
                      decoration: InputDecoration(
                        icon: Icon(Icons.person,
                        color: Colors.grey,
                        ),
                      hintText: 'name and surname',
                  ),
                  validator: (val) => val.length < 6 
                  ? 'Not valid name or surname' : null,
                ),
            ),
            //end of 1st txtfld

                    //2nd textfield container start
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 45,
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.only(
                        top: 4, left: 16, right: 16, bottom: 4
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5
                          )
                        ]
                      ),
                      child: TextFormField(
                      controller: email,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email,
                        color: Colors.grey,
                        ),
                      hintText: 'enter your email',                 
                  ),
                  validator: (val) => !EmailValidator.Validate(val, true)
                  ?'Please provide a valid email.'
                  :null,
                  keyboardType: TextInputType.emailAddress,

                ),
            ),
            //end 2nd textfield container start
            
            //start 3rd txtfld
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 45,
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.only(
                        top: 4, left: 16, right: 16, bottom: 4
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5
                          )
                        ]
                      ),
                      child: TextFormField(
                      controller: phone,
                      decoration: InputDecoration(
                        icon: Icon(Icons.phone,
                        color: Colors.grey,
                        ),
                      hintText: 'eg 775959352',                  
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (val) => val.length < 9 
                  ? 'Not valid phone number' : null,

                ),
            ),
            //end 3rd txtfld

//start 4th fld
/*
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 45,
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.only(
                        top: 4, left: 16, right: 16, bottom: 4
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5
                          )
                        ]
                      ),
                      child: TextFormField(
                      controller: dob,
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today,
                        color: Colors.grey,
                        ),
                      hintText: 'DoB',
                  ),
                    keyboardType: TextInputType.datetime,
                    validator: (String value){
                    if(value.isEmpty){
                      return 'Please enter your DoB';
                    }
                  },

                ),
            ),
            //end 4th
*/

              
              Container(
                width: MediaQuery.of(context).size.width/1.2,
                      height: 45,
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.only(
                        top: 4, left: 16, right: 16, bottom: 4
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5
                          )
                        ]
                      ),
                      child: 
                      //start datetime picker
            new FlatButton(
              child: new Row(
                children: <Widget>[
                  new Text('DoB: '+'${_dataInfo}', style: TextStyle(color: Colors.grey),),
                  new Icon(Icons.calendar_today, color: Colors.grey,),
                ],
                
              ),
              onPressed: () async{
                final dtpik = await showDatePicker(
                  context: context,
                  initialDate: new DateTime(2010),
                  firstDate: new DateTime(1950),
                  lastDate: new DateTime(2010));

                if (dtpik != null && dtpik != _dataInfo){
                  setState(() {
                   _dataInfo = dtpik; 
                  });
                }
              },
            ),
            //end datetimepicker,

              ),

             /*start datetime picker
            new FlatButton(
              child: new Row(
                children: <Widget>[
                  new Text('DOB: '+'${_dataInfo}'),
                  new Icon(Icons.calendar_today),
                ],
                
              ),
              onPressed: () async{
                final dtpik = await showDatePicker(
                  context: context,
                  initialDate: new DateTime(2010),
                  firstDate: new DateTime(1950),
                  lastDate: new DateTime(2010));

                if (dtpik != null && dtpik != _dataInfo){
                  setState(() {
                   _dataInfo = dtpik; 
                  });
                }
              },
            ),
            /end datetimepicker*/


//Location text field
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 45,
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.only(
                        top: 4, left: 16, right: 16, bottom: 4
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5
                          )
                        ]
                      ),
                      child: TextFormField(
                      controller: location,  
                      decoration: InputDecoration(
                        icon: Icon(Icons.location_city,
                        color: Colors.grey,
                        ),
                      hintText: 'eg belvedere, harare',
                  ),
                  validator: (val) => val.length < 6 
                  ? 'Please enter correct location' : null,
                ),
            ),
            //end of Location txtfld

            //start 5th fld
                    Container(
                      width: MediaQuery.of(context).size.width/1.2,
                      height: 45,
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.only(
                        top: 4, left: 16, right: 16, bottom: 4
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5
                          )
                        ]
                      ),
                      child: TextFormField(
                      controller: prod,
                      decoration: InputDecoration(
                        icon: Icon(Icons.vpn_key,
                        color: Colors.grey,
                        ),
                      hintText: 'enter product code',

                  ),
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Please enter your product no';
                    }
                  },
                ),
            ),
            //end 5th
          
                   // Spacer(),
            //start button container
            
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0)
                        ),
                        
                        /*
                        height: 45,
                        width: MediaQuery.of(context).size.width/1.2,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepPurple,Colors.purpleAccent
                            ]
                          ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50)
                        )
                        ),
                        */
                        color: Colors.deepPurple,
                        
                        child: Center(
                          
                          child: Text('Verify'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                        
                        ),
                        onPressed: (){
                          if(_formKey.currentState.validate()){
                              
                              _verify();
                          }
                          
                        },
                      ),
                    ),//end of button container
                  ],
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}