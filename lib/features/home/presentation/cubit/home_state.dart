// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:equatable/equatable.dart';


class Medicine extends Equatable {
  final String name;
  final String dosage;
  final bool isAvailable;
   int quantity;

   Medicine({
    required this.name,
    required this.dosage,
    required this.isAvailable,
    required this.quantity });

  @override
  List<Object> get props => [name, dosage, isAvailable, quantity];
}

abstract class HomeState extends Equatable {
  final bool isFabExpanded;
  final bool isOrderMode;
  final Set<Medicine> selectedMedicines;

  const HomeState({
    required this.isFabExpanded,
    required this.isOrderMode,
    required this.selectedMedicines,
  });

  @override
  List<Object> get props => [isFabExpanded, isOrderMode, selectedMedicines];
}

class HomeInitial extends HomeState {
  const HomeInitial()
      : super(
          isFabExpanded: false,
          isOrderMode: false,
          selectedMedicines: const {},
        );
}

class HomeUpdated extends HomeState {
  const HomeUpdated({
    required super.isFabExpanded,
    required super.isOrderMode,
    required super.selectedMedicines,
  });

  HomeUpdated copyWith({
    bool? isFabExpanded,
    bool? isOrderMode,
    Set<Medicine>? selectedMedicines,
  }) {
    return HomeUpdated(
      isFabExpanded: isFabExpanded ?? this.isFabExpanded,
      isOrderMode: isOrderMode ?? this.isOrderMode,
      selectedMedicines: selectedMedicines ?? this.selectedMedicines,
    );
  }
}
