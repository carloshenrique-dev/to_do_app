import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:to_do_app/src/settings/settings_controller.dart';
import 'package:to_do_app/src/settings/settings_service.dart';

void main() {
  group('SettingsController', () {
    late SettingsController settingsController;

    setUp(() {
      settingsController = SettingsController(SettingsService());
    });

    test('should load settings', () async {
      await settingsController.loadSettings();

      expect(settingsController.themeMode, isNotNull);
    });

    test('should update theme mode', () async {
      const newThemeMode = ThemeMode.dark;

      await settingsController.loadSettings();
      await settingsController.updateThemeMode(newThemeMode);

      expect(settingsController.themeMode, equals(newThemeMode));
    });

    test('should not update theme mode if new theme mode is null', () async {
      await settingsController.loadSettings();
      final initialThemeMode = settingsController.themeMode;

      await settingsController.updateThemeMode(null);

      expect(settingsController.themeMode, equals(initialThemeMode));
    });

    test(
        'should not update theme mode if new theme mode is the same as the current theme mode',
        () async {
      await settingsController.loadSettings();
      final initialThemeMode = settingsController.themeMode;

      await settingsController.updateThemeMode(initialThemeMode);

      expect(settingsController.themeMode, equals(initialThemeMode));
    });
  });
}
