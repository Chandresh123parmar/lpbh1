import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'Reset_Password.dart';

class VerifyOtp extends StatefulWidget {
  const VerifyOtp({super.key});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:AppBar(
        backgroundColor: Colors.white,
          title: Text('Verify OTP',style: TextStyle(color: Colors.blue.shade600),),
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back,color: Colors.blue.shade600,)),
          centerTitle: true,
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 30),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Enter OTP',style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500),),
                  SizedBox(height: 10,),
                  Text("We sent a 6-digit code to "),
                  SizedBox(height: height * 0.07,),
                  Center(
                    child: Pinput(
                      validator: (value){
                        if(value!.isEmpty){
                          return '';
                        }
                      },
                      length: 6,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                        width: width * 0.13,
                          height: height * 0.07,
                          textStyle: TextStyle(fontSize: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          )),
                      focusedPinTheme: PinTheme(
                        height: height * 0.06,
                        width: width * 0.15,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.04,),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),
                          backgroundColor: Colors.blue
                        ),
                          onPressed: (){
                            if(_formkey.currentState!.validate()){
                              Navigator.push(context, MaterialPageRoute(builder: (_) => ChangePassword()));
                            }
                          },
                          child: Text('Verify OTP',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),)
                      ),
                    ),
                  ),
              
                  SizedBox(height: 20,),
                  Center(child: Text('Resend OTP in 59 seconds',style: TextStyle(color: Colors.grey.shade600),)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
