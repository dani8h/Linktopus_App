import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Jobs_page extends StatefulWidget {
  @override
  State<Jobs_page> createState() => _Jobs_pageState();
}

class _Jobs_pageState extends State<Jobs_page> {
  TextEditingController _searchController = new TextEditingController();
  final ref = FirebaseDatabase.instance.ref();
  List<dynamic> companylist = [];
  bool _loading = true;
  int n = 0;
  ScrollController _scrollController = new ScrollController();
  bool gettingmore = false;
  bool moreAvailable = true;

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
  }

  _getmore() async {
    print('getmore called');
    n = n + 10;
    await _getcompanies();
    setState(() {
      gettingmore = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getcompanies();

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
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: AssetImage('assets/images/apple_icon.png'),
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
              _buttonRow(),
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
                          itemCount: companylist.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return _jdcard(
                                companylist[index].child('Role').value,
                                companylist[index].child('Company Name').value,
                                companylist[index].child('Location').value,
                                companylist[index].child('Description').value,
                                companylist[index].child('Image').value);
                            //     ListTile(
                            //   title: Text(
                            //       companylist[index].child('location').value),
                            // );
                          })
                  // ListView(
                  //     children: [
                  //       _jdcard(),
                  //       _jdcard(),
                  //       _jdcard(),
                  //       _jdcard(),
                  //       _jdcard()
                  //     ],
                  //   ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}

class _buttonRow extends StatefulWidget {
  const _buttonRow({Key? key}) : super(key: key);

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
            onPressed: () {},
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white)),
            child: Container(
              child: Row(
                children: [
                  Text(
                    'Filter',
                    style: TextStyle(color: Colors.black),
                  ),
                  Icon(
                    Icons.filter_alt_outlined,
                    color: Colors.black,
                  )
                ],
              ),
            )),
      ],
    );
  }
}

Widget _jdcard(String? role, String? cname, String? location, String? info,
    String? imgUrl) {
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
            IconButton(onPressed: () {}, icon: Icon(Icons.chevron_right))
          ],
        )
      ],
    ),
  );
}
