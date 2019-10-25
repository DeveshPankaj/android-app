import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:flutter/gestures.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_market/components/app_bar.dart';
import 'package:local_market/components/circular_loading_button.dart';
import 'package:local_market/components/page.dart';
import 'package:local_market/components/request_priduct_item.dart';
import 'package:local_market/controller/notification_controler.dart';
import 'package:local_market/controller/order_controller.dart';
import 'package:local_market/utils/utils.dart';
import 'package:local_market/views/cart.dart';
import "package:local_market/views/signup.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:local_market/views/home.dart";
import 'package:outline_material_icons/outline_material_icons.dart';

class ProductRequests extends StatefulWidget {
  @override
  _ProductRequestsState createState() => _ProductRequestsState();
}

class _ProductRequestsState extends State<ProductRequests> {
  final NotificationController _notificationController =
      new NotificationController();
  List<Map<String, String>> _orders = new List<Map<String, String>>();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _OldPasswordTextController =
      new TextEditingController();
  TextEditingController _passwordTextController = new TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final Utils _utils = new Utils();

  ScrollController _scrollController = ScrollController();
  
  var _loading = true;
  var _orderCount = -1;

  bool moreNotificationAvailable = true;
  bool gettingMoreNotification = false;
  String lastNotificationId = null;

  @override
  Widget build(BuildContext context) {
    return Page(
      controller: _scrollController,
      appBar: RegularAppBar(
        elevation: _utils.elevation,
        brightness: Brightness.light,
        backgroundColor: _utils.colors['appBar'],
        iconTheme: IconThemeData(color: _utils.colors['appBarIcons']),
        title: Text(
          "Notifications",
          style: TextStyle(color: _utils.colors['appBarText']),
        ),
      ),
      children: <Widget>[
        this._loading
            ? PageItem(
                child: SpinKitCircle(
                  color: _utils.colors['theme'],
                ),
              )
            : PageList.builder(
                itemCount: this._orders.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {},
                    child: RequestItem(
                      notificationId: _orders[i]['id'].toString(),
                      prod_name: _orders[i]['productName'].toString(),
                      prod_price: _orders[i]['prodPrice'].toString(),
                      prod_image: _orders[i]["productImage"].toString(),
                      order_time: _orders[i]['dateTime'].toString(),
                      prod_quantity: _orders[i]['quantity'].toString(),
                      prod_size : _orders[i]['size'].toString(),
                      updateNotifications : this.updateNotifications
                    ),
                  );
                }),
        this._orderCount == 0
            ? PageItem(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "No Notification Found",
                        style: TextStyle(
                            color: _utils.colors['searchBarIcons'],
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    )),
              )
            : PageItem(
                child: Text(""),
              )
      ],
    );
  }

  void updateNotifications(String notificationId){
    // print('Hello World');
    for(var i = 0; i < this._orders.length; i++){
      if(this._orders[i]['id'] == notificationId){
        setState(() {
          this._orders.removeAt(i);
        });
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    this._notificationController.getN(8).then((orders) {
      debugPrint(orders.toString());
      this.lastNotificationId = orders[orders.length - 1]['id'];
      setState(() {
        this._orders = orders;
        this._loading = false;
        this._orderCount = orders.length;
      });
    });

    _scrollController.addListener((){
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.25;

      if(maxScroll - currentScroll <= delta){
        getMoreNotifications();
      }
    });
  }

  getMoreNotifications(){
    if(moreNotificationAvailable){
      if(gettingMoreNotification == true) return;
      print('getting more notifications....');
      gettingMoreNotification = true;
      this._notificationController.getNNext(8, this.lastNotificationId).then((orders) {
        debugPrint(orders.toString());
        this._orders.addAll(orders);
        this.lastNotificationId = orders[orders.length - 1]['id'];
        if(orders.length < 8){
          this.moreNotificationAvailable = false;
        }
        // this._orders.sort((a,b){
        //   return b['dateTime'].compareTo(a['dateTime']);
        // });
        setState(() {
          this._orderCount = orders.length;
        });
        this.gettingMoreNotification = false;
      });
    }else{
      print('no more');
    }
  }
}
