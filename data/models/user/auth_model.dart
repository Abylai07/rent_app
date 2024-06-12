import '../../../domain/entity/user/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    super.token,
    super.refreshToken,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      token: json['access'],
      refreshToken: json['refresh'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refresh'] = refreshToken;
    data['access'] = token;
    return data;
  }
}
