// ========== ENUM ==========
enum TaskPriority { low, medium, high }

// ========== EXTENSION ==========
extension PriorityLabel on TaskPriority {
  String get label {
    switch (this) {
      case TaskPriority.low:
        return 'Низкий';
      case TaskPriority.medium:
        return 'Средний';
      case TaskPriority.high:
        return 'Высокий';
    }
  }
}

// ========== КЛАСС С ПОЛЯМИ И МЕТОДАМИ ==========
class Task {
  final String title;
  TaskPriority priority;
  bool isDone;

  Task(this.title, this.priority, {this.isDone = false});

  void markDone() {
    isDone = true;
  }

  @override
  String toString() {
    return '[${priority.label}] $title ${isDone ? "(выполнено)" : ""}';
  }
}

// ========== GENERICS (List<Task>) ==========
class TaskManager {
  final List<Task> _tasks = [];

  void addTask(Task task) {
    _tasks.add(task);
  }

  // ========== АНОНИМНАЯ ФУНКЦИЯ ==========
  void printAll() {
    _tasks.forEach((task) {
      print(task);
    });
  }

  // ========== FUTURE ==========
  Future<void> processTasksAsync() async {
    print('\n--- Асинхронная обработка ---');
    for (var task in _tasks) {
      await Future.delayed(const Duration(milliseconds: 300));
      task.markDone();
      print('Обработано: ${task.title}');
    }
    print('Все задачи обработаны.\n');
  }
}

// ========== ЗАПУСК ==========
Future<void> main() async {
  final manager = TaskManager();

  // ========== ЦИКЛ (for) ==========
  final titles = ['Купить хлеб', 'Сделать лабу', 'Позвонить маме'];
  final priorities = [TaskPriority.low, TaskPriority.high, TaskPriority.medium];

  for (var i = 0; i < titles.length; i++) {
    manager.addTask(Task(titles[i], priorities[i]));
  }

  print('--- Список задач ---');
  manager.printAll();

  // Запуск Future и ожидание
  await manager.processTasksAsync();

  print('--- После обработки ---');
  manager.printAll();
}