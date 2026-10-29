import 'package:flutter/material.dart';

// Модель данных для карточки (Лаба 3)
class SpaceItem {
  final String title;
  final String description;
  final String imageUrl;

  SpaceItem({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

// Главный экран со списком карточек
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Данные для карточек
  final List<SpaceItem> _items = [
    SpaceItem(
      title: 'Планета Марс',
      description: 'Красная планета, четвертая от Солнца. Имеет два спутника: Фобос и Деймос.',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/0/02/OSIRIS_Mars_true_color.jpg',
    ),
    SpaceItem(
      title: 'Туманность Андромеды',
      description: 'Ближайшая к Млечному Пути большая галактика. Содержит триллионы звезд.',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/9/98/Andromeda_Galaxy_%28with_h-alpha%29.jpg',
    ),
    SpaceItem(
      title: 'Черная дыра',
      description: 'Область пространства-времени с настолько сильным тяготением, что покинуть её не могут даже объекты, движущиеся со скоростью света.',
      imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/4/4f/Black_hole_-_Messier_87_crop_max_res.jpg',
    ),
  ];

  // Список для хранения лайкнутых карточек (Лаба 4)
  final Set<int> _likedItems = {};

  // Метод для лайка и показа Snackbar
  void _toggleLike(int index) {
    setState(() {
      if (_likedItems.contains(index)) {
        _likedItems.remove(index);
      } else {
        _likedItems.add(index);
      }
    });

    // Показ всплывающего сообщения (Snackbar)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _likedItems.contains(index)
              ? 'Вы поставили лайк: ${_items[index].title}'
              : 'Лайк убран: ${_items[index].title}',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  // Переход на экран с деталями (Лаба 4)
  void _openDetails(SpaceItem item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailsPage(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Севоднясев Станислав ПИбд-33'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          final isLiked = _likedItems.contains(index);

          // Сама карточка
          return Card(
            elevation: 4,
            margin: const EdgeInsets.only(bottom: 16.0),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => _openDetails(item), // Нажатие на карточку
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Картинка
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      item.imageUrl,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 180,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image, size: 50),
                        );
                      },
                    ),
                  ),
                  // Текст и кнопка лайка
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                item.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                        // Кнопка лайка
                        IconButton(
                          icon: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : null,
                          ),
                          onPressed: () => _toggleLike(index),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Экран с детальной информацией (Лаба 4)
class DetailsPage extends StatelessWidget {
  final SpaceItem item;

  const DetailsPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              item.imageUrl,
              height: 300,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 300,
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, size: 80),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    item.description,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Дополнительная информация:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Здесь может быть любой текст на ваше усмотрение. Это окно открывается при нажатии на карточку, как и требовалось в Лабораторной 4.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}