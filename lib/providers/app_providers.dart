import 'package:gokul_weds_vrinda/providers/audio_provider.dart';
import 'package:gokul_weds_vrinda/providers/card_providers.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  static List<SingleChildWidget> get allProviders => [
        ChangeNotifierProvider(create: (_) => CardProvider()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
      ];
}