local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");
local _G = _G or getfenv(0)

local ORANGE = "|cffFF8400";
local data = AtlasLoot_Data["AtlasLootSetItems"]

function AtlasLoot_GetDataSource(dataID)
	local source = nil
	for k in pairs(AtlasLoot_Data) do
		if source then
			break
		end
		for i in pairs(AtlasLoot_Data[k]) do
			if i == dataID then
				source = k
				break
			end
		end
	end
	return source
end

function AtlasLoot_PrepMenu(backPage, title)
	for i = 1, 30, 1 do
		_G["AtlasLootItem_" .. i]:Hide();
	end
	for i = 1, 30, 1 do
		local button = _G["AtlasLootMenuItem_" .. i]
		button:Hide();
		button.isheader = false;
		button.container = nil
		button.dataSource = nil
		_G["AtlasLootMenuItem_" .. i .. "_Icon"]:SetTexCoord(0, 1, 0, 1)
		_G["AtlasLootMenuItem_"..i.."_IconBorder"]:SetVertexColor(1, 1, 1)
	end
	if backPage then
		AtlasLootItemsFrame_BACK:Show();
		AtlasLootItemsFrame_BACK.lootpage = backPage;
	else
		AtlasLootItemsFrame_BACK:Hide();
	end
	AtlasLootItemsFrame_NEXT:Hide();
	AtlasLootItemsFrame_PREV:Hide();
	AtlasLootServerQueryButton:Hide();
	for i = 1, 30, 1 do
		_G["AtlasLootMenuItem_" .. i .. "_Extra"]:Show();
	end
	AtlasLoot_BossName:SetText("|cffFFFFFF" .. title);
	-- AtlasLoot_SetItemInfoFrame(AtlasLoot_AnchorPoint);
end

function AtlasLootSetMenu()
	AtlasLoot_PrepMenu(nil, AL["Collections"])
	AtlasLootCharDB.LastBoss = "SETMENU"
	AtlasLootCharDB.LastBossText = AL["Collections"]
	--ZG
	AtlasLootMenuItem_3_Name:SetText(AL["Zul'Gurub Sets"]);
	AtlasLootMenuItem_3_Extra:SetText("");
	AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Sword_55");
	AtlasLootMenuItem_3.lootpage = "ZGSET";
	AtlasLootMenuItem_3:Show();
	--AQ20
	AtlasLootMenuItem_4_Name:SetText(AL["Ruins of Ahn'Qiraj Sets"]);
	AtlasLootMenuItem_4_Extra:SetText("");
	AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Axe_15");
	AtlasLootMenuItem_4.lootpage = "AQ20SET";
	AtlasLootMenuItem_4:Show();
	--AQ40
	AtlasLootMenuItem_5_Name:SetText(AL["Temple of Ahn'Qiraj Sets"]);
	AtlasLootMenuItem_5_Extra:SetText("");
	AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\INV_Shoulder_35");
	AtlasLootMenuItem_5.lootpage = "AQ40SET";
	AtlasLootMenuItem_5:Show();
	--Karazhan
	AtlasLootMenuItem_6_Name:SetText(AL["Karazhan"] .. " " .. AL["Sets"]);
	AtlasLootMenuItem_6_Extra:SetText("");
	AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\INV_Staff_Medivh");
	AtlasLootMenuItem_6.lootpage = "KARASET";
	AtlasLootMenuItem_6:Show();
	--Legendaries
	AtlasLootMenuItem_8_Name:SetText(AL["Legendary Items"]);
	AtlasLootMenuItem_8_Extra:SetText("");
	AtlasLootMenuItem_8_Icon:SetTexture("Interface\\Icons\\INV_Hammer_Unique_Sulfuras");
	AtlasLootMenuItem_8.lootpage = "Legendaries";
	AtlasLootMenuItem_8:Show();
	--Rare Pets
	AtlasLootMenuItem_9_Name:SetText(AL["Rare Pets"]);
	AtlasLootMenuItem_9_Extra:SetText("");
	AtlasLootMenuItem_9_Icon:SetTexture("Interface\\Icons\\Ability_Seal");
	AtlasLootMenuItem_9.lootpage = "RarePets1";
	AtlasLootMenuItem_9:Show();
	--Rare Mounts
	AtlasLootMenuItem_10_Name:SetText(AL["Rare Mounts"]);
	AtlasLootMenuItem_10_Extra:SetText("");
	AtlasLootMenuItem_10_Icon:SetTexture("Interface\\Icons\\INV_Misc_QirajiCrystal_05");
	AtlasLootMenuItem_10.lootpage = "RareMounts";
	AtlasLootMenuItem_10:Show();
	--Sets
	AtlasLootMenuItem_2_Name:SetText(AL["Sets"]);
	AtlasLootMenuItem_2_Extra:SetText("");
	AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Sword_43");
	AtlasLootMenuItem_2.lootpage = "PRE60SET";
	AtlasLootMenuItem_2:Show();
	--World Epics
	AtlasLootMenuItem_23_Name:SetText(AL["World Epics"]);
	AtlasLootMenuItem_23_Extra:SetText("");
	AtlasLootMenuItem_23_Icon:SetTexture("Interface\\Icons\\INV_Gauntlets_30");
	AtlasLootMenuItem_23.lootpage = "WorldEpics1";
	AtlasLootMenuItem_23:Show();
	--Tabards
	AtlasLootMenuItem_24_Name:SetText(AL["Tabards"]);
	AtlasLootMenuItem_24_Extra:SetText("");
	AtlasLootMenuItem_24_Icon:SetTexture("Interface\\Icons\\INV_Shirt_GuildTabard_01");
	AtlasLootMenuItem_24.lootpage = "Tabards";
	AtlasLootMenuItem_24:Show();
	--Dungeon Set 1/2
	AtlasLootMenuItem_17_Name:SetText(AL["Dungeon 1/2 Sets"]);
	AtlasLootMenuItem_17_Extra:SetText("");
	AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Helmet_24");
	AtlasLootMenuItem_17.lootpage = "T0SET";
	AtlasLootMenuItem_17:Show();
	--Tier 1
	AtlasLootMenuItem_18_Name:SetText(AL["Tier 1 Sets"]);
	AtlasLootMenuItem_18_Extra:SetText("");
	AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_Helmet_09");
	AtlasLootMenuItem_18.lootpage = "T1SET";
	AtlasLootMenuItem_18:Show();
	--Tier 2
	AtlasLootMenuItem_19_Name:SetText(AL["Tier 2 Sets"]);
	AtlasLootMenuItem_19_Extra:SetText("");
	AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\INV_Helmet_74");
	AtlasLootMenuItem_19.lootpage = "T2SET";
	AtlasLootMenuItem_19:Show();
	--Tier 3
	AtlasLootMenuItem_20_Name:SetText(AL["Tier 3 Sets"]);
	AtlasLootMenuItem_20_Extra:SetText("");
	AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\INV_Helmet_58");
	AtlasLootMenuItem_20.lootpage = "T3SET";
	AtlasLootMenuItem_20:Show();
	for i = 1, 30 do
		if _G["AtlasLootMenuItem_"..i].container then
			_G["AtlasLootMenuItem_"..i.."_IconBorder"]:SetVertexColor(1, 0.82, 0)
		else
			_G["AtlasLootMenuItem_"..i.."_IconBorder"]:SetVertexColor(1, 1, 1)
		end
	end
