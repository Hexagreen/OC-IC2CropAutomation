local config = {
    -- NOTE: EACH CONFIG SHOULD END WITH A COMMA

    -- Side Length of Working Farm
    workingFarmSizeX = 6,
    workingFarmSizeY = 6,
    workingFarmPos = {0, 1},
    -- Side Length of Storage Farm
    storageFarmSizeX = 9,
    storageFarmSizeY = 9,
    storageFarmPos = {2, -2},

    -- The coordinate for charger
    chargerPos = {0, 0},
    -- The coordinate for the container contains crop sticks
    stickContainerPos = {-1, 0},
    -- The coordinate for the container to store seeds, products, etc
    storagePos = {-2, 0},

    -- Once complete, remove all extra crop sticks to prevent the working farm from weeding
    cleanUp = true,
    -- Pickup any and all drops (don't change)
    pickUpDrops = true,
    -- Keep crops that are not the target crop during autoSpread and autoStat
    keepMutations = true,
    -- Stat-up crops during autoTier (Very Slow)
    statWhileTiering = false,

    -- Minimum tier for the working farm during autoTier
    autoTierThreshold = 13,
    -- Minimum Gr + Ga - Re for the working farm during autoStat (21 + 31 - 0 = 52)
    autoStatThreshold = 52,
    -- Minimum Gr + Ga - Re for the storage farm during autoSpread (23 + 31 - 0 = 54)
    autoSpreadThreshold = 54,

    -- Maximum Growth for crops on the working farm
    workingMaxGrowth = 23,
    -- Maximum Resistance for crops on the working farm
    workingMaxResistance = 9,
    -- Maximum Growth for crops on the storage farm
    storageMaxGrowth = 23,
    -- Maximum Resistance for crops on the storage farm
    storageMaxResistance = 9,

    -- Minimum Charge Level
    needChargeLevel = 0.2,
    -- Max breed round before termination of autoTier.
    maxBreedRound = 1000,

    -- The slot for spade
    spadeSlot = 0,
    -- The slot for crop sticks
    stickSlot = -1,
    -- The slot which the robot will stop storing items
    storageStopSlot = -2
}

config.workingFarmArea = config.workingFarmSizeX * config.workingFarmSizeY
config.storageFarmArea = config.storageFarmSizeX * config.storageFarmSizeY

return config