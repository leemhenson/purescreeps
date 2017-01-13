module Main where

import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, logShow)
import Prelude (Unit)
import Screeps (CMD)

loop :: ∀ e. Eff (cmd :: CMD, console :: CONSOLE | e) Unit
loop = do
  logShow "testing"
