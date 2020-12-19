import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'seed.freezed.dart';
@freezed
abstract class Seed implements _$Seed {
  const Seed._();

  const factory Seed({
    @required String value,
    @required Duration timeLeft,
  }) = _Seed;

  factory Seed.empty() => const Seed(
        value: '',
        timeLeft:  Duration(),
      );


}
