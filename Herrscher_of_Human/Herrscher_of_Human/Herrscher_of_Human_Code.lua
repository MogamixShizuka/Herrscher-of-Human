


local g_VIRTUAL_FEATURE = GameInfo.Features['QGG_HOH_VIRTUAL_FEATURE']

function OnHOHCountForWonders(iX,iY,buildingID,playerID,cityID,iPercentComplete,iUnknown)
    local pPlayer=Players[playerID]
    local pLeader=PlayerConfigurations[playerID]:GetLeaderTypeName();
    if pLeader=='LEADER_QGG_HOH_ELYSIA' then
        if pPlayer:GetProperty('HOHCountForWonders') == nil then
            pPlayer:SetProperty('HOHCountForWonders',0)
        end
        local pPlayerHOHCountForWonders:number = pPlayer:GetProperty("HOHCountForWonders");
        pPlayer:SetProperty('HOHCountForWonders',(pPlayerHOHCountForWonders+1))
    end
end
Events.WonderCompleted.Add(OnHOHCountForWonders)

local q_HOHWonderGreatEngineerPercentage = GlobalParameters.HOH_GREAT_ENGINEER_PERCENTAGE

function OnHOHWonderToGreatEngineerPoints(iX,iY,buildingID,playerID,cityID,iPercentComplete,iUnknown)
    local pPlayer=Players[playerID]
    local pLeader=PlayerConfigurations[playerID]:GetLeaderTypeName();
    if pLeader=='LEADER_QGG_HOH_ELYSIA' then
        local pPlayerHOHCountForWonders:number = pPlayer:GetProperty("HOHCountForWonders");
        if pPlayerHOHCountForWonders>=7 then
            local GameSpeedCost = GameConfiguration.GetGameSpeedType();
            local iSpeedCostMultiplier = GameInfo.GameSpeeds[GameSpeedCost].CostMultiplier*0.01
            local pCity = CityManager.GetCity(playerID,cityID)
            local pBuilding = GameInfo.Buildings[buildingID]
            local GreatEngineerID = GameInfo.GreatPersonClasses['GREAT_PERSON_CLASS_ENGINEER'].Index
            local Amount = pBuilding.Cost * q_HOHWonderGreatEngineerPercentage * 0.01 * iSpeedCostMultiplier
            pPlayer:GetGreatPeoplePoints():ChangePointsTotal(GreatEngineerID,Amount)
        end
    end
end
Events.WonderCompleted.Add(OnHOHWonderToGreatEngineerPoints)

function OnHOHPlayerEraChanged(playerID,eraID)
    local pPlayer=Players[playerID]
    local iPlayerConfig = PlayerConfigurations[playerID];
    if(iPlayerConfig:GetLeaderTypeName() == "LEADER_QGG_HOH_ELYSIA") then
        if pPlayer:GetProperty("HOHCountForWonders") ~= nil then
            local pPlayerHOHCountForWonders:number = pPlayer:GetProperty("HOHCountForWonders");
            if pPlayerHOHCountForWonders>=7 then
                for row in GameInfo.Modifiers() do
                    local ModifierId = row.ModifierId
                    if string.find(ModifierId,'BONUS_HOH_WONDER_BONUS_') then
                        pPlayer:AttachModifierByID(ModifierId)
                    end
                end
            end
        end
    end
end
Events.PlayerEraChanged.Add(OnHOHPlayerEraChanged)

function OnHOHCivicCompleted(playerID,iCivic,bCancelled)
    local pPlayer=Players[playerID]
    local iPlayerConfig = PlayerConfigurations[playerID];
    if(iPlayerConfig:GetLeaderTypeName() == "LEADER_QGG_HOH_ELYSIA") then
        if pPlayer:GetProperty('HOHCountForTechCivic') == nil then
            pPlayer:SetProperty('HOHCountForTechCivic',0)
        end
        local pPlayerHOHCountForTechCivic:number = pPlayer:GetProperty("HOHCountForTechCivic");
        pPlayer:SetProperty('HOHCountForTechCivic',(pPlayerHOHCountForTechCivic+1))
    end
end
Events.CivicCompleted.Add( OnHOHCivicCompleted );

function OnHOHResearchCompleted(playerID,iCivic,bCancelled)
    local pPlayer=Players[playerID]
    local iPlayerConfig = PlayerConfigurations[playerID];
    if(iPlayerConfig:GetLeaderTypeName() == "LEADER_QGG_HOH_ELYSIA") then
        if pPlayer:GetProperty('HOHCountForTechCivic') == nil then
            pPlayer:SetProperty('HOHCountForTechCivic',0)
        end
        local pPlayerHOHCountForTechCivic:number = pPlayer:GetProperty("HOHCountForTechCivic");
        pPlayer:SetProperty('HOHCountForTechCivic',(pPlayerHOHCountForTechCivic+1))
    end
