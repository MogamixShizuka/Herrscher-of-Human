--Civilization Ability
--帝国宜居度产出+50%。
insert or replace into TraitModifiers
(TraitType,ModifierId)
SELECT
'TRAIT_CIVILIZATION_HOH_ELYSIAN_REALM', 'TRAIT_CIVILIZATION_HOH_ELYSIAN_REALM_'||HappinessType||'_'||YieldType
from Happinesses,Yields;
insert or replace into Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) 
SELECT
'TRAIT_CIVILIZATION_HOH_ELYSIAN_REALM_'||HappinessType||'_'||YieldType, 'MODIFIER_PLAYER_CITIES_ADJUST_HAPPINESS_YIELD', 0, 1, 0, NULL, NULL
from Happinesses,Yields;
insert or replace into ModifierArguments (ModifierId, Name, Value) 
SELECT
'TRAIT_CIVILIZATION_HOH_ELYSIAN_REALM_'||HappinessType||'_'||YieldType, 'HappinessType', HappinessType
from Happinesses,Yields;
insert or replace into ModifierArguments (ModifierId, Name, Value) 
SELECT
'TRAIT_CIVILIZATION_HOH_ELYSIAN_REALM_'||HappinessType||'_'||YieldType, 'YieldType', YieldType
from Happinesses,Yields;
insert or replace into ModifierArguments (ModifierId, Name, Value) 
SELECT
'TRAIT_CIVILIZATION_HOH_ELYSIAN_REALM_'||HappinessType||'_'||YieldType, 'Amount', Happinesses.NonFoodYieldModifier*(0.5)
from Happinesses,Yields;
--娱乐区辐射全国
insert or replace into TraitModifiers (TraitType, ModifierId) VALUES 
('TRAIT_CIVILIZATION_HOH_ELYSIAN_REALM', 'TRAIT_CIVILIZATION_HOH_ELYSIAN_REALM_ALL_RANGE');
insert or replace into Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('TRAIT_CIVILIZATION_HOH_ELYSIAN_REALM_ALL_RANGE', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_EXTRA_REGIONAL_RANGE', 0, 0, 0, NULL, 'RS_DISTRICT_IS_DISTRICT_ENTERTAINMENT');
insert or replace into ModifierArguments (ModifierId, Name, Value) VALUES 
('TRAIT_CIVILIZATION_HOH_ELYSIAN_REALM_ALL_RANGE', 'Amount', '9999');
-- RequirementSets
insert or replace into RequirementSets (RequirementSetId, RequirementSetType) VALUES 
('RS_DISTRICT_IS_DISTRICT_ENTERTAINMENT', 'REQUIREMENTSET_TEST_ANY');
insert or replace into RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
('RS_DISTRICT_IS_DISTRICT_ENTERTAINMENT', 'REQUIRES_DISTRICT_IS_ENTERTAINMENT_COMPLEX'), 
('RS_DISTRICT_IS_DISTRICT_ENTERTAINMENT', 'REQ_DISTRICT_IS_DISTRICT_QGG_HOH_ELYSIA'), 
('RS_DISTRICT_IS_DISTRICT_ENTERTAINMENT', 'REQUIRES_DISTRICT_IS_WATER_PARK');
-- Requirements
insert or replace into Requirements (RequirementId, RequirementType) VALUES 
('REQ_DISTRICT_IS_DISTRICT_QGG_HOH_ELYSIA', 'REQUIREMENT_DISTRICT_TYPE_MATCHES');
insert or replace into RequirementArguments (RequirementId, Name, Value) VALUES 
('REQ_DISTRICT_IS_DISTRICT_QGG_HOH_ELYSIA', 'DistrictType', 'DISTRICT_QGG_HOH_ELYSIA');
-- RequirementSets
insert or replace into RequirementSets (RequirementSetId, RequirementSetType) 
SELECT 'RS_QGG_HOH_DISTRICT_IS_'||DistrictType, 'REQUIREMENTSET_TEST_ALL' 
FROM Districts; 
insert or replace into RequirementSetRequirements (RequirementSetId, RequirementId) 
SELECT 'RS_QGG_HOH_DISTRICT_IS_'||DistrictType, 'REQ_QGG_HOH_DISTRICT_IS_'||DistrictType
FROM Districts; 
-- Requirements
insert or replace into Requirements (RequirementId, RequirementType) 
SELECT 'REQ_QGG_HOH_DISTRICT_IS_'||DistrictType, 'REQUIREMENT_DISTRICT_TYPE_MATCHES'
FROM Districts; 
insert or replace into RequirementArguments (RequirementId, Name, Value)  
SELECT 'REQ_QGG_HOH_DISTRICT_IS_'||DistrictType, 'DistrictType', DistrictType
FROM Districts; 
-- -- RequirementSets
-- insert or replace into RequirementSets (RequirementSetId, RequirementSetType) VALUES 
-- ('RS_ELYSIA_HAS_7GREATPEOPLE_ANY_GREAT_PERSON_CLASS_ART', 'REQUIREMENTSET_TEST_ANY'), 
-- --('RS_LEADER_IS_HOH_ELISIA','REQUIREMENTSET_TEST_ALL'),
-- ('RS_LEADER_IS_HOH_ELISIA_7GREATPEOPLE', 'REQUIREMENTSET_TEST_ALL');

-- insert or replace into RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
-- ('RS_ELYSIA_HAS_7GREATPEOPLE_ANY_GREAT_PERSON_CLASS_ART', 'REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_WRITER'), 
-- ('RS_ELYSIA_HAS_7GREATPEOPLE_ANY_GREAT_PERSON_CLASS_ART', 'REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_ARTIST'), 
-- ('RS_ELYSIA_HAS_7GREATPEOPLE_ANY_GREAT_PERSON_CLASS_ART', 'REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_MUSICIAN'), 
-- --('RS_LEADER_IS_HOH_ELISIA','REQ_LEADER_IS_HOH_ELISIA'),
-- ('RS_LEADER_IS_HOH_ELISIA_7GREATPEOPLE', 'REQ_LEADER_IS_HOH_ELISIA'), 
-- ('RS_LEADER_IS_HOH_ELISIA_7GREATPEOPLE', 'REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_PROPHET'), 
-- ('RS_LEADER_IS_HOH_ELISIA_7GREATPEOPLE', 'REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_GENERAL'), 
-- ('RS_LEADER_IS_HOH_ELISIA_7GREATPEOPLE', 'REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_ADMIRAL'), 
-- ('RS_LEADER_IS_HOH_ELISIA_7GREATPEOPLE', 'REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_ENGINEER'), 
-- ('RS_LEADER_IS_HOH_ELISIA_7GREATPEOPLE', 'REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_MERCHANT'), 
-- ('RS_LEADER_IS_HOH_ELISIA_7GREATPEOPLE', 'REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_SCIENTIST'), 
-- ('RS_LEADER_IS_HOH_ELISIA_7GREATPEOPLE', 'REQ_ELYSIA_HAS_7GREATPEOPLE_ANY_GREAT_PERSON_CLASS_ART');
 -- Requirements
insert or replace into Requirements (RequirementId, RequirementType) VALUES 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_WRITER', 'REQUIREMENT_PLAYER_HAS_GREAT_PERSON_CLASS'), 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_ARTIST', 'REQUIREMENT_PLAYER_HAS_GREAT_PERSON_CLASS'), 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_MUSICIAN', 'REQUIREMENT_PLAYER_HAS_GREAT_PERSON_CLASS'), 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_PROPHET', 'REQUIREMENT_PLAYER_HAS_GREAT_PERSON_CLASS'), 
('REQ_LEADER_IS_HOH_ELISIA', 'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES');
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_GENERAL', 'REQUIREMENT_PLAYER_HAS_GREAT_PERSON_CLASS'), 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_ADMIRAL', 'REQUIREMENT_PLAYER_HAS_GREAT_PERSON_CLASS'), 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_ENGINEER', 'REQUIREMENT_PLAYER_HAS_GREAT_PERSON_CLASS'), 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_MERCHANT', 'REQUIREMENT_PLAYER_HAS_GREAT_PERSON_CLASS'), 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_SCIENTIST', 'REQUIREMENT_PLAYER_HAS_GREAT_PERSON_CLASS'), 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_ANY_GREAT_PERSON_CLASS_ART', 'REQUIREMENT_REQUIREMENTSET_IS_MET');
insert or replace into RequirementArguments (RequirementId, Name, Value) VALUES 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_WRITER', 'GreatPersonClass', 'GREAT_PERSON_CLASS_WRITER'), 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_ARTIST', 'GreatPersonClass', 'GREAT_PERSON_CLASS_ARTIST'), 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_MUSICIAN', 'GreatPersonClass', 'GREAT_PERSON_CLASS_MUSICIAN'), 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_PROPHET', 'GreatPersonClass', 'GREAT_PERSON_CLASS_PROPHET'), 
('REQ_LEADER_IS_HOH_ELISIA', 'LeaderType', 'LEADER_QGG_HOH_ELYSIA');
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_GENERAL', 'GreatPersonClass', 'GREAT_PERSON_CLASS_GENERAL'), 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_ADMIRAL', 'GreatPersonClass', 'GREAT_PERSON_CLASS_ADMIRAL'), 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_ENGINEER', 'GreatPersonClass', 'GREAT_PERSON_CLASS_ENGINEER'), 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_MERCHANT', 'GreatPersonClass', 'GREAT_PERSON_CLASS_MERCHANT'), 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_GREAT_PERSON_CLASS_SCIENTIST', 'GreatPersonClass', 'GREAT_PERSON_CLASS_SCIENTIST'), 
-- ('REQ_ELYSIA_HAS_7GREATPEOPLE_ANY_GREAT_PERSON_CLASS_ART', 'RequirementSetId', 'RS_ELYSIA_HAS_7GREATPEOPLE_ANY_GREAT_PERSON_CLASS_ART');
--Leader Ability
--所有玩家全部城市宜居度产出+50%
insert or replace into TraitModifiers
(TraitType,ModifierId)
SELECT
'TRAIT_LEADER_QGG_HOH_ELYSIA', 'TRAIT_LEADER_QGG_HOH_ELYSIA_ALL_ENTERTAIN_'||HappinessType||'_'||YieldType
from Happinesses,Yields;
insert or replace into Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) 
SELECT
'TRAIT_LEADER_QGG_HOH_ELYSIA_ALL_ENTERTAIN_'||HappinessType||'_'||YieldType, 'QGG_HOH_LEADER_MODIFIER_PLAYER_CITIES_ADJUST_HAPPINESS_YIELD', 0, 1, 0, NULL, NULL
from Happinesses,Yields;
insert or replace into ModifierArguments (ModifierId, Name, Value) 
SELECT
'TRAIT_LEADER_QGG_HOH_ELYSIA_ALL_ENTERTAIN_'||HappinessType||'_'||YieldType, 'HappinessType', HappinessType
from Happinesses,Yields;
insert or replace into ModifierArguments (ModifierId, Name, Value) 
SELECT
'TRAIT_LEADER_QGG_HOH_ELYSIA_ALL_ENTERTAIN_'||HappinessType||'_'||YieldType, 'YieldType', YieldType
from Happinesses,Yields;
insert or replace into ModifierArguments (ModifierId, Name, Value) 
SELECT
'TRAIT_LEADER_QGG_HOH_ELYSIA_ALL_ENTERTAIN_'||HappinessType||'_'||YieldType, 'Amount', Happinesses.NonFoodYieldModifier*(0.5)
from Happinesses,Yields;
-- Custom ModifierType
insert or replace into Types (Type, Kind) VALUES 
('QGG_HOH_LEADER_MODIFIER_PLAYER_CITIES_ADJUST_HAPPINESS_YIELD', 'KIND_MODIFIER');
insert or replace into DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES 
('QGG_HOH_LEADER_MODIFIER_PLAYER_CITIES_ADJUST_HAPPINESS_YIELD', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_CITY_HAPPINESS_YIELD');
--所有城市宜居度+1
insert or replace into TraitModifiers (TraitType, ModifierId) VALUES 
('TRAIT_LEADER_QGG_HOH_ELYSIA', 'TRAIT_LEADER_QGG_HOH_ELYSIA_ALL_ENTERTAIN_FOR_ALL_CITIES');
insert or replace into Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('TRAIT_LEADER_QGG_HOH_ELYSIA_ALL_ENTERTAIN_FOR_ALL_CITIES', 'QGG_HOH_LEADER_MODIFIER_PLAYER_CITIES_ADJUST_TRAIT_AMENITY', 0, 0, 0, NULL, NULL);
insert or replace into ModifierArguments (ModifierId, Name, Value) VALUES 
('TRAIT_LEADER_QGG_HOH_ELYSIA_ALL_ENTERTAIN_FOR_ALL_CITIES', 'Amount', '1');
-- Custom ModifierType
insert or replace into Types (Type, Kind) VALUES 
('QGG_HOH_LEADER_MODIFIER_PLAYER_CITIES_ADJUST_TRAIT_AMENITY', 'KIND_MODIFIER');
insert or replace into DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES 
('QGG_HOH_LEADER_MODIFIER_PLAYER_CITIES_ADJUST_TRAIT_AMENITY', 'COLLECTION_ALL_CITIES', 'EFFECT_ADJUST_TRAIT_AMENITY');


---------------------
--Modifiers
--沿海城市单元格扩张+100%
insert or replace into Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('HOH_BONUS_QGG_BORDER_EXPANSION', 'QGG_HOH_MODIFIER_PLAYER_CITIES_CULTURE_BORDER_EXPANSION', 0, 0, 0, NULL, 'RS_QGG_HOH_CITY_ADJACENT_OCEAN');
insert or replace into ModifierArguments (ModifierId, Name, Value) VALUES 
('HOH_BONUS_QGG_BORDER_EXPANSION', 'Amount', '100');
-- Custom ModifierType
insert or replace into Types (Type, Kind) VALUES 
('QGG_HOH_MODIFIER_PLAYER_CITIES_CULTURE_BORDER_EXPANSION', 'KIND_MODIFIER');
insert or replace into DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES 
('QGG_HOH_MODIFIER_PLAYER_CITIES_CULTURE_BORDER_EXPANSION', 'COLLECTION_PLAYER_CITIES', 'EFFECT_ADJUST_CITY_CULTURE_BORDER_EXPANSION');
-- RequirementSets
insert or replace into RequirementSets (RequirementSetId, RequirementSetType) VALUES 
('RS_QGG_HOH_CITY_ADJACENT_OCEAN', 'REQUIREMENTSET_TEST_ALL');
insert or replace into RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
('RS_QGG_HOH_CITY_ADJACENT_OCEAN', 'REQ_QGG_HOH_CITY_ADJACENT_OCEAN');
-- Requirements
insert or replace into Requirements (RequirementId, RequirementType) VALUES 
('REQ_QGG_HOH_CITY_ADJACENT_OCEAN', 'REQUIREMENT_PLOT_ADJACENT_TO_COAST');
insert or replace into RequirementArguments (RequirementId, Name, Value) VALUES 
('REQ_QGG_HOH_CITY_ADJACENT_OCEAN', 'MaxRange', '1'), 
('REQ_QGG_HOH_CITY_ADJACENT_OCEAN', 'MinRange', '0');
--水域单元格+1信仰，+1食物。
insert or replace into Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('HOH_BONUS_QGG_WATER_PLOT_YIELD_FOOD', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 0, 0, 0, NULL, 'RS_QGG_HOH_PLOT_SEA'),
('HOH_BONUS_QGG_WATER_PLOT_YIELD_FAITH', 'MODIFIER_PLAYER_ADJUST_PLOT_YIELD', 0, 0, 0, NULL, 'RS_QGG_HOH_PLOT_SEA');
insert or replace into ModifierArguments (ModifierId, Name, Value) VALUES 
('HOH_BONUS_QGG_WATER_PLOT_YIELD_FOOD', 'Amount', '1'), 
('HOH_BONUS_QGG_WATER_PLOT_YIELD_FOOD', 'YieldType', 'YIELD_FOOD'),
('HOH_BONUS_QGG_WATER_PLOT_YIELD_FAITH', 'Amount', '1'), 
('HOH_BONUS_QGG_WATER_PLOT_YIELD_FAITH', 'YieldType', 'YIELD_FAITH');
-- RequirementSets
insert or replace into RequirementSets (RequirementSetId, RequirementSetType) VALUES 
('RS_QGG_HOH_PLOT_SEA', 'REQUIREMENTSET_TEST_ALL');
insert or replace into RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
('RS_QGG_HOH_PLOT_SEA', 'REQ_QGG_HOH_PLOT_SEA');
-- Requirements
insert or replace into Requirements (RequirementId, RequirementType) VALUES 
('REQ_QGG_HOH_PLOT_SEA', 'REQUIREMENT_PLOT_TERRAIN_CLASS_MATCHES');
insert or replace into RequirementArguments (RequirementId, Name, Value) VALUES 
('REQ_QGG_HOH_PLOT_SEA', 'TerrainClass', 'TERRAIN_CLASS_WATER');
--海运移动力+3
insert or replace into Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('HOH_BONUS_QGG_SEA_MOVEMENT', 'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT', 0, 0, 0, NULL, 'RS_HOH_UNIT_ON_SEA');
insert or replace into ModifierArguments (ModifierId, Name, Value) VALUES 
('HOH_BONUS_QGG_SEA_MOVEMENT', 'Amount', '3');
insert or replace into Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) VALUES 
('HOH_BONUS_QGG_SEA_MOVEMENT2', 'MODIFIER_PLAYER_UNITS_ADJUST_SEA_MOVEMENT', 0, 0, 0, NULL, NULL);
insert or replace into ModifierArguments (ModifierId, Name, Value) VALUES 
('HOH_BONUS_QGG_SEA_MOVEMENT2', 'Amount', '3');
-- RequirementSets
insert or replace into RequirementSets (RequirementSetId, RequirementSetType) VALUES 
('RS_HOH_UNIT_ON_SEA', 'REQUIREMENTSET_TEST_ALL');
insert or replace into RequirementSetRequirements (RequirementSetId, RequirementId) VALUES 
('RS_HOH_UNIT_ON_SEA', 'REQ_HOH_UNIT_ON_SEA');
-- Requirements
insert or replace into Requirements (RequirementId, RequirementType) VALUES 
('REQ_HOH_UNIT_ON_SEA', 'REQUIREMENT_UNIT_EMBARKED');

