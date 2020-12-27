local dungeonIndex = 12
local nerfMultiplier = 1
local pi = math.pi
TDT.dungeonTotalCount[dungeonIndex] = {normal=392,teeming=466,teemingEnabled=true}
TDT.dungeonBosses[dungeonIndex] ={ --The Arcway
    [1] = {
        [1] = {
            ["name"] = "Ivanyr",
            ["health"] = 99914542,
            ["encounterID"] = 1497,
            ["level"] = 112,
            ["creatureType"] = "Humanoid",
            ["id"] = 98203,
            ["displayId"] = 65741,
            ["x"] = 141.82552042721,
            ["y"] = -420.40893610614,
        },
        [2] = {
            ["name"] = "Corstilax",
            ["health"] = 109796277,
            ["encounterID"] = 1498,
            ["level"] = 112,
            ["creatureType"] = "Mechanical",
            ["id"] = 98205,
            ["displayId"] = 65791,
            ["x"] = 329.28477214128,
            ["y"] = -433.29667076262,
        },
        [3] = {
            ["name"] = "Nal'tira",
            ["health"] = 88812990,
            ["encounterID"] = 1500,
            ["level"] = 112,
            ["creatureType"] = "Beast",
            ["id"] = 98207,
            ["displayId"] = 65793,
            ["x"] = 518.32894630157,
            ["y"] = -416.63829089113,
        },
        [4] = {
            ["name"] = "General Xakal",
            ["health"] = 99914610,
            ["encounterID"] = 1499,
            ["level"] = 112,
            ["creatureType"] = "Demon",
            ["id"] = 98206,
            ["displayId"] = 65792,
            ["x"] = 638.61053326137,
            ["y"] = -275.10193861121,
        },
    },
}
TDT.dungeonEnemies[dungeonIndex] = { --The Arcway
    [1] = {
        ["name"] = "Unstable Amalgamation",
        ["health"] = 11114474*nerfMultiplier,
        ["level"] = 110,
        ["creatureType"] = "Aberration",
        ["id"] = 98425,
        ["displayId"] = 33922,
        ["count"] = 4,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 397.90733166333,y = -149.77167210698,sublevel=1,g=1},
            [2] = {x = 407.76465527225,y = -149.77167210698,sublevel=1,g=1},
            [3] = {x = 397.36597904221,y = -187.63643084888,sublevel=1,g=2},
            [4] = {x = 407.00236806212,y = -187.63643084888,sublevel=1,g=2},
            [5] = {x = 367.59420221202,y = -297.13514094464,sublevel=1,g=4},
            [6] = {x = 378.95787273325,y = -299.40789845725,sublevel=1,g=4},
            [7] = {x = 371.23053620431,y = -291.22604943973,sublevel=1,g=4},
            [8] = {x = 403.26369039058,y = -144.91358574685,sublevel=1,g=1,teeming=true},
        },
    },
    [2] = {
        ["name"] = "Acidic Bile",
        ["health"] = 23585511*nerfMultiplier,
        ["level"] = 111,
        ["creatureType"] = "Aberration",
        ["id"] = 98728,
        ["displayId"] = 46333,
        ["count"] = 7,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 402.48441859485,y = -179.70652936138,sublevel=1,g=2},
            [2] = {x = 337.04838216098,y = -199.85516721713,sublevel=1,patrolFacing=(16/32)*pi,patrolFacing2=(48/32)*pi,patrol={
                [1] = {x = 319.32114666021,y = -200.40061571461},
                [2] = {x = 357.75234170874,y = -200.40061571461},
            }},
            [3] = {x = 363.30674998582,y = -262.5967350442,sublevel=1,patrolFacing=(60/32)*pi,patrolFacing2=(32/32)*pi,patrol={
                [1] = {x = 363.30674998582,y = -262.5967350442},
                [2] = {x = 368.04361040264,y = -253.12299162353},
                [3] = {x = 363.30674998582,y = -262.5967350442},
                [4] = {x = 362.78047231644,y = -280.4914180895},
            }},
        },
    },
    [3] = {
        ["name"] = "Plagued Rat",
        ["health"] = 4445789*nerfMultiplier,
        ["level"] = 110,
        ["creatureType"] = "Beast",
        ["id"] = 98732,
        ["displayId"] = 27972,
        ["count"] = 1,
        ["scale"] = 0.8,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 369.95090390597,y = -217.4337864127,sublevel=1,g=3},
            [2] = {x = 381.86260116568,y = -231.29772449343,sublevel=1,g=3},
            [3] = {x = 377.59419322284,y = -241.38057622473,sublevel=1,g=3},
            [4] = {x = 372.59420472298,y = -235.47148471982,sublevel=1,g=3},
            [5] = {x = 374.86692322165,y = -231.38057971804,sublevel=1,g=3},
            [6] = {x = 377.59419322284,y = -223.65330171001,sublevel=1,g=3},
            [7] = {x = 287.23173425158,y = -192.92053990667,sublevel=1,g=8},
            [8] = {x = 288.52336546661,y = -197.4666262996,sublevel=1,g=8},
            [9] = {x = 286.70523748441,y = -203.37573731148,sublevel=1,g=8},
            [10] = {x = 291.70522598427,y = -203.37573731148,sublevel=1,g=8},
            [11] = {x = 294.88700847404,y = -195.19390780093,sublevel=1,g=8},
            [12] = {x = 282.61431297565,y = -204.28482080955,sublevel=1,g=8},
            [13] = {x = 274.8870544746,y = -208.37574531831,sublevel=1,g=8},
            [14] = {x = 270.79609095189,y = -208.37574531831,sublevel=1,g=8},
            [15] = {x = 266.2506929685,y = -198.83028080717,sublevel=1,g=8},
            [16] = {x = 273.52339996703,y = -200.64846731029,sublevel=1,g=8},
            [17] = {x = 277.15977297327,y = -202.46665381341,sublevel=1,g=8},
            [18] = {x = 281.25065846808,y = -197.4666262996,sublevel=1,g=8},
            [19] = {x = 281.70520997061,y = -193.37572129781,sublevel=1,g=8},
            [20] = {x = 273.97795146955,y = -194.28484380983,sublevel=1,g=8},
            [21] = {x = 266.2506929685,y = -191.55755430167,sublevel=1,g=8},
        },
    },
    [4] = {
        ["name"] = "Withered Manawraith",
        ["health"] = 18868408*nerfMultiplier,
        ["level"] = 111,
        ["creatureType"] = "Humanoid",
        ["id"] = 105952,
        ["displayId"] = 70161,
        ["count"] = 6,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 391.77060420821,y = -307.64766193239,sublevel=1,g=5},
            [2] = {x = 398.1342082017,y = -308.55678444441,sublevel=1,g=5},
            [3] = {x = 436.06776098198,y = -297.7083143461,sublevel=1,g=6},
            [4] = {x = 452.72359181358,y = -257.26354324186,sublevel=1,patrolFacing=(23/32)*pi,patrol={
                [1] = {x = 452.72359181358,y = -257.26354324186},
                [2] = {x = 432.72359880019,y = -271.35444475034},
                [3] = {x = 427.72361030033,y = -258.17262673993},
            }},
            [5] = {x = 270.22449666764,y = -266.97170949779,sublevel=1,g=9},
            [6] = {x = 328.84933455378,y = -391.85781174978,sublevel=1,g=16},
            [7] = {x = 353.61664842905,y = -398.73005623028,sublevel=1,g=17},
            [8] = {x = 322.35384502207,y = -309.50702742904,sublevel=1,patrolFacing=(4/32)*pi,patrolFacing2=(36/32)*pi,patrol={
                [1] = {x = 314.97924184586,y = -292.93869107518},
                [2] = {x = 329.07014335434,y = -325.66595059645},
            }},
            [9] = {x = 333.14808848927,y = -302.72018634309,sublevel=1,patrolFacing=(4/32)*pi,patrolFacing2=(36/32)*pi,patrol={
                [1] = {x = 327.58351234034,y = -291.73439637894},
                [2] = {x = 337.58348934006,y = -316.27984589664},
            }},
            [10] = {x = 403.51960836011,y = -362.83523054065,sublevel=1,g=21,patrolFacing=(0/32)*pi,patrolFacing2=(32/32)*pi,patrol={
                [1] = {x = 403.50556144631,y = -345.80914886772},
                [2] = {x = 403.69031343198,y = -386.73314634647},
            }},
            [11] = {x = 409.51960836011,y = -362.83523054065,sublevel=1,g=21},
            [12] = {x = 398.2843808592,y = -400.20549865404,sublevel=1,g=22},
            [13] = {x = 405.55712687168,y = -419.29642767632,sublevel=1,g=22},
            [14] = {x = 405.67645219801,y = -399.29657150525,sublevel=1,g=22,teeming=true},
        },
    },
    [5] = {
        ["name"] = "Withered Fiend",
        ["health"] = 11855438*nerfMultiplier,
        ["level"] = 110,
        ["creatureType"] = "Humanoid",
        ["id"] = 98733,
        ["displayId"] = 70160,
        ["count"] = 4,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 404.80674017291,y = -310.42266630879,sublevel=1,g=5},
            [2] = {x = 393.8976991821,y = -319.51359882439,sublevel=1,g=5},
            [3] = {x = 403.89771519576,y = -316.78628980925,sublevel=1,g=5},
            [4] = {x = 438.33413086742,y = -307.22953991802,sublevel=1,g=6},
            [5] = {x = 426.97042010073,y = -301.77499932452,sublevel=1,g=6},
            [6] = {x = 427.42501066646,y = -292.22953377891,sublevel=1,g=6},
            [7] = {x = 440.15225904665,y = -288.59316037859,sublevel=1,g=6},
            [8] = {x = 401.31624018482,y = -229.79327693304,sublevel=1,g=7},
            [9] = {x = 427.67991521959,y = -238.88418994166,sublevel=1,g=7},
            [10] = {x = 417.17085770036,y = -237.46593938857,sublevel=1,g=7},
            [11] = {x = 411.71639513476,y = -227.46592229118,sublevel=1,g=7},
            [12] = {x = 286.75423664795,y = -263.00193762816,sublevel=1,g=9},
            [13] = {x = 270.84508839132,y = -280.72921406402,sublevel=1,g=9},
            [14] = {x = 286.29968509617,y = -279.36555940867,sublevel=1,g=9},
            [15] = {x = 322.07942622459,y = -382.88238760637,sublevel=1,g=16},
            [16] = {x = 362.10474587078,y = -391.13531022395,sublevel=1,g=17},
            [17] = {x = 357.33159222286,y = -341.66000313192,sublevel=1,g=19},
            [18] = {x = 359.43688359658,y = -335.34424194588,sublevel=1,g=19},
            [19] = {x = 351.54217646728,y = -325.87052111224,sublevel=1,g=19},
            [20] = {x = 349.43679474546,y = -343.23894907518,sublevel=1,g=19},
            [21] = {x = 340.48953227739,y = -335.87054220228,sublevel=1,g=19},
            [22] = {x = 311.03760175983,y = -282.15530214925,sublevel=1,g=20},
            [23] = {x = 312.61647994202,y = -265.83951987316,sublevel=1,g=20},
            [24] = {x = 317.87966320227,y = -278.47113259333,sublevel=1,g=20},
            [25] = {x = 322.61652361909,y = -270.05005744655,sublevel=1,g=20},
            [26] = {x = 328.9323525662,y = -273.73427217651,sublevel=1,g=20},
            [27] = {x = 396.32464749598,y = -408.82698766068,sublevel=1,g=22},
            [28] = {x = 404.05194501098,y = -408.37243615815,sublevel=1,g=22},

            [29] = {x = 398.22554642088,y = -447.95340636169,sublevel=1,g=23},
            [30] = {x = 404.58915041436,y = -444.31703335545,sublevel=1,g=23},
            [31] = {x = 411.40738393826,y = -449.77159286481,sublevel=1,g=23},
            [32] = {x = 403.22553492074,y = -461.1352243721,sublevel=1,g=23},
            [33] = {x = 394.58921242859,y = -457.95338336141,sublevel=1,g=23},
            [34] = {x = 406.53334371117,y = -454.77159759572,sublevel=1,g=23},

            [35] = {x = 469.10668132635,y = -216.17736237943,sublevel=1},
            [36] = {x = 479.10669734002,y = -217.54093885911,sublevel=1},
            [37] = {x = 469.56127184282,y = -187.99552034852,sublevel=1},
            [38] = {x = 481.37941583869,y = -186.63186584096,sublevel=1},
            [39] = {x = 356.5140677851,y = -195.50485595248,sublevel=1},
            [40] = {x = 347.87770627901,y = -205.95944297564,sublevel=1},
            [41] = {x = 326.5140197441,y = -194.59583097533,sublevel=1},

            [42] = {x = 356.69509584199,y = -329.51389941196,sublevel=1,g=19,teeming=true},
            [43] = {x = 345.78601583722,y = -339.51387641168,sublevel=1,g=19,teeming=true},
        },
    },
    [6] = {
        ["name"] = "Forgotten Spirit",
        ["health"] = 24528930*nerfMultiplier,
        ["level"] = 111,
        ["creatureType"] = "Undead",
        ["id"] = 113699,
        ["displayId"] = 70550,
        ["count"] = 8,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 403.42814869785,y = -164.45401245195,sublevel=1,patrolFacing=(25/32)*pi,patrolFacing2=(40/32)*pi,patrol={
                [1] = {x = 403.90386726128,y = -155.04935967937}, --blubs
                [2] = {x = 403.42814869785,y = -164.45401245195}, --purple
                [3] = {x = 390.72210777179,y = -175.95841668385},
                [4] = {x = 373.55450180257,y = -193.28004073251},
                [5] = {x = 379.85950383389,y = -240.24166201955},
                [6] = {x = 363.49584481279,y = -263.42349604362},
                [7] = {x = 367.13217880508,y = -287.5143940588},
                [8] = {x = 403.95038234209,y = -318.87803808645},
                [9] = {x = 422.14236443535,y = -309.91532657851},
                [10] = {x = 436.23326747089,y = -293.09713373924},
                [11] = {x = 438.50598621585,y = -274.9153057516},
                [12] = {x = 421.68781288356,y = -226.27897245488},
                [13] = {x = 427.5969440428,y = -201.73350077016},
                [14] = {x = 416.68782384184,y = -175.82441344405}, --orange
                [15] = {x = 403.42814869785,y = -164.45401245195}, --purple
                [16] = {x = 403.90386726128,y = -155.04935967937}, --blubs
                [17] = {x = 403.42814869785,y = -164.45401245195}, --purple
                [18] = {x = 416.68782384184,y = -175.82441344405}, --orange
                [19] = {x = 427.5969440428,y = -201.73350077016},
                [20] = {x = 421.68781288356,y = -226.27897245488},
                [21] = {x = 438.50598621585,y = -274.9153057516},
                [22] = {x = 436.23326747089,y = -293.09713373924},
                [23] = {x = 422.14236443535,y = -309.91532657851},
                [24] = {x = 403.95038234209,y = -318.87803808645},
                [25] = {x = 367.13217880508,y = -287.5143940588},
                [26] = {x = 363.49584481279,y = -263.42349604362},
                [27] = {x = 379.85950383389,y = -240.24166201955},
                [28] = {x = 373.55450180257,y = -193.28004073251},
                [29] = {x = 390.72210777179,y = -175.95841668385},
                [30] = {x = 403.42814869785,y = -164.45401245195}, --purple
            }},
            [2] = {x = 558.90923327706,y = -194.22421343259,sublevel=1,patrolFacing=(2/32)*pi,patrolFacing2=(34/32)*pi,patrol={
                [1] = {x = 551.97778771281,y = -261.36305327896},
                [2] = {x = 552.88685170391,y = -299.99940430514},
                [3] = {x = 566.52320170987,y = -307.27215031762},
                [4] = {x = 566.97771419844,y = -264.9994262852},
                [5] = {x = 560.15955870244,y = -242.27216327062},
                [6] = {x = 560.61411020496,y = -212.27215424357},
                [7] = {x = 554.25046719753,y = -155.9085091957},
                [8] = {x = 537.43229568786,y = -149.99941769079},
                [9] = {x = 526.52317666915,y = -160.45398520698},
                [10] = {x = 511.06865966704,y = -182.27214521651},
                [11] = {x = 526.52317666915,y = -160.45398520698},
                [12] = {x = 537.43229568786,y = -149.99941769079},
                [13] = {x = 554.25046719753,y = -155.9085091957},
                [14] = {x = 560.61411020496,y = -212.27215424357},
                [15] = {x = 560.15955870244,y = -242.27216327062},
                [16] = {x = 566.97771419844,y = -264.9994262852},
                [17] = {x = 566.52320170987,y = -307.27215031762},
                [18] = {x = 552.88685170391,y = -299.99940430514},
            }},
            [3] = {x = 330.32466501594,y = -323.80059542779,sublevel=1,patrolFacing=(6/32)*pi,patrolFacing2=(38/32)*pi,patrol={
                [1] = {x = 314.12421867425,y = -288.69969718885},
                [2] = {x = 319.12420717411,y = -309.60877370031},
                [3] = {x = 346.7687013683,y = -348.0754835361},
                [4] = {x = 357.22322987055,y = -348.0754835361},
                [5] = {x = 332.95063678158,y = -306.39057970492},
                [6] = {x = 323.40525029833,y = -283.20882370874},
                [7] = {x = 312.04161879104,y = -275.48150668676},
                [8] = {x = 277.4961337527,y = -274.11785217919},
                [9] = {x = 278.57290664586,y = -201.13203499851},
                [10] = {x = 336.3002062013,y = -201.13203499851},
                [11] = {x = 278.57290664586,y = -201.13203499851},
                [12] = {x = 277.4961337527,y = -274.11785217919},
                [13] = {x = 312.04161879104,y = -275.48150668676},
                [14] = {x = 323.40525029833,y = -283.20882370874},
                [15] = {x = 332.95063678158,y = -306.39057970492},
                [16] = {x = 357.22322987055,y = -348.0754835361},
                [17] = {x = 346.7687013683,y = -348.0754835361},
                [18] = {x = 319.12420717411,y = -309.60877370031},
            }},
            [4] = {x = 244.52193781981,y = -364.41527976828,sublevel=1,patrolFacing=(-2/32)*pi,patrolFacing2=(42/32)*pi,patrol={
                [1] = {x = 227.32399113798,y = -375.0369059905},--purple
                [2] = {x = 244.52193781981,y = -364.41527976828},--green
                [3] = {x = 254.976505336,y = -373.5061927769},--blue
                [4] = {x = 267.70379135086,y = -377.59709777869},
                [5] = {x = 270.88561285458,y = -365.77893427585},
                [6] = {x = 269.52195834701,y = -352.59711626544},
                [7] = {x = 286.7946813592,y = -342.59711975875},
                [8] = {x = 292.63824555631,y = -335.76319844346},
                [9] = {x = 280.36547203003,y = -316.21773742562},
                [10] = {x = 288.54732104755,y = -310.30864592072},
                [11] = {x = 317.18371458099,y = -360.30862845419},
                [12] = {x = 307.63821105589,y = -364.39955296295},
                [13] = {x = 295.36543752961,y = -344.39955994956},
                [14] = {x = 274.0018290226,y = -350.30861244052},
                [15] = {x = 256.7291060104,y = -342.12682194392},
                [16] = {x = 245.36551351706,y = -347.12681044378},
                [17] = {x = 244.52193781981,y = -364.41527976828},--green
                [18] = {x = 227.32399113798,y = -375.0369059905},--purple
                [19] = {x = 244.52193781981,y = -364.41527976828},--green
                [20] = {x = 245.36551351706,y = -347.12681044378},
                [21] = {x = 256.7291060104,y = -342.12682194392},
                [22] = {x = 274.0018290226,y = -350.30861244052},
                [23] = {x = 295.36543752961,y = -344.39955994956},
                [24] = {x = 307.63821105589,y = -364.39955296295},
                [25] = {x = 317.18371458099,y = -360.30862845419},
                [26] = {x = 288.54732104755,y = -310.30864592072},
                [27] = {x = 280.36547203003,y = -316.21773742562},
                [28] = {x = 292.63824555631,y = -335.76319844346},
                [29] = {x = 286.7946813592,y = -342.59711975875},
                [30] = {x = 269.52195834701,y = -352.59711626544},
                [31] = {x = 270.88561285458,y = -365.77893427585},
                [32] = {x = 267.70379135086,y = -377.59709777869},
                [33] = {x = 254.976505336,y = -373.5061927769},--blue
                [34] = {x = 244.52193781981,y = -364.41527976828},--green
            }},
        },
    },
    [7] = {
        ["name"] = "Warp Shade",
        ["health"] = 14819297*nerfMultiplier,
        ["level"] = 110,
        ["creatureType"] = "Elemental",
        ["id"] = 106059,
        ["displayId"] = 31471,
        ["count"] = 4,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 285.15303457788,y = -304.86256380914,sublevel=1,g=10},
            [2] = {x = 277.15028823026,y = -307.75134766304,sublevel=1,g=10},
            [3] = {x = 307.71143280705,y = -365.87247607778,sublevel=1,g=11},
            [4] = {x = 316.34779431314,y = -359.50883307035,sublevel=1,g=11},
            [5] = {x = 210.4512861451,y = -410.37030771568,sublevel=1,g=13},
            [6] = {x = 191.36039613676,y = -375.82482267734,sublevel=1,g=14},
            [7] = {x = 467.72836126099,y = -311.41292422506,sublevel=1,g=45},
            [8] = {x = 463.1829632776,y = -320.04926622418,sublevel=1,g=45},
            [9] = {x = 471.36477328117,y = -330.5038142334,sublevel=1,g=45},
            [10] = {x = 481.36478929484,y = -319.14018272611,sublevel=1,g=45},
            [11] = {x = 210.37886166784,y = -402.3699115151,sublevel=1,g=13,teeming=true},
            [12] = {x = 190.37881013353,y = -381.00626399415,sublevel=1,g=14,teeming=true},
        },
    },
    [8] = {
        ["name"] = "Arcane Anomaly",
        ["health"] = 15330582*nerfMultiplier,
        ["level"] = 111,
        ["creatureType"] = "Elemental",
        ["id"] = 98756,
        ["displayId"] = 55131,
        ["count"] = 4,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 292.05823017762,y = -340.47828621906,sublevel=1},
            [2] = {x = 256.01544932303,y = -360.82955651529,sublevel=1,g=47,sublevel=1,patrolFacing=(20/32)*pi,patrolFacing2=(55/32)*pi,patrol={
                [1] = {x = 214.83406824345,y = -382.2883447718},
                [2] = {x = 274.37949578109,y = -350.4701687486},
            }},
            [3] = {x = 157.72405311742,y = -405.82970458966,sublevel=1,g=15},
            [4] = {x = 161.81497762618,y = -414.46602708181,sublevel=1,g=15},
            [5] = {x = 485.27332169177,y = -263.59814903528,sublevel=1},
            [6] = {x = 433.74600183911,y = -350.74341624941,sublevel=1},
            [7] = {x = 472.72834976085,y = -320.50383723368,sublevel=1,g=45},
            [8] = {x = 282.14437891513,y = -345.01415290813,sublevel=1,teeming=true},
            [9] = {x = 252.72544315243,y = -355.89286334599,sublevel=1,g=47,teeming=true},
        },
    },
    [9] = {
        ["name"] = "Mana Wyrm",
        ["health"] = 2963859*nerfMultiplier,
        ["level"] = 110,
        ["creatureType"] = "Beast",
        ["id"] = 102351,
        ["displayId"] = 19285,
        ["count"] = 1,
        ["scale"] = 0.8,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 260.74310676119,y = -344.56109675067,sublevel=1,g=12},
            [2] = {x = 255.19967513137,y = -346.0378192737,sublevel=1,g=12},
            [3] = {x = 245.65421062022,y = -349.21960176347,sublevel=1,g=12},
            [4] = {x = 241.56332512541,y = -343.76506176108,sublevel=1,g=12},
            [5] = {x = 247.92692911889,y = -333.76508476136,sublevel=1,g=12},
            [6] = {x = 256.70462962013,y = -372.49027648146,sublevel=1,g=12},
            [7] = {x = 263.06827262756,y = -372.94484749095,sublevel=1,g=12},
            [8] = {x = 271.25012164508,y = -380.67214500595,sublevel=1,g=12},
            [9] = {x = 278.97738014613,y = -374.76303399407,sublevel=1,g=12},
            [10] = {x = 273.5228011298,y = -367.49030748857,sublevel=1,g=12},
            [11] = {x = 209.23980285904,y = -417.18926379438,sublevel=1,g=13},
            [12] = {x = 219.69433136128,y = -410.82564029392,sublevel=1,g=13},
            [13] = {x = 216.51254887152,y = -403.55289428145,sublevel=1,g=13},
            [14] = {x = 199.69437736184,y = -405.82563228709,sublevel=1,g=13},
            [15] = {x = 196.81497515309,y = -368.1024760755,sublevel=1,g=14},
            [16] = {x = 184.5422796547,y = -369.46605255517,sublevel=1,g=14},
            [17] = {x = 184.5422796547,y = -378.55694605682,sublevel=1,g=14},
            [18] = {x = 195.45135965947,y = -380.82970356944,sublevel=1,g=14},
            [19] = {x = 490.17234774646,y = -291.61836293687,sublevel=1,g=43},
            [20] = {x = 480.17233173279,y = -285.70929093894,sublevel=1,g=43},
            [21] = {x = 473.80872773931,y = -297.52747394875,sublevel=1,g=43},
            [22] = {x = 487.89962924779,y = -302.98201395114,sublevel=1,g=43},
            [23] = {x = 485.17232023265,y = -292.0729144394,sublevel=1,g=43},
            [24] = {x = 450.91018975132,y = -334.14016773267,sublevel=1,g=44},
            [25] = {x = 445.91020125146,y = -337.32202825033,sublevel=1,g=44},
            [26] = {x = 449.54661327164,y = -343.23108074129,sublevel=1,g=44},
            [27] = {x = 453.18294726393,y = -347.7765372456,sublevel=1,g=44},
            [28] = {x = 459.54662928531,y = -342.77654874574,sublevel=1,g=44},
        },
    },
    [10] = {
        ["name"] = "Nightborne Spellsword",
        ["health"] = 14819297*nerfMultiplier,
        ["level"] = 110,
        ["creatureType"] = "Humanoid",
        ["id"] = 105921,
        ["displayId"] = 69434,
        ["count"] = 4,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 332.94631363386,y = -386.57581310578,sublevel=1,g=16},
            [2] = {x = 361.2010035647,y = -398.42102005755,sublevel=1,g=17},
            [3] = {x = 343.83022672861,y = -411.02393732985,sublevel=1,g=18},
            [4] = {x = 332.46659398982,y = -410.56938577807,sublevel=1,g=18},
        },
    },
    [11] = {
        ["name"] = "Nightborne Reclaimer",
        ["health"] = 11855444*nerfMultiplier,
        ["level"] = 110,
        ["creatureType"] = "Humanoid",
        ["id"] = 105915,
        ["displayId"] = 69432,
        ["count"] = 4,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 322.94606047922,y = -388.84857859476,sublevel=1,g=16},
            [2] = {x = 354.83736055727,y = -391.14829355205,sublevel=1,g=17},
            [3] = {x = 337.46658303154,y = -416.47849743033,sublevel=1,g=18},
            [4] = {x = 335.00768839593,y = -405.72023018853,sublevel=1,g=18,teeming=true},
            [5] = {x = 342.18950989965,y = -406.17480119803,sublevel=1,g=18,teeming=true},
        },
    },
    [12] = {
        ["name"] = "Enchanted Broodling",
        ["health"] = 3112046*nerfMultiplier,
        ["level"] = 110,
        ["creatureType"] = "Beast",
        ["id"] = 105876,
        ["displayId"] = 69416,
        ["count"] = 1,
        ["scale"] = 0.6,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 486.63539922919,y = -417.61119633386,sublevel=1,g=24},
            [2] = {x = 489.06416938559,y = -409.75137535781,sublevel=1,g=24},
            [3] = {x = 493.60960638293,y = -413.38774836405,sublevel=1,g=24},
            [4] = {x = 494.9732608905,y = -419.29685937593,sublevel=1,g=24},
            [5] = {x = 490.42782389316,y = -423.38776437771,sublevel=1,g=24},
            [6] = {x = 494.06415788545,y = -429.29683637565,sublevel=1,g=24},
            [7] = {x = 496.54169356244,y = -424.78048726111,sublevel=1,g=24},

            [8] = {x = 520.55141812679,y = -438.84239839694,sublevel=1,g=25},
            [9] = {x = 528.27871564179,y = -439.29694989946,sublevel=1,g=25},
            [10] = {x = 534.64231963527,y = -439.29694989946,sublevel=1,g=25},
            [11] = {x = 519.18780263317,y = -444.7514508879,sublevel=1,g=25},
            [12] = {x = 526.91510014817,y = -431.56967189144,sublevel=1,g=25},
            [13] = {x = 535.55142264032,y = -433.84237088313,sublevel=1,g=25},
            [14] = {x = 528.81446010211,y = -442.5077812828,sublevel=1,g=25},

            [15] = {x = 521.03474637579,y = -387.53937614852,sublevel=1,g=26},
            [16] = {x = 529.21655637937,y = -387.08484415297,sublevel=1,g=26},
            [17] = {x = 524.67111938203,y = -384.81210614732,sublevel=1,g=26},
            [18] = {x = 535.58019938679,y = -391.63030065728,sublevel=1,g=26},
            [19] = {x = 525.58026140102,y = -390.26664614971,sublevel=1,g=26},
            [20] = {x = 518.30743736065,y = -391.63030065728,sublevel=1,g=26},
            [21] = {x = 530.63262709825,y = -390.68959273924,sublevel=1,g=26},
        },
    },
    [13] = {
        ["name"] = "Vicious Manafang",
        ["health"] = 10373509*nerfMultiplier,
        ["level"] = 110,
        ["creatureType"] = "Beast",
        ["id"] = 98759,
        ["displayId"] = 65920,
        ["count"] = 4,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 498.82290874527,y = -431.8277302102,sublevel=1,g=27},
            [2] = {x = 502.56310896409,y = -437.61801900709,sublevel=1,g=27},
            [3] = {x = 505.29037896528,y = -440.79982100383,sublevel=1,g=27},
            [4] = {x = 511.65402197271,y = -437.61801900709,sublevel=1,g=27},

            [5] = {x = 512.56308596381,y = -403.9816369738,sublevel=1,g=28},
            [6] = {x = 506.19944295638,y = -408.07258098954,sublevel=1,g=28},
            [7] = {x = 504.83590549065,y = -402.16346997766,sublevel=1,g=28},

            [8] = {x = 535.29042700628,y = -397.61801347334,sublevel=1,g=29},
            [9] = {x = 534.38132400123,y = -400.79983497706,sublevel=1,g=29},
            [10] = {x = 545.74491649458,y = -411.2543634793,sublevel=1,g=29},
            [11] = {x = 543.01768550733,y = -418.52712899875,sublevel=1,g=29},
            [12] = {x = 541.65403099976,y = -425.79985550425,sublevel=1,g=29},
        },
    },
    [14] = {
        ["name"] = "Wrathguard Felblade",
        ["health"] = 14819297*nerfMultiplier,
        ["level"] = 110,
        ["creatureType"] = "Demon",
        ["id"] = 98770,
        ["displayId"] = 64693,
        ["count"] = 4,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 541.58285067247,y = -354.76740279202,sublevel=1,g=30},
            [2] = {x = 566.38958705299,y = -271.3742995488,sublevel=1,g=31,patrolFacing=(0/32)*pi,patrolFacing2=(32/32)*pi,patrol={
                [1] = {x = 566.22569702471,y = -294.5998321145},
                [2] = {x = 566.22569702471,y = -257.78162857749},
            }},
            [3] = {x = 551.77103050645,y = -284.01751662087,sublevel=1,g=32,patrolFacing=(0/32)*pi,patrolFacing2=(32/32)*pi,patrol={
                [1] = {x = 551.77103050645,y = -258.69453526038},
                [2] = {x = 551.77103050645,y = -293.19938165206},
            }},
            [4] = {x = 583.26786035216,y = -158.65758641441,sublevel=1,g=38,patrolFacing=(16/32)*pi,patrolFacing2=(48/32)*pi,patrol={
                [1] = {x = 595.01129178256,y = -158.75117788},
                [2] = {x = 568.19310425922,y = -158.75117788},
            }},
            [5] = {x = 583.26786035216,y = -164.65758641441,sublevel=1,g=38},
            [6] = {x = 617.08765376897,y = -210.80429994368,sublevel=1,g=40},
            [7] = {x = 607.03620339703,y = -210.80429994368,sublevel=1,g=40},
            [8] = {x = 611.11304833453,y = -283.12952092708,sublevel=1,g=41},
            [9] = {x = 482.18091017292,y = -200.79202301767,sublevel=1,g=42},
        },
    },
    [15] = {
        ["name"] = "Eredar Chaosbringer",
        ["health"] = 11855444*nerfMultiplier,
        ["level"] = 110,
        ["creatureType"] = "Demon",
        ["id"] = 105617,
        ["displayId"] = 63997,
        ["count"] = 4,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 548.45788803829,y = -350.39239852074,sublevel=1,g=30},
            [2] = {x = 539.70787949573,y = -346.01739424947,sublevel=1,g=30},
            [3] = {x = 573.07707518648,y = -270.53998767046,sublevel=1,g=31},
            [4] = {x = 545.33506500874,y = -285.37039590299,sublevel=1,g=32},
            [5] = {x = 530.65181443424,y = -191.84163953033,sublevel=1,g=36},
            [6] = {x = 550.19725806328,y = -179.11439115014,sublevel=1,g=36},
            [7] = {x = 517.02776308473,y = -166.58971217741,sublevel=1,g=37},
            [8] = {x = 521.11868759349,y = -152.95336217145,sublevel=1,g=37},
            [9] = {x = 521.11868759349,y = -159.77153717443,sublevel=1,g=37},
            [10] = {x = 613.46583557881,y = -150.12287099919,sublevel=1,g=39},
            [11] = {x = 603.92037106767,y = -166.03197851776,sublevel=1,g=39},
            [12] = {x = 611.71996768184,y = -214.81382349844,sublevel=1,g=40,patrolFacing=(0/32)*pi,patrolFacing2=(32/32)*pi,patrol={
                [1] = {x = 611.71996768184,y = -247.81879446322},
                [2] = {x = 611.71996768184,y = -186.90968631019},
            }},
            [13] = {x = 611.11304833453,y = -270.85682542869,sublevel=1,g=41},
            [14] = {x = 565.8832291924,y = -281.92009410722,sublevel=1},
            [15] = {x = 555.42870069016,y = -271.92007809355,sublevel=1},
            [16] = {x = 549.06505768273,y = -273.46556211167,sublevel=1},
            [17] = {x = 489.90816867397,y = -195.79203451781,sublevel=1,g=42},
            [18] = {x = 489.90816867397,y = -206.246602034,sublevel=1,g=42},
            [19] = {x = 484.69460298094,y = -207.06715495472,sublevel=1,g=42,teeming=true},
            [20] = {x = 484.69460298094,y = -193.88533694431,sublevel=1,g=42,teeming=true},
        },
    },
    [16] = {
        ["name"] = "Dreadborne Seer",
        ["health"] = 18868422*nerfMultiplier,
        ["level"] = 111,
        ["creatureType"] = "Demon",
        ["id"] = 105651,
        ["displayId"] = 67378,
        ["count"] = 10,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 554.05727447644,y = -321.16302223981,sublevel=1,patrolFacing=(29/32)*pi,patrolFacing2=(63/32)*pi,patrol={
                [1] = {x = 551.78459474542,y = -329.7994236958},
                [2] = {x = 560.42091817351,y = -292.98119666175},
            }},
            [2] = {x = 561.31009986677,y = -235.91412704902,sublevel=1,patrolFacing=(0/32)*pi,patrolFacing2=(32/32)*pi,patrol={
                [1] = {x = 561.12507429874,y = -254.67256937926},
                [2] = {x = 561.57958683657,y = -222.85437040088},
            }},
            [3] = {x = 617.57060987953,y = -276.51349625987,sublevel=1,g=41},
            [4] = {x = 448.88672349888,y = -201.07368949371,sublevel=1,patrolFacing=(16/32)*pi,patrolFacing2=(48/32)*pi,patrol={
                [1] = {x = 469.58717001489,y = -201.07368949371},
                [2] = {x = 429.1326324856,y = -201.07368949371},
            }},
            [5] = {x = 607.06557212752,y = -276.55429663756,sublevel=1,g=41,teeming=true},
        },
    },
    [17] = {
        ["name"] = "Wyrmtongue Scavenger",
        ["health"] = 4445789*nerfMultiplier,
        ["level"] = 110,
        ["creatureType"] = "Demon",
        ["id"] = 105629,
        ["displayId"] = 65211,
        ["count"] = 1,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 567.57900670522,y = -204.96062721614,sublevel=1,g=33},
            [2] = {x = 573.36287378641,y = -201.40911409623,sublevel=1,g=33},
            [3] = {x = 571.54466777631,y = -195.9545350799,sublevel=1,g=33},
            [4] = {x = 568.81735876118,y = -190.04548258894,sublevel=1,g=33},
            [5] = {x = 539.81386117247,y = -206.48843176281,sublevel=1,g=34},
            [6] = {x = 537.99569417633,y = -212.85205526326,sublevel=1,g=34},
            [7] = {x = 529.81388417275,y = -213.76117777528,sublevel=1,g=34},
            [8] = {x = 527.99567816266,y = -208.30661826593,sublevel=1,g=34},
            [9] = {x = 512.50612154204,y = -188.7264782798,sublevel=1,g=35},
            [10] = {x = 509.32430003832,y = -193.27191527714,sublevel=1,g=35},
            [11] = {x = 505.23341454351,y = -192.81740278856,sublevel=1,g=35},
        },
    },
    [18] = {
        ["name"] = "Felguard Destroyer",
        ["health"] = 24528930*nerfMultiplier,
        ["level"] = 111,
        ["creatureType"] = "Demon",
        ["id"] = 105682,
        ["displayId"] = 39908,
        ["count"] = 8,
        ["scale"] = 1.2,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 541.11868060688,y = -184.77155770162,sublevel=1,g=36},
            [2] = {x = 613.92042609528,y = -160.12288701286,sublevel=1,g=39},
            [3] = {x = 606.82048968677,y = -156.45891102154,sublevel=1,g=39,teeming=true},
        },
    },
    [19] = {
        ["name"] = "Priestess of Misery",
        ["health"] = 29434718*nerfMultiplier,
        ["level"] = 111,
        ["creatureType"] = "Demon",
        ["id"] = 105706,
        ["displayId"] = 21542,
        ["count"] = 10,
        ["scale"] = 1,
        ["color"] = {r=1,g=1,b=1,a=0.8},
        ["clones"] = {
            [1] = {x = 561.37487073532,y = -158.75117788,sublevel=1},
        },
    },
}