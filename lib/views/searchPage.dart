import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:local_market/utils/search.dart';

// void main() => runApp(new MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new SearchPage(),
//     );
//   }
// }

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => new _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var tempSearchStore = [];
  var remamber = new Map();

  initiateSearch(value) {
    // load data if required
    loadData() {
      remamber[value] = List();
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        print("results " + docs.documents.length.toString());
        for (int i = 0; i < docs.documents.length; ++i) {
          remamber[value].add(docs.documents[i].data);
          print(docs.documents[i].data['name']);
        }
      });
    }

    // build search result
    buildResult() {
      tempSearchStore = List();
      final ch = value.substring(0, 1);
      print('building results for ' + value + " in " + ch);

      // remamber[ch].forEach((element) {
      //   if (element['name'].startsWith(value)) {
      //     print(value + " -> " + element['name']);
      //     // setState(() {
      //     //   tempSearchStore.add(element);
      //     // });
      //   }
      // });

      for (var item in remamber[ch]) {
        if(item['name'].startsWith(value)){
          setState(() {
            tempSearchStore.add(item);
          });
          print(value + " -> " + item['name']);
        }
      }

      print("result build done");
    }

    // if no key is pressed
    if (value.length == 0) {
      setState(() {
        tempSearchStore = List();
      });
    }

    // check if user is trying to search something
    else if (value.length == 1) {
      print('calling search');
      // print(remamber[value]);

      // do not load data if found in cache memo
      if (remamber[value] != null) {
        print("Key found in cache " + value);
        if (remamber[value].length == 0) {
          loadData();
        }
      } else {
        print("Key not found in cache " + value);
        loadData();
      }
      // build result on every key stock
      print("searching");
      buildResult();
    } else {
      // build result on every key stock
      print("searching");
      buildResult();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.red,
          title: Text('Apni Dukan'),
        ),
        body: ListView(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (val) {
                initiateSearch(val);
              },
              decoration: InputDecoration(
                  prefixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(Icons.search),
                    iconSize: 20.0,
                    onPressed: () {
                      // Navigator.of(context).pop();
                    },
                  ),
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Search product',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0))),
            ),
          ),
          SizedBox(height: 10.0),
          GridView.count(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              primary: false,
              shrinkWrap: true,
              children: tempSearchStore.map((element) {
                return buildResultCard(element);
              }).toList())
        ]));
  }
}

Widget buildResultCard(data) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: Container(
          child: Center(
              child: Text(
        data['name'],
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ))));
}
