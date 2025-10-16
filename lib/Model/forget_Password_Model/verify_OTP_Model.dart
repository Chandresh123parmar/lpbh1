class verifyotpModel {
  bool? status;
  String? message;
  String? emailId;
  int? userId;

  verifyotpModel({this.status, this.message, this.emailId, this.userId});

  verifyotpModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    emailId = json['email_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['email_id'] = this.emailId;
    data['user_id'] = this.userId;
    return data;
  }
}
