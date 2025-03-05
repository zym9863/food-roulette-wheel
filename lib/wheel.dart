import 'dart:math';
import 'package:flutter/material.dart';

class RouletteWheel extends StatefulWidget {
  final List<String> items;
  final Function(String) onSelected;

  const RouletteWheel({
    Key? key,
    required this.items,
    required this.onSelected,
  }) : super(key: key);

  @override
  State<RouletteWheel> createState() => _RouletteWheelState();
}

class _RouletteWheelState extends State<RouletteWheel> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final Random _random = Random();
  double _angle = 0.0;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );

    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // 计算最终选中的项目
        final double anglePerItem = 2 * pi / widget.items.length;
        // 修正计算方式，使箭头指向正确的项目
        _selectedIndex = ((_angle % (2 * pi)) / anglePerItem).floor();
        widget.onSelected(widget.items[_selectedIndex]);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _spinWheel() {
    if (_controller.isAnimating) return;

    // 重置动画控制器
    _controller.reset();

    // 生成随机旋转角度（多转几圈再停下）
    final double spinAngle = _random.nextDouble() * 2 * pi + 4 * pi;
    _angle = spinAngle;

    // 创建新的旋转动画
    _animation = Tween<double>(
      begin: 0.0,
      end: spinAngle,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    // 开始动画
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(150),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                spreadRadius: 5,
              ),
            ],
          ),
          child: GestureDetector(
            onTap: _spinWheel,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 轮盘背景
                Container(
                  width: 310,
                  height: 310,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [Colors.grey.shade200, Colors.grey.shade400],
                      stops: const [0.7, 1.0],
                    ),
                  ),
                ),
                // 轮盘
                SizedBox(
                  width: 300,
                  height: 300,
                  child: Transform.rotate(
                    angle: _controller.isAnimating ? _animation.value : _angle,
                    child: CustomPaint(
                      painter: WheelPainter(widget.items),
                      size: const Size(300, 300),
                    ),
                  ),
                ),
                // 中心点和指针
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 8,
                        spreadRadius: 1,
                      ),
                    ],
                    border: Border.all(color: Colors.orange.shade700, width: 3),
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.restaurant, color: Colors.orange.shade700, size: 30),
                        // 添加一个小的叉子图标作为装饰
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Icon(Icons.restaurant_menu, color: Colors.orange.shade900, size: 15),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: _spinWheel,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade600,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 5,
          ),
          icon: const Icon(Icons.refresh),
          label: const Text('旋转轮盘', style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }
}

class WheelPainter extends CustomPainter {
  final List<String> items;
  final List<List<Color>> gradientColors = [
    [Colors.red.shade300, Colors.red.shade700],
    [Colors.orange.shade300, Colors.orange.shade700],
    [Colors.amber.shade300, Colors.amber.shade700],
    [Colors.green.shade300, Colors.green.shade700],
    [Colors.teal.shade300, Colors.teal.shade700],
    [Colors.blue.shade300, Colors.blue.shade700],
    [Colors.indigo.shade300, Colors.indigo.shade700],
    [Colors.purple.shade300, Colors.purple.shade700],
    [Colors.pink.shade300, Colors.pink.shade700],
    [Colors.deepOrange.shade300, Colors.deepOrange.shade700],
  ];

  WheelPainter(this.items);

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double anglePerItem = 2 * pi / items.length;

    // 绘制每个扇形区域
    for (int i = 0; i < items.length; i++) {
      final double startAngle = i * anglePerItem;
      final Paint paint = Paint()
        ..style = PaintingStyle.fill
        ..shader = RadialGradient(
          colors: gradientColors[i % gradientColors.length],
          center: Alignment.center,
          radius: 0.8,
        ).createShader(Rect.fromCircle(center: Offset(centerX, centerY), radius: radius));

      canvas.drawArc(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        startAngle,
        anglePerItem,
        true,
        paint,
      );

      // 绘制分隔线
      final Paint linePaint = Paint()
        ..color = Colors.white
        ..strokeWidth = 2;

      canvas.drawLine(
        Offset(centerX, centerY),
        Offset(
          centerX + radius * cos(startAngle),
          centerY + radius * sin(startAngle),
        ),
        linePaint,
      );

      // 绘制文本
      final textPainter = TextPainter(
        text: TextSpan(
          text: items[i],
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        textDirection: TextDirection.ltr,
      );

      textPainter.layout();

      // 计算文本位置（在扇形区域中心）
      final double textAngle = startAngle + anglePerItem / 2;
      final double textRadius = radius * 0.7; // 文本距离中心点的距离
      final double textX = centerX + textRadius * cos(textAngle) - textPainter.width / 2;
      final double textY = centerY + textRadius * sin(textAngle) - textPainter.height / 2;

      // 保存当前画布状态
      canvas.save();
      // 移动到文本位置
      canvas.translate(textX, textY);
      // 旋转文本使其沿着半径方向
      canvas.rotate(textAngle + pi / 2);
      // 绘制文本
      textPainter.paint(canvas, Offset.zero);
      // 恢复画布状态
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}