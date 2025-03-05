[English](README_EN.md) | [中文](README.md)

# 食物轮盘 (Food Roulette Wheel)

一个帮助你随机决定吃什么的Flutter应用，通过旋转轮盘随机选择食物，解决"今天吃什么"的日常难题。

![应用图标](assets/image_fx_.jpg)

## 功能特点

- **食物轮盘**：精美的可旋转轮盘界面，每个食物选项以不同颜色区分
- **随机选择**：点击轮盘或按钮触发旋转动画，随机选择一种食物
- **结果展示**：轮盘停止后清晰显示选中的食物结果
- **自定义食物**：预设多种常见食物选项（火锅、寿司、披萨等）
- **流畅动画**：使用Flutter动画系统实现平滑的旋转效果

## 技术实现

- 使用Flutter框架开发，支持Android、iOS、Web等多平台
- 采用Material Design 3设计风格
- 自定义绘制组件实现轮盘效果
- 使用动画控制器实现平滑的旋转动画
- 随机数生成器确保选择的随机性

## 安装方法

### 前提条件

- 安装Flutter SDK (^3.7.0)
- 配置好Flutter开发环境

### 获取代码

```bash
# 克隆项目
git clone git clone https://github.com/zym9863/food_roulette_wheel.git

# 进入项目目录
cd food_roulette_wheel

# 安装依赖
flutter pub get
```

### 运行应用

```bash
# 运行应用
flutter run
```

## 使用方法

1. 启动应用，进入主界面
2. 点击轮盘中心或下方的"旋转轮盘"按钮
3. 等待轮盘旋转并停止
4. 查看结果区域显示的食物选择

## 依赖库

- flutter_animate: ^4.5.0
- simple_animations: ^5.0.2
- cupertino_icons: ^1.0.8

## 开发者

如需贡献代码或报告问题，请提交Issue或Pull Request。

## 许可证

本项目采用MIT许可证。详情请参阅LICENSE文件。
