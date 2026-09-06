import 'dart:async';
import 'dart:html' as html;
import 'dart:convert';

class EmailService {
  // Correct Supabase project for Ardaita:
  // https://supabase.com/dashboard/project/eukkhlbgmcnhstdfmeea/database/schemas
  static const String _supabaseUrl = 'https://eukkhlbgmcnhstdfmeea.supabase.co';

  // Paste the actual green "anon public" key for this project in the dashboard:
  // https://supabase.com/dashboard/project/eukkhlbgmcnhstdfmeea/settings/api
  // Do not use the service_role key or any stale key from another project.
  static const String _supabaseApiKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'sb_publishable_lEJEIHL2_d22-lQFfSLEig_J60MEAEC',
  );

  static Future<void> sendContactEmail({
    required String fullName,
    required String email,
    required String message,
  }) async {
    final payload = {'fullName': fullName, 'email': email, 'message': message};

    await _sendToSupabase('contact_submissions', payload);
  }

  static Future<void> sendVolunteerApplication({
    required String fullName,
    required String email,
    required String initiative,
    required String motivation,
  }) async {
    final payload = {
      'fullName': fullName,
      'email': email,
      'initiative': initiative,
      'motivation': motivation,
    };

    await _sendToSupabase('volunteer_applications', payload);
  }

  static Future<void> _sendToSupabase(
    String tableName,
    Map<String, dynamic> payload,
  ) async {
    final url = '$_supabaseUrl/rest/v1/$tableName';

    try {
      if (_supabaseApiKey.isEmpty) {
        throw StateError(
          'Supabase API key is not configured. '
          'Add the actual green "anon public" key from the Ardaita Supabase project '
          'and rebuild. Use: flutter run --dart-define=SUPABASE_ANON_KEY="PASTE_KEY_HERE"',
        );
      }

      final request = html.HttpRequest()
        ..open('POST', url)
        ..setRequestHeader('Content-Type', 'application/json')
        ..setRequestHeader('apikey', _supabaseApiKey)
        ..setRequestHeader('Authorization', 'Bearer $_supabaseApiKey');

      final completer = Completer<void>();

      request.onLoad.listen((event) {
        if (request.status! >= 200 && request.status! < 300) {
          print('[EmailService] ✓ Submission sent successfully to $tableName');
          completer.complete();
        } else {
          final statusCode = request.status;
          final statusText = request.statusText;
          final responseText = request.responseText;

          String errorMessage = 'Server error: $statusCode - $statusText';

          if (statusCode == 401) {
            errorMessage =
                'Authentication failed (401). Your API key may be invalid. '
                'Check GET_SUPABASE_API_KEY.md for instructions.';
          } else if (statusCode == 404) {
            errorMessage =
                'Table not found (404). Check that $tableName table exists. '
                'Run the SQL from SUPABASE_SETUP.md.';
          } else if (statusCode == 400) {
            errorMessage =
                'Bad request (400). Response: $responseText. '
                'Check field names match the database schema.';
          }

          print('[EmailService] ✗ Error: $errorMessage');
          completer.completeError(StateError(errorMessage));
        }
      });

      request.onError.listen((event) {
        print('[EmailService] ✗ Network error: ${request.responseText}');
        completer.completeError(
          StateError(
            'Network error: Failed to send submission. Check browser console.',
          ),
        );
      });

      print('[EmailService] Sending to: $url');
      print('[EmailService] Table: $tableName');
      print('[EmailService] Payload: $payload');
      request.send(jsonEncode(payload));
      await completer.future;
    } catch (e) {
      print('[EmailService] ✗ Exception: $e');
      rethrow;
    }
  }
}
