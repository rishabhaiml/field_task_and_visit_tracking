import 'package:get/get.dart';

class MockAiService extends GetxService {
  /// Analyzes visit notes using deterministic rules to generate a mock AI insight.
  Future<String> analyzeNotes(String notes) async {
    // ⏳ Simulate API processing time for realism
    await Future.delayed(const Duration(seconds: 2));

    final lowerNotes = notes.toLowerCase();

    // Rule 1: Escalation / Warning Flags
    if (lowerNotes.contains('angry') ||
        lowerNotes.contains('upset') ||
        lowerNotes.contains('issue') ||
        lowerNotes.contains('broken')) {
      return '⚠️ Warning Flag: Customer dissatisfaction or critical issue detected. Recommend immediate follow-up by Team Lead.';
    }

    // Rule 2: Positive / Next Steps
    if (lowerNotes.contains('interested') ||
        lowerNotes.contains('buy') ||
        lowerNotes.contains('upgrade')) {
      return '💡 Suggested Next Step: High conversion probability. Send product catalog and schedule a follow-up call within 48 hours.';
    }

    // Rule 3: Default Summary
    return '📝 AI Summary: Routine visit completed. No critical flags detected. Proceed with standard workflow.';
  }
}
