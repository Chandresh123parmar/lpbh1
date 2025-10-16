import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lpbh1/Api/API_Service.dart';
import 'package:lpbh1/Model/forget_Password_Model/resetPasswordModel.dart';
import 'Login_Screen.dart';

class ChangePassword extends StatefulWidget {
  final String? emailId;
  final String? otp;

  const ChangePassword({super.key, this.emailId, this.otp});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController newPasswordcontroller = TextEditingController();
  final TextEditingController confirmPasswordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;

  bool hidePassword = true;
  bool hidePassword1 = true;

  // ✅ Reset Password API (without old password)
  Future<resetPasswordModel> resetapi(
      String email,
      String otp,
      String newpassword,
      String newpasswordConfirmation
      ) async {
    final response = await http.post(
      Uri.parse(ApiUrl.reset_password),
      body: {
        'email': email,
        'otp': otp,
        'old_password' : '',
        'new_password': newpassword,
        'new_password_confirmation': newpasswordConfirmation,
      },
    );

    print('Reset Password Response: ${response.body}');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return resetPasswordModel.fromJson(data);
    } else {
      throw Exception('Failed to reset password');
    }
  }

  void _resetPassword() async {
    if (_formkey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await resetapi(
          widget.emailId.toString(),
          widget.otp.toString(),
          newPasswordcontroller.text.trim(),
          confirmPasswordcontroller.text.trim(),
        );

        setState(() {
          _isLoading = false;
        });

        if (response.status == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message ?? 'Password reset successfully')),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(response.message ?? 'Invalid OTP or Email')),
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
            'Reset Password',
            style: TextStyle(color: Colors.blue, fontSize: 22),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.blue),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Set your new password',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: height * 0.06),

                  // 🔒 New Password
                  TextFormField(
                    controller: newPasswordcontroller,
                    obscureText: hidePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a new password';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: 'New Password',
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.blue),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          hidePassword = !hidePassword;
                        }),
                        icon: Icon(
                          hidePassword ? Icons.visibility_off : Icons.visibility,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  // 🔒 Confirm Password
                  TextFormField(
                    controller: confirmPasswordcontroller,
                    obscureText: hidePassword1,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter confirm password';
                      } else if (value != newPasswordcontroller.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: 'Confirm Password',
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.blue),
                      suffixIcon: IconButton(
                        onPressed: () => setState(() {
                          hidePassword1 = !hidePassword1;
                        }),
                        icon: Icon(
                          hidePassword1 ? Icons.visibility_off : Icons.visibility,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.05),

                  // ✅ Reset Password Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _resetPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: _isLoading
                          ? SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                          : Text('Reset Password',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
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
