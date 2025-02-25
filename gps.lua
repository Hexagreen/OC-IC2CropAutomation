local robot = require('robot')
local config = require('config')
local nowFacing = 1
local nowPos = {0, 0}
local savedPos = {}

-- ======= BOXED SLOT ========
--  _________________________
-- | 63 62 61 60 59 58 57 56 |
-- | 48 49 50 51 52 53 54 55 |
-- | 47 46 45 44 43 42 41 40 |
-- | 32 33 34 35 36 37 38 39 |
-- | 31 30 29 28 27 26 25 24 |
-- | 16 17 18 19 20 21 22 23 |
-- | 15 14 13 12 11 10 09 08 |
-- | 00 01 02 03 04 05 06 07 |
--  ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
local function boxedSlotToPos(slot, xLength, zeroPos)
    local col = slot % xLength
    local row = slot // xLength
    local x
    local y

    if row % 2 == 1 then
        x = xLength - 1 - col + zeroPos[1]
    else
        x = col + zeroPos[1]
    end
    y = row + zeroPos[2]

    return {x, y}
end


local function workingSlotToPos(slot)
    return boxedSlotToPos(slot - 1, config.workingFarmSizeX, config.workingFarmPos)
end


local function storageSlotToPos(slot)
    return boxedSlotToPos(slot - 1, config.storageFarmSizeX, config.storageFarmPos)
end


local function getFacing()
    return nowFacing
end


local function getPos()
    return nowPos
end


local function safeForward()
    local forwardSuccess
    repeat
        forwardSuccess = robot.forward()
    until forwardSuccess
end


local function turnTo(facing)
    local delta = (facing - nowFacing) % 4
    nowFacing = facing
    if delta <= 2 then
        for _=1, delta do
            robot.turnRight()
        end
    else
        for _= 1, 4 - delta do
            robot.turnLeft()
        end
    end
end


local function turningDelta(facing)
    local delta = (facing - nowFacing) % 4
    if delta <= 2 then
        return delta
    else
        return 4-delta
    end
end


local function go(pos)
    if nowPos[1] == pos[1] and nowPos[2] == pos[2] then
        return
    end

    -- Find path
    local posDelta = {pos[1]-nowPos[1], pos[2]-nowPos[2]}
    local path = {}

    if posDelta[1] > 0 then
        path[#path+1] = {2, posDelta[1]}
    elseif posDelta[1] < 0 then
        path[#path+1] = {4, -posDelta[1]}
    end

    if posDelta[2] > 0 then
        path[#path+1] = {1, posDelta[2]}
    elseif posDelta[2] < 0 then
        path[#path+1] = {3, -posDelta[2]}
    end

    -- Optimal first turn
    if #path == 2 and turningDelta(path[2][1]) < turningDelta(path[1][1]) then
        path[1], path[2] = path[2], path[1]
    end

    for i=1, #path do
        turnTo(path[i][1])
        for _=1, path[i][2] do
            safeForward()
        end
    end

    nowPos = pos
end


local function down(distance)
    if distance == nil then
        distance = 1
    end
    for _=1, distance do
        robot.down()
    end
end


local function up(distance)
    if distance == nil then
        distance = 1
    end
    for _=1, distance do
        robot.up()
    end
end


local function save()
    savedPos[#savedPos+1] = nowPos
end


local function resume()
    if #savedPos == 0 then
        return
    end
    go(savedPos[#savedPos])
    savedPos[#savedPos] = nil
end


return {
    boxedSlotToPos = boxedSlotToPos,
    workingSlotToPos = workingSlotToPos,
    storageSlotToPos = storageSlotToPos,
    getFacing = getFacing,
    getPos = getPos,
    turnTo = turnTo,
    go = go,
    save = save,
    resume = resume,
    down = down,
    up = up
}
