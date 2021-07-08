class Drain {
  String volume;
  String types;

  Drain(Map<dynamic, dynamic> json) {
    this.volume = json['volume'];
    this.types = json ['types'];
  }

  Drain.newInstance();

  static Drain parse(Map<dynamic, dynamic> json) {
    if (json == null) {
      return Drain.newInstance();
    } else {
      return Drain(json);
    }
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'volume': this.volume,
      'types': this.types
    };
  }
}