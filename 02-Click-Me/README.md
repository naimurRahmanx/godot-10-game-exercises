```sh
# Game 02 – Clicker Game

## Screenshots

### Gameplay
![Gameplay](screenshots/gameplay.png)

---

## Goal
Click the button to increase the score.

---

## Controls
- Left Click → Increase score by 1

---

## Concepts Practiced
- `Control` node usage
- `VBoxContainer` layout behavior
- Button `pressed()` signal
- Updating `Label.text`
- Node path referencing (`$Layout/ScoreLabel`)
- Using `@onready` to cache node references
- Basic state management (`var score`)
- String formatting (`"Score: %d" % score`)

---

## Scene Structure

```
Main (Control)
└── Layout (VBoxContainer)
    ├── ScoreLabel (Label)
    └── ClickButton (Button)
```

---

## Notes
This game was intentionally simple to focus on UI fundamentals.

It helped clarify:
- The difference between `Control` and `Node2D`
- How container nodes control layout
- How signals trigger logic
- Why state should live in the main script instead of UI nodes
- Why incorrect node paths cause `null instance` errors

---

## Reflection
Although the code is short, this game reinforced important architectural ideas:

- UI layout is container-driven.
- Signals connect UI to logic cleanly.
- Scene hierarchy determines how node paths work.
- Separating update logic into a function keeps code organized.
- The script owns the score; the Label only displays it.

This game strengthened understanding of UI structure and signal flow in Godot 4.x.

```