end
Events.ResearchCompleted.Add( OnHOHResearchCompleted );

local HOHNoticificationHash = DB.MakeHash("NOTIFICATION_HOH_GREAT_PERSON_POINTS_BY_GLORY");
function OnHOHDistrictBuildProgressChanged(playerID: number, districtID : number, cityID :number, districtX : number, districtY : number, districtType:number,  era,  civilization, percentComplete:number , iAppeal, isPillaged)
    local pPlayer=Players[playerID]
    local iPlayerConfig = PlayerConfigurations[playerID];
    if(iPlayerConfig:GetLeaderTypeName() == "LEADER_QGG_HOH_ELYSIA") then
        if pPlayer:GetProperty("HOHCountForWonders") ~= nil then
            local pPlayerHOHCountForWonders:number = pPlayer:GetProperty("HOHCountForWonders");
            if (pPlayerHOHCountForWonders>=7 and percentComplete>=100) then
                if pPlayer:GetProperty("sbfsHOHCountForWonders") == nil then 
                    pPlayer:SetProperty("sbfsHOHCountForWonders",0)
                end
                local sbfs = pPlayer:GetProperty("sbfsHOHCountForWonders")
                if sbfs%2 == 1 then
                    if GameInfo.Districts[districtType].RequiresPopulation == true then
                        local pPlayerHOHCountForTechCivicOnBonus:number = pPlayer:GetProperty("HOHCountForTechCivic");
                        local pCurruntTurn = Game.GetCurrentGameTurn();
                        local pRandomNumForCT = Game.GetRandNum(pCurruntTurn,'pRandomNumForCTProperty')
                        local pAmount = math.ceil(pRandomNumForCT*0.007*pPlayerHOHCountForTechCivicOnBonus*q_HOHWonderGreatEngineerPercentage*0.1)
                        for row in GameInfo.GreatPersonClasses() do
                            local GPPID = row.Index
                            pPlayer:GetGreatPeoplePoints():ChangePointsTotal(GPPID,pAmount)
                        end
                        local HOHmsgString = Locale.Lookup("LOC_HOHNoticification");
                        NotificationManager.SendNotification(playerID, HOHNoticificationHash, msgString, Locale.Lookup('LOC_HOHNoticification_EXPLAIN',pAmount),districtX,districtY);
                    end
                end
                pPlayer:SetProperty("sbfsHOHCountForWonders",sbfs+1)
            end
        end
    end
end
Events.DistrictBuildProgressChanged.Add( OnHOHDistrictBuildProgressChanged );

function OnHOHplayerTurnStarted(playerID)
    local pPlayer=Players[playerID]
    local iPlayerConfig = PlayerConfigurations[playerID];
    local pPlayerVis:table = PlayersVisibility[playerID];
    if(iPlayerConfig:GetLeaderTypeName() == "LEADER_QGG_HOH_ELYSIA") then
        if pPlayer:GetProperty('HOHCountFor12Buildings') == nil then
            pPlayer:SetProperty('HOHCountFor12Buildings',0)
        end
        local pCities:table = pPlayer:GetCities();
        for i, pCity in pCities:Members() do
            local pCityBldgs:table = pCity:GetBuildings();
            for buildingInfo in GameInfo.Buildings() do
                local buildingIndex:number = buildingInfo.Index;
				local TraitType:string = buildingInfo.TraitType;
                if TraitType~= nil then
                    if TraitType == 'TRAIT_LEADER_QGG_HOH_ELYSIA_BUILDINGS' then
                        if(pCityBldgs:HasBuilding(buildingIndex)) then
                        local pHOHCountFor12Buildings = pPlayer:GetProperty('HOHCountFor12Buildings')
                        pPlayer:SetProperty('HOHCountFor12Buildings',pHOHCountFor12Buildings+1)
                        end
                    end
                end
            end
        end
        if pPlayer:GetProperty('HOHCountFor12Buildings')< 12 then 
            pPlayer:SetProperty('HOHCountFor12Buildings',0)
        end
        if pPlayer:GetProperty('HOHCountForOcean7') == nil then
            if pPlayer:GetProperty('HOHCountForOcean7Num') == nil then 
                pPlayer:SetProperty('HOHCountForOcean7Num',0)
            end
            for iPlotIndex = 0, Map.GetPlotCount()-1, 1 do
                local HOHCountForOcean7NumQ = pPlayer:GetProperty('HOHCountForOcean7Num')
                local pPlot = Map.GetPlotByIndex(iPlotIndex)
                local TerrainTypeName = GameInfo.Terrains[pPlot:GetTerrainType()].Name
                local a=pPlayerVis:IsRevealed(pPlot)
                if (TerrainTypeName == 'LOC_TERRAIN_OCEAN_NAME' and pPlayerVis:IsRevealed(pPlot)) then
                    local HOHCountForOcean7NumQ = HOHCountForOcean7NumQ+1;
                    pPlayer:SetProperty('HOHCountForOcean7Num',HOHCountForOcean7NumQ)
                end
            end
            local HOHCountForOcean7NumN = pPlayer:GetProperty('HOHCountForOcean7Num')
            if HOHCountForOcean7NumN < 13 then
                pPlayer:SetProperty('HOHCountForOcean7Num',0)
            end
            if HOHCountForOcean7NumN >= 13 then
                pPlayer:SetProperty('HOHCountForOcean7',1)
                pPlayer:AttachModifierByID('HOH_BONUS_QGG_BORDER_EXPANSION')
                pPlayer:AttachModifierByID('HOH_BONUS_QGG_WATER_PLOT_YIELD_FOOD')
                pPlayer:AttachModifierByID('HOH_BONUS_QGG_WATER_PLOT_YIELD_FAITH')
                pPlayer:AttachModifierByID('HOH_BONUS_QGG_SEA_MOVEMENT')
                pPlayer:AttachModifierByID('HOH_BONUS_QGG_SEA_MOVEMENT2')
            end
        end
    end
