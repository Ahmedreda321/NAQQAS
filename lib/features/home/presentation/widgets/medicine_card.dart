import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../cubit/home_state.dart';

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
