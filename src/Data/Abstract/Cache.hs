{-# LANGUAGE ConstraintKinds, GeneralizedNewtypeDeriving, TypeFamilies #-}
module Data.Abstract.Cache where

import Data.Abstract.Configuration
import Data.Abstract.Heap
import Data.Map.Monoidal as Monoidal
import Data.Semilattice.Lower
import Prologue

-- | A map of 'Configuration's to 'Set's of resulting values & 'Heap's.
newtype Cache term cell location value = Cache { unCache :: Monoidal.Map (Configuration term location cell value) (Set (value, Heap location cell value)) }
  deriving (Eq, Lower, Monoid, Ord, Reducer (Configuration term location cell value, (value, Heap location cell value)), Show, Semigroup)

type Cacheable term cell location value = (Ord (cell value), Ord location, Ord term, Ord value)

-- | Look up the resulting value & 'Heap' for a given 'Configuration'.
cacheLookup :: Cacheable term cell location value => Configuration term location cell value -> Cache term cell location value -> Maybe (Set (value, Heap location cell value))
cacheLookup key = Monoidal.lookup key . unCache

-- | Set the resulting value & 'Heap' for a given 'Configuration', overwriting any previous entry.
cacheSet :: Cacheable term cell location value => Configuration term location cell value -> Set (value, Heap location cell value) -> Cache term cell location value -> Cache term cell location value
cacheSet key value = Cache . Monoidal.insert key value . unCache

-- | Insert the resulting value & 'Heap' for a given 'Configuration', appending onto any previous entry.
cacheInsert :: Cacheable term cell location value => Configuration term location cell value -> (value, Heap location cell value) -> Cache term cell location value -> Cache term cell location value
cacheInsert = curry cons
