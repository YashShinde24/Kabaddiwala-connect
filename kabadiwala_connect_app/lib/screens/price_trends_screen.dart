import 'package:flutter/material.dart';
import '../app_colors.dart';
import '../components/price_item_card.dart';

class PriceTrendsScreen extends StatefulWidget {
  const PriceTrendsScreen({super.key});

  @override
  State<PriceTrendsScreen> createState() => _PriceTrendsScreenState();
}

class _PriceTrendsScreenState extends State<PriceTrendsScreen> {
  int _selectedFilter = 0;
  final _filters = ['All', 'E-Waste', 'Paper', 'Plastic', 'Metal', 'Glass'];
  final _searchController = TextEditingController();

  final _items = const [
    _PriceData('E-Waste Motherboard', Icons.memory, '₹320/kg', '+₹15 today', true),
    _PriceData('Copper Wire', Icons.cable, '₹550/kg', '+₹22 today', true),
    _PriceData('Aluminium', Icons.view_module, '₹120/kg', '+₹5 today', true),
    _PriceData('Iron / Steel', Icons.hardware, '₹45/kg', '-₹2 today', false),
    _PriceData('Newspaper', Icons.newspaper, '₹15/kg', '-₹1 today', false),
    _PriceData('Cardboard', Icons.inventory_2, '₹12/kg', '0 today', true),
    _PriceData('Plastic Bottles', Icons.local_drink, '₹20/kg', '+₹1 today', true),
    _PriceData('Hard Plastic', Icons.format_shapes, '₹18/kg', '0 today', true),
    _PriceData('Glass Bottles', Icons.wine_bar, '₹5/kg', '-₹1 today', false),
    _PriceData('CRT Monitor', Icons.monitor, '₹80/kg', '+₹10 today', true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
              color: AppColors.surface,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.trending_up, color: AppColors.secondary, size: 22),
                          SizedBox(width: 6),
                          Text('Live Market Rates',
                              style: TextStyle(
                                  fontFamily: 'Noto Sans',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.onSurface)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.location_on, size: 13, color: AppColors.secondary),
                            SizedBox(width: 4),
                            Text('Delhi NCR',
                                style: TextStyle(
                                    fontFamily: 'Noto Sans',
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.onSurface)),
                            SizedBox(width: 2),
                            Icon(Icons.arrow_drop_down, size: 16, color: AppColors.onSurfaceVariant),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Search bar
                  Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLowest,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.outlineVariant),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(Icons.search, color: AppColors.onSurfaceVariant, size: 20),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: const InputDecoration(
                              hintText: 'Search scrap category...',
                              hintStyle: TextStyle(
                                  fontFamily: 'Noto Sans',
                                  fontSize: 14,
                                  color: AppColors.onSurfaceVariant),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Filter chips
                  SizedBox(
                    height: 34,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _filters.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 8),
                      itemBuilder: (context, i) => GestureDetector(
                        onTap: () => setState(() => _selectedFilter = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                          decoration: BoxDecoration(
                            color: _selectedFilter == i
                                ? AppColors.primary
                                : AppColors.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: _selectedFilter == i
                                  ? AppColors.primary
                                  : AppColors.outlineVariant,
                            ),
                          ),
                          child: Text(_filters[i],
                              style: TextStyle(
                                  fontFamily: 'Noto Sans',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: _selectedFilter == i
                                      ? Colors.white
                                      : AppColors.onSurfaceVariant)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Last updated
                  Row(
                    children: [
                      Container(
                        width: 6, height: 6,
                        decoration: const BoxDecoration(
                          color: AppColors.statusOnline,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text('Rates updated 2 min ago',
                          style: TextStyle(
                              fontFamily: 'Noto Sans',
                              fontSize: 11,
                              color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                ],
              ),
            ),

            // List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: _items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, i) => PriceItemCard(
                  nameEn: _items[i].nameEn,
                  icon: _items[i].icon,
                  price: _items[i].price,
                  delta: _items[i].delta,
                  isPositive: _items[i].isPositive,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceData {
  final String nameEn, price, delta;
  final IconData icon;
  final bool isPositive;
  const _PriceData(this.nameEn, this.icon, this.price, this.delta, this.isPositive);
}
