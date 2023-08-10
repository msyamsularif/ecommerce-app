part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final UserModel? user;

  const AuthState({
    this.authStatus = AuthStatus.initial,
    this.user,
  });

  @override
  List<Object?> get props => [authStatus, user];

  AuthState copyWith({
    AuthStatus? authStatus,
    UserModel? user,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
  }
}

enum AuthStatus {
  initial,
  login,
  register,
  loading,
  failed,
  success,
}
