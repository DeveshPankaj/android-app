library my_prj.globals;

import 'package:cloud_firestore/cloud_firestore.dart';

int cartSize = 0;
Map<String, dynamic> cart = new Map<String, dynamic> ();
double total = 0;
Map<String, List<dynamic>> productListener = new Map<String, List<dynamic>>();

DocumentSnapshot currentUser = null;