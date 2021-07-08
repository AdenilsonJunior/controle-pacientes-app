class HasWhich {
  String has;
  String which;

  HasWhich(Map<dynamic, dynamic> json) {
    this.has = json['has'];
    this.which = json['which'];
  }

  static HasWhich parse(Map<dynamic, dynamic> json) {
    if (json == null) {
      return HasWhich.newInstance();
    } else {
      return HasWhich(json);
    }
  }

  HasWhich.newInstance();

  Map<dynamic, dynamic> toJson() {
    return {'has': this.has, 'which': this.which};
  }
}
