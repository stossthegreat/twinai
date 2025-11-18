import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/app_models.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

class BottomTabs extends StatefulWidget {
  final TabType selectedTab;
  final ValueChanged<TabType> onTabChanged;
  final String mode;

  const BottomTabs({
    Key? key,
    required this.selectedTab,
    required this.onTabChanged,
    this.mode = "CALM",
  }) : super(key: key);

  @override
  State<BottomTabs> createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs>
    with TickerProviderStateMixin {
  late AnimationController _glowController;

  final List<TabItem> tabs = [
    TabItem(id: TabType.twin, label: 'TWIN', icon: '◈'),
    TabItem(id: TabType.memory, label: 'MEMORY', icon: '◉'),
    TabItem(id: TabType.patterns, label: 'SYSTEMS', icon: '◊'),
    TabItem(id: TabType.future, label: 'PROPHET', icon: '✶'),
    TabItem(id: TabType.dreams, label: 'DREAMS', icon: '🌙'),
    TabItem(id: TabType.shadow, label: 'SHADOW', icon: '⚫'),
  ];

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.tabHeight,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.white10,
            width: 1,
          ),
        ),
        color: Colors.black,
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: tabs.map((tab) {
            final isSelected = tab.id == widget.selectedTab;
            return _buildTabItem(tab, isSelected);
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildTabItem(TabItem tab, bool isSelected) {
    final modeColor = AppColors.getSystemModeColor(widget.mode);
    final activeColor = isSelected ? modeColor : AppColors.white40;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => widget.onTabChanged(tab.id),
        behavior: HitTestBehavior.opaque,
        child: Transform.scale(
          scale: isSelected ? 1.1 : 1.0,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: AppDimensions.animationFast),
            curve: Curves.easeInOut,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon with glow effect
                AnimatedBuilder(
                  animation: _glowController,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.all(AppDimensions.paddingS),
                      decoration: isSelected
                          ? BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: modeColor.withOpacity(
                                    0.3 + 0.2 * _glowController.value,
                                  ),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            )
                          : null,
                      child: Text(
                        tab.icon,
                        style: TextStyle(
                          fontSize: 18,
                          color: activeColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
                
                const SizedBox(height: 2),
                
                // Label
                Text(
                  tab.label,
                  style: TextStyle(
                    fontSize: 9,
                    color: activeColor,
                    letterSpacing: 2.8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // Active indicator
                AnimatedContainer(
                  duration: const Duration(milliseconds: AppDimensions.animationFast),
                  width: isSelected ? 4 : 0,
                  height: isSelected ? 4 : 0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: modeColor,
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: modeColor.withOpacity( 0.9),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ]
                        : null,
                  ),
                ).animate(target: isSelected ? 1 : 0)
                  .scale(
                    begin: const Offset(0, 0),
                    end: const Offset(1, 1),
                    duration: 300.ms,
                    curve: Curves.elasticOut,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
