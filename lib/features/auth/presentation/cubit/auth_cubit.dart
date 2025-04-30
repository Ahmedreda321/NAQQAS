import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/auth_service.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/services/logger_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> authWithGoogle() async {
    emit(AuthLoading());

    final user = await AuthService.signInWithGoogle();

    if (user == null) {
      emit(const AuthFailure("Login failed"));
      return;
    }

    final auth = await user.authentication;
    AppLogger.e("🚨🚨🚨🚨🚨🚨Token: ${auth.idToken}");

    await LocalStorageService.saveToken(auth.idToken ?? '');

    emit(AuthSuccess());
  }
}
