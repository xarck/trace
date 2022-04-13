class Profile {
  String? country;
  String? displayName;
  String? email;
  ExplicitContent? explicitContent;
  ExternalUrls? externalUrls;
  Followers? followers;
  String? href;
  String? id;
  List<ProfileImage>? images;
  String? product;
  String? type;
  String? uri;

  Profile(
      {this.country,
      this.displayName,
      this.email,
      this.explicitContent,
      this.externalUrls,
      this.followers,
      this.href,
      this.id,
      this.images,
      this.product,
      this.type,
      this.uri});

  Profile.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    displayName = json['display_name'];
    email = json['email'];
    explicitContent = json['explicit_content'] != null
        ? new ExplicitContent.fromJson(json['explicit_content'])
        : null;
    externalUrls = json['external_urls'] != null
        ? new ExternalUrls.fromJson(json['external_urls'])
        : null;
    followers = json['followers'] != null
        ? new Followers.fromJson(json['followers'])
        : null;
    href = json['href'];
    id = json['id'];
    if (json['images'] != null) {
      images = <ProfileImage>[];
      json['images'].forEach((v) {
        images!.add(new ProfileImage.fromJson(v));
      });
    }
    product = json['product'];
    type = json['type'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = this.country;
    data['display_name'] = this.displayName;
    data['email'] = this.email;
    if (this.explicitContent != null) {
      data['explicit_content'] = this.explicitContent!.toJson();
    }
    if (this.externalUrls != null) {
      data['external_urls'] = this.externalUrls!.toJson();
    }
    if (this.followers != null) {
      data['followers'] = this.followers!.toJson();
    }
    data['href'] = this.href;
    data['id'] = this.id;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['product'] = this.product;
    data['type'] = this.type;
    data['uri'] = this.uri;
    return data;
  }
}

class ExplicitContent {
  bool? filterEnabled;
  bool? filterLocked;

  ExplicitContent({this.filterEnabled, this.filterLocked});

  ExplicitContent.fromJson(Map<String, dynamic> json) {
    filterEnabled = json['filter_enabled'];
    filterLocked = json['filter_locked'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['filter_enabled'] = this.filterEnabled;
    data['filter_locked'] = this.filterLocked;
    return data;
  }
}

class ExternalUrls {
  String? spotify;

  ExternalUrls({this.spotify});

  ExternalUrls.fromJson(Map<String, dynamic> json) {
    spotify = json['spotify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['spotify'] = this.spotify;
    return data;
  }
}

class Followers {
  String? href;
  int? total;

  Followers({this.href, this.total});

  Followers.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['total'] = this.total;
    return data;
  }
}

class ProfileImage {
  String? url;
  int? height;
  int? width;

  ProfileImage({this.url, this.height, this.width});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    height = json['height'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['height'] = this.height;
    data['width'] = this.width;
    return data;
  }
}
