# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)

## [0.0.6] - 2026-04-18

[diff](https://github.com/van-appears/mikroga/compare/0.0.5...0.0.6)

### Added

- Added a new `images.lua` which is a global that represents the images, so that they are only loaded once

### Changed

- Updated other files to use less globals
- Changed player and enemy to return simple coords for the new bullets they launch rather than instantiate PlayerBullet and EnemyBullet directly

## [0.0.5] - 2026-04-14

[diff](https://github.com/van-appears/mikroga/compare/0.0.4...0.0.5)

### Added

- Added a new `playerbullet.lua` to represent the player shooting

### Changed

- Updated `player.lua` to fire bullets
- Updated `game.lua`to cover enemy and player bullet collisions

## [0.0.4] - 2026-04-12

[diff](https://github.com/van-appears/mikroga/compare/0.0.3...0.0.4)

### Added

- Added another simple global string called STATE
- Added a new `menu.lua` which shows basic title and instruction

### Changed

- Moved what previously was in `main.lua` into `game.lua`
- `main.lua` now uses the STATE value to determine whether to show the menu or game
- Colliding with a bullet or enemy now returns the game to the menu

## [0.0.3] - 2026-04-11

[diff](https://github.com/van-appears/mikroga/compare/0.0.2...0.0.3)

### Added

- Added bullets (`enemybullet.lua`) that are launched towards the player location once an 'enemy' reaches a specific location. Bullet collision restarts the game

### Changed

- Renamed certain variables to camelCase and changed windowH_height, window_width to WINDOW_HEIGHT, WINDOW_WIDTH

## [0.0.2] - 2026-04-05

[diff](https://github.com/van-appears/mikroga/compare/0.0.1...0.0.2)

### Added

- Added enemies (`enemy1.lua`) that fall from the top of the screen at random speed. Enemy collision restarts the game.

## [0.0.1] - 2026-04-04

### Added

- Very basic initial commit that just allows moving a ship around using the arrow keys
