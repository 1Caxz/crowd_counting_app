import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/login_user.dart';
import 'domain/repositories/auth_repository.dart';
import 'data/datasources/auth_remote_datasource.dart';

final sl = GetIt.instance;

void init() {
  sl.registerLazySingleton(() => http.Client());

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: sl()),
  );

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );

  // Usecase
  sl.registerLazySingleton(() => LoginUser(sl()));
}
