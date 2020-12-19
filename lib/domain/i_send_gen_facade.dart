import 'package:dartz/dartz.dart';
import 'package:qr_challenge/domain/seed.dart';
import 'package:qr_challenge/domain/seed_failure.dart';


abstract class ISeedGenFacade {
  Future<Either<SeedFailure, Seed>> getNewSeed();
}