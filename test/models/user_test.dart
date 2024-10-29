import 'package:flutter_test/flutter_test.dart';
import 'package:master_focus_todo/models/user.dart';

void main() {
  test('User', () {
    expect(User(), isA<User>());
  });

  test('User.fromMap', () {
    expect(User.fromMap({'id': '1', 'name': 'Marcos'}), isA<User>());
  });

  test('User.fromJson', () {
    expect(User.fromJson('{"id": "1", "name": "Marcos"}'), isA<User>());
  });

  test('User.toMap', () {
    final user = User.fromMap({'id': '1', 'name': 'Marcos'});
    expect(user.toMap(), {'id': '1', 'name': 'Marcos'});
  });

  test('User.toJson', () {
    final user = User.fromMap({'id': '1', 'name': 'Marcos'});
    expect(user.toJson(), '{"id":"1","name":"Marcos"}');
  });
}
