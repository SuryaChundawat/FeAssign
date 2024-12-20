

import 'package:dio/dio.dart';
import 'package:fe_assign/provider/login_provider.dart';
import 'package:fe_assign/provider/wallet_provider.dart';
import 'package:fe_assign/utils/app_constants.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasource/remote/dio/dio_client.dart';
import 'data/repository/login_repository.dart';

final sl = GetIt.instance;

Future<void> init() async{

  sl.registerLazySingleton(() => DioClient(AppConstants.baseUrl, sl()));
  sl.registerLazySingleton(() => LoginRepository(dioClient: sl()));

  sl.registerFactory(() => LoginProvider(loginRepository: sl()));
  sl.registerFactory(() => WalletProvider());

  //external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());

}