end

function AtlasLootWorldEpicsMenu()
	AtlasLoot_PrepMenu("SETMENU", AL["World Epics"])
	--Lvl 30-39 BoE World Epics
	AtlasLootMenuItem_2_Name:SetText(AL["Level 30-39"]);
	AtlasLootMenuItem_2_Extra:SetText("");
	AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Ring_15");
	AtlasLootMenuItem_2.lootpage = "WorldEpics1";
	AtlasLootMenuItem_2:Show();
	--Lvl 40-49 BoE World Epics
	AtlasLootMenuItem_3_Name:SetText(AL["Level 40-49"]);
	AtlasLootMenuItem_3_Extra:SetText("");
	AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Staff_29");
	AtlasLootMenuItem_3.lootpage = "WorldEpics2";
	AtlasLootMenuItem_3:Show();
	--Lvl 50-60 BoE World Epics
	AtlasLootMenuItem_4_Name:SetText(AL["Level 50-60"]);
	AtlasLootMenuItem_4_Extra:SetText("");
	AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Sword_19");
	AtlasLootMenuItem_4.lootpage = "WorldEpics3";
	AtlasLootMenuItem_4:Show();
end

function AtlasLootPRE60SetMenu()
	AtlasLoot_PrepMenu("SETMENU", AL["Sets"])
	--The Deadmines - Defias Leather
	AtlasLootMenuItem_2_Name:SetText(AL["Defias Leather"]);
	AtlasLootMenuItem_2_Extra:SetText(ORANGE .. AL["The Deadmines"]);
	AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Pants_12");
	AtlasLootMenuItem_2.lootpage = "DEADMINES";
	AtlasLootMenuItem_2.container = data.DeadminesC
	AtlasLootMenuItem_2:Show();
	--Wailing Caverns - Embrace of the Viper
	AtlasLootMenuItem_3_Name:SetText(AL["Embrace of the Viper"]);
	AtlasLootMenuItem_3_Extra:SetText(ORANGE .. AL["Wailing Caverns"]);
	AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Shirt_16");
	AtlasLootMenuItem_3.lootpage = "WAILING";
	AtlasLootMenuItem_3.container = data.WailingC
	AtlasLootMenuItem_3:Show();
	--Scarlet Monastery - Chain of the Scarlet Crusade
	AtlasLootMenuItem_4_Name:SetText(AL["Chain of the Scarlet Crusade"]);
	AtlasLootMenuItem_4_Extra:SetText(ORANGE .. AL["Scarlet Monastery"]);
	AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Gauntlets_19");
	AtlasLootMenuItem_4.lootpage = "SCARLET";
	AtlasLootMenuItem_4.container = data.ScarletC
	AtlasLootMenuItem_4:Show();
	--Blackrock Depths - The Gladiator
	AtlasLootMenuItem_5_Name:SetText(AL["The Gladiator"]);
	AtlasLootMenuItem_5_Extra:SetText(ORANGE .. AL["Blackrock Depths"]);
	AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\INV_Helmet_01");
	AtlasLootMenuItem_5.lootpage = "BLACKROCKD";
	AtlasLootMenuItem_5.container = data.BlackrockdC
	AtlasLootMenuItem_5:Show();
	--Ironweave Battlesuit
	AtlasLootMenuItem_6_Name:SetText(AL["Ironweave Battlesuit"]);
	AtlasLootMenuItem_6_Extra:SetText(ORANGE .. AL["Various Locations"]);
	AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\INV_Boots_Cloth_05");
	AtlasLootMenuItem_6.lootpage = "IRONWEAVE";
	AtlasLootMenuItem_6.container = data.IronweaveC
	AtlasLootMenuItem_6:Show();
	--Stratholme - The Postmaster
	AtlasLootMenuItem_7_Name:SetText(AL["The Postmaster"]);
	AtlasLootMenuItem_7_Extra:SetText(ORANGE .. AL["Stratholme"]);
	AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\INV_Boots_02");
	AtlasLootMenuItem_7.lootpage = "STRAT";
	AtlasLootMenuItem_7.container = data.StratC
	AtlasLootMenuItem_7:Show();
	--Scholomance - Cloth - Necropile Raiment
	AtlasLootMenuItem_8_Name:SetText(AL["Necropile Raiment"]);
	AtlasLootMenuItem_8_Extra:SetText(ORANGE .. AL["Scholomance"]);
	AtlasLootMenuItem_8_Icon:SetTexture("Interface\\Icons\\INV_Shoulder_02");
	AtlasLootMenuItem_8.lootpage = "ScholoCloth";
	AtlasLootMenuItem_8.container = data.ScholoClothC
	AtlasLootMenuItem_8:Show();
	--Scholomance - Leather - Cadaverous Garb
	AtlasLootMenuItem_9_Name:SetText(AL["Cadaverous Garb"]);
	AtlasLootMenuItem_9_Extra:SetText(ORANGE .. AL["Scholomance"]);
	AtlasLootMenuItem_9_Icon:SetTexture("Interface\\Icons\\INV_Belt_16");
	AtlasLootMenuItem_9.lootpage = "ScholoLeather";
	AtlasLootMenuItem_9.container = data.ScholoLeatherC
	AtlasLootMenuItem_9:Show();
	--Scholomance - Mail - Bloodmail Regalia
	AtlasLootMenuItem_10_Name:SetText(AL["Bloodmail Regalia"]);
	AtlasLootMenuItem_10_Extra:SetText(ORANGE .. AL["Scholomance"]);
	AtlasLootMenuItem_10_Icon:SetTexture("Interface\\Icons\\INV_Gauntlets_26");
	AtlasLootMenuItem_10.lootpage = "ScholoMail";
	AtlasLootMenuItem_10.container = data.ScholoMailC
	AtlasLootMenuItem_10:Show();
	--Scholomance - Plate - Deathbone Guardian
	AtlasLootMenuItem_11_Name:SetText(AL["Deathbone Guardian"]);
	AtlasLootMenuItem_11_Extra:SetText(ORANGE .. AL["Scholomance"]);
	AtlasLootMenuItem_11_Icon:SetTexture("Interface\\Icons\\INV_Belt_12");
	AtlasLootMenuItem_11.lootpage = "ScholoPlate";
	AtlasLootMenuItem_11.container = data.ScholoPlateC
	AtlasLootMenuItem_11:Show();
	--Scourge Invasion
	AtlasLootMenuItem_12_Name:SetText(AL["Scourge Invasion"]);
	AtlasLootMenuItem_12_Extra:SetText(ORANGE .. AL["Various Locations"]);
	AtlasLootMenuItem_12_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Talisman_13");
	AtlasLootMenuItem_12.lootpage = "ScourgeInvasion";
	AtlasLootMenuItem_12.container = data.ScourgeInvasionC
	AtlasLootMenuItem_12:Show();
	--Spider's Kiss
	AtlasLootMenuItem_17_Name:SetText(AL["Spider's Kiss"]);
	AtlasLootMenuItem_17_Extra:SetText(ORANGE .. AL["Lower Blackrock Spire"]);
	AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\INV_Weapon_ShortBlade_16");
	AtlasLootMenuItem_17.lootpage = "SpiderKiss";
	AtlasLootMenuItem_17.container = data.SpiderKissC
	AtlasLootMenuItem_17:Show();
	--Dal'Rend's Arms
	AtlasLootMenuItem_18_Name:SetText(AL["Dal'Rend's Arms"]);
	AtlasLootMenuItem_18_Extra:SetText(ORANGE .. AL["Upper Blackrock Spire"]);
	AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\INV_Sword_43");
	AtlasLootMenuItem_18.lootpage = "DalRend";
	AtlasLootMenuItem_18.container = data.DalRendC
	AtlasLootMenuItem_18:Show();
	--Shard of the Gods
	AtlasLootMenuItem_22_Name:SetText(AL["Shard of the Gods"]);
	AtlasLootMenuItem_22_Extra:SetText(ORANGE .. AL["Various Locations"]);
	AtlasLootMenuItem_22_Icon:SetTexture("Interface\\Icons\\INV_Misc_MonsterScales_15");
	AtlasLootMenuItem_22.lootpage = "ShardOfGods";
	AtlasLootMenuItem_22.container = data.ShardOfGodsC
	AtlasLootMenuItem_22:Show();
	--Spirit of Eskhandar
	AtlasLootMenuItem_23_Name:SetText(AL["Spirit of Eskhandar"]);
	AtlasLootMenuItem_23_Extra:SetText(ORANGE .. AL["Various Locations"]);
	AtlasLootMenuItem_23_Icon:SetTexture("Interface\\Icons\\INV_Misc_MonsterClaw_04");
	AtlasLootMenuItem_23.lootpage = "SpiritofEskhandar";
	AtlasLootMenuItem_23.container = data.SpiritofEskhandarC
	AtlasLootMenuItem_23:Show();
	for i = 1, 30 do
		local button = _G["AtlasLootMenuItem_" .. i]
		button.dataSource = AtlasLoot_GetDataSource(button.lootpage)
		if ( type(button.container) == "table" ) then
			_G["AtlasLootMenuItem_"..i.."_IconBorder"]:SetVertexColor(1, 0.82, 0)
			for row = 1, getn(button.container) do
				for item = 1, getn(button.container[row]) do
					AtlasLoot_CacheItem(button.container[row][item][1])
				end
			end
		end
	end
