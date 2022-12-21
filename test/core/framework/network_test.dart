import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_testing/core/framework/network.dart';

import 'network_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Network>()])
void main() {
  ///[testable]
  late Network network;

  ///[setups]
  setUp(() {
    network = MockNetwork();
  });

  ///[tests]
  test('Test network connection', () async {
    ///[arranges]
    when(network.isConnected).thenAnswer((realInvocation) async => true);

    ///[act]
    final status = await network.isConnected;

    ///[expects]
    verify(network.isConnected);
    verifyNoMoreInteractions(network);
    expect(status, true);
  });
}
