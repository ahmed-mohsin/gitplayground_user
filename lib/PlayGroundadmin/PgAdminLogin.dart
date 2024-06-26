import 'package:flutter/material.dart';
import 'authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

class PgLogin extends StatefulWidget {
  PgLogin({this.auth, this.onSignedIn,this.emailHint,this.passwordHint});
final String emailHint, passwordHint ;
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  State<StatefulWidget> createState() => new PgLoginState();
}

enum FormMode { LOGIN, SIGNUP }

class PgLoginState extends State<PgLogin> {
  final _formKey = new GlobalKey<FormState>();
  bool val = true;
  String _email ;
  String _password;
  String _errorMessage;

  FormMode _formMode = FormMode.LOGIN;
  bool _isIos;
  bool _isLoading;

  @override
  void initState() {

    _errorMessage = "";
    _isLoading = false;

    super.initState();
  }

  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  _validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_validateAndSave()) {
      String userId = "";
      try {
        if (_formMode == FormMode.LOGIN) {
          userId = await widget.auth.signIn(_email, _password);
          final prefs = await SharedPreferences.getInstance();
          if(val==true){
          prefs.setString('email', _email).whenComplete(() {
            print("data saved");
          });
          prefs.setString('password', _password).whenComplete(() {
            print("data saved");
          });}
          else if (val==false){
          prefs.remove('email');
          prefs.remove('password');
          }



          print('Signed in: $userId');
        } else {
          /*
          userId = await widget.auth.signUp(_email, _password);
          widget.auth.sendEmailVerification();
          _showVerifyEmailSentDialog();
*/
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId != null &&
            userId.length > 0 &&
            _formMode == FormMode.LOGIN) {
          widget.onSignedIn();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          if (_isIos) {
            _errorMessage = e.details;
          } else
            _errorMessage = e.message;
        });
      }
    }
  }

  Future<bool> saveData(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(key, value);
  }

  Future<String> loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

     String key = prefs.getString('email') ?? "email";
    return key ;

  }

  Future<String> loadmailfromShared() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String mail = prefs.get("email");
    return mail;
  }

  void _changeFormToSignUp() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.SIGNUP;
    });
  }

  void _changeFormToLogin() {
    _formKey.currentState.reset();
    _errorMessage = "";
    setState(() {
      _formMode = FormMode.LOGIN;
    });
  }

  @override
  Widget build(BuildContext context) {

    _isIos = Theme.of(context).platform == TargetPlatform.iOS;
    String mh ;



    // _loademailHint();
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: new Text('El3bkora admin'),
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.all(16.0),
                  child: new Form(
                    key: _formKey,
                    child: new ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        _showLogo(),

                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                          child: new TextFormField(
                            initialValue: widget.emailHint,
                            style: TextStyle(fontSize: 18, color: Colors.teal),
                            // controller: controller,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: true,
                            decoration: new InputDecoration(
                                icon: new Icon(
                              Icons.mail,
                              color: Colors.grey,
                            )),
                            validator: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  _isLoading = false;
                                });
                                return 'Email can\'t be empty';
                              }
                            },
                            onSaved: (value) => _email = value,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                          child: new TextFormField(
                            initialValue: widget.passwordHint,
                            style: TextStyle(fontSize: 20,color: Colors.teal),
                            // controller: controller,
                            maxLines: 1,
                            obscureText: true,
                            autofocus: false,
                            decoration: new InputDecoration(
                                icon: new Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                )),
                            validator: (value) {
                              if (value.isEmpty) {
                                setState(() {
                                  _isLoading = false;
                                });
                                return 'Email can\'t be empty';
                              }
                            },
                            onSaved: (value) => _password = value,
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                                activeColor: Colors.teal,
                                value: val,
                                onChanged: (bool value) {
                                  setState(() {
                                    val = value;
                                  });
                                }),
                            Text("Remember login data")
                          ],
                        ),
                        _showPrimaryButton(),
                        //_showSecondaryButton(),
                        _showErrorMessage(),
                      ],
                    ),
                  )),
              _showCircularProgress(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  /*void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Verify your account"),
          content: new Text("Link to verify account has been sent to your email"),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                _changeFormToLogin();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }*/

  Widget _showErrorMessage() {
    if (_errorMessage != null && _errorMessage.length > 0) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.green,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.only(top: 10),
        child: Image.asset(
          "assets/admin.png",
          height: 140,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _showSecondaryButton() {
    return new FlatButton(
      child: _formMode == FormMode.LOGIN
          ? new Text('Create an account',
              style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300))
          : new Text('Have an account? Sign in',
              style:
                  new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
      onPressed: _formMode == FormMode.LOGIN
          ? _changeFormToSignUp
          : _changeFormToLogin,
    );
  }

  Widget _showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.teal,
            child: _formMode == FormMode.LOGIN
                ? new Text('Login',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white))
                : new Text('Create account',
                    style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed: _validateAndSubmit,
          ),
        ));
  }
}

/*import 'package:flutter/material.dart';

import 'AdminCpanal.dart';

class PgLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          children: <Widget>[
            Spacer(),
            Container(
              height: 200,
              color: Colors.white10,
              width: 200,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(),
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    pgAdminCpanal() /*AdmiinManualReservation(
                      pgname: "ahly",
                    )*/
                                ));
                      },
                      child: Text(
                        "login",
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "contact with el3bkora.com",
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}*/
