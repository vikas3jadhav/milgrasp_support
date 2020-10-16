

class TodaysCount{
  String attended_by;
  String count;

  TodaysCount(this.attended_by, this.count);


  TodaysCount.fromJSON(Map<String, dynamic> json) {
    attended_by =json["attended_by"];
    count =json["count"];
  }
}