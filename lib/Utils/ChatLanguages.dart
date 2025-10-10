// lib/utils/chat_languages.dart

// Enum to define the supported chat languages for the AI advisor.
enum ChatLanguage {
  romanUrdu,
  urdu,
  english,
}

/// Extension methods for the [ChatLanguage] enum to provide display strings
/// and AI instruction strings.
extension ChatLanguageExtension on ChatLanguage {
  /// Returns a user-friendly string representation of the language for UI display.
  String toDisplayString() {
    switch (this) {
      case ChatLanguage.romanUrdu:
        return 'Roman Urdu';
      case ChatLanguage.urdu:
        return 'Urdu (اردو)';
      case ChatLanguage.english:
        return 'English';
    }
  }

  /// Returns a string representation of the language suitable for
  /// instructing the AI model to respond in that specific language.
  String toInstructionString() {
    switch (this) {
      case ChatLanguage.romanUrdu:
      // For Roman Urdu, the instruction can be the same as display
        return 'Roman Urdu';
      case ChatLanguage.urdu:
      // For actual Urdu script, we instruct the AI to use 'Urdu'
        return 'Urdu';
      case ChatLanguage.english:
      // For English, we instruct the AI to use 'English'
        return 'English';
    }
  }
}