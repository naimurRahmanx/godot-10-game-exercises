```sh
# Game 04 – Simple Shooter

A simple 2D shooter built in Godot 4.x.

The player moves left and right, shoots bullets upward, destroys falling enemies, and earns points.
If an enemy touches the player, the game ends.

---

## 🎯 Goal

- Move left and right
- Shoot enemies
- Increase score
- Avoid enemy collision

---

## 🎮 Controls

- Left Arrow / A → Move Left
- Right Arrow / D → Move Right
- Space → Shoot

---

## 🧠 Concepts Practiced

- Scene instancing (PackedScene)
- CharacterBody2D movement
- Area2D collision detection
- Collision layers & masks
- Signals (enemy_killed, player_hit)
- Score system
- Spawning with Timer
- Object lifecycle (queue_free)
- Global vs local position
- Scene responsibility separation

---

## 🏗 Scene Structure

Main Scene:

Main (Node2D)
 ├── Player (CharacterBody2D)
 ├── Timer
 ├── CanvasLayer
 │    ├── ScoreLabel
 │    └── GameOverLabel

Bullet Scene:

Bullet (Area2D)
 ├── Sprite2D
 └── CollisionShape2D

Enemy Scene:

Enemy (Area2D)
 ├── Sprite2D
 └── CollisionShape2D

---

## ⚙️ Collision Layers Setup

Layer 1 → Player  
Layer 2 → Enemy  
Layer 3 → Bullet  

Player:
- Layer: Player
- Mask: Enemy

Enemy:
- Layer: Enemy
- Mask: Player + Bullet

Bullet:
- Layer: Bullet
- Mask: Enemy

---

## 🔄 Game Flow

1. Player moves using physics-based movement.
2. Player shoots bullets with cooldown.
3. Bullet moves upward.
4. Enemy moves downward.
5. Bullet hits enemy → enemy.die() is called.
6. Enemy emits enemy_killed → Score increases.
7. Enemy hits player → player_hit signal.
8. Main stops spawning and shows Game Over.

---

## 📈 Score System

- Score increases by 1 per enemy destroyed.
- Score label updates dynamically.
- Game stops when player is hit.

---

## 🧱 Architectural Decisions

- Player handles input.
- Bullet handles enemy collision.
- Enemy handles its own death.
- Main handles score and game state.
- Signals are used for global events.
- No direct cross-scene manipulation.

---

## 📦 Folder Structure

04-Simple-Shooter/
 ├── scenes/
 ├── scripts/
 ├── assets/
 └── README.md

---

## 🧹 Git Notes

Recommended .gitignore entries for Godot 4:

.godot/
.import/

Do NOT ignore:
- .uid files
- .tscn
- .gd
- project.godot

---

## 🚀 How to Run

1. Open Godot 4.x
2. Import this project folder
3. Open Main.tscn
4. Press Run

---

## 📌 Reflection

This game builds on previous concepts and introduces:

- Projectile systems
- Multi-actor interaction
- Event-driven architecture
- Proper node responsibility
- Clean signal-based design

This is the first step toward more complex game systems.

---

Finished > Perfect.
```