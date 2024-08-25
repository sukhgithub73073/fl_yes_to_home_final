import 'dart:math';



double calculateHaversineDistance(double lat1, double lon1, double lat2, double lon2) {
  const R = 6371000; // Radius of Earth in meters
  final lat1Rad = lat1 * pi / 180;
  final lat2Rad = lat2 * pi / 180;
  final deltaLat = (lat2 - lat1) * pi / 180;
  final deltaLon = (lon2 - lon1) * pi / 180;

  final a = sin(deltaLat / 2) * sin(deltaLat / 2) +
      cos(lat1Rad) * cos(lat2Rad) *
          sin(deltaLon / 2) * sin(deltaLon / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));

  return R * c; // Distance in meters
}
double estimateTravelTime(double distanceInMeters, double averageSpeedInKmph) {
  final speedInMetersPerSecond = averageSpeedInKmph * 1000 / 3600;
  return distanceInMeters / speedInMetersPerSecond; // Time in seconds
}



String calculateDistance({
  required double startLatitude,
  required double startLongitude,
  required double endLatitude,
  required double endLongitude
}) {
  const double R = 6371e3; // Earth's radius in meters

  // Convert latitude and longitude from degrees to radians
  double lat1 = startLatitude * (pi / 180);
  double lat2 = endLatitude * (pi / 180);
  double deltaLat = (endLatitude - startLatitude) * (pi / 180);
  double deltaLon = (endLongitude - startLongitude) * (pi / 180);

  // Haversine formula
  double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
      cos(lat1) * cos(lat2) *
          sin(deltaLon / 2) * sin(deltaLon / 2);
  double c = 2 * atan2(sqrt(a), sqrt(1 - a));

  double distanceInMeters = R * c; // Distance in meters

  return formatDistance(distanceInMeters);
}

String formatDistance(double distanceInMeters) {
  if (distanceInMeters < 1000) {
    return '${distanceInMeters.round()} m';
  } else {
    double distanceInKm = distanceInMeters / 1000;
    return '${distanceInKm.toStringAsFixed(1)} km'; // Rounded to one decimal place
  }
}

String formatTravelTime(double distanceInMeters, double speedKmph) {
  // Convert speed from km/h to m/min
  double speedMpm = (speedKmph * 1000) / 60;

  // Calculate time in minutes
  double timeInMinutes = distanceInMeters / speedMpm;

  // Calculate hours and minutes
  int hours = (timeInMinutes / 60).floor();
  int minutes = (timeInMinutes % 60).round();

  // Format the output based on hours and minutes
  if (hours > 0) {
    if (minutes > 0) {
      return '$hours hour${hours != 1 ? 's' : ''} $minutes min';
    } else {
      return '$hours hour${hours != 1 ? 's' : ''}';
    }
  } else {
    return '$minutes min';
  }
}
