import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class GoldPrice {
  final double barSell;
  final double barBuy;
  final double jewelrySell;
  final double jewelryBuy;
  final String releaseAt;

  GoldPrice({
    required this.barSell,
    required this.barBuy,
    required this.jewelrySell,
    required this.jewelryBuy,
    required this.releaseAt,
  });

  factory GoldPrice.fromJson(Map<String, dynamic> json) {
    return GoldPrice(
      barSell: (json['BarSell'] ?? 0).toDouble(),
      barBuy: (json['BarBuy'] ?? 0).toDouble(),
      jewelrySell: (json['JewelrySell'] ?? 0).toDouble(),
      jewelryBuy: (json['JewelryBuy'] ?? 0).toDouble(),
      releaseAt: json['ReleaseAt'] ?? '',
    );
  }
}

void main() {
  runApp(const GoldSignApp());
}

class GoldSignApp extends StatelessWidget {
  const GoldSignApp({super.key});

  @override
  Widget build(BuildContext context) {
    const maroon = Color(0xFF6B1F22);

    return MaterialApp(
      title: 'GOLDSIGN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: maroon),
        textTheme: GoogleFonts.notoSansThaiTextTheme(),
        useMaterial3: true,
      ),
      home: const PriceBoardPage(),
    );
  }
}

