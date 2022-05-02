
class OSSPolicyModel {
  String? accessKeyId;
  String? policy;
  String? signature;
  String? expire;
  String? dir;
  String? host;
  String? callback;

  OSSPolicyModel(
      {this.accessKeyId,
        this.policy,
        this.signature,
        this.expire,
        this.dir,
        this.host,
        this.callback});

  OSSPolicyModel.fromJson(Map<String, dynamic> json) {
    accessKeyId = json['accessKeyId'];
    policy = json['policy'];
    signature = json['signature'];
    expire = json['expire'];
    dir = json['dir'];
    host = json['host'];
    callback = json['callback'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessKeyId'] = this.accessKeyId;
    data['policy'] = this.policy;
    data['signature'] = this.signature;
    data['expire'] = this.expire;
    data['dir'] = this.dir;
    data['host'] = this.host;
    data['callback'] = this.callback;
    return data;
  }
}
