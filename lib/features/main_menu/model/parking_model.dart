class Parking {
  final String id;
  final String location;
  final double lat;
  final double lng;
  final String phoneNumber;
  final List<String> urls;

  Parking({
    required this.id,
    required this.location,
    required this.lat,
    required this.lng,
    required this.phoneNumber,
    required this.urls,
  });

  factory Parking.fromFirestore(Map<String, dynamic> data, String documentId) {
    return Parking(
      id: documentId,
      location: data['location'] ?? '',
      lat: (data['lat'] ?? 0).toDouble(),
      lng: (data['lng'] ?? 0).toDouble(),
      phoneNumber: data['phone_number'] ?? '',
      urls: List<String>.from(data['urls'] ?? []),
    );
  }
}
