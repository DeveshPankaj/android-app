library my_prj.cache;

import 'package:cloud_firestore/cloud_firestore.dart';

Map<String, List<DocumentSnapshot>> subCategoryPage = new Map<String, List<DocumentSnapshot>>();

Map<String, List<Map<String, String> > > searchCache = new Map<String, List<Map<String, String> > >();