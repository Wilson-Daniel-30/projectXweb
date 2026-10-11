import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:projectx/constants.dart';
import 'package:projectx/web/cod_ticker_web.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('COD ticker uses brand navy and existing copy', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CodTickerWeb(),
        ),
      ),
    );
    await tester.pump();

    expect(find.byKey(kCodTickerWebKey), findsOneWidget);
    expect(find.text(CodTickerWeb.label), findsWidgets);

    final bar = tester.widget<ColoredBox>(find.byKey(kCodTickerWebKey));
    expect(bar.color, primaryColor);

    final text = tester.widget<Text>(find.text(CodTickerWeb.label).first);
    expect(text.style?.fontFamily, 'Plus Jakarta');
    expect(text.style?.color, whiteColor);

    await tester.pumpWidget(const SizedBox.shrink());
  });
}
