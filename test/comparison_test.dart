@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:timezone/standalone.dart';

Future<void> main() async {
  await initializeTimeZone();
  group('Test equality and inequality', () {
    test('Test that == checks for the same moment in time, not location', () {
      final location1 = getLocation('Europe/London');
      final location2 = getLocation('America/Detroit');
      final time1 = TZDateTime(location1, 2021, 1, 1, 5, 0);
      final time2 = TZDateTime(location2, 2021, 1, 1, 0, 0);
      expect(time1, time2);
    });
  });
}
