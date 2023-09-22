class Item{
  String? title;
  String? description;
  Item({
    this.title,
    this.description,
  });

  factory Item.fromJson(Map<String,dynamic>json)=>
    Item(
      title: json['title'],
      description: json['description'],
    );
  Map<String, dynamic> toJson() => {'title': title, 'description': description};


}