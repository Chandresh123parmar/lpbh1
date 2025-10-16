class forgetModel {
  bool? status;
  String? message;
  int? userId;
  String? otp;

  forgetModel({this.status, this.message, this.userId, this.otp});

  forgetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userId = json['user_id'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['otp'] = this.otp;
    return data;
  }
}
