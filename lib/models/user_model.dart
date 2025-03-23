/// User Model
///
/// This class represents a user in the application.
/// It contains the user's profile information and methods for serialization.
class UserModel {
  String? id;
  String? name;
  String? phone;
  String? email;
  String? city;
  String? location;
  List<String>? userTypes;
  String? profileImage;
  String? firebaseId;

  /// Constructor
  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.city,
    this.location,
    this.userTypes,
    this.profileImage,
    this.firebaseId,
  });

  /// Create a UserModel from JSON
  ///
  /// @param json The JSON object to deserialize
  /// @return A new UserModel instance
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      city: json['city'],
      location: json['location'],
      userTypes: json['user_types'] != null 
          ? List<String>.from(json['user_types']) 
          : null,
      profileImage: json['profile_image'],
      firebaseId: json['firebase_id'],
    );
  }

  /// Convert UserModel to JSON
  ///
  /// @return A map representing the UserModel
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone': phone,
      'email': email,
      'city': city,
      'location': location,
      'user_types': userTypes,
      'profile_image': profileImage,
      'firebase_id': firebaseId,
    };
  }
}

