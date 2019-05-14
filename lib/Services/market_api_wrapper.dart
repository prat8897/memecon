import 'package:http/http.dart' as http;
import 'dart:convert';

final String mainUrl = "meme.market";

Future <List<InvestmentsByPost>> fetchInvestmentsByPost(String post, {String perPage = "5", String page = "0"}) async {

  var uri = Uri.https(mainUrl, '/api/investments/post/$post', { "per_page" : perPage, "page" : page});
  final response = await http.get(uri);
  
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    final investmentsByPost = InvestmentsByPost().investmentsByPostFromJson(response.body);
    //print("Printing name from: InvestmentsByPost\n" + investmentsByPost[0].name.toString());
    return investmentsByPost;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load <List<InvestmentsByPost>>');
  }
}

Future <InvestorByName> fetchInvestorByName(String name) async {

  var uri = Uri.https(mainUrl, '/api/investor/$name');
  final response = await http.get(uri);
  
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    final investorByName = InvestorByName().investorNameFromJson(response.body);
    //print("Printing name from: InvestorByName\n" + investorByName.name.toString());
    return investorByName;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load <InvestorByName>');
  }
}

Future <List<InvestmentsByName>> fetchInvestmentsByName(String name, {String perPage = "5", String page = "0"}) async {

  var uri = Uri.https(mainUrl, '/api/investor/$name/investments', { "per_page" : perPage, "page" : page});
  final response = await http.get(uri);
  
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    final investmentsByName = InvestmentsByName().investmentsByNameFromJson(response.body);
    //print("Printing name from: InvestmentsByName\n" + investmentsByName[0].name.toString());
    return investmentsByName;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load <List<InvestmentsByName>>');
  }
}

Future <List<ActiveInvestmentsByName>> fetchActiveInvestmentsByName(String name, {String perPage = "5", String page = "0"}) async {
  
  var uri = Uri.https(mainUrl, '/api/investor/$name/active', { "per_page" : perPage, "page" : page});
  final response = await http.get(uri);
  
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    final activeinvestmentsByName = ActiveInvestmentsByName().activeInvestmentsByNameFromJson(response.body);
    //print("Printing name from: ActiveInvestmentsByName\n" + activeinvestmentsByName[0].name.toString());
    return activeinvestmentsByName;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load <List<ActiveInvestmentsByName>>');
  }
}

Future <List<TopInvestors>> fetchTopInvestors({String perPage = "5"}) async {
  
  var uri = Uri.https(mainUrl, '/api/investors/top', { "per_page" : perPage});
  final response = await http.get(uri);
  
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    final topInvestors = TopInvestors().topInvestorsFromJson(response.body);
    //print("Printing name from: TopInvestors\n" + topInvestors[0].name.toString());
    return topInvestors;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load <List<TopInvestors>>');
  }
}

Future <FirmById> fetchFirmById(int id) async {

  var uri = Uri.https(mainUrl, '/api/firm/${id.toString()}');
  final response = await http.get(uri);
  
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    final firmById = FirmById().firmByIdFromJson(response.body);
    //print("Printing name from: FirmById\n" + firmById.name.toString());
    return firmById;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load <FirmById>');
  }
}

Future <List<FirmMembersById>> fetchFirmMembersById(int id, {String perPage = "5"}) async {

  var uri = Uri.https(mainUrl, '/api/firm/${id.toString()}/members', { "per_page" : perPage});
  final response = await http.get(uri);
  
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    final firmMembersById = FirmMembersById().firmMembersByIdFromJson(response.body);
    //print("Printing name from: FirmMembersById\n" + firmMembersById[0].name.toString());
    return firmMembersById;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load <List<FirmMembersById>>');
  }
}

Future <List<TopFirms>> fetchTopFirms({String perPage = "5"}) async {
  
  var uri = Uri.https(mainUrl, '/api/firms/top', { "per_page" : perPage});
  final response = await http.get(uri);
  
  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    final topFirms = TopFirms().topFirmsFromJson(response.body);
    //print("Printing name from: TopFirms\n" + topFirms[0].name.toString());
    return topFirms;
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load <List<TopFirms>>');
  }
}

class InvestmentsByPost {
  int id;
  String post;
  int upvotes;
  String comment;
  String name;
  int amount;
  int time;
  bool done;
  String response;
  int finalUpvotes;
  int profit;

  InvestmentsByPost({
    this.id,
    this.post,
    this.upvotes,
    this.comment,
    this.name,
    this.amount,
    this.time,
    this.done,
    this.response,
    this.finalUpvotes,
    this.profit,
  });

