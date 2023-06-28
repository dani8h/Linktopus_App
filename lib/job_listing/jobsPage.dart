import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
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
  TextEditingController _searchController = new TextEditingController();
  final ref = FirebaseDatabase.instance.ref();
  List<dynamic> companylist = [];
  List<dynamic> finallist = [];
  bool _loading = true;
  int n = 0;
  ScrollController _scrollController = new ScrollController();
  bool gettingmore = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var uid;

  void inputData() {
    final User? user = auth.currentUser;
    uid = user?.uid;
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
        if (companyfilter.length > 0) {
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
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                          builder: (context) => Profile(uid: uid),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundImage:
                          AssetImage('assets/images/apple_icon.png'),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Color(0xff4f4f4f))),
                      child: Icon(
                        Icons.notifications_outlined,
                        color: Color(0xff4f4f4f),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Job listings',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
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
                    onSubmitted: (String s) {
                      print("string searched ${s}");
                    },
                  ),
                ),
              ),
              _buttonRow(widget.filterapplied),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: companylist.length == 0
                    ? Center(
                        child: Text('No results found ...'),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: finallist.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return _jdcard(
                              finallist[index].child('Role').value,
                              finallist[index].child('Company Name').value,
                              finallist[index].child('Location').value,
                              finallist[index].child('Description').value,
                              finallist[index].child('Image').value,
                              context);
                        }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _buttonRow extends StatefulWidget {
  final bool filterapplied;
  _buttonRow(this.filterapplied);

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
                  style: TextStyle(color: Colors.black),
                ),
                Icon(
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
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(
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
                  return JobPopup();
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
                    style: TextStyle(
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

Widget _jdcard(String? role, String? cname, String? location, String? info,
    String? imgUrl, BuildContext context) {
  if (info == null) {
    info = 'NA';
  }
  return Container(
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
            backgroundImage: NetworkImage(imgUrl!),
          ),
        ),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              role ?? 'NA',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
            Text(
              cname ?? 'NA',
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 15),
            ),
            Text(
              location ?? 'NA',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              info!.length > 80 ? '${info.substring(0, 80)}...Read more' : info,
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
                      return Bottomsheet();
                    },
                  );
                },
                icon: Icon(Icons.chevron_right))
          ],
        )
      ],
    ),
  );
}
