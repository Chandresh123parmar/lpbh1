import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../Api/API_Service.dart';
import '../../Model/registationmodel.dart';
import 'Login_Screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController numbercontroller = TextEditingController();
  final TextEditingController addresscontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  
  bool hidePassowrd = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20,right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text('Create Account',style: TextStyle(color: Colors.blue.shade600,fontSize: 28,fontWeight: FontWeight.w500),),

                  SizedBox(height: 20,),
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade300,
                    radius: 50,
                    child: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.camera_alt_rounded,size: 35,color: Colors.blue.shade400,),),
                  ),
                  SizedBox(height: 30,),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please enter your name ';
                      }else{
                        return null;
                      }
                    },
                    controller: namecontroller,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Full Name',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(Icons.person,color: Colors.blue.shade500,),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your email address';
                      }else{
                        return null;
                      }
                    },
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Email Address',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(Icons.email,color: Colors.blue.shade500,),
                    ),
                  ),
                  SizedBox(height: 20),

                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your password';
                      }else if(value.length < 8){
                        return 'Password must be at least 8 characters';
                      }else{
                        return null;
                      }
                    },
                    controller: passwordcontroller,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: hidePassowrd,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(Icons.lock,color: Colors.blue.shade500,),
                      suffixIcon: IconButton(
                          onPressed: (){
                            setState(() {
                              hidePassowrd = !hidePassowrd;
                            });
                          }, 
                          icon: Icon(hidePassowrd ? Icons.visibility_off : Icons.visibility,color: Colors.blue.shade500,))
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your Mobile number';
                      }else{
                        return null;
                      }
                    },
                    controller: numbercontroller,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Mobile Number',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(Icons.phone,color: Colors.blue.shade500,),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter address';
                      }else{
                        return null;
                      }
                    },
                    controller: addresscontroller,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Address',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(Icons.location_on_sharp,color: Colors.blue.shade500,),
                    ),
                  ),
                  SizedBox(height: 30,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue
                      ),
                        onPressed: (){
                          /*if(_formkey.currentState!.validate()){

                           // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                          }*/
                          login(
                              namecontroller.text.trim(),
                              emailcontroller.text.trim(),
                              passwordcontroller.text.trim(),
                              numbercontroller.text.trim(),
                              addresscontroller.text.trim()
                          );

                        },
                        child: Text('Register',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),)),
                  ),
                  SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('alredy create account?'),
                      TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text('Sign in',style: TextStyle(color: Colors.blue.shade400),))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<registatinModel> login(String namecontroller,String emailcontroller,String passwordcontroller,String numbercontroller,String addresscontroller)async{
    final response = await http.post(Uri.parse(ApiUrl.register),
        body: ({
            "name": namecontroller,
            "email": emailcontroller,
            "password": passwordcontroller,
            'mobile': numbercontroller,
            "address": addresscontroller,
            "image": "https://falgunigajjar.artologyplus.com/BussinessDialouge/images/registration/1759907410_image_68e60e52702d2.png",
        }
        ));
    if(response.statusCode == 200){
      Navigator.push(context, MaterialPageRoute(builder: (_) =>LoginScreen()));
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Signup successful',style: TextStyle(color: Colors.white),),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(),
            backgroundColor: Colors.redAccent.shade100,)
      );
      return registatinModel.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Signup unsuccessful',style: TextStyle(color: Colors.white),),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(),
            backgroundColor: Colors.redAccent.shade100,)
      );
      throw Exception('=========>>>>>>>>error');
    }
  }

}
