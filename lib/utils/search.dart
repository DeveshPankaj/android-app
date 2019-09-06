import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';


// Future<List<Object> > getWithPattern(String pattern) async {
//     pattern = pattern.toLowerCase();

//     List<Object> results = new List<Object>();

//     QuerySnapshot snapshot = await _firestore.collection(ref).orderBy('name').startAt([pattern]).endAt([pattern + '\uf8ff']).getDocuments();
//     // print(document.toString());
//     snapshot.documents.forEach((doc){
//       results.add({
//         "id" : doc.data['id'],
//         "name" : doc.data['name'],
//         "image" : doc.data['image']
//       });
//     });
//     return results;
//   }

class SearchService {
  searchByName(String searchField) {
    // final ch = searchField.substring(0, 1).toUpperCase();
    final ch = searchField.substring(0, 1);
    final Firestore _database = Firestore.instance;

    // return _database.collection("products").where('name', isEqualTo:ch).getDocuments();

    // return _database
    //     .reference()
    //     .orderByKey()
    //     .startAt(ch)
    //     .endAt(ch + "\uf8ff");
    return  _database.collection('products').orderBy('name').startAt([ch]).endAt([ch + '\uf8ff']).getDocuments();

    // return Firestore.instance
    //     .collection('products')
    //     .where('name',
    //         isEqualTo: "Asdfasdfas")
    //     .getDocuments();



  }
}
