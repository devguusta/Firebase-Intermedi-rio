import 'package:firebase_analytics/firebase_analytics.dart';

class CustomFirebaseAnylitcs {
  late FirebaseAnalytics _firebaseAnalytics;
  late FirebaseAnalyticsObserver observer;

  CustomFirebaseAnylitcs._internal();
  static final CustomFirebaseAnylitcs _singleton =
      CustomFirebaseAnylitcs._internal();
  factory CustomFirebaseAnylitcs() => _singleton;

  Future<void> inicialize() async {}

  Future<void> getCounter() async {
    _firebaseAnalytics = FirebaseAnalytics.instance;

    observer = FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);
    await _firebaseAnalytics.logPurchase(
      value: 50,
      currency: 'USD',
      tax: 1,
    );
  }

  Future<void> getEvent() async {
    _firebaseAnalytics = FirebaseAnalytics.instance;
    observer = FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);
    await _firebaseAnalytics.logEvent(
      name: 'teste',
      parameters: <String, dynamic>{
        'teste': 'teste',
      },
    );
  }
}
