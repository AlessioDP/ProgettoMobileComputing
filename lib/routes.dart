import 'package:SearchIt/data/objects.dart';

class HomepageArguments {
  final bool itemsPage;

  HomepageArguments(this.itemsPage);
}

class ItempageArguments {
  final List<int> indexParent;
  //final ListedObject parent;

  ItempageArguments(this.indexParent);
}

class EditHomeArguments {
  //final Home home;
  final int indexHome;

  EditHomeArguments(this.indexHome);
}

class EditItemArguments {
  //final ListedObject parent;
  //final Item item;
  final List<int> indexParent;
  final int indexItem;

  EditItemArguments(this.indexParent, this.indexItem);
}

class ViewItemArguments {
  final List<int> indexParent;
  final Item item;

  ViewItemArguments(this.indexParent, this.item);
}
