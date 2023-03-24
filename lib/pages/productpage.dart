import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../buckets.firestore.dart';
import '../fields.firestore.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sub-collection data'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(FirestoreBuckets.allschools)
            .doc("radhanagor")
            .collection(FirestoreBuckets.students)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot != null) {
            if (snapshot.data!.docs.isNotEmpty) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  Map<String, dynamic> docData =
                      snapshot.data!.docs[index].data();

                  if (docData.isEmpty) {
                    return Text("No Data");
                  }
                  String name = docData[FirestoreField.name];

                  return ListTile(
                    title: Text(name),
                  );
                },
                itemCount: snapshot.data!.docs.length,
              );
            } else {
              return Text("nod ata");
            }
          } else {
            return Text("nod ata");
          }
        },
      ),
    );
  }
}