end

function AtlasLootZGSetMenu()
	AtlasLoot_PrepMenu("SETMENU", AL["Zul'Gurub Sets"])
	--Priest
	AtlasLootMenuItem_3_Name:SetText("|cffffffff" .. AL["Priest"]);
	AtlasLootMenuItem_3_Extra:SetText("");
	AtlasLootMenuItem_3_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\priest")
	AtlasLootMenuItem_3.lootpage = "ZGPriest";
	AtlasLootMenuItem_3.container = data.ZGPriestC
	AtlasLootMenuItem_3:Show();
	--Mage
	AtlasLootMenuItem_4_Name:SetText("|cff68ccef" .. AL["Mage"]);
	AtlasLootMenuItem_4_Extra:SetText("");
	AtlasLootMenuItem_4_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\mage")
	AtlasLootMenuItem_4.lootpage = "ZGMage";
	AtlasLootMenuItem_4.container = data.ZGMageC
	AtlasLootMenuItem_4:Show();
	--Warlock
	AtlasLootMenuItem_5_Name:SetText("|cff9382c9" .. AL["Warlock"]);
	AtlasLootMenuItem_5_Extra:SetText("");
	AtlasLootMenuItem_5_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\warlock")
	AtlasLootMenuItem_5.lootpage = "ZGWarlock";
	AtlasLootMenuItem_5.container = data.ZGWarlockC
	AtlasLootMenuItem_5:Show();
	--Rogue
	AtlasLootMenuItem_6_Name:SetText("|cfffff468" .. AL["Rogue"]);
	AtlasLootMenuItem_6_Extra:SetText("");
	AtlasLootMenuItem_6_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\rogue")
	AtlasLootMenuItem_6.lootpage = "ZGRogue";
	AtlasLootMenuItem_6.container = data.ZGRogueC
	AtlasLootMenuItem_6:Show();
	--Druid
	AtlasLootMenuItem_7_Name:SetText("|cffff7c0a" .. AL["Druid"]);
	AtlasLootMenuItem_7_Extra:SetText("");
	AtlasLootMenuItem_7_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\druid")
	AtlasLootMenuItem_7.lootpage = "ZGDruid";
	AtlasLootMenuItem_7.container = data.ZGDruidC
	AtlasLootMenuItem_7:Show();
	--Hunter
	AtlasLootMenuItem_18_Name:SetText("|cffaad372" .. AL["Hunter"]);
	AtlasLootMenuItem_18_Extra:SetText("");
	AtlasLootMenuItem_18_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\hunter")
	AtlasLootMenuItem_18.lootpage = "ZGHunter";
	AtlasLootMenuItem_18.container = data.ZGHunterC
	AtlasLootMenuItem_18:Show();
	--Shaman
	AtlasLootMenuItem_19_Name:SetText("|cff2773ff" .. AL["Shaman"]);
	AtlasLootMenuItem_19_Extra:SetText("");
	AtlasLootMenuItem_19_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\shaman")
	AtlasLootMenuItem_19.lootpage = "ZGShaman";
	AtlasLootMenuItem_19.container = data.ZGShamanC
	AtlasLootMenuItem_19:Show();
	--Paladin
	AtlasLootMenuItem_20_Name:SetText("|cfff48cba" .. AL["Paladin"]);
	AtlasLootMenuItem_20_Extra:SetText("");
	AtlasLootMenuItem_20_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\paladin")
	AtlasLootMenuItem_20.lootpage = "ZGPaladin";
	AtlasLootMenuItem_20.container = data.ZGPaladinC
	AtlasLootMenuItem_20:Show();
	--Warrior
	AtlasLootMenuItem_21_Name:SetText("|cffc69b6d" .. AL["Warrior"]);
	AtlasLootMenuItem_21_Extra:SetText("");
	AtlasLootMenuItem_21_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\warrior")
	AtlasLootMenuItem_21.lootpage = "ZGWarrior";
	AtlasLootMenuItem_21.container = data.ZGWarriorC
	AtlasLootMenuItem_21:Show();
	--Zul'Gurub Rings
	AtlasLootMenuItem_23_Name:SetText(AL["Zul'Gurub Rings"]);
	AtlasLootMenuItem_23_Extra:SetText("");
	AtlasLootMenuItem_23_Icon:SetTexture("Interface\\Icons\\INV_Jewelry_Ring_46");
	AtlasLootMenuItem_23.lootpage = "ZGRings";
	AtlasLootMenuItem_23.container = data.ZGRingsC
	AtlasLootMenuItem_23:Show();
	--Primal Blessing
	AtlasLootMenuItem_24_Name:SetText(AL["Primal Blessing"]);
	AtlasLootMenuItem_24_Extra:SetText("");
	AtlasLootMenuItem_24_Icon:SetTexture("Interface\\Icons\\INV_Weapon_Hand_01");
	AtlasLootMenuItem_24.lootpage = "PrimalBlessing";
	AtlasLootMenuItem_24.container = data.PrimalBlessingC
	AtlasLootMenuItem_24:Show();
	--The Twin Blades of Hakkari
	AtlasLootMenuItem_25_Name:SetText(AL["The Twin Blades of Hakkari"]);
	AtlasLootMenuItem_25_Extra:SetText("");
	AtlasLootMenuItem_25_Icon:SetTexture("Interface\\Icons\\INV_Sword_55");
	AtlasLootMenuItem_25.lootpage = "HakkariBlades";
	AtlasLootMenuItem_25.container = data.HakkariBladesC
	AtlasLootMenuItem_25:Show();
	for i = 1, 30 do
		local button = _G["AtlasLootMenuItem_" .. i]
		button.dataSource = AtlasLoot_GetDataSource(button.lootpage)
		if ( type(button.container) == "table" ) then
			_G["AtlasLootMenuItem_"..i.."_IconBorder"]:SetVertexColor(1, 0.82, 0)
			for row = 1, getn(button.container) do
				for item = 1, getn(button.container[row]) do
					AtlasLoot_CacheItem(button.container[row][item][1])
				end
			end
		end
	end
