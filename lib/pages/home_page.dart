import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/report_model.dart';
import 'Drawer.dart';
import 'all_users_page.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final CollectionReference _postedReport =
  //     FirebaseFirestore.instance.collection("report");
  // final CollectionReference _postedReport = FirebaseFirestore.instance.collection("report").orderBy("name", descending: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Reports"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white, size: 30.0),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AllUsersPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white, size: 30.0),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/login_page/", (route) => false);
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: MyDrawer(),
      ),
      body: StreamBuilder<List<ReportModel>>(
        stream: getAllReport(),
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            // final report = snapshots.data!;

            return ListView.builder(
                itemCount: snapshots.data!.length,
                itemBuilder: (context, index) {
                  var tSnapshot = snapshots.data![index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(
                        tSnapshot.reporterName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      subtitle: Text(
                        tSnapshot.reporterLocation,
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
                              messageReported: tSnapshot.messageReported,
                              reporterLocation: tSnapshot.reporterLocation,
                              reporterName: tSnapshot.reporterName,
                              reporterPhone: tSnapshot.reporterPhone,
                              locationLat: tSnapshot.locationLat,
                              locationLong: tSnapshot.locationLong,
                              fileSend: tSnapshot.fileSend,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                });
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Stream<List<ReportModel>> getAllReport() => FirebaseFirestore.instance
      .collection("report")
      .orderBy("timestamp", descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => ReportModel.fromJson(doc.data()))
          .toList());
}
