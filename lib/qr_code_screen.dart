import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'application/send_gen_bloc/seed_gen_bloc.dart';
import 'core/my_cache.dart';
import 'injection.dart';

class QRCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<SeedGenBloc>()..add(const SeedGenEvent.getSeed()),
      child: const QRCodeBody(),
    );
  }
}

class QRCodeBody extends StatelessWidget {
  const QRCodeBody();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final Persistence cache = getIt<Persistence>();
    CountdownController countdownController;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('QR Code'),
      ),
      body: BlocBuilder<SeedGenBloc, SeedGenState>(
          builder: (context, state) => state.map(
                fetchingSeed: (e) =>
                    const Center(child: CircularProgressIndicator()),
                fetchFailed: (e) {
                  //let try to fetch after 15sec
                  Future.delayed(const Duration(seconds: 15), () {
                    context
                        .bloc<SeedGenBloc>()
                        .add(const SeedGenEvent.getSeed());
                  });
                  return Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      QrImage(
                        data: cache.getCachedSeed,
                        version: QrVersions.auto,
                        // embeddedImage: AssetImage(),
                        size: size.width * 0.57,
                        embeddedImageStyle: QrEmbeddedImageStyle(
                          size: Size(size.width * 0.08, size.width * 0.08),
                        ),
                      ),
                      Text('Cached Seed',
                          style: TextStyle(color: Colors.red[200])),
                    ],
                  ));
                },
                fetchSuccess: (e) {
                  // Let's save a copy of seed to cache
                  cache.setSeed(e.seed.value);
                  countdownController =
                      CountdownController(duration: e.seed.timeLeft)..start();

                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        QrImage(
                          data: e.seed.value,
                          version: QrVersions.auto,
                          // embeddedImage: AssetImage(),
                          size: size.width * 0.57,
                          embeddedImageStyle: QrEmbeddedImageStyle(
                            size: Size(size.width * 0.08, size.width * 0.08),
                          ),
                        ),
                        Countdown(
                            countdownController: countdownController,
                            builder: (context, time) {
                              if (time.inSeconds <= 0) {
                                context
                                    .bloc<SeedGenBloc>()
                                    .add(const SeedGenEvent.getSeed());
                                countdownController?.stop();
                              }

                              return Text("${time.inSeconds}s");
                            }),
                        // Text('${timer.value}
                      ],
                    ),
                  );
                },
              )),
    );
  }
}
