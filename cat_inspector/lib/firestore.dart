import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreService{
  final CollectionReference empdetails=FirebaseFirestore.instance.collection('EmployeeDetails');

  Future<void> createAcc(String id,String Pass){
    return empdetails.add(
        {'ID': id,
          "Password": Pass,}
    );
  }
}