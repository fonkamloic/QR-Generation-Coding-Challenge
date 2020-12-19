import 'package:dartz/dartz.dart';

import 'seed.dart';
import 'seed_failure.dart';


abstract class ISeedGenFacade {
  Future<Either<SeedFailure, Seed>> getNewSeed();
}