end

function AtlasLootAQ40SetMenu()
	AtlasLoot_PrepMenu("SETMENU", AL["Temple of Ahn'Qiraj Sets"])
	--Priest
	AtlasLootMenuItem_3_Name:SetText("|cffffffff" .. AL["Priest"]);
	AtlasLootMenuItem_3_Extra:SetText("");
	AtlasLootMenuItem_3_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\priest")
	AtlasLootMenuItem_3.lootpage = "AQ40Priest";
	AtlasLootMenuItem_3.container = data.AQ40PriestC
	AtlasLootMenuItem_3:Show();
	--Mage
	AtlasLootMenuItem_4_Name:SetText("|cff68ccef" .. AL["Mage"]);
	AtlasLootMenuItem_4_Extra:SetText("");
	AtlasLootMenuItem_4_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\mage")
	AtlasLootMenuItem_4.lootpage = "AQ40Mage";
	AtlasLootMenuItem_4.container = data.AQ40MageC
	AtlasLootMenuItem_4:Show();
	--Warlock
	AtlasLootMenuItem_5_Name:SetText("|cff9382c9" .. AL["Warlock"]);
	AtlasLootMenuItem_5_Extra:SetText("");
	AtlasLootMenuItem_5_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\warlock")
	AtlasLootMenuItem_5.lootpage = "AQ40Warlock";
	AtlasLootMenuItem_5.container = data.AQ40WarlockC
	AtlasLootMenuItem_5:Show();
	--Rogue
	AtlasLootMenuItem_6_Name:SetText("|cfffff468" .. AL["Rogue"]);
	AtlasLootMenuItem_6_Extra:SetText("");
	AtlasLootMenuItem_6_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\rogue");
	AtlasLootMenuItem_6.lootpage = "AQ40Rogue";
	AtlasLootMenuItem_6.container = data.AQ40RogueC
	AtlasLootMenuItem_6:Show();
	--Druid
	AtlasLootMenuItem_7_Name:SetText("|cffff7c0a" .. AL["Druid"]);
	AtlasLootMenuItem_7_Extra:SetText("");
	AtlasLootMenuItem_7_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\druid");
	AtlasLootMenuItem_7.lootpage = "AQ40Druid";
	AtlasLootMenuItem_7.container = data.AQ40DruidC
	AtlasLootMenuItem_7:Show();
	--Hunter
	AtlasLootMenuItem_18_Name:SetText("|cffaad372" .. AL["Hunter"]);
	AtlasLootMenuItem_18_Extra:SetText("");
	AtlasLootMenuItem_18_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\hunter");
	AtlasLootMenuItem_18.lootpage = "AQ40Hunter";
	AtlasLootMenuItem_18.container = data.AQ40HunterC
	AtlasLootMenuItem_18:Show();
	--Shaman
	AtlasLootMenuItem_19_Name:SetText("|cff2773ff" .. AL["Shaman"]);
	AtlasLootMenuItem_19_Extra:SetText("");
	AtlasLootMenuItem_19_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\shaman")
	AtlasLootMenuItem_19.lootpage = "AQ40Shaman";
	AtlasLootMenuItem_19.container = data.AQ40ShamanC
	AtlasLootMenuItem_19:Show();
	--Paladin
	AtlasLootMenuItem_20_Name:SetText("|cfff48cba" .. AL["Paladin"]);
	AtlasLootMenuItem_20_Extra:SetText("");
	AtlasLootMenuItem_20_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\paladin");
	AtlasLootMenuItem_20.lootpage = "AQ40Paladin";
	AtlasLootMenuItem_20.container = data.AQ40PaladinC
	AtlasLootMenuItem_20:Show();
	--Warrior
	AtlasLootMenuItem_21_Name:SetText("|cffc69b6d" .. AL["Warrior"]);
	AtlasLootMenuItem_21_Extra:SetText("");
	AtlasLootMenuItem_21_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\warrior");
	AtlasLootMenuItem_21.lootpage = "AQ40Warrior";
	AtlasLootMenuItem_21.container = data.AQ40WarriorC
	AtlasLootMenuItem_21:Show();
	for i = 1, 30 do
		local button = _G["AtlasLootMenuItem_" .. i]
		button.dataSource = AtlasLoot_GetDataSource(button.lootpage)
		if ( type(button.container) == "table" ) then
			_G["AtlasLootMenuItem_"..i.."_IconBorder"]:SetVertexColor(1, 0.82, 0)
			for row = 1, getn(button.container) do
				for item = 1, getn(button.container[row]) do
					AtlasLoot_CacheItem(button.container[row][item][1])
				end
			end
		end
	end
