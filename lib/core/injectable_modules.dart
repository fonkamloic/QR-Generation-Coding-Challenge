import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:injectable/injectable.dart';
import '../repository/qr_generator_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class MyInjectableModule {
  @preResolve
  Future<SharedPreferences> get sharedPreference =>
      SharedPreferences.getInstance();

  @lazySingleton
  DataConnectionChecker get connectionChecker => DataConnectionChecker();
  
  @lazySingleton
  QRGenService get qrGenService => QRGenService.create();
}
