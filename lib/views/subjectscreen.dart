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
  String titlecenter = "loading...";
  late double screenHeight, screenWidth, resWidth;

  TextEditingController searchController = TextEditingController();
  String search = "";
  String dropdownvalue = 'Programming 101';
  var types = [
    'All',
    'Programming 101',
    'Programming 201',
    'Introduction to Web programming ',
    'Web programming advanced',
    'Python for Everybody',
    'Introduction to Computer Science',
    'Code Yourself! An Introduction to Programming',
    'IBM Full Stack Software Developer Professional Certificate',
    'Graphic Design Specialization',
    'Fundamentals of Graphic Design',
    'Fundamentals of Graphic Design',
    'Full-Stack Web Development with React',
    'Software Design and Architecture',
    'Software Testing and Automation',
    'Introduction to Cyber Security',
  ];

  @override
  void initState() {
    super.initState();
    _loadSubjects();
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
        title: const Text('Subject'),
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
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Text("Subject Available",
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
                                      Text(subList![index]
                                          .subjectName
                                          .toString())
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

  void _loadSubjects() {
    http.post(Uri.parse("http://10.143.166.165/mytutor2/php/loadsubject.php"),
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
