import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../models/tutors.dart';
import '../models/user.dart';

class tutorscreen extends StatefulWidget {
  final User user;
  const tutorscreen({Key? key, required this.user}) : super(key: key);

  @override
  State<tutorscreen> createState() => _tutorscreenState();
}

class _tutorscreenState extends State<tutorscreen> {
  List<tutor>? subList = <tutor>[];
  String titlecenter = "loading...";
  late double screenHeight, screenWidth, resWidth;

  TextEditingController searchController = TextEditingController();
  String search = "";
  String dropdownvalue = 'Prashanthini a/l Manjit Ramasamy';
  var types = [
    'All',
    'Prashanthini a/l Manjit Ramasamy',
    'Chai Tan Hiu',
    'Nur Maya binti Aidil Hafizee ',
    'Ling Liang Thok',
    'Teoh Chum Liek',
    'Muhammet Firdaus Miskoulan bin Jamal',
    'P. Veetil a/l Ramadas',
  ];

  @override
  void initState() {
    super.initState();
    _loadtutors();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.height;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
      //rowcount =2;
    } else {
      resWidth = screenWidth * 0.75;
      //rowcount =2;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('tutor'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              _loadSearchDialog();
            },
          )
        ],
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
              text: 'My tutors',
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
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text("tutor Available",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                    child: GridView.count(
                        crossAxisCount: 2,
                        children: List.generate(subList!.length, (index) {
                          return Card(
                              child: Column(
                            children: [
                              Flexible(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Text(subList![index].tutorname.toString())
                                    ],
                                  ))
                            ],
                          ));
                        })))
              ],
            ),
    );
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

  void _loadtutors() {
    http.post(Uri.parse("http://10.143.166.165/mytutor2/php/loadtutor.php"),
        body: {}).then((response) {
      var jsondata = jsonDecode(response.body);
      if (response.statusCode == 200 && jsondata['status'] == 'success') {}
      var extractdata = jsondata['data'];
      subList = <tutor>[];
      extractdata['tutor'].forEach((v) {
        subList!.add(tutor.fromJson(v));
      });
    });
  }

  void _loadSearchDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                title: const Text(
                  "Search ",
                ),
                content: SizedBox(
                  //height: screenHeight / 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            labelText: 'Search',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0))),
                        child: DropdownButton(
                          value: dropdownvalue,
                          underline: const SizedBox(),
                          isExpanded: true,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: types.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      search = searchController.text;
                      Navigator.of(context).pop();
                    },
                    child: const Text("Search"),
                  )
                ],
              );
            },
          );
        });
  }
}
