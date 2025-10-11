class CategoryBusinessList {
  bool? status;
  String? message;
  List<Data>? data;

  CategoryBusinessList({this.status, this.message, this.data});

  CategoryBusinessList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? bussinessName;
  String? bussinessCategory;
  String? ownerName;
  String? address;
  String? mobile;
  String? email;
  String? websiteUrl;
  String? bussinessDetails;
  String? bussinessCard;
  String? lcBirthCertificate;
  String? referenceses;
  String? partnersProprietor;
  String? partnerName;
  String? partnerMobno;
  int? status;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.userId,
        this.bussinessName,
        this.bussinessCategory,
        this.ownerName,
        this.address,
        this.mobile,
        this.email,
        this.websiteUrl,
        this.bussinessDetails,
        this.bussinessCard,
        this.lcBirthCertificate,
        this.referenceses,
        this.partnersProprietor,
        this.partnerName,
        this.partnerMobno,
        this.status,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    bussinessName = json['bussiness_name'];
    bussinessCategory = json['bussiness_category'];
    ownerName = json['owner_name'];
    address = json['address'];
    mobile = json['mobile'];
    email = json['email'];
    websiteUrl = json['website_url'];
    bussinessDetails = json['bussiness_details'];
    bussinessCard = json['bussiness_card'];
    lcBirthCertificate = json['lc_birth_certificate'];
    referenceses = json['referenceses'];
    partnersProprietor = json['partners_proprietor'];
    partnerName = json['partner_name'];
    partnerMobno = json['partner_mobno'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['bussiness_name'] = this.bussinessName;
    data['bussiness_category'] = this.bussinessCategory;
    data['owner_name'] = this.ownerName;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['website_url'] = this.websiteUrl;
    data['bussiness_details'] = this.bussinessDetails;
    data['bussiness_card'] = this.bussinessCard;
    data['lc_birth_certificate'] = this.lcBirthCertificate;
    data['referenceses'] = this.referenceses;
    data['partners_proprietor'] = this.partnersProprietor;
    data['partner_name'] = this.partnerName;
    data['partner_mobno'] = this.partnerMobno;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