end
GameEvents.PlayerTurnStarted.Add(OnHOHplayerTurnStarted)

function OnHOHCityBuilt(playerID,cityID,iX,iY)
    local pPlayer=Players[playerID]
    local iPlayerConfig = PlayerConfigurations[playerID];
    if(iPlayerConfig:GetLeaderTypeName() == "LEADER_QGG_HOH_ELYSIA") then
        if pPlayer:GetProperty('HOHCountForCity') == nil then
            if pPlayer:GetProperty('HOHCountForCityNum') == nil then 
                pPlayer:SetProperty('HOHCountForCityNum',0)
            end
            local pPlayerCities = Players[playerID]:GetCities()
            for i, pCity in pPlayerCities:Members() do
                local HOHCountForCityNumQ = pPlayer:GetProperty('HOHCountForCityNum')
                local HOHCountForCityNumQ = HOHCountForCityNumQ+1;
                pPlayer:SetProperty('HOHCountForCityNum',HOHCountForCityNumQ)
            end
            local HOHCountForCityNumN = pPlayer:GetProperty('HOHCountForCityNum')
            if HOHCountForCityNumN < 7 then
                pPlayer:SetProperty('HOHCountForCityNum',0)
            end
            if HOHCountForCityNumN >= 7 then
                pPlayer:SetProperty('HOHCountForCity',1)
            end
        end
        if pPlayer:GetProperty('HOHCountForCity') ~= nil then
            if pPlayer:GetProperty('HOHCountForCityForFeature') == nil then
                for iPlotIndex = 0, Map.GetPlotCount()-1, 1 do
                    local pPlot = Map.GetPlotByIndex(iPlotIndex)
                    local pPlotPlayerID = pPlot:GetOwner()
                    local pPlayerConfig = PlayerConfigurations[pPlotPlayerID];
                    if pPlayerConfig:GetLeaderTypeName() == "LEADER_QGG_HOH_ELYSIA" then
                        if (pPlot:GetImprovementType() ~= -1) then
                            if pPlot:GetFeatureType() == -1 then
                                TerrainBuilder.SetFeatureType(pPlot,g_VIRTUAL_FEATURE.Index)
                            end
                        end
                    end
                end
                pPlayer:SetProperty('HOHCountForCityForFeature',1)
            end
        end
    end
end
GameEvents.CityBuilt.Add(OnHOHCityBuilt)

function OnHOHUnitMovementPointsChanged(playerID,unitID,MovementPoints)
    local pPlayer=Players[playerID]
    local iPlayerConfig = PlayerConfigurations[playerID];
    if(iPlayerConfig:GetLeaderTypeName() == "LEADER_QGG_HOH_ELYSIA") then
        if pPlayer:GetProperty('HOHCountForOcean7') ~= nil then
            local pUnit = pPlayer:GetUnits():FindID(unitID);
            local Ux = pUnit:GetX();
            local Uy = pUnit:GetY();
            local pPlot = Map.GetPlot(Ux, Uy)
            if pPlot:IsRiver() ==true then
                UnitManager.RestoreMovementToFormation(pUnit);
                UnitManager.RestoreMovementToFormation(pUnit);
            end
        end
    end
end
Events.UnitMoved.Add( OnHOHUnitMovementPointsChanged );



