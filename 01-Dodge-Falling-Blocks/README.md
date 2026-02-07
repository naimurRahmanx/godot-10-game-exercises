```sh
# Game 01 – Dodge the Falling Blocks

## Screenshots

### Gameplay
![Gameplay]([./screenshots/gameplay.png](https://github.com/naimurRahmanx/godot-10-game-exercises/blob/main/01-Dodge-Falling-Blocks/screenshots/gameplay.png?raw=true))

### Game Over
![Game Over]([./screenshots/game-over.png](https://github.com/naimurRahmanx/godot-10-game-exercises/blob/main/01-Dodge-Falling-Blocks/screenshots/game-over.png?raw=true))


## Goal
Move the player left and right to avoid falling blocks.

## Controls
- Left Arrow / A → Move left
- Right Arrow / D → Move right

## Concepts Practiced
- Scene instancing (`PackedScene`)
- Timers (`Timer.timeout`)
- Signals (built-in + custom)
- Area2D vs CharacterBody2D collisions
- Player movement clamping using sprite size

## Notes
This game was rebuilt multiple times to understand:
- Area2D vs CharacterBody2D
- Signal connections
- Scene responsibility

## Reflection
This game helped clarify how overall game flow should be handled by a main scene,
while player and obstacle scenes focus only on their own behavior.

```
