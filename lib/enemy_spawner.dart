import 'package:xania/components/enemy.dart';
import 'package:xania/game_controller.dart';

class EnemySpawner {
  final GameController gameController;
  final int maxSpawnInterval = 3000;
  final int minSpawnInterval = 700;
  final int intervalChange = 3;
  final int maxEnemies = 5;
  int currentInterval;
  int nextSpawn;

  EnemySpawner(this.gameController) {
    initialize();
  }
  void initialize() {
    killAllEnemies();
    currentInterval = maxSpawnInterval;
    nextSpawn = DateTime.now().millisecondsSinceEpoch + currentInterval;
  }

  void killAllEnemies() {
    gameController.enemies.forEach((Enemy e) => e.isDead = true);
  }

  void update(double t) {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (gameController.enemies.length < maxEnemies && now >= nextSpawn) {
      gameController.spawnEnemy();
      if (currentInterval > minSpawnInterval) {
        currentInterval -= intervalChange;
        currentInterval -= (currentInterval * 0.1).toInt();
      }
      nextSpawn = now + currentInterval;
    }
  }
}
