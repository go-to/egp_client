import 'dart:ui';

class Config {
  // タイトル
  static const String appTitle = 'ヱビスビールに合う逸品グランプリ';

  // マップ表示
  static const double defaultMapLatitude = 35.64691938518296;
  static const double defaultMapLongitude = 139.71008179999998;
  static const double defaultMapZoom = 17;
  static const int locationDistanceFilter = 100;
  static const String googleMapStyleJsonPath =
      'assets/jsons/google_map_style.json';
  static const String shopDefaultImagePath = 'assets/images/shop_default.png';
  static const String shopOpenImagePath = 'assets/images/shop_open.png';
  static const String shopSelectedImagePath = 'assets/images/shop_selected.png';
  static const String isStampedImagePath = 'assets/images/done.png';
  static const String isStampedSelectedImagePath =
      'assets/images/done_selected.png';
  static const double shopImageWidth = 50;
  static const double shopImageHeight = 50;
  static const double shopSelectedImageWidth = 80;
  static const double shopSelectedImageHeight = 80;
  static const double latitudeAdjustValue = 0.00002;
  static const double longitudeAdjustValue = 0.00002;
  static const String notInCurrentSalesText = '時間外';
  static const String irregularHoliday = '不定休';
  static const String needsReservation = '要予約';
  static const int customMarkerIconGenerateProcessBatchSize = 100;

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

  // 店舗詳細
  static const String openMap = '地図を開く';
  static const String hasStamp = '獲得済み (%d個)';
  static const String receiveStamp = 'スタンプを獲得する';
  static const String cancelStamp = 'スタンプ取り消し';
  static const String mapSearchFirstKeyword = '恵比寿 %s %s';
  static const String googleMapsUrl = 'comgooglemaps://%s?q=%s';
  static const String appleMapsUrl = 'https://maps.apple.com/?q=%s';
  static const String browserUrl =
      'https://www.google.com/maps/search/?api=1&query=%s';

  // スタンプ
  static const String isStampedLabel = '済';
  static const String stampNumLabelPerShop = '店舗別';
  static const String stampNumLabelTotal = '合計';

  // イベントページ
  static const String eventBaseUrl = 'https://ebisu-gp.com';

  // メッセージ
  static const String messageUrlCopied = 'URLをコピーしました';
  static const String messageMapCannotOpened = 'マップを開けませんでした';

  // ボタンのラベル
  static const String buttonLabelOk = 'OK';
  static const String buttonLabelClose = '閉じる';

  // カラーコード
  static final Color colorFromRGBOCancel =
      Color.fromRGBO(220, 150, 150, 0.9); // #dc9696;
  static final Color colorFromRGBODisabled =
      Color.fromRGBO(204, 204, 204, 0.9); // #cccccc
  static final Color colorFromRGBOBeerDark =
      Color.fromRGBO(161, 152, 34, 0.9); // #a19822
  static final Color colorFromRGBOBeer =
      Color.fromRGBO(255, 215, 64, 0.9); // #ffd740
  static final Color colorFromRGBOWhite =
      Color.fromRGBO(255, 255, 255, 0.9); // #ffffff

  // 文字サイズ
  static final double fontSizeVeryLarge = 36;
  static final double fontSizeLarge = 20;
  static final double fontSizeMiddleLarge = 16;
  static final double fontSizeNormal = 14;
  static final double fontSizeSmall = 12;
  static final double fontSizeVerySmall = 10;

  // アイコンサイズ
  static final double iconSizeLarge = 24;
  static final double iconSizeMiddleSmall = 18;
  static final double iconSizeSmall = 16;

  // 秒数
  static final int overlayRemoveDelayedTime = 3;
}
