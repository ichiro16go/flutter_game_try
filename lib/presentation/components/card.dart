import 'package:flutter/material.dart';
import 'dart:math' as math;

// カードコンポーネント本体
class SpellCard extends StatelessWidget {
  const SpellCard({
    super.key,
    required this.manaCost,
    required this.cardName,
    this.cardIllustration,
    required this.cardText,
    this.expansion,
    this.cardNumber,
    required this.cardSize,
  });

  final int manaCost;
  final String cardName;
  final Widget? cardIllustration;
  final String cardText;
  final String? expansion;
  final String? cardNumber;
  final double cardSize;

  @override
  Widget build(BuildContext context) {
    // カードのサイズを画面幅に合わせて調整
    final cardWidth = cardSize * 0.9;
    final cardHeight = cardWidth * 1.4; // デュエマカードの比率は約1.4

    return Center(
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 44, 44, 44), // カードの枠色
          borderRadius: BorderRadius.circular(cardWidth * 0.05),
          border: Border.all(color: Colors.black, width: 0.01),
        ),
        child: Stack(
          children: [
            // 背景の白い部分
            Positioned.fill(
              top: cardHeight * 0.02,
              bottom: cardHeight * 0.02,
              left: cardWidth * 0.02,
              right: cardWidth * 0.02,
              child: Container(color: Colors.white),
            ),

            // ヘッダー部分
            _buildHeader(cardWidth, cardHeight),

            // イラストエリア
            Positioned(
              top: cardHeight * 0.18,
              left: cardWidth * 0.1,
              right: cardWidth * 0.1,
              height: cardHeight * 0.35,
              child: Container(
                color: Colors.grey[200], // イラストがない場合の背景色
                child:
                    cardIllustration ??
                    const Center(child: Text('Illustration')),
              ),
            ),

            // カードテキストエリア
            Positioned(
              top: cardHeight * 0.55,
              left: cardWidth * 0.1,
              right: cardWidth * 0.1,
              bottom: cardHeight * 0.1,
              child: _buildCardTextBox(cardWidth, cardHeight),
            ),

            // フッター部分
            _buildFooter(cardWidth, cardHeight),
          ],
        ),
      ),
    );
  }

  // ヘッダー（マナ、カード名、シンボル）を構築
  Widget _buildHeader(double cardWidth, double cardHeight) {
    return Stack(
      children: [
        // マナコスト
        Positioned(
          top: cardHeight * 0.03,
          left: cardWidth * 0.04,
          child: Container(
            width: cardWidth * 0.15,
            height: cardWidth * 0.15,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Center(
              child: Text(
                manaCost.toString(),
                style: TextStyle(
                  fontSize: cardWidth * 0.08,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        // カード名
        Positioned(
          top: cardHeight * 0.05,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              cardName,
              style: TextStyle(
                fontSize: cardWidth * 0.07,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // カードテキストボックスを構築
  Widget _buildCardTextBox(double cardWidth, double cardHeight) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 「呪文」タブ
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            border: Border(
              top: BorderSide(color: Colors.black),
              left: BorderSide(color: Colors.black),
              bottom: BorderSide(color: Colors.black),
            ),
          ),
          child: Center(
            child: Text('呪文', style: TextStyle(fontSize: cardWidth * 0.035)),
          ),
        ),
        // テキスト本文エリア
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Text(cardText, style: TextStyle(fontSize: cardWidth * 0.04)),
          ),
        ),
      ],
    );
  }

  // フッター（文明、エキスパンション）を構築
  Widget _buildFooter(double cardWidth, double cardHeight) {
    return Positioned(
      bottom: cardHeight * 0.03,
      left: cardWidth * 0.06,
      right: cardWidth * 0.06,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 文明シンボル (今回はジョーカーズのJをテキストで表現)
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Text(
              'J',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: cardWidth * 0.05,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
