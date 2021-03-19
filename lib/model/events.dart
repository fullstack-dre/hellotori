part of "model.dart";

class Event{
  String uid;
  String title;
  String videoLink;
  String description;
  String type;
  String schedule;
  bool isChatEnabled;

  Event({required this.uid,required this.title, required this.videoLink,required this.description, required this.type, required this.schedule, required this.isChatEnabled}){
    this.uid = uid; 
    this.title = title;
    this.videoLink = videoLink;
    this.description = description;
    this.type = type;
    this.schedule = schedule;
    this.isChatEnabled = isChatEnabled;
  }
}

