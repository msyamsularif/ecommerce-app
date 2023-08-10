import 'package:bloc/bloc.dart';
import 'package:ecommerce_app/models/user_model.dart';
import 'package:equatable/equatable.dart';

import 'package:ecommerce_app/services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authService)
      : super(const AuthState(authStatus: AuthStatus.initial));

  final AuthService _authService;

  void register({
    required String name,
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      emit(state.copyWith(authStatus: AuthStatus.loading));

      UserModel user = await _authService.register(
        name: name,
        username: username,
        email: email,
        password: password,
      );

      emit(state.copyWith(authStatus: AuthStatus.register, user: user));
    } catch (e) {
      emit(const AuthState(authStatus: AuthStatus.failed));
    }
  }

  void login({
    required String email,
    required String password,
  }) async {
    try {
      emit(state.copyWith(authStatus: AuthStatus.loading));

      UserModel user = await _authService.login(
        email: email,
        password: password,
      );

      emit(state.copyWith(authStatus: AuthStatus.login, user: user));
    } catch (e) {
      emit(const AuthState(authStatus: AuthStatus.failed));
    }
  }
}
