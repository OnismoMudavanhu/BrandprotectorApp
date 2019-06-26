import 'package:flutter/material.dart';
import './pages/Pharmacist.dart';
import './pages/Customer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      
      

     /* appBar: new AppBar(
        title: new Text("Brand Protector"),
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            onPressed: ()=>debugPrint("Yeah its working"),
          ),
        ],
      ),
*/
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[

            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  Colors.deepPurple,
                  Colors.purpleAccent
                ])
              ),
              child: new Container(
                child: Column(
                  children: <Widget>[
                    Material(

                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      elevation: 10,
                      child: Padding(padding: EdgeInsets.all(8.0),
                      child: new Image.asset('assets/logoo.png', width: 80, height: 80,),) ,
                    ),
                    Padding(padding: EdgeInsets.all(8.0),
                    child: Text('Brand Protector', style:TextStyle(color: Colors.white, fontSize:20.0),),)
                  ],
                ),
              )),
           
            new ListTile(
              title: new Text("Customer"),
            leading: new Icon(Icons.business_center,color: Colors.black,),
            
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(builder:(BuildContext context)=> new Customer("Product Verification")));
            },

            ),

            new Divider(
              height: 2.0,
              color: Colors.grey,
            ),

            new ListTile(
              title: new Text("Pharmacist"),
              leading:new Icon(Icons.local_pharmacy,color: Colors.black,),
            
            onTap: (){
              Navigator.of(context).pop();
              Navigator.of(context).push(new MaterialPageRoute(builder:(BuildContext context)=> new Pharmacist("My QR Scanner")));
            },

            ),
            new Divider(
              height: 10.0,
              color: Colors.purple,
            ),
            new ListTile(
              title: new Text("close"),
              trailing: new Icon(Icons.close,color:Colors.red),
            
            onTap: (){
              Navigator.of(context).pop();
            },

            )
          ],
        ),
      ),

body: new Container(
  
  child: Column(
    
    children: <Widget>[
      // start container of logo
      Container(
              
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/3.0,
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
      
//end container of logo
      Container(
        //width: MediaQuery.of(context).size.width,
       // padding: EdgeInsets.all(30.0),
        padding: EdgeInsets.only(
                      top: 4, left: 16, right: 16, bottom: 4
                    ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Image.asset('assets/drug.png', width:70, height:150,),
            ),
            Container(
              child: new Text("Important Tips", style:TextStyle(
                fontSize: 25.0,
                color: Colors.black,
               
              ),),
            ),
            Align(
              alignment: Alignment.center,
              child: new Text("Swipe from the left to choose if you are a customer or a pharmacist.", 
              style: TextStyle(
                color: Colors.red,
                fontSize: 18.0,
                fontStyle: FontStyle.italic
              ),),
            ),
            Align(
              alignment: Alignment.center,
              child: new Text("Select correct category, give correct information for your purchase to be recognized and enter the promotion.", 
              style: TextStyle(
                color: Colors.red,
                fontSize: 18.0,
                fontStyle: FontStyle.italic
              ),),
            )
           
          ],
        ),
      )

    ],
  )
),

    );
  }
}