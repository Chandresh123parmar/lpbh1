import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lpbh1/Api/API_Service.dart';
import 'package:lpbh1/Model/UserProfileModel.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Edit Profile',style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
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
                    onTap: (){},
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade400,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white,width: 2)
                      ),
                      child: Icon(Icons.camera_alt_rounded,color: Colors.white,size: 20,),
                    ),
                  )
                ],
              ),
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    hintText: 'Your Name',
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    labelText: 'Full Name',
                    labelStyle: TextStyle(color: Colors.grey.shade600,fontSize: 18),
                    prefixIcon: Icon(Icons.person_outline_rounded,color: Colors.blue.shade500,)
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      hintText: 'Your Email',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.grey.shade600,fontSize: 18),
                      prefixIcon: Icon(Icons.email_outlined,color: Colors.blue.shade500,)
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  controller: numberController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      hintText: 'Mobile Number',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      labelText: 'Mobile Number',
                      labelStyle: TextStyle(color: Colors.grey.shade600,fontSize: 18),
                      prefixIcon: Icon(Icons.phone_outlined,color: Colors.blue.shade500,)
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  maxLength: 100,
                  maxLines: 2,
                  controller: addressController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      hintText: 'Your Address',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      labelText: 'Address',
                      labelStyle: TextStyle(color: Colors.grey.shade600,fontSize: 18),
                      prefixIcon: Icon(Icons.location_on_outlined,color: Colors.blue.shade500,)
                  ),
                ),
              ),
              SizedBox(height: 25,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 3,
                      backgroundColor: Colors.blue.shade300,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                      onPressed: (){},
                      child: Text('Update Profile',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<UserProfileModel> updateprofileapi()async{
    final response = await http.post(Uri.parse(ApiUrl.user_edit));
    if(response.body == 200){
      print(response.body);
      print(response.statusCode);
      return UserProfileModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }else{
      throw Exception('Failed to load Edit Profile');
    }
  }
}
