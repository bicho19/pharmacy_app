import 'package:flutter/material.dart';
import 'package:pharmacy_app/src/store/abstract/widget_view.dart';
import 'package:pharmacy_app/src/store/providers/auth_provider.dart';
import 'package:pharmacy_app/src/store/providers/leftover_provider.dart';
import 'package:pharmacy_app/src/store/providers/medicament_provider.dart';
import 'package:pharmacy_app/src/store/providers/patient_provider.dart';
import 'package:pharmacy_app/src/store/providers/prescription_provider.dart';
import 'package:pharmacy_app/src/store/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class StoreProvider extends StatefulWidget {
  StoreProvider({this.child});
  final Widget child;
  @override
  _StoreProviderController createState() => _StoreProviderController();
}

class _StoreProviderController extends State<StoreProvider> {
  PatientProvider _patientProvider = PatientProvider();
  AuthProvider _authProvider = AuthProvider();
  MedicamentProvider _medicamentProvider = MedicamentProvider();
  PrescriptionProvider _prescriptionProvider = PrescriptionProvider();
  SettingsProvider _settings = SettingsProvider();
  LeftOverProvider _leftOverProvider = LeftOverProvider();

  @override
  Widget build(BuildContext context) => _StoreProviderView(this);

  @override
  void initState() {
    super.initState();
        () async {
      await _patientProvider.init();
      await _authProvider.init();
      await _medicamentProvider.init();
      await _prescriptionProvider.init();
      await _settings.init();
      await _leftOverProvider.init();
    }();
  }
}

class _StoreProviderView
    extends WidgetView<StoreProvider, _StoreProviderController> {
  _StoreProviderView(_StoreProviderController state) : super(state);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => state._patientProvider,),
        ChangeNotifierProvider(create: (_) => state._authProvider,),
        ChangeNotifierProvider(create: (_) => state._medicamentProvider,),
        ChangeNotifierProvider(create: (_) => state._prescriptionProvider,),
        ChangeNotifierProvider(create: (_) => state._settings,),
        ChangeNotifierProvider(create: (_) => state._leftOverProvider,),
      ],
      child: state.widget.child,
    );
  }
}
