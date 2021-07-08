class Notification {
  String topic;
  String title;
  String message;

  Notification(this.topic, this.title, this.message);

  Map<dynamic, dynamic> toJson() {
    return  {
      'topic': this.topic,
      'title': this.title,
      'message': this.message
    };
  }
}