  factory InvestmentsByPost.fromJson(Map<String, dynamic> json) => new InvestmentsByPost(
    id: json["id"],
    post: json["post"],
    upvotes: json["upvotes"],
    comment: json["comment"],
    name: json["name"],
    amount: json["amount"],
    time: json["time"],
    done: json["done"],
    response: json["response"],
    finalUpvotes: json["final_upvotes"],
    profit: json["profit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post": post,
    "upvotes": upvotes,
    "comment": comment,
    "name": name,
    "amount": amount,
    "time": time,
    "done": done,
    "response": response,
    "final_upvotes": finalUpvotes,
    "profit": profit,
  };

  List<InvestmentsByPost> investmentsByPostFromJson(String str) {
    return new List<InvestmentsByPost>.from(json.decode(str).map((x) => InvestmentsByPost.fromJson(x)));
  }

  String investmentsByPostToJson(List<InvestmentsByPost> data) {
    return json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));
  }
}

class InvestorByName {
  int id;
  String name;
  int balance;
  int completed;
  int broke;
  List<String> badges;
  int firm;
  String firmRole;
  int networth;
  int rank;

  InvestorByName({
    this.id,
    this.name,
    this.balance,
    this.completed,
    this.broke,
    this.badges,
    this.firm,
    this.firmRole,
    this.networth,
    this.rank,
  });

  factory InvestorByName.fromJson(Map<String, dynamic> json) => new InvestorByName(
    id: json["id"],
    name: json["name"],
    balance: json["balance"],
    completed: json["completed"],
    broke: json["broke"],
    badges: new List<String>.from(json["badges"].map((x) => x)),
    firm: json["firm"],
    firmRole: json["firm_role"],
    networth: json["networth"],
    rank: json["rank"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "balance": balance,
    "completed": completed,
    "broke": broke,
    "badges": new List<dynamic>.from(badges.map((x) => x)),
    "firm": firm,
    "firm_role": firmRole,
    "networth": networth,
    "rank": rank,
  };


  InvestorByName investorNameFromJson(String str) {
    return InvestorByName.fromJson(json.decode(str));
  }

  String investorNameToJson(InvestorByName data) {
    return json.encode(data.toJson());
  }
}

class InvestmentsByName {
  int id;
  String post;
  int upvotes;
  String comment;
  String name;
  int amount;
  int time;
  bool done;
  String response;
  int finalUpvotes;
  bool success;
  int profit;

  InvestmentsByName({
    this.id,
    this.post,
    this.upvotes,
    this.comment,
    this.name,
    this.amount,
    this.time,
    this.done,
    this.response,
    this.finalUpvotes,
    this.success,
    this.profit,
  });

  factory InvestmentsByName.fromJson(Map<String, dynamic> json) => new InvestmentsByName(
    id: json["id"],
    post: json["post"],
    upvotes: json["upvotes"],
    comment: json["comment"],
    name: json["name"],
    amount: json["amount"],
    time: json["time"],
    done: json["done"],
    response: json["response"],
    finalUpvotes: json["final_upvotes"],
    success: json["success"],
    profit: json["profit"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post": post,
    "upvotes": upvotes,
    "comment": comment,
    "name": name,
    "amount": amount,
    "time": time,
    "done": done,
    "response": response,
    "final_upvotes": finalUpvotes,
    "success": success,
    "profit": profit,
  };

  List<InvestmentsByName> investmentsByNameFromJson(String str) {
    return new List<InvestmentsByName>.from(json.decode(str).map((x) => InvestmentsByName.fromJson(x)));
  }

  String investmentsByNameToJson(List<InvestmentsByName> data) {
    return json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));
  }
}

class ActiveInvestmentsByName {
  int id;
  String post;
  int upvotes;
  String comment;
  String name;
  int amount;
  int time;
  String response;
  int finalUpvotes;

  ActiveInvestmentsByName({
    this.id,
    this.post,
    this.upvotes,
    this.comment,
    this.name,
    this.amount,
    this.time,
    this.response,
    this.finalUpvotes,
  });

  factory ActiveInvestmentsByName.fromJson(Map<String, dynamic> json) => new ActiveInvestmentsByName(
    id: json["id"],
    post: json["post"],
    upvotes: json["upvotes"],
    comment: json["comment"],
    name: json["name"],
    amount: json["amount"],
    time: json["time"],
    response: json["response"],
    finalUpvotes: json["final_upvotes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "post": post,
    "upvotes": upvotes,
    "comment": comment,
    "name": name,
    "amount": amount,
    "time": time,
    "response": response,
    "final_upvotes": finalUpvotes,
  };

  List<ActiveInvestmentsByName> activeInvestmentsByNameFromJson(String str) {
    return new List<ActiveInvestmentsByName>.from(json.decode(str).map((x) => ActiveInvestmentsByName.fromJson(x)));
  }

  String activeInvestmentsByNameToJson(List<ActiveInvestmentsByName> data) {
    return json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));
  }
}

class TopInvestors {
  int id;
  String name;
  int balance;
  int completed;
  int broke;
  List<String> badges;
  int firm;
  String firmRole;
  int networth;

