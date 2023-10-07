// Future<void> updateSortOrder(SortBy newSortType) async {
//   if (sortType == newSortType) {
//     // Toggle between ascending and descending
//     sortAscending = !sortAscending;
//   } else {
//     sortType = newSortType;
//     sortAscending = true;
//   }

//   // Print a message to check if the function is called
//   print('updateSortOrder called with newSortType: $newSortType');

//   // Reset the pagination
//   n = 0;

//   // Clear the companylist to prevent duplicates
//   companylist.clear();

//   // Fetch the data asynchronously
//   await _getcompanies();

//   // Apply the sorting logic
//   if (sortType == SortBy.salaryAscending ||
//       sortType == SortBy.salaryDescending) {
//     // Sort by Salary
//     companylist.sort((a, b) {
//       var salaryA = double.tryParse(a.child('Salary').value.toString()) ?? 0;
//       var salaryB = double.tryParse(b.child('Salary').value.toString()) ?? 0;
//       int comparisonResult = sortAscending
//           ? salaryA.compareTo(salaryB)
//           : salaryB.compareTo(salaryA);

//       // Print the sorting details
//       print(
//           'Sorting by Salary: Salary A: $salaryA, Salary B: $salaryB, Comparison Result: $comparisonResult');

//       return comparisonResult;
//     });
//   } else if (sortType == SortBy.idAscending ||
//       sortType == SortBy.idDescending) {
//     // Sort by ID
//     companylist.sort((a, b) {
//       var idA = int.tryParse(a.child('Id').value.toString()) ?? 0;
//       var idB = int.tryParse(b.child('Id').value.toString()) ?? 0;
//       int comparisonResult =
//           sortAscending ? idA.compareTo(idB) : idB.compareTo(idA);

//       // Print the sorting details
//       print(
//           'Sorting by ID: ID A: $idA, ID B: $idB, Comparison Result: $comparisonResult');
//       print(companylist.length);

//       return comparisonResult;
//     });
//   }

//   // Apply any filters
//   applyfilter();

//   // Refresh the UI after sorting and filtering
//   setState(() {});
// }

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart' as fstore;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linktopus_app/SignUp/googlesignin.dart';
import 'package:linktopus_app/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'filter_popup.dart';
import 'bottom_sheet.dart';

