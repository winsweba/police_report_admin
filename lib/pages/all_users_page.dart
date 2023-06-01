import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:police_office/models/all_users_model.dart';

class AllUsersPage extends StatefulWidget {
  const AllUsersPage({super.key});

  @override
  State<AllUsersPage> createState() => _AllUsersPageState();
}

class _AllUsersPageState extends State<AllUsersPage> {
  // final CollectionReference _postedReport =
  //     FirebaseFirestore.instance.collection("report");
  // final CollectionReference _postedReport = FirebaseFirestore.instance.collection("report").orderBy("name", descending: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Users"),
        // leading: IconButton(
        //   icon: const Icon(Icons.person, size: 30.0),
        //   onPressed: () {
        //     print("Print");
        //     // _launchUrl();
        //   },
        // ),
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.logout, color: Colors.white, size: 30.0),
        //     onPressed: () {
        //       FirebaseAuth.instance.signOut();
        //       Navigator.of(context)
        //           .pushNamedAndRemoveUntil("/login_page/", (route) => false);
        //     },
        //   ),
        // ],
      ),
      body: StreamBuilder<List<AllUsers>>(
        stream: getAllReport(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            final report = snapshots.data!;

            return ListView.builder(
                itemCount: snapshots.data!.length,
                itemBuilder: (context, index) {
                  var tSnapshot = snapshots.data![index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(tSnapshot.userNme, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                      subtitle: Column(
                        children: [
                          SizedBox(height: 10,),
                           Text(tSnapshot.userEmail, style: TextStyle(fontSize: 16),),
                           SizedBox(height: 10,),
                           Text(tSnapshot.phoneNumber, style: TextStyle(fontSize: 16),),
                        ],
                      ),
                      onTap: () {
                        Fluttertoast.showToast(
                        msg: "user Id:: ${tSnapshot.userId}",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 15.0,
                      );
                      },
                    ),
                  );
                });
          }
           else {
            return const Center(child:  CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Stream<List<AllUsers>> getAllReport() => FirebaseFirestore.instance
      .collection("Users")
      .orderBy("timestamp", descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => AllUsers.fromJson(doc.data()))
          .toList());
}
