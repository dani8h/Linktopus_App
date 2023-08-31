import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linktopus_app/login/landing_page.dart';
import 'package:linktopus_app/profile.dart';
import 'filter_popup.dart';
import 'bottom_sheet.dart';

class Jobs_page extends StatefulWidget {
  bool filterapplied = false;
  Map<String, dynamic> myfilter = {};
  Jobs_page([Map<String, dynamic>? filter]) {
    if (filter != null) {
      filterapplied = true;
      myfilter = filter;
    }
  }
  @override
  State<Jobs_page> createState() => _Jobs_pageState();
}

class _Jobs_pageState extends State<Jobs_page> {
  final TextEditingController _searchController = TextEditingController();
  final ref = FirebaseDatabase.instance.ref();
  List<dynamic> companylist = [];
  List<dynamic> finallist = [];
  List<dynamic> textfilteredlist = [];
  bool _loading = true;
  int n = 0;
  final ScrollController _scrollController = ScrollController();
  bool gettingmore = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var uid;
  var profilePic;
  String? ImgUrl;

  Future<void> inputData() async {
    final User? user = auth.currentUser;
    uid = user?.uid;
    if (uid != null) {
      String? path = 'users/$uid/ProfilePic';
      print('image path is $path');
      final storageRef = FirebaseStorage.instance.ref().child(path);
      ImgUrl = await storageRef.getDownloadURL();
      print('image url $ImgUrl');
    }
  }

  _getcompanies() async {
    Query q = ref
        .child('1N3PmKSTY7isdFNXaKFCALDT9-OoYNiQ3txilEqUR5UM/Sheet1')
        .orderByKey()
        .startAfter(n.toString())
        .endAt((n + 10).toString());
    _loading = true;
    DataSnapshot dataSnapshot = await q.get();
    companylist.addAll(dataSnapshot.children);
    setState(() {
      _loading = false;
    });
    applyfilter();
  }

  _getmore() async {
    print('getmore called');
    n = n + 10;
    await _getcompanies();
    setState(() {
      gettingmore = false;
    });
  }

  applyfilter() {
    finallist = companylist;

    if (widget.filterapplied) {
      if (widget.myfilter['Companies'] != null) {
        List<String> companyfilter = [];
        companyfilter.addAll(widget.myfilter['Companies']);
        if (companyfilter.isNotEmpty) {
          finallist = finallist
              .where((element) =>
                  companyfilter.contains(element.child('Company Name').value))
              .toList();
        }
      }

      if (widget.myfilter['Location'] != null) {
        String location = widget.myfilter['Location'].toString().toLowerCase();
        finallist = finallist
            .where((element) => element
                .child('Location')
                .value
                .toString()
                .toLowerCase()
                .contains(location))
            .toList();
      }

      if (widget.myfilter['upper range'] != null &&
          widget.myfilter['upper range'] != 5000000) {
        double upperRange = widget.myfilter['upper range'];
        finallist = finallist
            .where((element) => element.child('Salary').value <= upperRange)
            .toList();
      }
      if (widget.myfilter['upper range'] != null &&
          widget.myfilter['upper range'] != 0) {
        double lowerRange = widget.myfilter['lower range'];
        finallist = finallist
            .where((element) => element.child('Salary').value >= lowerRange)
            .toList();
      }

      // print('filtered companylist');
      // for (var e in finallist) {
      //   print(e.child('Salary').value);
      // }
    }
    textfilteredlist = finallist;
  }

  void textFilter(String t) {
    if (t.isEmpty) {
      textfilteredlist = finallist;
    } else {
      textfilteredlist = finallist
          .where((element) => element
              .child('Role')
              .value
              .toString()
              .toLowerCase()
              .contains(t.toLowerCase()))
          .toList();
    }
  }

