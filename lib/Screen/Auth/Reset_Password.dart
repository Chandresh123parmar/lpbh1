import 'package:flutter/material.dart';

import 'Login_Screen.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  bool hidePassword = true;
  bool hidePassword1 = true;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Reset Password',style: TextStyle(color: Colors.blue,fontSize: 25),),
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              }, 
              icon: Icon(Icons.arrow_back,color: Colors.blue,)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration:BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.blue.shade500)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline_outlined,color: Colors.blue.shade700,),
                          SizedBox(width: 10,),
                          Text('Enter your current password and \nset a new password to reset your \naccount password',style: TextStyle(color: Colors.blue),),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.07,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter a new password';
                      }else if(value.length < 8){
                        return 'Password must be at least 8 characters';
                      }else{
                        return null;
                      }
                    },
                    controller: newPassword,
                    obscureText: hidePassword,
                    keyboardType: TextInputType.visiblePassword,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        hintText: 'New Password',
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        labelText: 'New Password',
                        labelStyle: TextStyle(color:Colors.black),
                        prefixIcon: Icon(Icons.lock_outline,color: Colors.blue.shade500,),
                        suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                hidePassword = !hidePassword;
                              });
                            },
                            icon: Icon(hidePassword ? Icons.visibility_off : Icons.visibility,color: Colors.blue.shade500,))
                    ),
                  ),
                  SizedBox(height: height * 0.02,),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter a confirm password';
                      }else if(value != newPassword.text){
                        return 'Password do not match';
                      }else{
                        return null;
                      }
                    },
                    controller: confirmPassword,
                    obscureText: hidePassword1,
                    keyboardType: TextInputType.visiblePassword,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        hintText: 'Confirm Password',
                        hintStyle: TextStyle(color: Colors.grey.shade600),
                        labelText: 'Confirm Password',
                        labelStyle: TextStyle(color:Colors.black),
                        prefixIcon: Icon(Icons.lock_outline,color: Colors.blue.shade500,),
                        suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                hidePassword1 = !hidePassword1;
                              });
                            },
                            icon: Icon(hidePassword1 ? Icons.visibility_off : Icons.visibility,color: Colors.blue.shade500,))
                    ),
                  ),
                  SizedBox(height: height * 0.04,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            backgroundColor: Colors.blue
                        ),
                        onPressed: (){
                          if(_formkey.currentState!.validate()){
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    margin: EdgeInsets.all(10),
                                    duration: Duration(seconds: 1),
                                    content: Text('Successfully changed Password ✅'))
                            );
                            Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                          }
                        },
                        child: Text('Reset Password',style: TextStyle(color: Colors.white,fontSize: 18),)),
                  ),
                  SizedBox(height: 10,),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(
                          color: Colors.blue,
                          width: width * 0.002
                        )
                      ),
                        onPressed: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));

                        },
                        child: Text('Cancel',style: TextStyle(color:Colors.blue,fontSize: 18,fontWeight: FontWeight.w500 ),)),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
