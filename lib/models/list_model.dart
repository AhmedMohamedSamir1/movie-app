class ListModel
{
  late String listId;
  late String listName;

  ListModel({
    required this.listId,
    required this.listName,
  });

  ListModel.fromJson(Map<String, dynamic> json)
  {
    listId = json['listId'];
    listName = json['listName'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      'listId': listId,
      'listName': listName,
    };
  }
}