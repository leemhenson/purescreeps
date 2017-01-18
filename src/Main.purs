module Main where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, log)
import Data.Int (decimal, toStringAs)
import Data.Maybe (maybe)
import Data.Traversable (for_)
import Prelude ((<>), bind, Unit)
import Screeps.Constants (part_carry, part_move, part_work)
import Screeps.Effects (TICK)
import Screeps.Game (getGameGlobal, rooms, spawns)
import Screeps.Room (name)
import Screeps.Room (name) as R
import Screeps.Spawn (CreepInfo, canCreateCreep)
import Screeps.Spawn (energy, energyCapacity, name) as S
import Screeps.Types (GameGlobal, ReturnCode(..), Room, Spawn)

showCreepInfo :: CreepInfo -> String
showCreepInfo info = info.name <> " (" <> info.remainingTime <> "/" <> info.needTime <> ")"

showSpawningCreepInfo :: CreepInfo -> String
showSpawningCreepInfo info = " spawning " <> showCreepInfo info

showSpawn :: Spawn -> String
showSpawn spawn = "[spawn] " <> name <> " (" <> energy <> "/" <> capacity <> ")" <> spawning
  where
    capacity = toStringAs decimal (S.energyCapacity spawn)
    energy = toStringAs decimal (S.energy spawn)
    name = S.name spawn
    spawning = maybe "" showSpawningCreepInfo (S.spawning spawn)

showRoom :: Room -> String
showRoom room = "[room] " <> name
  where
    name = R.name room

spawnHarvester :: Spawn -> ReturnCode
spawnHarvester spawn = canCreateCreep spawn [part_move part_carry part_work]

loop :: ∀ e. Eff (console :: CONSOLE, tick :: TICK | e) Unit
loop = do
  log "loop"

  game <- getGameGlobal

  for_ (rooms game) \room ->
    log (showRoom room)

  for_ (spawns game) \spawn ->
    log (showSpawn spawn)