  @override
  void initState() {
    super.initState();
    inputData();
    _getcompanies();
    if (!_scrollController.hasClients) {
      setState(() {
        gettingmore = true;
      });
      _getmore();
    }
    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;
      if (maxScroll - currentScroll < delta && gettingmore == false) {
        setState(() {
          gettingmore = true;
        });
        _getmore();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Profile(),
                        ),
                      );
                    },
                    child: CircleAvatar(
                        radius: 25,
                        backgroundImage: ImgUrl == null
                            ? const AssetImage('assets/images/profilepic.jpg')
                            : NetworkImage(ImgUrl!) as ImageProvider),
                  ),
                  GestureDetector(
                    onTap: () {
                      signout();
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Color(0xff4f4f4f))),
                      child: const Icon(
                        Icons.logout,
                        color: Color(0xff4f4f4f),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Job listings',
                  style: GoogleFonts.poppins(
                      fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
              //search bar
              Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Center(
                  child: CupertinoSearchTextField(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                    controller: _searchController,
                    placeholder: 'Search',
                    onChanged: (value) => textFilter(value),
                    // onSubmitted: (String s) {
                    //   print("string searched ${s}");
                    // },
                  ),
                ),
              ),
              _buttonRow(widget.filterapplied),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: companylist.isEmpty
                    ? const Center(
                        child: Text('No results found ...'),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: textfilteredlist.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return _jdcard(textfilteredlist[index], context);
                        }),
              )
            ],
          ),
        ),
      ),
    );
  }

  signout() async {
    await auth.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Landing_Page()));
  }
}

class _buttonRow extends StatefulWidget {
  final bool filterapplied;
  const _buttonRow(this.filterapplied);

  @override
  State<_buttonRow> createState() => _buttonRowState();
}

class _buttonRowState extends State<_buttonRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white)),
          onPressed: () {},
          child: Container(
            child: Row(
              children: [
                Text(
                  'Sort',
                  style: GoogleFonts.poppins(color: Colors.black),
                ),
                const Icon(
                  Icons.sort,
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
        ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white)),
            child: Container(
              child: Row(
                children: [
                  Text(
                    'Bookmarked',
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                  const Icon(
                    Icons.bookmark_border,
                    color: Colors.pinkAccent,
                  )
                ],
              ),
            )),
        ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const JobPopup();
                },
              );
            },
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white)),
            child: Container(
              child: Row(
                children: [
                  Text(
                    'Filter',
                    style: GoogleFonts.poppins(
                        color:
                            widget.filterapplied ? Colors.blue : Colors.black),
                  ),
                  Icon(
                    Icons.filter_alt_outlined,
                    color: widget.filterapplied ? Colors.blue : Colors.black,
                  )
                ],
              ),
            )),
      ],
    );
  }
}

Widget _jdcard(dynamic cdata, BuildContext context) {
  // textfilteredlist[index].child('Role').value,
  // textfilteredlist[index]
  //     .child('Company Name')
  //     .value,
  // textfilteredlist[index].child('Location').value,
  // textfilteredlist[index]
  //     .child('Description')
  //     .value,
  // textfilteredlist[index].child('Image').value,
  String info = cdata.child('Description').value.toString() ?? 'NA';
  info = info.length > 80 ? '${info.substring(0, 80)}...Read more' : info;

  return GestureDetector(
    onTap: () {
      showModalBottomSheet<void>(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Bottomsheet(jobdata: cdata);
        },
      );
    },
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Color(0xffE5E5E5)),
      child: Row(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(cdata.child('Image').value),
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cdata.child('Role').value.toString() == null
                    ? 'NA'
                    : cdata.child('Role').value.toString(),
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
              Text(
                cdata.child('Company Name').value.toString() == null
                    ? 'NA'
                    : cdata.child('Company Name').value.toString(),
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
              ),
              Text(
                cdata.child('Location').value.toString() == null
                    ? 'NA'
                    : cdata.child('Location').value.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: Colors.grey),
              ),
              SizedBox(height: 10),
              Text(
                info,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              )
            ],
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    // print('button pressed');
                  },
                  icon: Icon(Icons.bookmark_add_outlined)),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return Bottomsheet(jobdata: cdata);
                      },
                    );
                  },
                  icon: Icon(Icons.chevron_right))
            ],
          )
        ],
      ),
    ),
  );
}
