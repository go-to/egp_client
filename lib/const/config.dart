class Config {
  // タイトル
  static const String appTitle = 'ヱビスビールに合う逸品グランプリ';

  // マップ表示
  static const double defaultMapLatitude = 35.64691938518296;
  static const double defaultMapLongitude = 139.71008179999998;
  static const double defaultMapZoom = 17;
  static const int locationDistanceFilter = 100;
  static const String shopDefaultImagePath = 'assets/shop_default.png';
  static const String shopOpenImagePath = 'assets/shop_open.png';
  static const String shopCloseImagePath = 'assets/shop_close.png';
  static const String shopSelectedImagePath = 'assets/shop_selected.png';
  static const String isStampedImagePath = 'assets/done.png';
  static const String isStampedSelectedImagePath = 'assets/done_selected.png';
  static const double shopImageWidth = 50;
  static const double shopImageHeight = 50;
  static const double shopSelectedImageWidth = 80;
  static const double shopSelectedImageHeight = 80;
  static const double latitudeAdjustValue = 0.00002;
  static const double longitudeAdjustValue = 0.00002;
  static const String notInCurrentSalesText = '時間外';
  static const String irregularHoliday = '不定休';
  static const String needsReservation = '要予約';

  // 現在地ボタン
  static const double currentPositionButtonWidth = 55;
  static const double currentPositionButtonHeight = 55;
  static const double currentPositionButtonPositionRight = 10;
  static const double currentPositionButtonPositionBottom = 20;

  // 検索項目
  static const Map<int, String> searchItemList = {
    0: '営業中',
    1: 'スタンプ未獲得',
    2: '不定休',
    3: '完全予約制',
    4: 'ビアカクテル部門',
  };

  // スタンプ
  static const String isStampedLabel = '済';
  static const String stampNumLabelPerShop = '店舗別';
  static const String stampNumLabelTotal = '合計';

  // イベントページ
  static const String eventBaseUrl = 'https://ebisu-gp.com';
}
