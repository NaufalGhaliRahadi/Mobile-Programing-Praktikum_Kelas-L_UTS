/// Satu fasilitas pada destinasi (nama, kunci ikon, dan deskripsi).
class Facility {
  final String name;
  final String icon;
  final String description;

  const Facility({
    required this.name,
    required this.icon,
    required this.description,
  });

  /// Menerima objek {name, icon, description} atau string biasa (nama saja).
  factory Facility.fromJson(dynamic json) {
    if (json is String) {
      return Facility(name: json, icon: '', description: '');
    }
    final map = json as Map<String, dynamic>;
    return Facility(
      name: map['name'] as String,
      icon: (map['icon'] as String?) ?? '',
      description: (map['description'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() =>
      {'name': name, 'icon': icon, 'description': description};
}

class Destination {
  final int id;
  final String name;
  final String category;
  final String location;
  final double rating;
  final String ticketPrice;
  final String openHours;
  final String description;
  final String imageUrl;
  final String mapUrl;
  final List<Facility> facilities;
  final DateTime addedDate;

  const Destination({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.rating,
    required this.ticketPrice,
    required this.openHours,
    required this.description,
    required this.imageUrl,
    required this.mapUrl,
    required this.facilities,
    required this.addedDate,
  });

  factory Destination.fromJson(Map<String, dynamic> json) {
    return Destination(
      id: json['id'] as int,
      name: json['name'] as String,
      category: json['category'] as String,
      location: json['location'] as String,
      rating: (json['rating'] as num).toDouble(),
      ticketPrice: json['ticket_price'] as String,
      openHours: json['open_hours'] as String,
      description: json['description'] as String,
      imageUrl: (json['image_url'] as String?) ?? '',
      mapUrl: (json['map_url'] as String?) ?? '',
      facilities: ((json['facilities'] as List?) ?? const [])
          .map(Facility.fromJson)
          .toList(),
      addedDate: DateTime.parse(json['added_date'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'category': category,
        'location': location,
        'rating': rating,
        'ticket_price': ticketPrice,
        'open_hours': openHours,
        'description': description,
        'image_url': imageUrl,
        'map_url': mapUrl,
        'facilities': facilities.map((f) => f.toJson()).toList(),
        'added_date': addedDate.toIso8601String().substring(0, 10),
      };
}