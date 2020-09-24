class User {
  String uid, displayName, email, phoneNumber;
  String photoUrl; // change to Url object later

  User(String uid, String email, String displayName, String phoneNumber, String photoUrl) {
    this.uid = uid;
    this.email = email;
    this.displayName = displayName;
    this.phoneNumber = phoneNumber;
    this.photoUrl = photoUrl;
  }
}
