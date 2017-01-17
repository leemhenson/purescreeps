module Main where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Traversable (for_)
import Prelude (bind, Unit)
import Screeps.Effects (TICK)
import Screeps.Game (getGameGlobal, rooms, spawns)
import Screeps.Room (name) as Room
import Screeps.Spawn (name) as Spawn
import Screeps.Types (GameGlobal)

spawnCreeps :: ∀ e. GameGlobal -> Eff (console :: CONSOLE | e) Unit
spawnCreeps game = do
  log "spawnCreeps"

  for_ (spawns game) \s ->
    log (Spawn.name s)

loop :: ∀ e. Eff (console :: CONSOLE, tick :: TICK | e) Unit
loop = do
  log "loop"

  game <- getGameGlobal

  for_ (rooms game) \r ->
    log (Room.name r)

  spawnCreeps game
