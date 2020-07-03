# Personal-LuaAndLove2d-ZeldaWithBullets

Game Prototyping I did when I had no internet and 6hrs/day of electricity in the Dominican Republic during my Peace Corps Service. I downloaded as many relevant libraries as I could offline: 
https://github.com/love2d-community/awesome-love2d

Uses BUMP Collision System with Simple Tiled Implementation libraries. 

Used Tiled application to organize assets:
https://thorbjorn.itch.io/tiled

Got assets from: 
https://opengameart.org/

Mostly worked on this offline weeks at a time, so there's alot of junk that makes no sense haha
Tried to separate every object as much as I could so I could use this as a platform for multiple projects. That's why the Player and Bullets are separate. Currently working on EnemyClass. Game currently shows the collision box


It sucked to do this without any internet resources, but I'm relatively proud of it.

Aiming for a Zenonia Meets Hotline Miami eventually. Fast 2D Arcade Action with RPG elements and persistent world. Would love to collaborate with other LUA/LOVE2D programmers and artists!

Controls
Move - WASD
Sprint - Left Shit + WASD
Shoot - J/K 

---
Ideas I want to implement
* Style Cues
    * Legend of Zelda 
        * Top-Down 
        * Zenonia - Overworld and dungeons are combined
    * Tales of Symphonia RPG
        * Special Moves can be assigned to certain keys
            * buttons for each attack
            * button combos = different sets of attacks
    * Pokemon Type Matchups 
        * Damage effectiveness 
    * Detective adventure story 
        * Clues, RPG-ish puzzles
    * Flashbacks and Concurrent stories
        * for each big game event, replay scene (in Hotline Miami Style)
* Features
    * Fatigue Recovery system
        * Auto-recover
            * Sprint takes fatigue
            * Running
            * Getting shot while covered
    * Cover system
        * auto grab to cover
        * if touching object
            * automatic cover
        * Getting shot under cover reduces fatigue
    * Flashbacks
        * for each crime-scene, replay scene 
            * As it happened (i.e. play as the bad guys)
            * skill of main player
                * reference to her latent psychic ability

Create Love Zip File
```
zip -9 -r ZeldaBullets.love .
```

Run game
```
open ZeldaBullets.love
```
or

```
love ./
```