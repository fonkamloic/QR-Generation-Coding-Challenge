import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/seed.dart';

part 'seed_dtos.freezed.dart';

@freezed
abstract class SeedDto implements _$SeedDto {
  const SeedDto._();
  const factory SeedDto({
    @required String value,
    @required DateTime expires_at,
  }) = _SeedDto;

  Seed toDomain() {
    return Seed(
        value: value,
        timeLeft:
            Duration(seconds: expires_at.difference(DateTime.now()).inSeconds));
  }

  factory SeedDto.fromResponse(Response response) => SeedDto(
      value: response.body['seed'] as String,
      expires_at: DateTime.fromMillisecondsSinceEpoch(
          response.body['expires_at'] as int));
}
