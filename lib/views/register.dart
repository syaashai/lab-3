import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:http/http.dart' as http;
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'loginscreen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late double screenHeight, screenWidth, ctrwidth;
  String pathAsset = 'assets/camera.png';
  var _image;
  final TextEditingController _premailController = TextEditingController();
  final TextEditingController _prnameController = TextEditingController();
  final TextEditingController _prphonenoController = TextEditingController();
  final TextEditingController _prpasswordController = TextEditingController();
  final TextEditingController _prpasswordController2 = TextEditingController();
  final TextEditingController _prhomeaddressController =
      TextEditingController();
  bool _agree = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth >= 800) {
      ctrwidth = screenWidth / 1.5;
    }
    if (screenWidth < 800) {
      ctrwidth = screenWidth / 1.1;
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('New User'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: ctrwidth,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(32, 32, 32, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Registration Form",
                            style: TextStyle(fontSize: 24),
                          ),
                          const SizedBox(height: 2),
                          TextFormField(
                            controller: _prnameController,
                            decoration: InputDecoration(
                                labelText: 'Name',
                                prefixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _premailController,
                            decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: const Icon(Icons.email),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _prphonenoController,
                            decoration: InputDecoration(
                                labelText: 'Phone number',
                                prefixIcon: const Icon(Icons.phone),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid phone number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            controller: _prhomeaddressController,
                            decoration: InputDecoration(
                                labelText: 'Home address',
                                prefixIcon: const Icon(Icons.home),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter valid home address';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 5),
                          Row(children: [
                            Flexible(
                              child: TextFormField(
                                controller: _prpasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (_prpasswordController.text !=
                                      _prpasswordController2.text) {
                                    return "Your password does not match";
                                  }
                                  if (value.length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                              ),
                              flex: 1,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: TextFormField(
                                controller: _prpasswordController2,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: 'Re-enter Password',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  if (_prpasswordController.text !=
                                      _prpasswordController2.text) {
                                    return "Your password does not match";
                                  }
                                  if (value.length < 6) {
                                    return "Password must be at least 6 characters";
                                  }
                                  return null;
                                },
                              ),
                              flex: 1,
                            ),
                          ]),
                          const SizedBox(height: 4),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(children: []),
                                SizedBox(
                                    width: screenWidth,
                                    height: 50,
                                    child: ElevatedButton(
                                      child: const Text("Register"),
                                      onPressed: () {
                                        _insertDialog();
                                      },
                                    ))
                              ])
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void _insertDialog() {
    if (_formKey.currentState!.validate() && _agree != null) {
      _formKey.currentState!.save();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text(
              "Add this detail",
              style: TextStyle(),
            ),
            content: const Text("Are you sure?", style: TextStyle()),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                  _insertProduct();
                },
              ),
              TextButton(
                child: const Text(
                  "No",
                  style: TextStyle(),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  void onChanged(bool? value) {
    setState(() {
      _agree = value!;
    });
  }

  void _insertProduct() {
    ProgressDialog pd = ProgressDialog(context: context);
    pd.show(msg: 'Registration in progress..', max: 100);
    String _prname = _prnameController.text;
    String _premail = _premailController.text;
    String _prphoneno = _prphonenoController.text;
    String _prpassword = _prpasswordController.text;
    String _prhomeaddress = _prhomeaddressController.text;
    http.post(Uri.parse("http://10.143.164.161/mytutor/php/register_user.php"),
        body: {
          "name": _prname,
          "email": _premail,
          "phoneno": _prphoneno,
          "password": _prpassword,
          "homeaddress": _prhomeaddress,
        }).then((response) {
      print(response.body);
      var data = jsonDecode(response.body);
      if (response.statusCode == 200 && data['status'] == 'success') {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        Navigator.push(context,
            MaterialPageRoute(builder: (content) => const LoginScreen()));
      } else {
        Fluttertoast.showToast(
            msg: data['status'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        pd.update(value: 0, msg: "Failed");
        pd.close();
      }
    });
  }
}
