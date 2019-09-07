import "package:flutter/material.dart";
import 'package:local_market/components/circular_loading_button.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController _userNameController = new TextEditingController();
  TextEditingController _userPhoneNumberController = new TextEditingController();
  TextEditingController _userAddressController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    this._userNameController.text = "John Smith";
    this._userPhoneNumberController.text = "7692909306";
    this._userAddressController.text = "Qtr. no. 81 Tilak Nagar";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          _userNameController.text,
          style: TextStyle(color: Colors.white),
        ),
        // elevation: 0.1,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: ListTile(
            //     title: TextFormField(
            //       enabled: false,
            //       textAlign: TextAlign.left,
            //       decoration: InputDecoration(hintText: "User Name", border: InputBorder.none),
            //       controller: _userNameController,
            //     ),
            //   ),
            // ),

            ListTile(
              title: TextFormField(
                enabled: false,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    hintText: "User Name",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.person)),
                controller: _userNameController,
              ),
            ),

            ListTile(
              title: TextFormField(
                // enabled: false,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    hintText: "Phone Number",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.phone)),
                controller: _userPhoneNumberController,
              ),
            ),

            ListTile(
              title: TextFormField(
                // enabled: false,
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                    hintText: "Address",
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.location_city)),
                controller: _userAddressController,
              ),
            ),

            Padding(padding: const EdgeInsets.all(10.0),
              child: FlatButton(child: Text("Save"), onPressed: () {
                print("Saving: "+_userPhoneNumberController.text+", "+_userAddressController.text);
              }, splashColor: Colors.white60, color: Colors.blue, textTheme: ButtonTextTheme.primary,),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(
            //     bottom: 10.0,
            //     left: 10.0,
            //     right: 10.0
            //   ),
            //   child: ListTile(
            //     title: TextFormField(
            //       // enabled: false,
            //       textAlign: TextAlign.left,
            //       decoration: InputDecoration(hintText: "User Name"),
            //       controller: _userNameController,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
