// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserData _$UserDataFromJson(Map<String, dynamic> json) {
  return UserData(
      address: json['address'] as String,
      award_integral: json['award_integral'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      email: json['email'] as String,
      gender: json['gender'] as String,
      id: json['id'] as String,
      integral: json['integral'] as String,
      is_old: json['is_old'] as String,
      language: json['language'] as String,
      member_level: json['member_level'] as String,
      money: json['money'] as String,
      nationality: json['nationality'] as String,
      phone: json['phone'] as String,
      profile_avatar: json['profile_avatar'] as String,
      province: json['province'] as String,
      realname: json['realname'] as String,
      special_money: json['special_money'] as String,
      username: json['username'] as String,
      wait_integral: json['wait_integral'] as String,
      waitdeliver: json['waitdeliver'] as int,
      waitpay: json['waitpay'] as int,
      zip_code: json['zip_code'] as String);
}

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'address': instance.address,
      'award_integral': instance.award_integral,
      'city': instance.city,
      'country': instance.country,
      'email': instance.email,
      'gender': instance.gender,
      'id': instance.id,
      'integral': instance.integral,
      'is_old': instance.is_old,
      'language': instance.language,
      'member_level': instance.member_level,
      'money': instance.money,
      'nationality': instance.nationality,
      'phone': instance.phone,
      'profile_avatar': instance.profile_avatar,
      'province': instance.province,
      'realname': instance.realname,
      'special_money': instance.special_money,
      'username': instance.username,
      'wait_integral': instance.wait_integral,
      'waitdeliver': instance.waitdeliver,
      'waitpay': instance.waitpay,
      'zip_code': instance.zip_code
    };
