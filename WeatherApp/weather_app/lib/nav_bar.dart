
import 'package:flutter/material.dart';
class NavBar extends StatelessWidget {
  const NavBar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
         UserAccountsDrawerHeader(
          accountName: Text('ElBucze', style: TextStyle(color: Colors.grey[100]),),
          accountEmail: Text('buczek2711@gmail.com',style: TextStyle(color: Colors.grey[100]),),
          currentAccountPicture: CircleAvatar(
            child: ClipOval(
              child: Image.network('https://icon-library.com/images/avatar-icon-images/avatar-icon-images-4.jpg',
              width: 90,
              height:90,
              fit: BoxFit.cover,
              
              ),
            ),
          ),
          decoration: BoxDecoration(
            color: Colors.grey[800],
          ),
          ),

          TextButton(
            onPressed: (){}, 
            child: Text('Clear all',style: TextStyle(color: Colors.grey[800]),),
            )
        ],
      ),
      
    );
  }
}