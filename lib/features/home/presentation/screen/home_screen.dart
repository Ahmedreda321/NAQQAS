import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:naqqas/features/home/presentation/widgets/search_widget.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Medicine> medicines = [
      Medicine(
        name: 'Paracetamol',
        dosage: '240 mg',
        isAvailable: true,
        quantity: 20,
      ),
      Medicine(
        name: 'Ibuprofen',
        dosage: '200 mg',
        isAvailable: false,
        quantity: 10,
      ),
      Medicine(
        name: 'Aspirin',
        dosage: '100 mg',
        isAvailable: true,
        quantity: 30,
      ),
      Medicine(
        name: 'Amoxicillin',
        dosage: '500 mg',
        isAvailable: true,
        quantity: 5,
      ),
      Medicine(
        name: 'Ciprofloxacin',
        dosage: '500 mg',
        isAvailable: false,
        quantity: 0,
      ),
      Medicine(
        name: 'Metformin',
        dosage: '500 mg',
        isAvailable: true,
        quantity: 15,
      ),
      Medicine(
        name: 'Lisinopril',
        dosage: '10 mg',
        isAvailable: true,
        quantity: 8,
      ),
      Medicine(
        name: 'Simvastatin',
        dosage: '20 mg',
        isAvailable: false,
        quantity: 0,
      ),
      Medicine(
        name: 'Levothyroxine',
        dosage: '50 mcg',
        isAvailable: true,
        quantity: 12,
      ),
      Medicine(
        name: 'Omeprazole',
        dosage: '20 mg',
        isAvailable: true,
        quantity: 25,
      ),
      Medicine(
        name: 'Amlodipine',
        dosage: '5 mg',
        isAvailable: false,
        quantity: 0,
      ),
    ];

    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(
                    context: context,
                    delegate: SearchWidget(
                      medicines: medicines,
                    ),
                  );
                },
                icon: const Icon(Icons.search)),
          ],
        ),
        drawer: Drawer(
            child: Column(
          children: [
            const DrawerHeader(
              child: Text('Drawer Header'),
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<HomeCubit>().newSheet();
                },
                child: const Text('new Sheet')),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Handle item tap
              },
            ),
          ],
        )),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      return ListView.builder(
                        itemCount: medicines.length,
                        itemBuilder: (context, index) {
                          final medicine = medicines[index];
                          return AnimatedMedicineCard(
                            medicine: medicine,
                            isSelected: state.selectedMedicines.contains(
                              medicine,
                            ),
                            onSelect: state.isOrderMode
                                ? () => context
                                    .read<HomeCubit>()
                                    .selectMedicine(medicine)
                                : null,
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton:
            // BlocBuilder<HomeCubit, HomeState>(
            //   builder: (context, state) {
            //     return FloatingActionButton(
            //       onPressed: () => context.read<HomeCubit>().toggleFab(),
            //       child: AnimatedSwitcher(
            //         duration: const Duration(milliseconds: 300),
            //         child:
            //             state.isFabExpanded
            //                 ? const Icon(Icons.close)
            //                 : const Icon(Icons.menu),
            //       ),
            //     );
            //   },
            // ),
            Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'fab1',
              onPressed: () {},
              child: const Icon(Icons.add_rounded),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              heroTag: 'fab2',
              onPressed: () {},
              child: const Icon(Icons.add_shopping_cart_rounded),
            ),
            const SizedBox(height: 16),
          ],
        ));
  }
}

class AnimatedMedicineCard extends StatefulWidget {
  final Medicine medicine;
  final bool isSelected;
  final VoidCallback? onSelect;

  const AnimatedMedicineCard({
    super.key,
    required this.medicine,
    this.isSelected = false,
    this.onSelect,
  });

  @override
  State<AnimatedMedicineCard> createState() => _AnimatedMedicineCardState();
}

class _AnimatedMedicineCardState extends State<AnimatedMedicineCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _incrementQuantity() {
    setState(() {
      widget.medicine.quantity++;
    });
    HapticFeedback.lightImpact();
  }

  void _decrementQuantity() {
    if (widget.medicine.quantity > 0) {
      setState(() {
        widget.medicine.quantity--;
      });
      HapticFeedback.lightImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: widget.onSelect,
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: widget.isSelected ? Colors.blue[400] : Colors.grey[900],
              borderRadius: BorderRadius.circular(16),
              border: widget.isSelected
                  ? Border.all(color: Colors.blue, width: 2)
                  : null,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.medicine.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Drug - ${widget.medicine.dosage}',
                        style: TextStyle(color: Colors.grey[400], fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[600]!, width: 1),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, color: Colors.white),
                        onPressed: _decrementQuantity,
                      ),
                      Text(
                        widget.medicine.quantity.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, color: Colors.white),
                        onPressed: _incrementQuantity,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  widget.medicine.isAvailable
                      ? Icons.check_circle
                      : Icons.cancel,
                  color:
                      widget.medicine.isAvailable ? Colors.green : Colors.red,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
