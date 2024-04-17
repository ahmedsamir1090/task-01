import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_app/cubit/download_state.dart';
import 'package:test_app/notification/notification_service.dart';

class DownloadCubit extends Cubit<DownloadStates> {
  DownloadCubit() : super(DownloadInitState());

  static DownloadCubit get(context) => BlocProvider.of(context);
  final dio = Dio();

  double progress = 0;
  CancelToken cancelToken = CancelToken();
  cancel() {
    progress = 0;
    emit(CancelDownloadState());
  }

  Future<String> _getFilePath(String filename) async {
    Directory? dir;

    try {
      dir = (await getApplicationDocumentsDirectory())!;
    } catch (err) {
      print("Cannot get download folder path $err");
    }
    return "${dir?.path}$filename";
  }

  Future<void> saveData() async {
    String fileUrl =
        "https://dw.uptodown.net/dwn/H2MLLadk07fGs-51hzOXMFuc__1UBAeyqzSGkuyseuUlY35PCZSX5xjtmHYHyIzefVh6NwskrHJ2eOfh1zfDQo7KrCE8F5vukKB3T2325mRJXmteDPQqu9U-5PIKZEtF/QdssiGxJdYhVQmsSg0EAJSderJk9Zu7G80ehlcGXWpEl9UVuqyzQ3HXyD_1-01T76Jy874Rxc8HFqJpL5LlPT2JuXi-pCeFnL6coVaJQNCtrtokq5hFz2Llt4ic1-0u3/O8gUoMumamsPzWcIAqvlzzV3-DR1_8T0mC8Y09xKCv6Mi4d2Q8GbN0fKZmrSJLhrsb20EXxexhGjlkDks0SMN11FJyq6k-ikOzGJGvRHGN4=/whatsapp-messenger-2-24-9-12.apk";

    await dio.download(
        fileUrl, await _getFilePath('whatsapp-messenger-2-24-9-12.apk'),
        onReceiveProgress: (received, total) {
      double progress = (((received / total) * 100).toDouble());
      double decimalReceived = received / 1000000;
      double decimalTotal = total / 1000000;
      print(progress.toStringAsFixed(1));
      this.progress = progress;
      NotificationService().createNotification(
          total,
          received,
          decimalReceived.toStringAsFixed(1),
          decimalTotal.toStringAsFixed(1),
          'whatsapp-messenger-2-24-9-12.apk');
      emit(ProgressDownloadState());
    });
  }
}