end

function AtlasLootAQ20SetMenu()
	AtlasLoot_PrepMenu("SETMENU", AL["Ruins of Ahn'Qiraj Sets"])
	--Priest
	AtlasLootMenuItem_3_Name:SetText("|cffffffff" .. AL["Priest"]);
	AtlasLootMenuItem_3_Extra:SetText("");
	AtlasLootMenuItem_3_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\priest");
	AtlasLootMenuItem_3.lootpage = "AQ20Priest";
	AtlasLootMenuItem_3.container = data.AQ20PriestC
	AtlasLootMenuItem_3:Show();
	--Mage
	AtlasLootMenuItem_4_Name:SetText("|cff68ccef" .. AL["Mage"]);
	AtlasLootMenuItem_4_Extra:SetText("");
	AtlasLootMenuItem_4_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\mage")
	AtlasLootMenuItem_4.lootpage = "AQ20Mage";
	AtlasLootMenuItem_4.container = data.AQ20MageC
	AtlasLootMenuItem_4:Show();
	--Warlock
	AtlasLootMenuItem_5_Name:SetText("|cff9382c9" .. AL["Warlock"]);
	AtlasLootMenuItem_5_Extra:SetText("");
	AtlasLootMenuItem_5_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\warlock")
	AtlasLootMenuItem_5.lootpage = "AQ20Warlock";
	AtlasLootMenuItem_5.container = data.AQ20WarlockC
	AtlasLootMenuItem_5:Show();
	--Rogue
	AtlasLootMenuItem_6_Name:SetText("|cfffff468" .. AL["Rogue"]);
	AtlasLootMenuItem_6_Extra:SetText("");
	AtlasLootMenuItem_6_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\rogue");
	AtlasLootMenuItem_6.lootpage = "AQ20Rogue";
	AtlasLootMenuItem_6.container = data.AQ20RogueC
	AtlasLootMenuItem_6:Show();
	--Druid
	AtlasLootMenuItem_7_Name:SetText("|cffff7c0a" .. AL["Druid"]);
	AtlasLootMenuItem_7_Extra:SetText("");
	AtlasLootMenuItem_7_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\druid");
	AtlasLootMenuItem_7.lootpage = "AQ20Druid";
	AtlasLootMenuItem_7.container = data.AQ20DruidC
	AtlasLootMenuItem_7:Show();
	--Hunter
	AtlasLootMenuItem_18_Name:SetText("|cffaad372" .. AL["Hunter"]);
	AtlasLootMenuItem_18_Extra:SetText("");
	AtlasLootMenuItem_18_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\hunter");
	AtlasLootMenuItem_18.lootpage = "AQ20Hunter";
	AtlasLootMenuItem_18.container = data.AQ20HunterC
	AtlasLootMenuItem_18:Show();
	--Shaman
	AtlasLootMenuItem_19_Name:SetText("|cff2773ff" .. AL["Shaman"]);
	AtlasLootMenuItem_19_Extra:SetText("");
	AtlasLootMenuItem_19_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\shaman")
	AtlasLootMenuItem_19.lootpage = "AQ20Shaman";
	AtlasLootMenuItem_19.container = data.AQ20ShamanC
	AtlasLootMenuItem_19:Show();
	--Paladin
	AtlasLootMenuItem_20_Name:SetText("|cfff48cba" .. AL["Paladin"]);
	AtlasLootMenuItem_20_Extra:SetText("");
	AtlasLootMenuItem_20_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\paladin");
	AtlasLootMenuItem_20.lootpage = "AQ20Paladin";
	AtlasLootMenuItem_20.container = data.AQ20PaladinC
	AtlasLootMenuItem_20:Show();
	--Warrior
	AtlasLootMenuItem_21_Name:SetText("|cffc69b6d" .. AL["Warrior"]);
	AtlasLootMenuItem_21_Extra:SetText("");
	AtlasLootMenuItem_21_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\warrior");
	AtlasLootMenuItem_21.lootpage = "AQ20Warrior";
	AtlasLootMenuItem_21.container = data.AQ20WarriorC
	AtlasLootMenuItem_21:Show();
	for i = 1, 30 do
		local button = _G["AtlasLootMenuItem_" .. i]
		button.dataSource = AtlasLoot_GetDataSource(button.lootpage)
		if ( type(button.container) == "table" ) then
			_G["AtlasLootMenuItem_"..i.."_IconBorder"]:SetVertexColor(1, 0.82, 0)
			for row = 1, getn(button.container) do
				for item = 1, getn(button.container[row]) do
					AtlasLoot_CacheItem(button.container[row][item][1])
				end
			end
		end
	end
end

