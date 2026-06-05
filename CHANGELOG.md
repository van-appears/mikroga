# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)

## [0.0.29] - 2026-06-05

[diff](https://github.com/van-appears/mikroga/compare/0.0.28...0.0.29)

### Added

- Created `level2.lua`, which at this point is mostly just a copy of `level1.lua`
- Created `enemy3.lua`, a third enemy type that fires forward along with its assets

### Changed

- Changed game.lua to allow multiple levels 

## [0.0.28] - 2026-05-30

[diff](https://github.com/van-appears/mikroga/compare/0.0.27...0.0.28)

### Changed

- Removing items from a table inside a loop over that table leads to jerkiness in some movements - so this refactor traverse tables in a different way 

## [0.0.27] - 2026-05-26

[diff](https://github.com/van-appears/mikroga/compare/0.0.26...0.0.27)

### Added

- Created `firetrigger.lua` to represent a way of triggering firing methods in enemies.
- Created `Figure8Path` as a new path type

### Changed

- Updated `enemy.lua`, `enemy1.lua`, `enemy2.lua` to use firetrigger and fixed a bug where they had lost their points and health settings 
- Updated `baddy1.lua` to have its own firing patterns, and to use the figure8path

## [0.0.26] - 2026-05-22

[diff](https://github.com/van-appears/mikroga/compare/0.0.25...0.0.26)

### Added

- Created `baddy1.lua` to represent an end-of-level boss. Baddy1 has no movement or fire pattern at this point and just requires several hits to kill. Level only ends once baddy is killed.

## [0.0.25] - 2026-05-22

[diff](https://github.com/van-appears/mikroga/compare/0.0.24...0.0.25)

### Changed

- Updated the level to also have a draw method, showing a particle field and planet to give a sense of motion. Image taken from opengameart.org and attribution added to README.md
- Updated the invulnerable image to no longer be transpatent.

## [0.0.24] - 2026-05-17

[diff](https://github.com/van-appears/mikroga/compare/0.0.23...0.0.24)

### Changed

- Removed extraneous code from EnemyPath.
- Changed explosion to use EnemyPath:angled introduced in the last change.
- Made explosions a bit more random.

## [0.0.23] - 2026-05-17

[diff](https://github.com/van-appears/mikroga/compare/0.0.22...0.0.23)

### Changed

- Extended EnemyPath to include curved and strafing paths.
- Updated main to have constants for each path type, enemy type and colour.
- Updated level1 and game to use additional paths and make use of additional constants.

## [0.0.22] - 2026-05-15

[diff](https://github.com/van-appears/mikroga/compare/0.0.21...0.0.22)

### Added

- Added `level1.lua` to represent specific timings and types of enemies arriving onscreen, rather than randomly generated as before. This is a very roughly created set of positions.

### Changed

- Added another state "completed" to represent getting to the end of the level - this causes the player to fly off the top of the screen.
- Changes to `hud.lua` to also show a basic completed message.
- Note that there is now a lot of 'dead' code in EnemyPath.lua, but some of that may be useful to extend the level with more interesting enemy paths.

## [0.0.21] - 2026-05-11

[diff](https://github.com/van-appears/mikroga/compare/0.0.20...0.0.21)

### Changed

- Added another state "begin" to represent the initial start of the game
- Changes to `game.lua` so that enemies do not appear in the "begin" state and player is launched into the screen.
- Changed `hud.lua` to show very basic 'get ready' and 'game over' messages.

## [0.0.20] - 2026-05-10

[diff](https://github.com/van-appears/mikroga/compare/0.0.19...0.0.20)

### Changed

- Added another state "death" to represent the final life lost
- Changes to `game.lua` so that final life lost results in an explosion for the player but enemies keep moving around the screen for a few seconds before returning to the menu
- Changed `explosion.lua` to allow for an object with a path, or an x / y variable.

## [0.0.19] - 2026-05-09

[diff](https://github.com/van-appears/mikroga/compare/0.0.18...0.0.19)

### Changed

- Moved local variables into object variables in `game.lua`
- Wait for draw after update before killing player, so bullet hits can be rendered.

## [0.0.18] - 2026-05-08

[diff](https://github.com/van-appears/mikroga/compare/0.0.17...0.0.18)

### Added

- Creaged `Enemy.lua` containing the duplicate code from Enemy1 and Enemy2

### Changed

- Updated Enemy1 and Enemy2 to extend the new Enemy object
- Tidied up the player to pass through colour in opts, rather than patching it in `game.lua`.

## [0.0.17] - 2026-05-06

[diff](https://github.com/van-appears/mikroga/compare/0.0.16...0.0.17)

### Changed

- Shift key now changes the player colour
- Player bullets now also have a colour. Opposite colour hits cause twice as much damage.

## [0.0.16] - 2026-05-05

[diff](https://github.com/van-appears/mikroga/compare/0.0.15...0.0.16)

### Added

- Added `colour` property to player and changed mikroga images to also be a quad.
- Being hit by an enemy bullet of the same colour absorbs that bullet and adds a point, but does not kill the player.

## [0.0.15] - 2026-05-04

[diff](https://github.com/van-appears/mikroga/compare/0.0.14...0.0.15)

### Added

- Added inner `ImageQuad` into Images and create black and white versions of enemies and their bullets.
- Added two global constants for BLACK and WHITE

### Changed

- Enemies are assigned a random colour and use that to render them and their bullets. Other than how they look, there is no in-game difference between black and white at this point.

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
