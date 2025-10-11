import 'package:flutter/material.dart';

import 'Verify_OTP.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController emailcontroller  = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:AppBar(
          backgroundColor: Colors.white,
          title: Text('Forget Password',style: TextStyle(color: Colors.blue.shade600),),
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,color: Colors.blue.shade600,)),
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 40),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Reset Password',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                  SizedBox(height:10,),
                  Text('Enter your email address to receive OTP '),
                  SizedBox(height: 40,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

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
                          prefixIcon: Icon(Icons.email,color: Colors.blue.shade500,)
                        ),
                      ),
                      SizedBox(height: 30,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            )
                          ),
                            onPressed: (){
                              if(_formkey.currentState!.validate()){
                                Navigator.push(context, MaterialPageRoute(builder: (_) => VerifyOtp()));
                              }
                            },
                            child: Text('Send OTP',style: TextStyle(color: Colors.white,fontSize: 18),)),
                      ),

                      SizedBox(height: 10,),

                      TextButton(
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text('Back to Login',style: TextStyle(color: Colors.blue.shade500),))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
