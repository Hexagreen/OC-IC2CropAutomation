local component = require('component')
local sides = require('sides')
local config = require('config')
local geolyzer = component.geolyzer


local function scan()
    local rawResult = geolyzer.analyze(sides.down)

    -- AIR
    if rawResult.name == 'minecraft:air' then
        return {isCrop=true, name='air'}

    elseif rawResult.name == 'IC2:blockCrop' then

        -- EMPTY CROP STICK
        if rawResult['CropName'] == nil then
            return {isCrop=true, name='emptyCrop'}

        -- FILLED CROP STICK
        else
            return {
                isCrop=true,
                name = rawResult['CropName'],
                gr = rawResult['CropGrowth'],
                ga = rawResult['CropGain'],
                re = rawResult['CropResistance'],
                tier = rawResult['CropTier'],
                size = rawResult['CropSize']
            }
        end

    -- RANDOM BLOCK
    else
        return {isCrop=false, name='block'}
    end
end


local function isWeed(crop, farm)
    if farm == 'working' then
        return crop.name == 'weed' or
        crop.name == 'Grass' or
        crop.gr > config.workingMaxGrowth or
        crop.re > config.workingMaxResistance or
        (crop.name == 'venomilia' and crop.gr > 7)

    elseif farm == 'storage' then
        return crop.name == 'weed' or
        crop.name == 'Grass' or
        crop.gr > config.storageMaxGrowth or
        crop.re > config.storageMaxResistance or
        (crop.name == 'venomilia' and crop.gr > 7)
    end
end


local function canDropSeed(crop)
    if crop.isCrop and crop.name ~= 'emptyCrop' then
        return crop.size >= 3
    end
    return false
end


return {
    scan = scan,
    isWeed = isWeed,
    canDropSeed = canDropSeed
}