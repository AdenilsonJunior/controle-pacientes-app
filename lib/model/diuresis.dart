class Diuresis {
  String volume;
  String characteristics;

  Diuresis(Map<dynamic, dynamic> json) {
    this.volume = json['volume'];
    this.characteristics = json['characteristics'];
  }

  static Diuresis parse(Map<dynamic, dynamic> json) {
    if (json != null) {
      return Diuresis(json);
    } else {
      return Diuresis.newInstance();
    }
  }

  Diuresis.newInstance();

  Map<dynamic, dynamic> toJson() {
    return {'volume': this.volume, 'characteristics': this.characteristics};
  }
}
