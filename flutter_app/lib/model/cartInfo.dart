class CartInfoMode {
  bool isCheck;

  String  goods_attr_value;
  String goods_image;
  int goods_number;
  String goods_price;
  String goods_pv;
  String goods_series_id;
  String goods_type;
  String id;
  String inventory_quantity;
  String is_selected;
  String is_shelve;
  String localeGoodsName;
  Map snap_up;

  CartInfoMode(
      {this.goods_attr_value,this.goods_image,this.goods_number,this.goods_price,this.goods_pv,
       this.isCheck, this.snap_up,this.goods_series_id,this.goods_type,this.id,this.inventory_quantity,this.is_selected,this.is_shelve,this.localeGoodsName,});

  CartInfoMode.fromJson(Map<String, dynamic> json) {
    goods_attr_value = json['goods_attr_value'];
    goods_image = json['goods_image'];

    goods_number = int.parse(json['goods_number'].toString());
    goods_price = json['goods_price'];
    goods_pv = json['goods_pv'];
    isCheck = json['isCheck'];
    snap_up = json['snap_up'];
    goods_series_id = json['goods_series_id'];
    goods_type = json['goods_type'];
    id = json['id'];
    inventory_quantity = json['inventory_quantity'];
    is_shelve = json['is_shelve'];
    is_selected = json['is_selected'];
    localeGoodsName = json['localeGoodsName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goods_attr_value'] = this.goods_attr_value;
    data['goods_image'] = this.goods_image;
    data['goods_number'] =this.goods_number;
    data['goods_price'] = this.goods_price;
    data['goods_pv'] = this.goods_pv;
    data['isCheck']= this.isCheck;
    data['snap_up']= this.snap_up;
    data['goods_series_id']= this.goods_series_id;
    data['goods_type']= this.goods_type;
    data['id']= this.id;
    data['inventory_quantity']= this.inventory_quantity;
    data['is_selected']= this.is_selected;
    data['is_shelve']= this.is_shelve;
    data['localeGoodsName']= this.localeGoodsName;

    return data;
  }
}