function AtlasLootT0SetMenu()
	AtlasLoot_PrepMenu("SETMENU", AL["Dungeon 1/2 Sets"])
	--Priest
	AtlasLootMenuItem_3_Name:SetText("|cffffffff" .. AL["Priest"]);
	AtlasLootMenuItem_3_Extra:SetText("");
	AtlasLootMenuItem_3_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\priest");
	AtlasLootMenuItem_3.lootpage = "T0Priest";
	AtlasLootMenuItem_3.container = data.T0PriestC
	AtlasLootMenuItem_3:Show();
	--Mage
	AtlasLootMenuItem_4_Name:SetText("|cff68ccef" .. AL["Mage"]);
	AtlasLootMenuItem_4_Extra:SetText("");
	AtlasLootMenuItem_4_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\mage");
	AtlasLootMenuItem_4.lootpage = "T0Mage";
	AtlasLootMenuItem_4.container = data.T0MageC
	AtlasLootMenuItem_4:Show();
	--Warlock
	AtlasLootMenuItem_5_Name:SetText("|cff9382c9" .. AL["Warlock"]);
	AtlasLootMenuItem_5_Extra:SetText("");
	AtlasLootMenuItem_5_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\warlock")
	AtlasLootMenuItem_5.lootpage = "T0Warlock";
	AtlasLootMenuItem_5.container = data.T0WarlockC
	AtlasLootMenuItem_5:Show();
	--Rogue
	AtlasLootMenuItem_6_Name:SetText("|cfffff468" .. AL["Rogue"]);
	AtlasLootMenuItem_6_Extra:SetText("");
	AtlasLootMenuItem_6_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\rogue")
	AtlasLootMenuItem_6.lootpage = "T0Rogue";
	AtlasLootMenuItem_6.container = data.T0RogueC
	AtlasLootMenuItem_6:Show();
	--Druid
	AtlasLootMenuItem_7_Name:SetText("|cffff7c0a" .. AL["Druid"]);
	AtlasLootMenuItem_7_Extra:SetText("");
	AtlasLootMenuItem_7_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\druid")
	AtlasLootMenuItem_7.lootpage = "T0Druid";
	AtlasLootMenuItem_7.container = data.T0DruidC
	AtlasLootMenuItem_7:Show();
	--Hunter
	AtlasLootMenuItem_18_Name:SetText("|cffaad372" .. AL["Hunter"]);
	AtlasLootMenuItem_18_Extra:SetText("");
	AtlasLootMenuItem_18_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\hunter")
	AtlasLootMenuItem_18.lootpage = "T0Hunter";
	AtlasLootMenuItem_18.container = data.T0HunterC
	AtlasLootMenuItem_18:Show();
	--Shaman
	AtlasLootMenuItem_19_Name:SetText("|cff2773ff" .. AL["Shaman"]);
	AtlasLootMenuItem_19_Extra:SetText("");
	AtlasLootMenuItem_19_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\shaman")
	AtlasLootMenuItem_19.lootpage = "T0Shaman";
	AtlasLootMenuItem_19.container = data.T0ShamanC
	AtlasLootMenuItem_19:Show();
	--Paladin
	AtlasLootMenuItem_20_Name:SetText("|cfff48cba" .. AL["Paladin"]);
	AtlasLootMenuItem_20_Extra:SetText("");
	AtlasLootMenuItem_20_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\paladin")
	AtlasLootMenuItem_20.lootpage = "T0Paladin";
	AtlasLootMenuItem_20.container = data.T0PaladinC
	AtlasLootMenuItem_20:Show();
	--Warrior
	AtlasLootMenuItem_21_Name:SetText("|cffc69b6d" .. AL["Warrior"]);
	AtlasLootMenuItem_21_Extra:SetText("");
	AtlasLootMenuItem_21_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\warrior")
	AtlasLootMenuItem_21.lootpage = "T0Warrior";
	AtlasLootMenuItem_21.container = data.T0WarriorC
	AtlasLootMenuItem_21:Show();
	for i = 1, 30 do
		local button = _G["AtlasLootMenuItem_" .. i]
		button.dataSource = AtlasLoot_GetDataSource(button.lootpage)
		if ( type(button.container) == "table" ) then
			_G["AtlasLootMenuItem_"..i.."_IconBorder"]:SetVertexColor(1, 0.82, 0)
			for row = 1, getn(button.container) do
				for item = 1, getn(button.container[row]) do
					AtlasLoot_CacheItem(button.container[row][item][1])
				end
			end
		end
	end
end

function AtlasLootT1SetMenu()
	AtlasLoot_PrepMenu("SETMENU", AL["Tier 1 Sets"])
	--Priest
	AtlasLootMenuItem_3_Name:SetText("|cffffffff" .. AL["Priest"]);
	AtlasLootMenuItem_3_Extra:SetText("");
	AtlasLootMenuItem_3_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\priest");
	AtlasLootMenuItem_3.lootpage = "T1Priest";
	AtlasLootMenuItem_3.container = data.T1PriestC
	AtlasLootMenuItem_3:Show();
	--Mage
	AtlasLootMenuItem_4_Name:SetText("|cff68ccef" .. AL["Mage"]);
	AtlasLootMenuItem_4_Extra:SetText("");
	AtlasLootMenuItem_4_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\mage")
	AtlasLootMenuItem_4.lootpage = "T1Mage";
	AtlasLootMenuItem_4.container = data.T1MageC
	AtlasLootMenuItem_4:Show();
	--Warlock
	AtlasLootMenuItem_5_Name:SetText("|cff9382c9" .. AL["Warlock"]);
	AtlasLootMenuItem_5_Extra:SetText("");
	AtlasLootMenuItem_5_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\warlock")
	AtlasLootMenuItem_5.lootpage = "T1Warlock";
	AtlasLootMenuItem_5.container = data.T1WarlockC
	AtlasLootMenuItem_5:Show();
	--Rogue
	AtlasLootMenuItem_6_Name:SetText("|cfffff468" .. AL["Rogue"]);
	AtlasLootMenuItem_6_Extra:SetText("");
	AtlasLootMenuItem_6_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\rogue");
	AtlasLootMenuItem_6.lootpage = "T1Rogue";
	AtlasLootMenuItem_6.container = data.T1RogueC
	AtlasLootMenuItem_6:Show();
	--Druid
	AtlasLootMenuItem_7_Name:SetText("|cffff7c0a" .. AL["Druid"]);
	AtlasLootMenuItem_7_Extra:SetText("");
	AtlasLootMenuItem_7_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\druid");
	AtlasLootMenuItem_7.lootpage = "T1Druid";
	AtlasLootMenuItem_7.container = data.T1DruidC
	AtlasLootMenuItem_7:Show();
	--Hunter
	AtlasLootMenuItem_18_Name:SetText("|cffaad372" .. AL["Hunter"]);
	AtlasLootMenuItem_18_Extra:SetText("");
	AtlasLootMenuItem_18_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\hunter");
	AtlasLootMenuItem_18.lootpage = "T1Hunter";
	AtlasLootMenuItem_18.container = data.T1HunterC
	AtlasLootMenuItem_18:Show();
	--Shaman
	AtlasLootMenuItem_19_Name:SetText("|cff2773ff" .. AL["Shaman"]);
	AtlasLootMenuItem_19_Extra:SetText("");
	AtlasLootMenuItem_19_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\shaman")
	AtlasLootMenuItem_19.lootpage = "T1Shaman";
	AtlasLootMenuItem_19.container = data.T1ShamanC
	AtlasLootMenuItem_19:Show();
	--Paladin
	AtlasLootMenuItem_20_Name:SetText("|cfff48cba" .. AL["Paladin"]);
	AtlasLootMenuItem_20_Extra:SetText("");
	AtlasLootMenuItem_20_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\paladin");
	AtlasLootMenuItem_20.lootpage = "T1Paladin";
	AtlasLootMenuItem_20.container = data.T1PaladinC
	AtlasLootMenuItem_20:Show();
	--Warrior
	AtlasLootMenuItem_21_Name:SetText("|cffc69b6d" .. AL["Warrior"]);
	AtlasLootMenuItem_21_Extra:SetText("");
	AtlasLootMenuItem_21_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\warrior");
	AtlasLootMenuItem_21.lootpage = "T1Warrior";
	AtlasLootMenuItem_21.container = data.T1WarriorC
	AtlasLootMenuItem_21:Show();
	for i = 1, 30 do
		local button = _G["AtlasLootMenuItem_" .. i]
		button.dataSource = AtlasLoot_GetDataSource(button.lootpage)
		if ( type(button.container) == "table" ) then
			_G["AtlasLootMenuItem_"..i.."_IconBorder"]:SetVertexColor(1, 0.82, 0)
			for row = 1, getn(button.container) do
				for item = 1, getn(button.container[row]) do
					AtlasLoot_CacheItem(button.container[row][item][1])
				end
			end
		end
	end
