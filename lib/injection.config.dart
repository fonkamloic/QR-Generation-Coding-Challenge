// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/i_send_gen_facade.dart';
import 'core/injectable_modules.dart';
import 'core/my_cache.dart';
import 'repository/qr_generator_service.dart';
import 'application/send_gen_bloc/seed_gen_bloc.dart';
import 'infrastructure/send_gen/send_gen_repository.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

Future<GetIt> $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) async {
  final gh = GetItHelper(get, environment, environmentFilter);
  final myInjectableModule = _$MyInjectableModule();
  gh.lazySingleton<DataConnectionChecker>(
      () => myInjectableModule.connectionChecker);
  gh.lazySingleton<QRGenService>(() => myInjectableModule.qrGenService);
  final sharedPreferences = await myInjectableModule.sharedPreference;
  gh.factory<SharedPreferences>(() => sharedPreferences);
  gh.lazySingleton<ISeedGenFacade>(() =>
      SeedGenRepository(get<QRGenService>(), get<DataConnectionChecker>()));
  gh.lazySingleton<Persistence>(() => Persistence(get<SharedPreferences>()));
  gh.factory<SeedGenBloc>(() => SeedGenBloc(get<ISeedGenFacade>()));
  return get;
}

class _$MyInjectableModule extends MyInjectableModule {}
