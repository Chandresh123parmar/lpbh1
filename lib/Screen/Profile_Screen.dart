import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:lpbh1/Api/API_Service.dart';
import 'package:lpbh1/Model/Logout_Model.dart';
import 'package:http/http.dart' as http;
import 'package:lpbh1/Screen/Auth/Edit_Profile.dart';
import 'package:lpbh1/Screen/Auth/Login_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Profile',style: TextStyle(fontWeight: FontWeight.w500),),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade400,
                    radius: 50,
                    backgroundImage: AssetImage('assets/Images/logo.png'),
                  ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfile()));
                      },
                      child: Container(
                        height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white,width: 2)
                          ),
            
                          child: Icon(Icons.edit,color: Colors.white,size: 22,)),
                    ),
                  ]
                ),
                Text('Chandresh',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                Text('chandresh100@gmail.com',style: TextStyle(fontSize: 15,color: Colors.grey.shade600),),

                Padding(
                  padding: EdgeInsets.only(left: 8,top: 30,bottom: 5 ),
                  child: Row(
                    children: [
                      Text('ACCOUNT',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
                    ],
                  ),
                ),

                Card(
                  elevation: 2,
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.person_outline_rounded),
                    title: Text('Edit Profile',style: TextStyle(fontWeight: FontWeight.w500),),
                    trailing: IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfile()));
                        },
                        icon: Icon(Icons.keyboard_arrow_right_outlined,color: Colors.grey.shade500,)),
            
                  ),
                ),
                Card(
                  elevation: 2,
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.lock_outline),
                    title: Text('Change Password',style: TextStyle(fontWeight: FontWeight.w500),),
                    trailing: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.keyboard_arrow_right_outlined,color: Colors.grey.shade500,)),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8,top: 10,bottom: 5),
                  child: Row(
                    children: [
                      Text('SETTINGS',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                    ],
                  ),
                ),

                Card(
                  elevation: 2,
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.info_outlined),
                    title: Text('About',style: TextStyle(fontWeight: FontWeight.w500),),
                    trailing: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.keyboard_arrow_right_outlined,color: Colors.grey.shade500,)),
            
                  ),
                ),
                Card(
                  elevation:2,
                  color: Colors.white,
                  child: ListTile(
                    leading: Icon(Icons.quick_contacts_mail_outlined),
                    title: Text('Contact Us',style: TextStyle(fontWeight: FontWeight.w500),),
                    trailing: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.keyboard_arrow_right_outlined,color: Colors.grey.shade500,)),
                  ),
                ),

                SizedBox(height: 30,),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                      onPressed: ()async{
                        builedMyNavBar(context);
                      },
                      icon: Icon(Icons.login_outlined,color: Colors.white,size: 29,),
                      label: Text('Logout',style: TextStyle(color: Colors.white,fontSize: 18),),
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor: Colors.blue.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }

Future builedMyNavBar(BuildContext context){
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Logout'),
            content: Text('Logged out your account'),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, child: Text('Close',style: TextStyle(color: Colors.red.shade300),)),
              TextButton(
                  onPressed: ()async{
                    logoutprofile();
                    SharedPreferences pref = await SharedPreferences.getInstance();
                    await pref.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Logout Successful', style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.blue,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(10),
                      ),
                    );
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));

                  },
                  child: Text('Logout',style: TextStyle(color: Colors.blue.shade400),))
            ],

          );
        }
        );
}

  Future<LogoutModel> logoutprofile()async{
    final response = await http.post(Uri.parse(ApiUrl.logout));
    if(response.statusCode == 200){
      print(response.body);
      print(response.statusCode);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      return LogoutModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);

    }else{
      throw Exception('Failed to load logout api');
    }
  }


}
