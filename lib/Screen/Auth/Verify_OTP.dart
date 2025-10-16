import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lpbh1/Api/API_Service.dart';
import 'package:lpbh1/Model/forget_Password_Model/verify_OTP_Model.dart';
import 'package:pinput/pinput.dart';
import 'Reset_Password.dart';

class VerifyOtp extends StatefulWidget {
  final int? userId;
  final String? emailId;
  final String? otp; // from forget API response

  const VerifyOtp({super.key, this.userId, this.otp, this.emailId});

  @override
  State<VerifyOtp> createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  bool _isLoading = false;

  //  API call for Verify OTP
  Future<verifyotpModel> verifyAPi(String userId,String email, String otp) async {
    final response = await http.post(
      Uri.parse(ApiUrl.otp_verify),
      body: {
        'user_id': userId,
        'email' : email,
        'otp': otp,
      },
    );

    print('Verify OTP Response: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return verifyotpModel.fromJson(data);
    } else {
      throw Exception('Failed to verify OTP');
    }
  }


  void _verifyOtp() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await verifyAPi(
          widget.userId.toString(),
          widget.emailId.toString(),
          otpController.text.trim(),
        );

        setState(() {
          _isLoading = false;
        });

        if (response.status == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message ?? 'OTP Verified Successfully')),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => ChangePassword(
                emailId: widget.emailId,
                otp: otpController.text.trim(),
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message ?? 'Invalid OTP')),
          );
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

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
          title: Text(
            'Verify OTP',
            style: TextStyle(color: Colors.blue.shade600),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.blue.shade600),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter OTP',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Text("We sent a 6-digit code to your email"),
                  SizedBox(height: height * 0.07),

                  // 🔢 OTP Input Field
                  Center(
                    child: Pinput(
                      controller: otpController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter OTP';
                        }
                        if (value.length < 6) {
                          return 'Enter valid 6-digit OTP';
                        }
                        return null;
                      },
                      length: 6,
                      keyboardType: TextInputType.number,
                      showCursor: true,
                      defaultPinTheme: PinTheme(
                        width: width * 0.13,
                        height: height * 0.07,
                        textStyle: TextStyle(fontSize: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200,
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        height: height * 0.07,
                        width: width * 0.13,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.04),

                  // ✅ Verify OTP Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _isLoading ? null : _verifyOtp,
                      child: _isLoading
                          ? SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                          : Text(
                        'Verify OTP',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Resend OTP in 59 seconds',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
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
