import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../models/subjects.dart';
import '../models/user.dart';

class subjectscreen extends StatefulWidget {
  final User user;
  const subjectscreen({Key? key, required this.user}) : super(key: key);

  @override
  State<subjectscreen> createState() => _subjectscreenState();
}

class _subjectscreenState extends State<subjectscreen> {
  List<Subject>? subList = <Subject>[];
  String titlecenter = "No subject available";

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Subject'),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                  accountName: Text(widget.user.name.toString()),
                  accountEmail: Text(widget.user.email.toString()),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://yt3.ggpht.com/a/AATXAJyAi_BhKSr-j8Od_1jghYmAERow_f3lBy-gMA=s900-c-k-c0xffffffff-no-rj-mo"),
                  )),
              _createDrawerItem(
                icon: Icons.book,
                text: 'My subjects',
                onTap: () {},
              ),
              _createDrawerItem(
                icon: Icons.schedule,
                text: 'Schedule',
                onTap: () {},
              ),
              _createDrawerItem(
                icon: Icons.settings,
                text: 'Settings',
                onTap: () {},
              ),
            ],
          ),
        ),
        body: subList!.isEmpty
            ? Center(
                child: Text(titlecenter,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)))
            : Column(children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text("Subject Available",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ]));
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  void _loadSubjects() {
    http.post(Uri.parse("http://10.143.164.161/mytutor2/php/loadsubject.php"),
        body: {}).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {}
      var extractdata = jsondata['data'];
      subList = <Subject>[];
      extractdata['subject'].forEach((v) {
        subList!.add(Subject.fromJson(v));
      });
    });
  }
}