--给所有区域套上伟人点数+1，
insert or replace into DistrictModifiers (DistrictType, ModifierId) 
SELECT A.DistrictType,'BONUS_HOH_DISTRICT_GREATPERSON_POINTS_'||B.DistrictType||'_'||B.GreatPersonClassType
FROM District_GreatPersonPoints A, District_GreatPersonPoints B
where exists (select B.DistrictType from Districts where (Districts.TraitType is null and B.DistrictType = Districts.DistrictType)); 
--伟人点数+1，条件是城市为7人口以上
insert or ignore into Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) 
SELECT 'BONUS_HOH_DISTRICT_GREATPERSON_POINTS_'||DistrictType||'_'||GreatPersonClassType, 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS', 0, 0, 0, NULL, 'RS_QGG_HOH_DISTRICT_IS_7POP_'||DistrictType
FROM District_GreatPersonPoints 
where exists (select DistrictType from Districts where (Districts.TraitType is null and District_GreatPersonPoints.DistrictType = Districts.DistrictType)); 
insert or ignore into ModifierArguments (ModifierId, Name, Value) 
SELECT 'BONUS_HOH_DISTRICT_GREATPERSON_POINTS_'||DistrictType||'_'||GreatPersonClassType, 'Amount', '1' 
FROM District_GreatPersonPoints 
where exists (select DistrictType from Districts where (Districts.TraitType is null and District_GreatPersonPoints.DistrictType = Districts.DistrictType)); 
insert or ignore into ModifierArguments (ModifierId, Name, Value) 
SELECT 'BONUS_HOH_DISTRICT_GREATPERSON_POINTS_'||DistrictType||'_'||GreatPersonClassType, 'GreatPersonClassType', GreatPersonClassType
FROM District_GreatPersonPoints 
where exists (select DistrictType from Districts where (Districts.TraitType is null and District_GreatPersonPoints.DistrictType = Districts.DistrictType)); 
-- RequirementSets
insert or ignore into RequirementSets (RequirementSetId, RequirementSetType) 
SELECT 'RS_QGG_HOH_DISTRICT_IS_7POP_'||DistrictType, 'REQUIREMENTSET_TEST_ALL' 
FROM District_GreatPersonPoints; 
insert or ignore into RequirementSetRequirements (RequirementSetId, RequirementId) 
SELECT 'RS_QGG_HOH_DISTRICT_IS_7POP_'||DistrictType, 'REQ_QGG_HOH_DISTRICT_IS_'||DistrictType
FROM District_GreatPersonPoints; 
insert or ignore into RequirementSetRequirements (RequirementSetId, RequirementId) 
SELECT 'RS_QGG_HOH_DISTRICT_IS_7POP_'||DistrictType, 'REQ_QGG_HOH_HAS_7_POP'
FROM District_GreatPersonPoints; 
insert or ignore into RequirementSetRequirements (RequirementSetId, RequirementId) 
SELECT 'RS_QGG_HOH_DISTRICT_IS_7POP_'||DistrictType, 'REQ_LEADER_IS_HOH_ELISIA'
FROM District_GreatPersonPoints; 
-- Requirements
insert or ignore into Requirements (RequirementId, RequirementType) 
SELECT 'REQ_QGG_HOH_DISTRICT_IS_'||DistrictType, 'REQUIREMENT_DISTRICT_TYPE_MATCHES'
FROM District_GreatPersonPoints; 
insert or ignore into RequirementArguments (RequirementId, Name, Value)  
SELECT 'REQ_QGG_HOH_DISTRICT_IS_'||DistrictType, 'DistrictType', DistrictType
FROM District_GreatPersonPoints; 
insert or replace into Requirements (RequirementId, RequirementType) VALUES 
('REQ_QGG_HOH_HAS_7_POP', 'REQUIREMENT_CITY_HAS_X_POPULATION');
insert or replace into RequirementArguments (RequirementId, Name, Value) VALUES 
('REQ_QGG_HOH_HAS_7_POP', 'Amount', '7');
-- --巨作为所在城市的所有区域+1相邻加成。
-- insert or replace into GreatWorkModifiers (GreatWorkType, ModifierId) 
-- SELECT GreatWorkType,'BONUS_HOH_GREATWORK_ADJACENCY_'||District_Adjacencies.DistrictType||'_'||Adjacency_YieldChanges.YieldType||'_ATTACH'
-- FROM GreatWorks,District_Adjacencies,Adjacency_YieldChanges where District_Adjacencies.YieldChangeId=Adjacency_YieldChanges.ID 
-- and exists 
-- (select District_Adjacencies.DistrictType from Districts where (Districts.TraitType is null and District_Adjacencies.DistrictType = Districts.DistrictType)); 