  TopInvestors({
    this.id,
    this.name,
    this.balance,
    this.completed,
    this.broke,
    this.badges,
    this.firm,
    this.firmRole,
    this.networth,
  });

  factory TopInvestors.fromJson(Map<String, dynamic> json) => new TopInvestors(
    id: json["id"],
    name: json["name"],
    balance: json["balance"],
    completed: json["completed"],
    broke: json["broke"],
    badges: new List<String>.from(json["badges"].map((x) => x)),
    firm: json["firm"],
    firmRole: json["firm_role"],
    networth: json["networth"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "balance": balance,
    "completed": completed,
    "broke": broke,
    "badges": new List<dynamic>.from(badges.map((x) => x)),
    "firm": firm,
    "firm_role": firmRole,
    "networth": networth,
  };

  List<TopInvestors> topInvestorsFromJson(String str) {
    return new List<TopInvestors>.from(json.decode(str).map((x) => TopInvestors.fromJson(x)));
  }

  String topInvestorsToJson(List<TopInvestors> data) {
    return json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));
  }
}

class FirmById {
  int id;
  String name;
  int balance;
  int size;
  int execs;
  int tax;
  int rank;
  bool private;
  int lastPayout;

  FirmById({
    this.id,
    this.name,
    this.balance,
    this.size,
    this.execs,
    this.tax,
    this.rank,
    this.private,
    this.lastPayout,
  });

  factory FirmById.fromJson(Map<String, dynamic> json) => new FirmById(
    id: json["id"],
    name: json["name"],
    balance: json["balance"],
    size: json["size"],
    execs: json["execs"],
    tax: json["tax"],
    rank: json["rank"],
    private: json["private"],
    lastPayout: json["last_payout"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "balance": balance,
    "size": size,
    "execs": execs,
    "tax": tax,
    "rank": rank,
    "private": private,
    "last_payout": lastPayout,
  };

  FirmById firmByIdFromJson(String str) {
    return FirmById.fromJson(json.decode(str));
  }

  String firmByIdToJson(FirmById data) {
    return json.encode(data.toJson());
  }
}

class FirmMembersById {
  int id;
  String name;
  int balance;
  int completed;
  int broke;
  List<dynamic> badges;
  int firm;
  String firmRole;
  int networth;

  FirmMembersById({
    this.id,
    this.name,
    this.balance,
    this.completed,
    this.broke,
    this.badges,
    this.firm,
    this.firmRole,
    this.networth,
  });

  factory FirmMembersById.fromJson(Map<String, dynamic> json) => new FirmMembersById(
    id: json["id"],
    name: json["name"],
    balance: json["balance"],
    completed: json["completed"],
    broke: json["broke"],
    badges: new List<dynamic>.from(json["badges"].map((x) => x)),
    firm: json["firm"],
    firmRole: json["firm_role"],
    networth: json["networth"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "balance": balance,
    "completed": completed,
    "broke": broke,
    "badges": new List<dynamic>.from(badges.map((x) => x)),
    "firm": firm,
    "firm_role": firmRole,
    "networth": networth,
  };

  List<FirmMembersById> firmMembersByIdFromJson(String str) {
    return new List<FirmMembersById>.from(json.decode(str).map((x) => FirmMembersById.fromJson(x)));
  }

  String firmMembersByIdToJson(List<FirmMembersById> data) {
    return json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));
  }
}

class TopFirms {
  int id;
  String name;
  int balance;
  int size;
  int execs;
  int tax;
  int rank;
  bool private;
  int lastPayout;

  TopFirms({
    this.id,
    this.name,
    this.balance,
    this.size,
    this.execs,
    this.tax,
    this.rank,
    this.private,
    this.lastPayout,
  });

  factory TopFirms.fromJson(Map<String, dynamic> json) => new TopFirms(
    id: json["id"],
    name: json["name"],
    balance: json["balance"],
    size: json["size"],
    execs: json["execs"],
    tax: json["tax"],
    rank: json["rank"],
    private: json["private"],
    lastPayout: json["last_payout"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "balance": balance,
    "size": size,
    "execs": execs,
    "tax": tax,
    "rank": rank,
    "private": private,
    "last_payout": lastPayout,
  };

  List<TopFirms> topFirmsFromJson(String str) {
    return new List<TopFirms>.from(json.decode(str).map((x) => TopFirms.fromJson(x)));
  }

  String topFirmsToJson(List<TopFirms> data) {
    return json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));
  }
}

/*
main() {
  fetchInvestmentsByPost("bogkn5");
  fetchInvestorByName("RegularNoodles");
  fetchInvestmentsByName("RegularNoodles");
  fetchActiveInvestmentsByName("TooEarlyForFlapjacks");
  fetchTopInvestors();
  fetchFirmById(10);
  fetchFirmMembersById(10);
  fetchTopFirms();
}
*/