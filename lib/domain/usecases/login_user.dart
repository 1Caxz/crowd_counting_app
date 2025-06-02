import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import '../entities/user.dart';
import '../../core/error/failure.dart';

class LoginUser {
  final AuthRepository repository;
  LoginUser(this.repository);

  Future<Either<Failure, User>> call(String email, String password) {
    return repository.login(email, password);
  }
}