-- insert or replace into Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) 
-- SELECT 'BONUS_HOH_GREATWORK_ADJACENCY_'||District_Adjacencies.DistrictType||'_'||Adjacency_YieldChanges.YieldType||'_ATTACH',  'MODIFIER_SINGLE_CITY_ATTACH_MODIFIER', 0, 0, 0, NULL,'RS_LEADER_IS_HOH_ELISIA_7GREATPEOPLE'
-- FROM District_Adjacencies,Adjacency_YieldChanges where District_Adjacencies.YieldChangeId=Adjacency_YieldChanges.ID 
-- and exists 
-- (select District_Adjacencies.DistrictType from Districts where (Districts.TraitType is null and District_Adjacencies.DistrictType = Districts.DistrictType)); 

-- insert or replace into ModifierArguments (ModifierId, Name, Value) 
-- SELECT 'BONUS_HOH_GREATWORK_ADJACENCY_'||District_Adjacencies.DistrictType||'_'||Adjacency_YieldChanges.YieldType||'_ATTACH', 'ModifierId', 'BONUS_HOH_GREATWORK_ADJACENCY_'||District_Adjacencies.DistrictType||'_'||Adjacency_YieldChanges.YieldType
-- FROM District_Adjacencies,Adjacency_YieldChanges where District_Adjacencies.YieldChangeId=Adjacency_YieldChanges.ID 
-- and exists 
-- (select District_Adjacencies.DistrictType from Districts where (Districts.TraitType is null and District_Adjacencies.DistrictType = Districts.DistrictType)); 
-- Custom ModifierType
insert or replace into Types (Type, Kind) VALUES 
('QGG_SINGLECITY_MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE', 'KIND_MODIFIER');
insert or replace into DynamicModifiers (ModifierType, CollectionType, EffectType) VALUES 
('QGG_SINGLECITY_MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE', 'COLLECTION_PLAYER_DISTRICTS', 'EFFECT_ADJUST_DISTRICT_BASE_YIELD_CHANGE');
--单个城市的区域+1相邻加成
insert or replace into Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) 
SELECT 'BONUS_HOH_GREATWORK_ADJACENCY_'||District_Adjacencies.DistrictType||'_'||Adjacency_YieldChanges.YieldType,  'QGG_SINGLECITY_MODIFIER_PLAYER_DISTRICT_ADJUST_BASE_YIELD_CHANGE', 0, 0, 0, NULL, 'RS_QGG_HOH_DISTRICT_IS_'||District_Adjacencies.DistrictType
FROM District_Adjacencies,Adjacency_YieldChanges where District_Adjacencies.YieldChangeId=Adjacency_YieldChanges.ID 
and exists 
(select District_Adjacencies.DistrictType from Districts where (Districts.TraitType is null and District_Adjacencies.DistrictType = Districts.DistrictType)); 
insert or replace into ModifierArguments (ModifierId, Name, Value) 
SELECT 'BONUS_HOH_GREATWORK_ADJACENCY_'||District_Adjacencies.DistrictType||'_'||Adjacency_YieldChanges.YieldType, 'Amount', '1'
FROM District_Adjacencies,Adjacency_YieldChanges where District_Adjacencies.YieldChangeId=Adjacency_YieldChanges.ID 
and exists 
(select District_Adjacencies.DistrictType from Districts where (Districts.TraitType is null and District_Adjacencies.DistrictType = Districts.DistrictType)); 
insert or replace into ModifierArguments (ModifierId, Name, Value) 
SELECT 'BONUS_HOH_GREATWORK_ADJACENCY_'||District_Adjacencies.DistrictType||'_'||Adjacency_YieldChanges.YieldType, 'YieldType', Adjacency_YieldChanges.YieldType
FROM District_Adjacencies,Adjacency_YieldChanges where District_Adjacencies.YieldChangeId=Adjacency_YieldChanges.ID 
and exists 
(select District_Adjacencies.DistrictType from Districts where (Districts.TraitType is null and District_Adjacencies.DistrictType = Districts.DistrictType)); 

