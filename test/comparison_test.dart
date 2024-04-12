@TestOn('vm')
library;

import 'dart:isolate';

import 'package:test/test.dart';
import 'package:timezone/standalone.dart';

Future<void> main() async {
  await initializeTimeZone();
  group('Equality and inequality of Timezones', () {
    test('Test that == checks for the same moment in time, not location', () {
      final location1 = getLocation('Europe/London'); // UTC+0 on 2021-01-01
      final location2 = getLocation('America/Detroit'); // UTC-5 on 2021-01-01
      final time1 = TZDateTime(location1, 2021, 1, 1, 5, 0);
      final time2 = TZDateTime(location2, 2021, 1, 1, 0, 0);
      expect(time1, time2);
    });

    test('Test that != checks for the same moment in time, not location', () {
      final location1 = getLocation('Europe/London');
      final location2 = getLocation('America/Detroit');
      final time1 = TZDateTime(location1, 2021, 1, 1, 20, 0);
      final time2 = TZDateTime(location2, 2021, 1, 1, 0, 0);
      expect(time1 != time2, isTrue);
    });
  });

  group('Equality of Locations', () {
    test('Test that Locations initialized on different threads are equal',
        () async {
      final location1 = getLocation('Europe/London');
      final location2 = await Isolate.run(() async {
        await initializeTimeZone();
        return getLocation('Europe/London');
      });
      expect(location1, location2);
    });
  });
}
