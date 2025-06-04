import 'package:dartz/dartz.dart';
import '../../core/error/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;

  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<Failure, User>> register(
    String name,
    String email,
    String password,
  ) async {
    try {
      final user = await authDataSource.register(name, email, password);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      final user = await authDataSource.login(email, password);
      return Right(user);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
