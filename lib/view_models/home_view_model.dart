import 'package:flutter/widgets.dart';

const String LoadingIndicatorTitle = '^';

class HomeViewModel extends ChangeNotifier {
  static const int ItemRequestThreshold = 15;

  int _currentPage = 0;
  List<String> _items;
  List<String> get items => _items;

  HomeViewModel() {
    _items = List<String>.generate(15, (index) => 'Title $index');
    // _items.insert(0, LoadingIndicatorTitle);
  }

  Future handleItemCreated(int index) async {
    int itemPosition = index + 1;
    bool requestMoreData = itemPosition % ItemRequestThreshold == 0;

    // ~/ divide and truncate to int
    int pageToRequest = itemPosition ~/ ItemRequestThreshold;

    if (requestMoreData && pageToRequest > _currentPage) {
      print('handleItemCreated | pageToRequest: $pageToRequest');
      _currentPage = pageToRequest;
      _showLoadingIndicator();

      await Future.delayed(Duration(seconds: 3));
      // Fetch your real api data here, we'll generate
      List<String> newFetchedItems = List<String>.generate(
          15, (index) => 'Title page: $_currentPage item: $index');

      _items.addAll(newFetchedItems);

      _removeLoadingIndicator();
    }
  }

  void _showLoadingIndicator() {
    _items.add(LoadingIndicatorTitle);
    notifyListeners();
  }

  void _removeLoadingIndicator() {
    _items.remove(LoadingIndicatorTitle);
    notifyListeners();
  }
}
