import 'package:event_booking/features/auth/domain/entities/user_entity.dart';

class AppSession {
  static final AppSession _instance = AppSession._internal();

  factory AppSession() {
    return _instance;
  }

  AppSession._internal();

  static UserEntity? currentUser;
}
