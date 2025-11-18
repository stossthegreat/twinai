import 'package:flutter/material.dart';
import '../models/app_models.dart';
import '../providers/system_state.dart';
import '../widgets/universal_backdrop.dart';
import '../widgets/scanner_overlay.dart';
import '../widgets/glitch_overlay.dart';
import '../widgets/custom_header.dart';
import '../widgets/bottom_tabs.dart';
import 'twin_mode.dart';
import 'memory_mode.dart';
import 'pattern_mode.dart';
import 'future_mode.dart';
import 'dream_mode.dart';
import 'shadow_mode.dart';
import 'settings/settings_main.dart';
import '../constants/app_colors.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late SystemStateProvider _systemState;
  TabType _selectedTab = TabType.twin;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _systemState = SystemStateProvider();
    _systemState.startSystemUpdates();
  }

  @override
  void dispose() {
    _systemState.dispose();
    super.dispose();
  }

  void _onTabChanged(TabType newTab) {
    setState(() {
      _selectedTab = newTab;
    });
  }

  void _onScanningChanged(bool isScanning) {
    setState(() {
      _isScanning = isScanning;
    });
  }

  void _onSystemModeChanged(SystemMode mode) {
    _systemState.setSystemMode(mode);
  }

  Widget _buildCurrentMode() {
    switch (_selectedTab) {
      case TabType.twin:
        return TwinMode(
          mode: _systemState.getModeString(),
          onScanningChanged: _onScanningChanged,
          onSystemModeChanged: _onSystemModeChanged,
        );
      case TabType.memory:
        return MemoryMode();
      case TabType.patterns:
        return PatternMode();
      case TabType.future:
        return FutureMode();
      case TabType.dreams:
        return DreamMode(mode: _systemState.getModeString());
      case TabType.shadow:
        return ShadowMode(mode: _systemState.getModeString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _systemState,
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              // Universal backdrop with mode-specific effects
              UniversalBackdrop(mode: _systemState.getModeString()),
              
              // Scanner overlay (when active)
              ScannerOverlay(isScanning: _isScanning),
              
              // Glitch overlay (when triggered)
              GlitchOverlay(showGlitch: _systemState.showGlitch),
              
              // Main app structure with scrollable header
              NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: Colors.black,
                      expandedHeight: 200.0,
                      floating: true,
                      pinned: false,
                      snap: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: CustomHeader(
                          cognitiveLoad: _systemState.cognitiveLoad,
                          systemStatus: _systemState.statusLabel,
                          systemMode: _systemState.getModeString(),
                          neuralActivity: _systemState.neuralActivity,
                          emotionalValence: _systemState.emotionalValence,
                          consciousnessDepth: _systemState.consciousnessDepth,
                          showGlitch: _systemState.showGlitch,
                          onSettingsTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SettingsMainScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ];
                },
                body: Container(
                  color: Colors.black,
                  child: _buildCurrentMode(),
                ),
              ),
              
              // Fixed bottom navigation
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: BottomTabs(
                  selectedTab: _selectedTab,
                  onTabChanged: _onTabChanged,
                  mode: _systemState.getModeString(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}