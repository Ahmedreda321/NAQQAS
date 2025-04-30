import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_consumer.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/services/logger_service.dart';
import '../../../../core/services/service_locator.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ApiConsumer api;

  HomeCubit()
      : api = sl<ApiConsumer>(),
        super(const HomeInitial());

  void newSheet() async {
    final token = await LocalStorageService.getToken();
    AppLogger.d("🚨🚨🚨🚨🚨🚨Token: $token");
    final requestBody = {
      'sheetName': 'My Sheet',
      'token': token,
    };
    await api.post("?action=createsheet", body: requestBody);
  }

  void toggleFab() {
    emit(
      HomeUpdated(
        isFabExpanded: !state.isFabExpanded,
        isOrderMode: state.isOrderMode,
        selectedMedicines: state.selectedMedicines,
      ),
    );
  }

  void toggleOrderMode(List<Medicine> medicines) {
    final newOrderMode = !state.isOrderMode;
    final Set<Medicine> selectedMedicines =
        newOrderMode ? Set.from(medicines) : {};
    emit(
      HomeUpdated(
        isFabExpanded: state.isFabExpanded,
        isOrderMode: newOrderMode,
        selectedMedicines: selectedMedicines,
      ),
    );
  }

  void selectMedicine(Medicine medicine) {
    final newSelection = Set<Medicine>.from(state.selectedMedicines);
    if (newSelection.contains(medicine)) {
      newSelection.remove(medicine);
    } else {
      newSelection.add(medicine);
    }
    emit(
      HomeUpdated(
        isFabExpanded: state.isFabExpanded,
        isOrderMode: state.isOrderMode,
        selectedMedicines: newSelection,
      ),
    );
  }
}
