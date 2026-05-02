# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)

## [0.0.14] - 2026-05-02

[diff](https://github.com/van-appears/mikroga/compare/0.0.13...0.0.14)

### Added

- Added `explosion.lua` to represent a fading piece of shrapnel. On enemy death a random number of explosions are created with random speed.

## [0.0.13] - 2026-05-01

[diff](https://github.com/van-appears/mikroga/compare/0.0.12...0.0.13)

### Changed

- Being hit no longer clears the screen but loses a life and sets a 3-second invulnerability timer, using an additional image.

## [0.0.12] - 2026-04-27

[diff](https://github.com/van-appears/mikroga/compare/0.0.11...0.0.12)

### Added

- Created `hud.lua` to render both the score and number of lives

### Changed

- Simple 'life' implementation wipes out enemies and bullets on hit, or resets back to menu
when all lives are gone.

## [0.0.11] - 2026-04-26

[diff](https://github.com/van-appears/mikroga/compare/0.0.10...0.0.11)

### Changed

- Updated `enemybullet.lua` to also use enemypath.
- Changed enemies to return a table of data to initialise enemypath for the bullets.
- Updated `enemypath.lua` to include bouncing when dropping, and to bounch round the screen in the random mode.

## [0.0.10] - 2026-04-22

[diff](https://github.com/van-appears/mikroga/compare/0.0.9...0.0.10)

### Added

- Added `enemypath.lua` as a set of different paths that enemies can take

### Changed

- Updated `enemy1.lua` and `enemy2.lua` to use an enemypath for direction, and to fire after a set time rather than when they reach a specific location.
- Changed `game.lua` to add enemies on a regular timer rather than when they die or go offscreen.
- Updated `player.lua` to handle both enemy path location and bullet location. 

## [0.0.9] - 2026-04-20

[diff](https://github.com/van-appears/mikroga/compare/0.0.8...0.0.9)

### Added

- Added `scoreboard.lua` as a global store for the high score

### Changed

- Updated enemies to have individual scores
- Updated `game.lua` to store and render the game score and set it in the Scoreboard at the end of the game

## [0.0.8] - 2026-04-20

[diff](https://github.com/van-appears/mikroga/compare/0.0.7...0.0.8)

### Added

- Added health property to enemies so they aren't killed by a single shot

## [0.0.7] - 2026-04-19

[diff](https://github.com/van-appears/mikroga/compare/0.0.6...0.0.7)

### Added

- Added a new `enemy2.lua` which is a second ship with a different firing pattern. This also means adding an additional image in `images.lua`

### Changed

- Updated `enemybullet.lua` so that bullets are targeted or not ('setTarget') flag
- Updated `game.lua` to pick a random enemy to add at each point, rather than always Enemy1

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
