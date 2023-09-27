class UserModel {
  User? user;
  String? message;
  String? statusCode;

  UserModel({this.user, this.message, this.statusCode});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    message = json['message'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    return data;
  }
}

class User {
  int? id;
  String? type;
  String? name;
  String? employeeId;
  String? email;
  String? mobile;
  String? gender;
  String? dob;
  int? shift;
  int? workLocation;
  String? extraWorkStatus;
  String? designation;
  int? salary;
  String? address;
  String? postalAddress;
  String? workAddress;
  String? taxNumber;
  String? bankName;
  String? ifscCode;
  String? bankAccount;
  String? upiId;
  String? status;
  String? photo;
  String? sign;
  String? createdAt;
  String? workLocationName;
  String? workLocationAddress;
  String? workLocationV4;
  String? workLocationV6;
  String? workLocationBroadcast;
  String? workLocationSubmask;

  User(
      {this.id,
        this.type,
        this.name,
        this.employeeId,
        this.email,
        this.mobile,
        this.gender,
        this.dob,
        this.shift,
        this.workLocation,
        this.extraWorkStatus,
        this.designation,
        this.salary,
        this.address,
        this.postalAddress,
        this.workAddress,
        this.taxNumber,
        this.bankName,
        this.ifscCode,
        this.bankAccount,
        this.upiId,
        this.status,
        this.photo,
        this.sign,
        this.createdAt,
        this.workLocationName,
        this.workLocationAddress,
        this.workLocationV4,
        this.workLocationV6,
        this.workLocationBroadcast,
        this.workLocationSubmask});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
    employeeId = json['employee_id'];
    email = json['email'];
    mobile = json['mobile'];
    gender = json['gender'];
    dob = json['dob'];
    shift = json['shift'];
    workLocation = json['work_location'];
    extraWorkStatus = json['extra_work_status'];
    designation = json['designation'];
    salary = json['salary'];
    address = json['address'];
    postalAddress = json['postal_address'];
    workAddress = json['work_address'];
    taxNumber = json['tax_number'];
    bankName = json['bank_name'];
    ifscCode = json['ifsc_code'];
    bankAccount = json['bank_account'];
    upiId = json['upi_id'];
    status = json['status'];
    photo = json['photo'];
    sign = json['sign'];
    createdAt = json['created_at'];
    workLocationName = json['work_location_name'];
    workLocationAddress = json['work_location_address'];
    workLocationV4 = json['work_location_v4'];
    workLocationV6 = json['work_location_v6'];
    workLocationBroadcast = json['work_location_broadcast'];
    workLocationSubmask = json['work_location_submask'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['employee_id'] = this.employeeId;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['shift'] = this.shift;
    data['work_location'] = this.workLocation;
    data['extra_work_status'] = this.extraWorkStatus;
    data['designation'] = this.designation;
    data['salary'] = this.salary;
    data['address'] = this.address;
    data['postal_address'] = this.postalAddress;
    data['work_address'] = this.workAddress;
    data['tax_number'] = this.taxNumber;
    data['bank_name'] = this.bankName;
    data['ifsc_code'] = this.ifscCode;
    data['bank_account'] = this.bankAccount;
    data['upi_id'] = this.upiId;
    data['status'] = this.status;
    data['photo'] = this.photo;
    data['sign'] = this.sign;
    data['created_at'] = this.createdAt;
    data['work_location_name'] = this.workLocationName;
    data['work_location_address'] = this.workLocationAddress;
    data['work_location_v4'] = this.workLocationV4;
    data['work_location_v6'] = this.workLocationV6;
    data['work_location_broadcast'] = this.workLocationBroadcast;
    data['work_location_submask'] = this.workLocationSubmask;
    return data;
  }
}
