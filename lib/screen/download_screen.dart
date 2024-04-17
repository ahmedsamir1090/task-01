import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:test_app/cubit/download_cubit.dart';
import 'package:test_app/cubit/download_state.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DownloadCubit, DownloadStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('download File'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DownloadCubit.get(context).progress == 100
                    ? const Text('Downloaded Successfully....')
                    : DownloadCubit.get(context).progress == 0
                        ? const SizedBox()
                        : Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: LinearPercentIndicator(
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              width: MediaQuery.of(context).size.width - 50,
                              animation: true,
                              lineHeight: 20.0,
                              animationDuration: 0,
                              percent: double.parse(DownloadCubit.get(context)
                                      .progress
                                      .toStringAsFixed(1)) /
                                  100,
                              center: Text(DownloadCubit.get(context)
                                  .progress
                                  .toStringAsFixed(1)),
                              barRadius: const Radius.circular(5),
                              progressColor: Colors.green,
                            ),
                          ),
                ElevatedButton(
                    onPressed: () {
                      DownloadCubit.get(context).saveData();
                    },
                    child: Text('Download Here'))
              ],
            ),
          ),
        );
      },
    );
  }
}
