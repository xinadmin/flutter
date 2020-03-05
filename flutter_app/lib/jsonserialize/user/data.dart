import 'package:json_annotation/json_annotation.dart';

part 'data.g.dart';

@JsonSerializable()
class UserData {
  String address;
  String award_integral;
  String city;
  String country;
  String email;
  String gender;
  String id;
  String integral;
  String is_old;
  String language;
  String member_level;
  String money;
  String nationality;
  String phone;
  String profile_avatar;
  String province;
  String realname;
  String special_money;
  String username;
  String  wait_integral;
  int waitdeliver;
  int  waitpay;
  String zip_code;

  UserData({
    this.address,
    this.award_integral,
    this.city,
    this.country,
    this.email,
    this.gender,
    this.id,
    this.integral,
    this.is_old,
    this.language,
    this.member_level,
    this.money,
    this.nationality,
    this.phone,
    this.profile_avatar,
    this.province,
    this.realname,
    this.special_money,
    this.username,
    this.wait_integral,
    this.waitdeliver,
    this.waitpay,
    this.zip_code
  });

  //反序列化
  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
  //序列化
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
