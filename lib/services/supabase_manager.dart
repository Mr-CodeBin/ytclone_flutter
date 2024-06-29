import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  static const String supabaseUrl = 'https://lmvziyrvnrhxwdwbxkpd.supabase.co';
  static const supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxtdnppeXJ2bnJoeHdkd2J4a3BkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTkzMjQxMjksImV4cCI6MjAzNDkwMDEyOX0.pfVX8CPuXaVhWzttVnNYJBnaqI_DBBDS_dsUzZMG9tE';

  static final SupabaseClient supabaseClient =
      SupabaseClient(supabaseUrl, supabaseAnonKey);
}
