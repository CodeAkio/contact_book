import 'dart:convert';

const String idColumn = "id";
const String nameColumn = "name";
const String emailColumn = "email";
const String phoneColumn = "phone";
const String imageColumn = "image";

class Contact {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;

  Contact({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
  });

  Contact copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? image,
  }) {
    return Contact(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      image: image ?? this.image,
    );
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      nameColumn: name,
      emailColumn: email,
      phoneColumn: phone,
      imageColumn: image,
    };

    if (id != null) {
      map[idColumn] = id;
    }

    return map;
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      id: map[idColumn],
      name: map[nameColumn],
      email: map[emailColumn],
      phone: map[phoneColumn],
      image: map[imageColumn],
    );
  }

  String toJson() => json.encode(toMap());

  factory Contact.fromJson(String source) =>
      Contact.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Contact(id: $id, name: $name, email: $email, phone: $phone, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Contact &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phone == phone &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phone.hashCode ^
        image.hashCode;
  }
}
