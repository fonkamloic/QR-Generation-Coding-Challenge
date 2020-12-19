import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:qr_challenge/domain/i_send_gen_facade.dart';
import 'package:qr_challenge/domain/seed.dart';
import 'package:qr_challenge/domain/seed_failure.dart';

part 'seed_gen_bloc.freezed.dart';
part 'seed_gen_event.dart';
part 'seed_gen_state.dart';

@injectable
class SeedGenBloc extends Bloc<SeedGenEvent, SeedGenState> {
  final ISeedGenFacade iSeedGenFacade;
  SeedGenBloc(
    this.iSeedGenFacade,
  ) : super(const SeedGenState.fetchingSeed());

  @override
  Stream<SeedGenState> mapEventToState(SeedGenEvent gEvent) async* {
    yield* gEvent.map(
      getSeed: (e) async* {
        yield const SeedGenState.fetchingSeed();
        final Either<SeedFailure, Seed> failureOrSeed =
            await iSeedGenFacade.getNewSeed();

        yield failureOrSeed.fold(
          (l) => SeedGenState.fetchFailed(failure: l),
          (r) => SeedGenState.fetchSuccess(seed: r),
        );
      },
    );
  }
}