--所有奇观+1全产
insert or replace into Modifiers (ModifierId, ModifierType, RunOnce, Permanent, NewOnly, OwnerRequirementSetId, SubjectRequirementSetId) 
SELECT 'BONUS_HOH_WONDER_BONUS_'||BuildingType||'_'||YieldType, 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_YIELD_CHANGE', 0, 0, 0, NULL, NULL
FROM Buildings,Yields WHERE Buildings.IsWonder="1";
insert or replace into ModifierArguments (ModifierId, Name, Value)
SELECT
'BONUS_HOH_WONDER_BONUS_'||BuildingType||'_'||YieldType, 'Amount', '1'					FROM Buildings,Yields WHERE Buildings.IsWonder="1"   
UNION SELECT
'BONUS_HOH_WONDER_BONUS_'||BuildingType||'_'||YieldType, 'BuildingType', BuildingType   FROM Buildings,Yields WHERE Buildings.IsWonder="1"
UNION SELECT
'BONUS_HOH_WONDER_BONUS_'||BuildingType||'_'||YieldType, 'YieldType', YieldType         FROM Buildings,Yields WHERE Buildings.IsWonder="1";

insert or replace into GlobalParameters(Name,Value)VALUES
('HOH_GREAT_ENGINEER_PERCENTAGE','10');