end

function AtlasLootT2SetMenu()
	AtlasLoot_PrepMenu("SETMENU", AL["Tier 2 Sets"])
	--Priest
	AtlasLootMenuItem_3_Name:SetText("|cffffffff" .. AL["Priest"]);
	AtlasLootMenuItem_3_Extra:SetText("");
	AtlasLootMenuItem_3_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\priest");
	AtlasLootMenuItem_3.lootpage = "T2Priest";
	AtlasLootMenuItem_3.container = data.T2PriestC
	AtlasLootMenuItem_3:Show();
	--Mage
	AtlasLootMenuItem_4_Name:SetText("|cff68ccef" .. AL["Mage"]);
	AtlasLootMenuItem_4_Extra:SetText("");
	AtlasLootMenuItem_4_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\mage")
	AtlasLootMenuItem_4.lootpage = "T2Mage";
	AtlasLootMenuItem_4.container = data.T2MageC
	AtlasLootMenuItem_4:Show();
	--Warlock
	AtlasLootMenuItem_5_Name:SetText("|cff9382c9" .. AL["Warlock"]);
	AtlasLootMenuItem_5_Extra:SetText("");
	AtlasLootMenuItem_5_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\warlock")
	AtlasLootMenuItem_5.lootpage = "T2Warlock";
	AtlasLootMenuItem_5.container = data.T2WarlockC
	AtlasLootMenuItem_5:Show();
	--Rogue
	AtlasLootMenuItem_6_Name:SetText("|cfffff468" .. AL["Rogue"]);
	AtlasLootMenuItem_6_Extra:SetText("");
	AtlasLootMenuItem_6_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\rogue");
	AtlasLootMenuItem_6.lootpage = "T2Rogue";
	AtlasLootMenuItem_6.container = data.T2RogueC
	AtlasLootMenuItem_6:Show();
	--Druid
	AtlasLootMenuItem_7_Name:SetText("|cffff7c0a" .. AL["Druid"]);
	AtlasLootMenuItem_7_Extra:SetText("");
	AtlasLootMenuItem_7_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\druid");
	AtlasLootMenuItem_7.lootpage = "T2Druid";
	AtlasLootMenuItem_7.container = data.T2DruidC
	AtlasLootMenuItem_7:Show();
	--Hunter
	AtlasLootMenuItem_18_Name:SetText("|cffaad372" .. AL["Hunter"]);
	AtlasLootMenuItem_18_Extra:SetText("");
	AtlasLootMenuItem_18_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\hunter");
	AtlasLootMenuItem_18.lootpage = "T2Hunter";
	AtlasLootMenuItem_18.container = data.T2HunterC
	AtlasLootMenuItem_18:Show();
	--Shaman
	AtlasLootMenuItem_19_Name:SetText("|cff2773ff" .. AL["Shaman"]);
	AtlasLootMenuItem_19_Extra:SetText("");
	AtlasLootMenuItem_19_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\shaman")
	AtlasLootMenuItem_19.lootpage = "T2Shaman";
	AtlasLootMenuItem_19.container = data.T2ShamanC
	AtlasLootMenuItem_19:Show();
	--Paladin
	AtlasLootMenuItem_20_Name:SetText("|cfff48cba" .. AL["Paladin"]);
	AtlasLootMenuItem_20_Extra:SetText("");
	AtlasLootMenuItem_20_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\paladin");
	AtlasLootMenuItem_20.lootpage = "T2Paladin";
	AtlasLootMenuItem_20.container = data.T2PaladinC
	AtlasLootMenuItem_20:Show();
	--Warrior
	AtlasLootMenuItem_21_Name:SetText("|cffc69b6d" .. AL["Warrior"]);
	AtlasLootMenuItem_21_Extra:SetText("");
	AtlasLootMenuItem_21_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\warrior");
	AtlasLootMenuItem_21.lootpage = "T2Warrior";
	AtlasLootMenuItem_21.container = data.T2WarriorC
	AtlasLootMenuItem_21:Show();
	for i = 1, 30 do
		local button = _G["AtlasLootMenuItem_" .. i]
		button.dataSource = AtlasLoot_GetDataSource(button.lootpage)
		if ( type(button.container) == "table" ) then
			_G["AtlasLootMenuItem_"..i.."_IconBorder"]:SetVertexColor(1, 0.82, 0)
			for row = 1, getn(button.container) do
				for item = 1, getn(button.container[row]) do
					AtlasLoot_CacheItem(button.container[row][item][1])
				end
			end
		end
	end
end

function AtlasLootT3SetMenu()
	AtlasLoot_PrepMenu("SETMENU", AL["Tier 3 Sets"])
	--Priest
	AtlasLootMenuItem_3_Name:SetText("|cffffffff" .. AL["Priest"]);
	AtlasLootMenuItem_3_Extra:SetText("");
	AtlasLootMenuItem_3_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\priest");
	AtlasLootMenuItem_3.lootpage = "T3Priest";
	AtlasLootMenuItem_3.container = data.T3PriestC
	AtlasLootMenuItem_3:Show();
	--Mage
	AtlasLootMenuItem_4_Name:SetText("|cff68ccef" .. AL["Mage"]);
	AtlasLootMenuItem_4_Extra:SetText("");
	AtlasLootMenuItem_4_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\mage")
	AtlasLootMenuItem_4.lootpage = "T3Mage";
	AtlasLootMenuItem_4.container = data.T3MageC
	AtlasLootMenuItem_4:Show();
	--Warlock
	AtlasLootMenuItem_5_Name:SetText("|cff9382c9" .. AL["Warlock"]);
	AtlasLootMenuItem_5_Extra:SetText("");
	AtlasLootMenuItem_5_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\warlock")
	AtlasLootMenuItem_5.lootpage = "T3Warlock";
	AtlasLootMenuItem_5.container = data.T3WarlockC
	AtlasLootMenuItem_5:Show();
	--Rogue
	AtlasLootMenuItem_6_Name:SetText("|cfffff468" .. AL["Rogue"]);
	AtlasLootMenuItem_6_Extra:SetText("");
	AtlasLootMenuItem_6_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\rogue");
	AtlasLootMenuItem_6.lootpage = "T3Rogue";
	AtlasLootMenuItem_6.container = data.T3RogueC
	AtlasLootMenuItem_6:Show();
	--Druid
	AtlasLootMenuItem_7_Name:SetText("|cffff7c0a" .. AL["Druid"]);
	AtlasLootMenuItem_7_Extra:SetText("");
	AtlasLootMenuItem_7_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\druid");
	AtlasLootMenuItem_7.lootpage = "T3Druid";
	AtlasLootMenuItem_7.container = data.T3DruidC
	AtlasLootMenuItem_7:Show();
	--Hunter
	AtlasLootMenuItem_18_Name:SetText("|cffaad372" .. AL["Hunter"]);
	AtlasLootMenuItem_18_Extra:SetText("");
	AtlasLootMenuItem_18_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\hunter");
	AtlasLootMenuItem_18.lootpage = "T3Hunter";
	AtlasLootMenuItem_18.container = data.T3HunterC
	AtlasLootMenuItem_18:Show();
	--Shaman
	AtlasLootMenuItem_19_Name:SetText("|cff2773ff" .. AL["Shaman"]);
	AtlasLootMenuItem_19_Extra:SetText("");
	AtlasLootMenuItem_19_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\shaman")
	AtlasLootMenuItem_19.lootpage = "T3Shaman";
	AtlasLootMenuItem_19.container = data.T3ShamanC
	AtlasLootMenuItem_19:Show();
	--Paladin
	AtlasLootMenuItem_20_Name:SetText("|cfff48cba" .. AL["Paladin"]);
	AtlasLootMenuItem_20_Extra:SetText("");
	AtlasLootMenuItem_20_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\paladin");
	AtlasLootMenuItem_20.lootpage = "T3Paladin";
	AtlasLootMenuItem_20.container = data.T3PaladinC
	AtlasLootMenuItem_20:Show();
	--Warrior
	AtlasLootMenuItem_21_Name:SetText("|cffc69b6d" .. AL["Warrior"]);
	AtlasLootMenuItem_21_Extra:SetText("");
	AtlasLootMenuItem_21_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\warrior");
	AtlasLootMenuItem_21.lootpage = "T3Warrior";
	AtlasLootMenuItem_21.container = data.T3WarriorC
	AtlasLootMenuItem_21:Show();
	for i = 1, 30 do
		local button = _G["AtlasLootMenuItem_" .. i]
		button.dataSource = AtlasLoot_GetDataSource(button.lootpage)
		if ( type(button.container) == "table" ) then
			_G["AtlasLootMenuItem_"..i.."_IconBorder"]:SetVertexColor(1, 0.82, 0)
			for row = 1, getn(button.container) do
				for item = 1, getn(button.container[row]) do
					AtlasLoot_CacheItem(button.container[row][item][1])
				end
			end
		end
	end
