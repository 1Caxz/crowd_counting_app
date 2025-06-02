import '../entities/user.dart';
import '../../core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login(String email, String password);
}