enum SortBy {
  idAscending,
  idDescending,
}

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
  SortBy? sortType;
  bool sortAscending = true;
  final TextEditingController _searchController = TextEditingController();
  final ref = FirebaseDatabase.instance.ref();
  List<dynamic> companylist = [];
  List<dynamic> finallist = [];
  List<dynamic> textfilteredlist = [];
  bool loading = true;
  int n = 0;
  final ScrollController _scrollController = ScrollController();
  bool gettingmore = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  var uid;
  var profilePic;
  String? ImgUrl;

  void UpdateBookmarkFilter(bool isActive) {
    setState(() {
      isBookmarkFilterActive = isActive;
    });
  }

  void updateSortOrder(SortBy newSortType) {
    if (sortType == newSortType) {
      // Toggle between ascending and descending
      sortAscending = !sortAscending;
    } else {
      sortType = newSortType;
      sortAscending =
          true; // Default to ascending order when a new sorting type is selected
    }

    // Perform the sorting here
    if (sortType == SortBy.idAscending || sortType == SortBy.idDescending) {
      // Sort by ID
      companylist.sort((a, b) {
        var idA = int.tryParse(a.child('Id').value.toString()) ?? 0;
        var idB = int.tryParse(b.child('Id').value.toString()) ?? 0;
        int comparisonResult =
            sortAscending ? idA.compareTo(idB) : idB.compareTo(idA);
        return comparisonResult;
      });

      // Update the UI by calling applyfilter() and setState()
      applyfilter();
      setState(() {});
    }
  }

  Future<void> inputData() async {
    final User? user = auth.currentUser;
    uid = user?.uid;
    if (uid != null) {
      String? path = 'users/$uid/ProfilePic';
      // print('image path is $path');
      final storageRef = FirebaseStorage.instance.ref().child(path);
      ImgUrl = await storageRef.getDownloadURL();
      // print('image url $ImgUrl');
    }
  }

  _getcompanies() async {
    if (isBookmarkFilterActive == true) {
      return;
    }
    Query q = ref
        .child('1Qv9Hsn9tDmj1uZ8YyK2YMCyN1-jtVoM-0Udoi9fbHSI')
        .child('Job Opportunities')
        .orderByKey()
        .startAfter(n.toString())
        .endAt((n + 10).toString());
    loading = true;
    DataSnapshot dataSnapshot = await q.get();
    companylist.addAll(dataSnapshot.children);

    // Fetch the bookmarked status for each job
    await fetchBookmarkedJobs();
    // print('company data , ${DateTime.now()}');
    // print(companylist.length);
    // for (dynamic e in companylist) {
    //   print(e.value);
    // }
    setState(() {
      loading = false;
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
    if (isBookmarkFilterActive == false) finallist = companylist;

    if (widget.filterapplied) {
      if (widget.myfilter['Companies'] != null &&
          widget.myfilter['Companies'].length != 0) {
        List<String> companyfilter = [];
        companyfilter.addAll(widget.myfilter['Companies']);
        if (companyfilter.isNotEmpty) {
          finallist = finallist
              .where((element) =>
                  companyfilter.contains(element.child('Company').value))
              .toList();
        }
      }

      if (widget.myfilter['Location'] != null &&
          widget.myfilter['Location'].length != 0) {
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

      if (widget.myfilter['lower range'] != null &&
          widget.myfilter['lower range'] != 5000000) {
        double upperRange = widget.myfilter['upper range'];
        finallist = finallist.where((element) {
          try {
            double salary = double.parse(element.child('Salary').value);
            return salary <= upperRange;
          } catch (e) {
            if (element.child('Salary').value == null ||
                element.child('Salary').value == '') return true;
            return false;
          }
        }).toList();
      }
      if (widget.myfilter['upper range'] != null &&
          widget.myfilter['upper range'] != 0) {
        double lowerRange = widget.myfilter['lower range'];
        finallist = finallist.where((element) {
          try {
            double salary = double.parse(element.child('Salary').value);
            return salary >= lowerRange;
          } catch (e) {
            if (element.child('Salary').value == null ||
                element.child('Salary').value == '') return true;
            return false;
          }
        }).toList();
      }

      print("filtered companies: ");
      for (dynamic e in finallist) {
        print(e.value);
      }
    }
    textfilteredlist = finallist.toSet().toList();

    textfilteredlist.toSet().toList();
  }

  void textFilter(String t) {
    if (t.isEmpty) {
      textfilteredlist = finallist;
    } else {
      textfilteredlist = finallist
          .where((element) => element
              .child('Profile')
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
    sortType = SortBy.idAscending; // Initialize the sort type
    sortAscending = true; //
    // Load the bookmarkedStatus from local storage
    loadBookmarkedStatus().then((loadedStatus) {
      setState(() {
        bookmarkedStatus = loadedStatus;
      });
    });
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

  bool isBookmarkFilterActive = false;

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
                          border: Border.all(color: const Color(0xff4f4f4f))),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Center(
                  child: CupertinoSearchTextField(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 10),
                    controller: _searchController,
                    placeholder: 'Search',
                    onChanged: (value) => textFilter(value),
                    // onSubmitted: (String s) {
                    //   print("string searched ${s}");
                    // },
                  ),
                ),
              ),
              _buttonRow(
                widget.myfilter.length != 0 ? widget.filterapplied : false,
                isBookmarkedFilterActive: isBookmarkFilterActive,
                updateTextFilteredList: (list) {
                  setState(() {
                    //textfilteredlist = list;
                    finallist = list;
                  }); // Pass the callback function
                  applyfilter();
                },
                UpdateBookmarkFilter: UpdateBookmarkFilter,
                sortType: sortType,
                updateSortOrder: updateSortOrder,
              ),
              const SizedBox(
                height: 30,
              ),

              Expanded(
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : companylist.isEmpty
                        ? Center(
                            child: Text('No results found ...'),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: textfilteredlist.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              return _jdcard(textfilteredlist[index], context);
                            },
                          ),
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
        context, MaterialPageRoute(builder: (context) => const EmailSignin()));
  }

  Map<String, bool> bookmarkedStatus = {};

  Future<void> fetchBookmarkedJobs() async {
    final User? user = auth.currentUser;
    if (user != null) {
      final userDocRef =
          fstore.FirebaseFirestore.instance.collection('users').doc(user.uid);

      // Fetch the user's document from Firestore
      final userData = await userDocRef.get();

      // Initialize bookmarkedStatus map
      final Map<String, bool> updatedStatus = {};

      // Check if the 'JobsBookmarked' field exists in the document
      if (userData.exists && userData.data()!.containsKey('JobsBookmarked')) {
        var jobsBookmarked = userData.get('JobsBookmarked') as List<dynamic>;

        for (var jobEntry in companylist) {
          final jobId = jobEntry.child('Id').value.toString();
          final isBookmarked = jobsBookmarked.contains(jobId);
          updatedStatus[jobId] = isBookmarked;
        }
      }

      setState(() {
        bookmarkedStatus = updatedStatus;
      });
    }
  }

  // Save the bookmarkedStatus to local storage
  Future<void> saveBookmarkedStatus(Map<String, bool> status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('bookmarkedStatus', jsonEncode(status));
  }

  // Load the bookmarkedStatus from local storage
  Future<Map<String, bool>> loadBookmarkedStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('bookmarkedStatus');
    if (jsonString != null) {
      final decodedMap = jsonDecode(jsonString);
      if (decodedMap is Map<String, dynamic>) {
        return decodedMap.map((key, value) => MapEntry(key, value as bool));
      }
    }
    return {}; // Default value if not found or not valid
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
    String info = cdata.child('Job Description').value.toString() ?? 'NA';
    info = info.length > 80 ? '${info.substring(0, 80)}...Read more' : info;

    // Get the bookmarked status for this job item
    String str = "${cdata.child('Id').value}";
    final bool isBookmarked = bookmarkedStatus[str] ?? false;

    void _addToBookmarks(dynamic cdata, bool bookmarkedstatus) async {
      final User? user = auth.currentUser;
      if (user != null) {
        final userDocRef =
            fstore.FirebaseFirestore.instance.collection('users').doc(user.uid);

        // Fetch the user's document from Firestore
        final userData = await userDocRef.get();

        // Check if the 'JobsBookmarked' field exists in the document
        if (userData.exists && userData.data()!.containsKey('JobsBookmarked')) {
          var jobsBookmarked = userData.get('JobsBookmarked') as List<dynamic>;

          // Check if the job is not already bookmarked
          String str = "${cdata.child('Id').value}";
          if (bookmarkedstatus) {
            // Add the job ID to the list of bookmarked jobs

            jobsBookmarked.add(str);
          } else {
            // Remove the job ID from the list of bookmarked jobs

            jobsBookmarked.remove(str);
          }
          // Update the 'JobsBookmarked' field in Firestore
          await userDocRef.update({'JobsBookmarked': jobsBookmarked});
        } else {
          // Create the 'JobsBookmarked' field as an empty list if it doesn't exist
          String str = "${cdata.child('Id').value}";
          await userDocRef.set({
            'JobsBookmarked': [str]
          }, fstore.SetOptions(merge: true));
        }
        bookmarkedStatus[str] = bookmarkedstatus;
        // Save the updated bookmarkedStatus to local storage
        await saveBookmarkedStatus(bookmarkedStatus);
      }
    }

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
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffE5E5E5)),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: CircleAvatar(
                  radius: 20,
                  backgroundImage: cdata.child('Image').value.toString() != ""
                      ? NetworkImage(cdata.child('Image').value.toString())
                      : NetworkImage(
                          'https://www.searchenginejournal.com/wp-content/uploads/2017/06/shutterstock_268688447.jpg')),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cdata.child('Profile').value.toString() ?? 'NA',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, fontSize: 18),
                ),
                Text(
                  cdata.child('Company').value.toString() ?? 'NA',
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 15),
                ),
                Text(
                  cdata.child('Location').value.toString() ?? 'NA',
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: Colors.grey),
                ),
                const SizedBox(height: 10),
                Text(
                  info,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 12),
                )
              ],
            )),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      // Toggle the bookmarked status for this item
                      final bool newBookmarkStatus = !isBookmarked;
                      String str = "${cdata.child('Id').value}";
                      bookmarkedStatus[str] = newBookmarkStatus;

                      _addToBookmarks(cdata, newBookmarkStatus);
                      setState(() {});
                    },
                    icon: isBookmarked
                        ? const Icon(Icons.bookmark)
                        : const Icon(Icons.bookmark_border)),
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
                    icon: const Icon(Icons.chevron_right))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _buttonRow extends StatefulWidget {
  final bool filterapplied;
  final void Function(bool)
      UpdateBookmarkFilter; // Define the callback function
  final void Function(List<dynamic>) updateTextFilteredList;
  SortBy? sortType;
  final void Function(SortBy) updateSortOrder;
  bool isBookmarkedFilterActive;
  // Callback for sorting
  // Add this parameter

  _buttonRow(this.filterapplied,
      {required this.updateTextFilteredList,
      required this.UpdateBookmarkFilter,
      required this.sortType,
      required this.updateSortOrder,
      required this.isBookmarkedFilterActive});

  @override
  State<_buttonRow> createState() => _buttonRowState();
}

