class UsersList{
  final List<Users> users;

  UsersList({required this.users});

  factory UsersList.fromJson(dynamic json){
    var usersJson = json as List;
    List<Users> usersList = usersJson.map((e) => Users.fromJson(e)).toList();
    return UsersList(users: usersList);
  }

}

class Users {
  final String login;
  final int id;
  final String avatarUrl;
  final String? name;
  final String? organization;
  final int? followers;
  final int? following;

  Users({
    required this.login,
    required this.id,
    required this.avatarUrl,
    this.name,
    this.organization,
    this.followers,
    this.following,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      login: json['login'] as String,
      id: json['id'] as int,
      avatarUrl: json['avatar_url'] as String,
      name: json['name'] ?? '',
      organization: json['organizations_url'] ?? '',
      followers: json['followers'] ?? 0,
      following: json['following'] ?? 0,
    );
  }

}

