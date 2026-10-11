import 'dart:async';

import 'package:flutter/material.dart';

import '../constants.dart';

const Key kCodTickerWebKey = Key('codTickerWeb');

class CodTickerWeb extends StatefulWidget {
  const CodTickerWeb({super.key});

  static const String label = 'CASH ON DELIVERY AVAILABLE';

  @override
  State<CodTickerWeb> createState() => _CodTickerWebState();
}

class _CodTickerWebState extends State<CodTickerWeb> {
  final ScrollController _controller = ScrollController();
  Timer? _timer;

  static const _style = TextStyle(
    fontFamily: 'Plus Jakarta',
    color: whiteColor,
    fontSize: 12,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    height: 1,
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (_) {
      if (!mounted || !_controller.hasClients) return;
      final position = _controller.position;
      if (!position.hasContentDimensions) return;
      final next = _controller.offset + 0.6;
      if (next >= position.maxScrollExtent) {
        _controller.jumpTo(0);
      } else {
        _controller.jumpTo(next);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Cash on delivery available',
      child: ColoredBox(
        key: kCodTickerWebKey,
        color: primaryColor,
        child: SizedBox(
          height: 36,
          width: double.infinity,
          child: ListView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(CodTickerWeb.label, style: _style),
                      SizedBox(width: 14),
                      Text('•', style: _style),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