class PriceBoardPage extends StatelessWidget {
  const PriceBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;
            return Center(
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade800, width: 2),
                ),
                clipBehavior: Clip.antiAlias,
                child:
                    isWide
                        ? Row(
                          children: const [
                            SizedBox(width: 420, child: LeftPanel()),
                            Expanded(child: RightSlideshow()),
                          ],
                        )
                        : const Column(
                          children: [
                            Expanded(flex: 7, child: LeftPanel()),
                            const SizedBox(height: 12),
                            Expanded(flex: 3, child: RightSlideshow()),
                          ],
                        ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class LeftPanel extends StatefulWidget {
  const LeftPanel({super.key});

  @override
  State<LeftPanel> createState() => _LeftPanelState();
}

class _LeftPanelState extends State<LeftPanel> {
  GoldPrice? _goldPrice;
  Timer? _timer;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGoldPrice();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _fetchGoldPrice();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchGoldPrice() async {
    try {
      final response = await http.get(
        Uri.parse('https://goldprice.dedecafe.com/goldprice'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        if (mounted) {
          setState(() {
            _goldPrice = GoldPrice.fromJson(data);
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const maroon = Color(0xFF6B1F22);
    final white = Colors.white;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    String formatPrice(double price) {
      final formattedPrice = price.toStringAsFixed(2);
      final parts = formattedPrice.split('.');
      final integerPart = parts[0];
      final decimalPart = parts.length > 1 ? parts[1] : '00';

      // Add thousand separators
      final regex = RegExp(r'(\d)(?=(\d{3})+(?!\d))');
      final formattedInteger = integerPart.replaceAllMapped(
        regex,
        (match) => '${match.group(1)},',
      );

      return '$formattedInteger.$decimalPart';
    }

    return Container(
      color: maroon,
      padding: EdgeInsets.symmetric(
        horizontal: isSmallScreen ? 16 : 24,
        vertical: isSmallScreen ? 16 : 28,
      ),
      child: DefaultTextStyle(
        style: GoogleFonts.notoSansThai(
          color: white,
          fontSize: isSmallScreen ? 14 : 18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _BrandHeader(isSmallScreen: isSmallScreen),
            SizedBox(height: isSmallScreen ? 12 : 18),
            Center(
              child: Text(
                'ทองคำแท่ง',
                style: GoogleFonts.notoSansThai(
                  color: white,
                  fontSize: isSmallScreen ? 24 : 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: isSmallScreen ? 6 : 10),
            _isLoading
                ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
                : PriceRow(
                  label: 'รับซื้อ',
                  value:
                      _goldPrice != null
                          ? formatPrice(_goldPrice!.barBuy)
                          : '0',
                  isSmallScreen: isSmallScreen,
                ),
            SizedBox(height: isSmallScreen ? 6 : 10),
            _isLoading
                ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
                : PriceRow(
                  label: 'ขายออก',
                  value:
                      _goldPrice != null
                          ? formatPrice(_goldPrice!.barSell)
                          : '0',
                  isSmallScreen: isSmallScreen,
                ),
            SizedBox(height: isSmallScreen ? 16 : 26),
            Center(
              child: Text(
                'ทองคำรูปพรรณ',
                style: GoogleFonts.notoSansThai(
                  color: white,
                  fontSize: isSmallScreen ? 24 : 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: isSmallScreen ? 6 : 10),
            _isLoading
                ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
                : PriceRow(
                  label: 'รับซื้อ',
                  value:
                      _goldPrice != null
                          ? formatPrice(_goldPrice!.jewelryBuy)
                          : '0',
                  isSmallScreen: isSmallScreen,
                ),
            SizedBox(height: isSmallScreen ? 6 : 10),
            _isLoading
                ? const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                )
                : PriceRow(
                  label: 'ขายออก',
                  value:
                      _goldPrice != null
                          ? formatPrice(_goldPrice!.jewelrySell)
                          : '0',
                  isSmallScreen: isSmallScreen,
                ),
            const Spacer(),
            Center(
              child: Text(
                _goldPrice?.releaseAt ?? 'กำลังโหลดข้อมูล...',
                style: GoogleFonts.notoSansThai(
                  color: white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandHeader extends StatelessWidget {
  final bool isSmallScreen;
  const _BrandHeader({required this.isSmallScreen});

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFF1D38A);
    return Column(
      children: [
        Center(
          child: Container(
            width: isSmallScreen ? 40 : 54,
            height: isSmallScreen ? 40 : 54,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: gold,
            ),
            child: Center(
              child: Text(
                'G',
                style: TextStyle(
                  fontSize: isSmallScreen ? 22 : 30,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: isSmallScreen ? 6 : 10),
        Center(
          child: Column(
            children: [
              Text(
                'GOLEPRICE',
                style: GoogleFonts.montserrat(
                  color: gold,
                  fontSize: isSmallScreen ? 24 : 34,
                  fontWeight: FontWeight.w700,
                  letterSpacing: isSmallScreen ? 1 : 2,
                ),
              ),
              Text(
                'ห้างทองทดสอบ',
                style: GoogleFonts.notoSansThai(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 12 : 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isSmallScreen;
  const PriceRow({
    super.key,
    required this.label,
    required this.value,
    required this.isSmallScreen,
  });

  @override
  Widget build(BuildContext context) {
    const gold = Color(0xFFF1D38A);
    final white = Colors.white;
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 12 : 18,
              vertical: isSmallScreen ? 8 : 12,
            ),
            decoration: BoxDecoration(
              color: gold,
              borderRadius: BorderRadius.horizontal(
                left: Radius.circular(isSmallScreen ? 12 : 18),
              ),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.notoSansThai(
                color: Colors.black87,
                fontSize: isSmallScreen ? 16 : 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        SizedBox(width: isSmallScreen ? 4 : 8),
        Expanded(
          flex: 7,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 8 : 16,
              vertical: isSmallScreen ? 6 : 10,
            ),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 18),
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontSize: isSmallScreen ? 20 : 32,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class RightSlideshow extends StatefulWidget {
  const RightSlideshow({super.key});

  @override
  State<RightSlideshow> createState() => _RightSlideshowState();
}

class _RightSlideshowState extends State<RightSlideshow> {
  final _controller = PageController();
  final List<String> _images = const [
    'assets/1.webp',
    'assets/2.webp',
    'assets/3.webp',
  ];
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      _index = (_index + 1) % _images.length;
      _controller.animateToPage(
        _index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: _images.length,
            onPageChanged: (i) => setState(() => _index = i),
            itemBuilder: (context, i) {
              return Image.asset(
                _images[i],
                fit: BoxFit.cover,
                errorBuilder:
                    (c, e, s) => const Center(
                      child: Text(
                        'Add images to assets: slide1.jpg, slide2.jpg, slide3.jpg',
                      ),
                    ),
              );
            },
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_images.length, (i) {
                final active = i == _index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: active ? 22 : 8,
                  decoration: BoxDecoration(
                    color: active ? Colors.black87 : Colors.black45,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }),
            ),
          ),
          Positioned(
            left: 8,
            top: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.55),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'GOLEPRICE',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
