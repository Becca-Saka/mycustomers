import 'package:json_annotation/json_annotation.dart';

import 'hive/store/store_h.dart';

part 'store.g.dart';

@JsonSerializable(nullable: true, includeIfNull: true)
class Store {

  Store(this.id, this.email, this.phone, this.tagline, this.address);

  @JsonKey(name: '_id')
  String id;

  String email, tagline;

  @JsonKey(name: 'phone_number')
  String phone;

  @JsonKey(name: 'shop_address')
  String address;

  @JsonKey(name: 'store_name')
  String name;


  factory Store.fromStoreH(StoreH store) => Store(
      store.id,
      // TODO: Add email field to the store hive model
      'email@email.com',
      '${store.ctyCode}${store.pNum}',
      store.tagline,
      store.address,
    );
  factory Store.fromJson(Map<String, dynamic> json) => _$StoreFromJson(json);
  Map<String, dynamic> toJson() => _$StoreToJson(this);
}