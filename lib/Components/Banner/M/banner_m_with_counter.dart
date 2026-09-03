import 'dart:async';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../constants.dart';
import '../../blur_container.dart';
import 'banner_m.dart';
import 'package:projectx/ViewModel/FlashSaleViewModel.dart';


class BannerMWithCounter extends StatefulWidget {
  const BannerMWithCounter({
    super.key,
    this.image = "https://drive.google.com/uc?export=download&id=16wcDCd3FSpykFbxJJB95OPMbNaTPdQHb",
    required this.text,
    required this.duration,
    required this.press,
  });

  final String image, text;
  final Duration duration;
  final VoidCallback press;

  @override
  State<BannerMWithCounter> createState() => _BannerMWithCounterState();
}

class _BannerMWithCounterState extends State<BannerMWithCounter> {
  late Duration _duration;
  late Timer _timer;

  @override
  void initState() {
    _duration = widget.duration;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _duration = Duration(seconds: _duration.inSeconds - 1);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FlashSaleViewModel()..fetchAppInfo(),
      child: Consumer<FlashSaleViewModel>(
          builder: (context,vm,child){
            if (vm.isLoading) {
              return Center(child: LoadingAnimationWidget.waveDots(
                color: primaryColor,
                size: 60,
              ));
            }
            if (vm.error != null) {
              return Center(child: Text('Error: ${vm.error}'));
            }

            DateTime dateTime = DateTime.parse(vm.appInfo!.saleTime!);


            final now = DateTime.now();
            final difference = dateTime.difference(now);

            if (difference.isNegative) {

              _timer.cancel();

            }

            final days = difference.inDays;
            final hours = difference.inHours % 24;
            final minutes = difference.inMinutes % 60;
            final seconds = difference.inSeconds % 60;

            return BannerM(
              image: widget.image,
              press: widget.press,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Super Flash Sale \n${vm.appInfo?.saleDiscountPercentage}% Off ',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontFamily: grandisExtendedFont,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            BlurContainer(
                              text: days.toString().padLeft(2, "0"),
                            ),
                            Text(
                              days>1?"Days":"Day",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 4),
                          child: SvgPicture.asset("assets/icons/dot.svg"),
                        ),
                        Column(
                          children: [
                            BlurContainer(
                              text: hours.toString().padLeft(2, "0"),
                            ),
                            Text(
                              hours>1?"Hrs":"Hr",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 4),
                          child: SvgPicture.asset("assets/icons/dot.svg"),
                        ),
                        Column(
                          children: [
                            BlurContainer(
                              text: minutes
                                  .remainder(60)
                                  .toString()
                                  .padLeft(2, "0"),
                            ),
                            Text(
                              minutes>1?"Mins":"Min",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: defaultPadding / 4),
                          child: SvgPicture.asset("assets/icons/dot.svg"),
                        ),
                        Column(
                          children: [
                            BlurContainer(
                              text: seconds
                                  .remainder(60)
                                  .toString()
                                  .padLeft(2, "0"),
                            ),
                            Text(
                              seconds>1?"Secs":"Sec",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),

                      ],
                    )
                  ],
                ),
              ],
            );
          }
      )
    );


  }
}
