
function getpred()
    pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    split = string.split(pingvalue,'(')
    ping = tonumber(split[1])
    if ping < 1000 then
        PredictionValue = 0.446
    elseif ping < 970 then
        PredictionValue = 0.438
    elseif ping < 940 then
        PredictionValue = 0.424
    elseif ping < 910 then
        PredictionValue = 0.418
    elseif ping < 880 then
        PredictionValue = 0.406
    elseif ping < 850 then
        PredictionValue = 0.394
    elseif ping < 820 then
        PredictionValue = 0.384
    elseif ping < 790 then
        PredictionValue = 0.376
    elseif ping < 760 then
        PredictionValue = 0.369
    elseif ping < 730 then
        PredictionValue = 0.356
    elseif ping < 700 then
        PredictionValue = 0.344
    elseif ping < 670 then
        PredictionValue = 0.332
    elseif ping < 640 then
        PredictionValue = 0.328
    elseif ping < 610 then
        PredictionValue = 0.314
    elseif ping < 580 then
        PredictionValue = 0.306
    elseif ping < 550 then
        PredictionValue = 0.291
    elseif ping < 520 then
        PredictionValue = 0.284
    elseif ping < 490 then
        PredictionValue = 0.274
    elseif ping < 460 then
        PredictionValue = 0.268
    elseif ping < 430 then
        PredictionValue = 0.254
    elseif ping < 400 then
        PredictionValue = 0.248
    elseif ping < 370 then
        PredictionValue = 0.231
    elseif ping < 340 then
        PredictionValue = 0.226
    elseif ping < 310 then
        PredictionValue = 0.219
    elseif ping < 280 then
        PredictionValue = 0.208
    elseif ping < 250 then
        PredictionValue = 0.196
    elseif ping < 220 then
        PredictionValue = 0.181
    elseif ping < 190 then
        PredictionValue = 0.179
    elseif ping < 160 then 
        PredictionValue = 0.164
    elseif ping < 130 then
        PredictionValue = 0.151
    elseif ping < 125 then
        PredictionValue = 0.149
    elseif ping < 110 then
        PredictionValue = 0.146
    elseif ping < 105 then
        PredictionValue = 0.138
    elseif ping < 90 then
        PredictionValue = 0.136
    elseif ping < 80 then
        PredictionValue = 0.134
    elseif ping < 70 then
        PredictionValue = 0.131
    elseif ping < 60 then
        PredictionValue = 0.1229
    elseif ping < 50 then
        PredictionValue = 0.1225
    elseif ping < 40 then
        PredictionValue = 0.1256
    end
    return(PredictionValue)
end
