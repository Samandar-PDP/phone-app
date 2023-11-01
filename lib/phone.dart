class Phone {
  int? id;
  String phoneName;
  String phoneDetail;

  Phone(this.id, this.phoneName, this.phoneDetail);

  Phone.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        phoneName = json['phone_name'],
        phoneDetail = json['phone_detail'];

  Map<String, dynamic> toJson() {
    return {'id': id, 'phone_name': phoneName, 'phone_detail': phoneDetail};
  }
}