end

function AtlasLoot_Kara40SetMenu()
	AtlasLoot_PrepMenu("SETMENU", AL["Karazhan"] .. " " .. AL["Sets"])
	--Priest
	AtlasLootMenuItem_3_Name:SetText("|cffffffff" .. AL["Priest"]);
	AtlasLootMenuItem_3_Extra:SetText("");
	AtlasLootMenuItem_3_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\priest");
	AtlasLootMenuItem_3.lootpage = "T35Priest";
	AtlasLootMenuItem_3.container = data.T35PriestC
	AtlasLootMenuItem_3:Show();
	--Mage
	AtlasLootMenuItem_4_Name:SetText("|cff68ccef" .. AL["Mage"]);
	AtlasLootMenuItem_4_Extra:SetText("");
	AtlasLootMenuItem_4_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\mage")
	AtlasLootMenuItem_4.lootpage = "T35Mage";
	AtlasLootMenuItem_4.container = data.T35MageC
	AtlasLootMenuItem_4:Show();
	--Warlock
	AtlasLootMenuItem_5_Name:SetText("|cff9382c9" .. AL["Warlock"]);
	AtlasLootMenuItem_5_Extra:SetText("");
	AtlasLootMenuItem_5_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\warlock")
	AtlasLootMenuItem_5.lootpage = "T35Warlock";
	AtlasLootMenuItem_5.container = data.T35WarlockC
	AtlasLootMenuItem_5:Show();
	--Rogue
	AtlasLootMenuItem_6_Name:SetText("|cfffff468" .. AL["Rogue"]);
	AtlasLootMenuItem_6_Extra:SetText("");
	AtlasLootMenuItem_6_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\rogue");
	AtlasLootMenuItem_6.lootpage = "T35Rogue";
	AtlasLootMenuItem_6.container = data.T35RogueC
	AtlasLootMenuItem_6:Show();
	--Druid
	AtlasLootMenuItem_7_Name:SetText("|cffff7c0a" .. AL["Druid"]);
	AtlasLootMenuItem_7_Extra:SetText("");
	AtlasLootMenuItem_7_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\druid");
	AtlasLootMenuItem_7.lootpage = "T35Druid";
	AtlasLootMenuItem_7.container = data.T35DruidC
	AtlasLootMenuItem_7:Show();
	--Hunter
	AtlasLootMenuItem_18_Name:SetText("|cffaad372" .. AL["Hunter"]);
	AtlasLootMenuItem_18_Extra:SetText("");
	AtlasLootMenuItem_18_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\hunter");
	AtlasLootMenuItem_18.lootpage = "T35Hunter";
	AtlasLootMenuItem_18.container = data.T35HunterC
	AtlasLootMenuItem_18:Show();
	--Shaman
	AtlasLootMenuItem_19_Name:SetText("|cff2773ff" .. AL["Shaman"]);
	AtlasLootMenuItem_19_Extra:SetText("");
	AtlasLootMenuItem_19_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\shaman")
	AtlasLootMenuItem_19.lootpage = "T35Shaman";
	AtlasLootMenuItem_19.container = data.T35ShamanC
	AtlasLootMenuItem_19:Show();
	--Paladin
	AtlasLootMenuItem_20_Name:SetText("|cfff48cba" .. AL["Paladin"]);
	AtlasLootMenuItem_20_Extra:SetText("");
	AtlasLootMenuItem_20_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\paladin");
	AtlasLootMenuItem_20.lootpage = "T35Paladin";
	AtlasLootMenuItem_20.container = data.T35PaladinC
	AtlasLootMenuItem_20:Show();
	--Warrior
	AtlasLootMenuItem_21_Name:SetText("|cffc69b6d" .. AL["Warrior"]);
	AtlasLootMenuItem_21_Extra:SetText("");
	AtlasLootMenuItem_21_Icon:SetTexture("Interface\\AddOns\\AtlasLoot\\Images\\warrior");
	AtlasLootMenuItem_21.lootpage = "T35Warrior";
	AtlasLootMenuItem_21.container = data.T35WarriorC
	AtlasLootMenuItem_21:Show();
	for i = 1, 30 do
		local button = _G["AtlasLootMenuItem_" .. i]
		button.dataSource = AtlasLoot_GetDataSource(button.lootpage)
		if ( type(button.container) == "table" ) then
			_G["AtlasLootMenuItem_"..i.."_IconBorder"]:SetVertexColor(1, 0.82, 0)
			for row = 1, getn(button.container) do
				for item = 1, getn(button.container[row]) do
					AtlasLoot_CacheItem(button.container[row][item][1])
				end
			end
		end
	end
end
