class AddressInfoMode {
  String add_time;
  String address;
  String city;
  String consignee;
  String country;
  String id;
  String is_default;
  String phone;
  String province;
  String user_id;
  String zip_code;

  AddressInfoMode({
    add_time,
    address,
    city,
    consignee,
    country,
    id,
    is_default,
    phone,
    province,
    user_id,
    zip_code,
  });

  AddressInfoMode.fromJson(Map<String, dynamic> json) {
    add_time = json['add_time'];
    address = json['address'];
    city = json['city'];
    consignee = json['consignee'];
    country = json['country'];
    id = json['id'];
    is_default = json['is_default'];
    phone = json['phone'];
    province = json['province'];
    user_id = json['user_id'];
    zip_code = json['zip_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['add_time'] = this.add_time;
    data['address'] = this.address;
    data['city'] = this.city;
    data['consignee'] = this.consignee;
    data['country'] = this.country;
    data['is_default'] = this.is_default;
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['province'] = this.province;
    data['user_id'] = this.user_id;
    data['zip_code'] = this.zip_code;

    return data;
  }
}
