import 'package:dog_breeds/widgets/title_case_widget.dart';
import 'package:flutter_test/flutter_test.dart';

// Wanted to give an example of a test so I created a simple title test case function

void main() {
  group('titleCase function tests', () {
    test('Capitalizes first letter and lowercases the rest', () {
      expect(titleCase('hello'), equals('Hello'));
      expect(titleCase('WORLD'), equals('World'));
      expect(titleCase('flutter'), equals('Flutter'));
    });

    test('Handles empty string', () {
      expect(titleCase(''), equals(''));
    });

    test('Handles single character', () {
      expect(titleCase('a'), equals('A'));
      expect(titleCase('Z'), equals('Z'));
    });

    test('Handles mixed case strings', () {
      expect(titleCase('pOoDlE'), equals('Poodle'));
      expect(titleCase('labraDOR'), equals('Labrador'));
    });

    test('Handles strings with spaces', () {
      expect(titleCase('golden retriever'), equals('Golden retriever'));
    });

    test('Handles strings with special characters', () {
      expect(titleCase('german-shepherd'), equals('German-shepherd'));
      expect(titleCase('st. bernard'), equals('St. bernard'));
    });
  });
}