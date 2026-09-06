@echo off
REM This script helps you get your Supabase API key
REM 
REM Instructions:
REM 1. Open this file in a text editor
REM 2. Read the instructions below
REM 3. Copy your API key and update the email_service.dart file

echo.
echo ========================================
echo   SUPABASE API KEY RETRIEVAL GUIDE
echo ========================================
echo.
echo Follow these steps to get your Supabase API key:
echo.
echo 1. Open your browser and go to:
echo    https://supabase.com/dashboard/project/eukkhlbgmcnhstdfmeea
echo.
echo 2. Look for "Settings" (gear icon) in the left sidebar
echo    Click on it
echo.
echo 3. Click on "API" in the left menu
echo.
echo 4. You'll see "Project API keys" section with:
echo    - service_role (KEEP THIS SECRET!)
echo    - anon public (THIS IS WHAT YOU NEED)
echo.
echo 5. Click the "Copy" button next to "anon public"
echo    (It should be a long string starting with "eyJ")
echo.
echo 6. Open: lib\backend\email_service.dart
echo.
echo 7. Find the line:
echo    static const String _supabaseApiKey = '';  // ← PASTE YOUR KEY HERE
echo.
echo 8. Replace the empty string with your copied key:
echo    static const String _supabaseApiKey = 'paste-your-key-here';
echo.
echo 9. Save the file
echo.
echo 10. Refresh your Flutter app and try again
echo.
echo ========================================
echo.
echo If you still get a 401 error after adding the key:
echo - Make sure you copied the ENTIRE key (it's very long)
echo - Check that the key doesn't have any extra spaces
echo - Verify the database tables exist (see SUPABASE_SETUP.md)
echo.
pause