class _buttonRowState extends State<_buttonRow> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  //bool isBookmarkedFilterActive = false;
  getbookmarks() async {
    final User? user = auth.currentUser;
    if (user != null) {
      final userDocRef =
          fstore.FirebaseFirestore.instance.collection('users').doc(user.uid);

      // Fetch the user's document from Firestore
      final userData = await userDocRef.get();

      List<dynamic> filteredlist = [];

      // Check if the 'JobsBookmarked' field exists in the document
      if (userData.exists && userData.data()!.containsKey('JobsBookmarked')) {
        var jobsBookmarked = userData.get('JobsBookmarked') as List<dynamic>;

        for (dynamic e in jobsBookmarked) {
          //query for each job id
          int checkid = int.parse(e as String);
          Query q = FirebaseDatabase.instance
              .ref()
              .child('1Qv9Hsn9tDmj1uZ8YyK2YMCyN1-jtVoM-0Udoi9fbHSI')
              .child('Job Opportunities')
              .orderByChild('Id')
              .equalTo(checkid);

          DataSnapshot dataSnapshot = await q.get();
          filteredlist.addAll(dataSnapshot.children);
          // for (dynamic e in dataSnapshot.children) {
          //   filteredlist.add(e.value);
          // }
        }

        widget.updateTextFilteredList(filteredlist);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white)),
            onPressed: () {
              // Ca ll the updateSortOrder function with the sorting type

              setState(() {
                widget.updateSortOrder(SortBy.idAscending);
              });
            },
            child: Container(
              child: Row(
                children: [
                  Text(
                    'Sort',
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.sort,
                        color: Colors.black,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.isBookmarkedFilterActive = !widget
                      .isBookmarkedFilterActive; // Toggle the bookmarked filter
                });
                getbookmarks();
                widget.UpdateBookmarkFilter(widget
                    .isBookmarkedFilterActive); // Notify the parent widget
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              child: Container(
                child: Row(
                  children: [
                    Text(
                      'Bookmarked',
                      style: GoogleFonts.poppins(
                          color: widget.isBookmarkedFilterActive
                              ? Colors.blue
                              : Colors.black),
                    ),
                    Icon(
                      Icons.bookmark_border,
                      color: Colors.pinkAccent,
                    ),
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
                          color: widget.filterapplied
                              ? Colors.blue
                              : Colors.black),
                    ),
                    Icon(
                      Icons.filter_alt_outlined,
                      color: widget.filterapplied ? Colors.blue : Colors.black,
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
