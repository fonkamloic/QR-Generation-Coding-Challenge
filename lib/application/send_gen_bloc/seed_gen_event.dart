part of 'seed_gen_bloc.dart';

@freezed
@immutable
abstract class SeedGenEvent with _$SeedGenEvent {
  const factory SeedGenEvent.getSeed() = _InitializeToken;
}
