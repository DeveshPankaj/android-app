import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

import 'package:local_market/utils/search.dart';

class SearchPage1 extends StatefulWidget {
  @override
  _SearchPage1State createState() => _SearchPage1State();
}

class _SearchPage1State extends State<SearchPage1> {
  // var tempSearchStore = [];
  // var remamber = new Map();

  // initiateSearch(value) {
  //   // load data if required
  //   loadData() {
  //     remamber[value] = List();
  //     SearchService().searchByName(value).then((QuerySnapshot docs) {
  //       print("results " + docs.documents.length.toString());
  //       for (int i = 0; i < docs.documents.length; ++i) {
  //         remamber[value].add(docs.documents[i].data);
  //         print(docs.documents[i].data['name']);
  //       }
  //     });
  //   }

  //   // build search result
  //   buildResult() {
  //     tempSearchStore = List();
  //     final ch = value.substring(0, 1);
  //     print('building results for ' + value + " in " + ch);

  //     // remamber[ch].forEach((element) {
  //     //   if (element['name'].startsWith(value)) {
  //     //     print(value + " -> " + element['name']);
  //     //     // setState(() {
  //     //     //   tempSearchStore.add(element);
  //     //     // });
  //     //   }
  //     // });

  //     for (var item in remamber[ch]) {
  //       if(item['name'].startsWith(value)){
  //         setState(() {
  //           tempSearchStore.add(item);
  //         });
  //         print(value + " -> " + item['name']);
  //       }
  //     }

  //     print("result build done");
  //   }

  //   // if no key is pressed
  //   if (value.length == 0) {
  //     setState(() {
  //       tempSearchStore = List();
  //     });
  //   }

  //   // check if user is trying to search something
  //   else if (value.length == 1) {
  //     print('calling search');
  //     // print(remamber[value]);

  //     // do not load data if found in cache memo
  //     if (remamber[value] != null) {
  //       print("Key found in cache " + value);
  //       if (remamber[value].length == 0) {
  //         loadData();
  //       }
  //     } else {
  //       print("Key not found in cache " + value);
  //       loadData();
  //     }
  //     // build result on every key stock
  //     print("searching");
  //     buildResult();
  //   } else {
  //     // build result on every key stock
  //     print("searching");
  //     buildResult();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Apni Dukan"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String>{
  var ls = [
    "gvghvknad",
    "jdavghsndls",
    "dajvghsbjaljmds",
    "kdhajsvgds",
    "kldahgufdvgs",
    "dhfsyga",
    "dkjahsyg",
    "fausjdh0",
    "gdafjgbsg",
    "dlkhaigfud",
    "jalhkufvha",
    "djlkahgiufas",
    "djkagfvs",
    "asjlfjkd",
    "klaksjfha"
  ];
  var top = [
    "kdhajsvgds",
    "kldahgufdvgs",
    "dhfsyga",
    "dkjahsyg",
    "fausjdh0",
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    var suggestions = [];
    if(query.isNotEmpty){
      SearchService().searchByName(query).then((QuerySnapshot docs) {
        // suggestions = query.isEmpty ? top : ls.where((e) => e.startsWith(query)).toList();
        // suggestions = docs.documents.where((e) => e['name'].toString().startsWith(query)).toList();
        for (var i=0; i<docs.documents.length; i++) {
          final item = docs.documents[i];
          suggestions.add(item);
          print(item['name'].toString());
        }
      });
    }
    

    


    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.local_bar),
        title: Text(suggestions[index]['name'].toString()),
      ),
      itemCount: suggestions.length,
    );
  }
}
