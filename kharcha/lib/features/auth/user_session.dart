/// Kharcha — Lightweight in-memory session for the logged-in user.
/// Populated on onboarding/login; read-only elsewhere.
class UserSession {
  UserSession._();

  static final UserSession _instance = UserSession._();
  static UserSession get instance => _instance;

  // ── Profile fields ───────────────────────────────────────────────
  String _name = '';
  String _email = '';
  String _currency = '₨';
  double _budget = 0.0;
  List<String> _categories = [];

  // ── Setters (call on login / onboarding finish) ──────────────────
  void setProfile({
    required String name,
    String email = '',
    String currency = '₨',
    double budget = 0.0,
    List<String>? categories,
  }) {
    _name = name.trim();
    _email = email.trim();
    _currency = currency;
    _budget = budget;
    _categories = categories ?? [];
  }

  // ── Getters ──────────────────────────────────────────────────────
  String get name => _name.isNotEmpty ? _name : 'You';
  String get email => _email;
  String get currency => _currency;
  double get budget => _budget;
  List<String> get categories => List.unmodifiable(_categories);

  /// First letter of the name, upper-cased — for avatar chips.
  String get initial =>
      _name.isNotEmpty ? _name[0].toUpperCase() : '?';

  /// Greeting based on device time.
  String get greeting {
    final h = DateTime.now().hour;
    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';
    return 'Good evening';
  }

  /// True once a name has been recorded.
  bool get isLoggedIn => _name.isNotEmpty;

  void clear() {
    _name = '';
    _email = '';
    _currency = '₨';
    _budget = 0.0;
    _categories = [];
  }
}
