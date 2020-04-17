import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:readhub_notification/logic/auth.dart';
import 'package:readhub_notification/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notification Console',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
 // MyHomePage({Key key, this.title}) : super(key: key);

  

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DatabaseReference database = FirebaseDatabase.instance.reference();

  TextEditingController notificationTitle = TextEditingController();
  TextEditingController notificationDescription = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

   @override
  void initState() {
    getCurrentUser().then((user) {
      if (user == null) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
          (Route<dynamic> route) => false,
        );
      } else {
        
      }
    });
    // crudObj.getData().then((result) {
    //   note = result;
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Console'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _isLoading,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    // Text('ReadHub Notification Console',textAlign: TextAlign.center,),
                    Container(
                      color: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.all(3),
                          child: TextFormField(
                            controller: notificationTitle,
                            //style: textStyle,
                            validator: (String Value) {
                              if (Value.isEmpty) {
                                return 'Enter Notification Title';
                              }
                              return null;
                            },
                            
                            decoration: InputDecoration(
                                labelText: 'Title',
                                labelStyle: TextStyle(
                                    fontSize: 18.0, color: Colors.black),
                                errorStyle: TextStyle(
                                    color: Colors.redAccent, fontSize: 15.0),
                                hintText: 'Enter Notification Title',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          )),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextFormField(
                          controller: notificationDescription,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Enter Notification Description';
                            }
                            return null;
                          },
                          maxLines: 8,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(
                                  fontSize: 18.0, color: Colors.black),
                              alignLabelWithHint: true,
                              labelText: 'Description',
                              hintText: 'Enter Notification Description',
                              errorStyle: TextStyle(
                                  color: Colors.redAccent, fontSize: 15.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10, right: 10, top: 5),
                      width: double.infinity,
                      child: MaterialButton(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 8, bottom: 8, left: 10, right: 10),
                          child: Text(
                            'Send Notification',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                               savePost(context);
                          }
                        },
                        color: Colors.blue,
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Future<void> savePost( BuildContext context) async {
    // String key = database.child("Post").push().key;

    // String date = DateFormat.yMMMd().format(DateTime.now());
    print('done1');

    var post = <String, dynamic>{
      'title': notificationTitle.text,
      'description': notificationDescription.text
    };

    database.child('Posts').push().set(post).then((onValue) {
      print('done2');
      setState(() {
        _isLoading = false;
      });
      notificationTitle.clear();
      notificationDescription.clear();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            title: Text('ReadHub Notification Console'),
            subtitle: Text('Sent Your Notification Successfully'),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Done'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }).catchError((onError) {
      setState(() {
        _isLoading = false;
      });
      notificationTitle.clear();
      notificationDescription.clear();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: ListTile(
            title: Text('ReadHub Notification Console'),
            subtitle: Text('Some Error ocurred, Please Try Again $onError'),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Done'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    });
  }
}