function OnHOHImprovementAddedToMap(locationX, locationY, improvementType, eImprovementOwner, resource, isPillaged, isWorked)
    local pPlot = Map.GetPlot(locationX, locationY)
    local pPlayer = Players[eImprovementOwner]
    local iPlayerConfig = PlayerConfigurations[eImprovementOwner]
    if pPlayer ~= nil then
        if iPlayerConfig:GetLeaderTypeName() == "LEADER_QGG_HOH_ELYSIA" then
            if pPlayer:GetProperty('HOHCountForCity') ~= nil then
                if pPlot:GetFeatureType() == -1 then
                    TerrainBuilder.SetFeatureType(pPlot,g_VIRTUAL_FEATURE.Index)
                end
            end
        end
    end
end
Events.ImprovementAddedToMap.Add( OnHOHImprovementAddedToMap );

function OnHOHplayerTurnStartedForBuff(playerID)
    local pPlayer=Players[playerID]
    local iPlayerConfig = PlayerConfigurations[playerID];
    if(iPlayerConfig:GetLeaderTypeName() == "LEADER_QGG_HOH_ELYSIA") then
        if pPlayer:GetProperty('WanderingDreamHasDone') == nil then
            pPlayer:SetProperty('WanderingDreamHasDone',0)
        end
        if pPlayer:GetProperty('WanderingDreamHasDone') == 0 then
            if pPlayer:GetProperty('HOHCountFor12Buildings') >= 12 then
                pPlayer:AttachModifierByID('TRAIT_LEADER_QGG_HOH_ELYSIA_PROPERTY_12BUILDINGS_YIELD_PRODUCTION')
                for i, APlayer in ipairs(PlayerManager.GetAlive()) do
                    APlayer:AttachModifierByID('TRAIT_LEADER_QGG_HOH_ELYSIA_PROPERTY_12BUILDINGS_PLOT_PRODUCTION')
                    APlayer:AttachModifierByID('TRAIT_LEADER_QGG_HOH_ELYSIA_PROPERTY_12BUILDINGS_PLOT_FAITH')
                    APlayer:AttachModifierByID('TRAIT_LEADER_QGG_HOH_ELYSIA_PROPERTY_12BUILDINGS_PLOT_FOOD')
                end
                for iPlotIndex = 0, Map.GetPlotCount()-1, 1 do
                    local pPlot = Map.GetPlotByIndex(iPlotIndex)
                    for loop, unit in ipairs(Units.GetUnitsInPlot(pPlot)) do
                        if(unit ~= nil) then
                            if unit then
                                UnitManager.Kill(unit,false); --false 直接杀死 true 本回合先移出地图 回合结束后杀死
                            end
                        end
                    end
                end
				pPlayer:SetProperty('WanderingDreamHasDone',1)
            end            
        end
    end
end
GameEvents.PlayerTurnStarted.Add(OnHOHplayerTurnStartedForBuff)

-- 更新 HOHAddGreatPersonProphet 函数以跟踪招募的伟人数量
function HOHAddGreatPersonProphet(playerID:number, unitID:number)
    local player:table = Players[playerID]
    local unit:table = player:GetUnits():FindID(unitID)
    local iPlayerConfig = PlayerConfigurations[playerID]
    if(iPlayerConfig:GetLeaderTypeName() == "LEADER_QGG_HOH_ELYSIA") then
        if player:GetProperty('HOHNumForGP') == nil then
            player:SetProperty('HOHNumForGP', 0)
        end
        if not unit then return end

        if GameInfo.GreatPersonIndividuals[unit:GetType()].GreatPersonIndividualType ~= nil then
            local HOHNumForGPnum:number = player:GetProperty('HOHNumForGP')
            player:SetProperty('HOHNumForGP', HOHNumForGPnum + 1)

            -- 当招募的伟人数量为第八个的时候，为玩家应用加成
            if HOHNumForGPnum >= 7 then  -- 因为是在当前伟人计数前更新
                ApplyHOHGreatPersonBonus(player)
            end
        end
    end
end

-- 为玩家应用愿时光永驻的加成效果
function ApplyHOHGreatPersonBonus(player:table)
    if player:GetProperty('HOHMaxBuff') == nil then
        player:SetProperty('HOHMaxBuff', 0)
    end
    local playerMaxBuff = player:GetProperty('HOHMaxBuff')
    if playerMaxBuff < 7 then
        for row in GameInfo.Modifiers() do
            local ModifierId = row.ModifierId
            if string.find(ModifierId, 'BONUS_HOH_GREATPERSON_ADJACENCY_') then
                player:AttachModifierByID(ModifierId)
            end
        end
        player:SetProperty('HOHMaxBuff', playerMaxBuff + 1)
    end
end

-- 初始化
local function HOHInitialize()
    Events.LoadGameViewStateDone.Add(function()
        Events.UnitAddedToMap.Add(HOHAddGreatPersonProphet)
    end)
end

HOHInitialize()
