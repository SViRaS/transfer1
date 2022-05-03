import 'package:flutter/material.dart';
import 'package:flutter_application_6/models/user.dart';

class UserInfo extends StatelessWidget {
  User userInfo;
  UserInfo(this.userInfo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
        centerTitle: true,
      ),
      body: Card(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                '${userInfo.name!.isEmpty ? null : userInfo.name}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text('${userInfo.job}'),
              leading: Icon(Icons.person, color: Colors.black),
              trailing: Text('${userInfo.job!.isEmpty ? null : userInfo.job}'),
            ),
            ListTile(
              title: Text(
                '${userInfo.phone!.isEmpty ? null : userInfo.phone}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(Icons.phone, color: Colors.black),
            ),
            ListTile(
              title: Text(
                '${userInfo.email!.isEmpty ? null : userInfo.email}',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              leading: Icon(Icons.mail, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
