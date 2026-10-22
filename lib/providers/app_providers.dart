import 'package:gokul_weds_vrinda/providers/card_providers.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProviders {
  static List<SingleChildWidget> get allProviders => [
        ChangeNotifierProvider(create: (_) => CardProvider()),
        // Innu future-il vere providers venamengilum ivide add cheyyam
      ];
}