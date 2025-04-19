local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot")
local BB = AceLibrary("Babble-Boss-2.2a")
local BZ = AceLibrary("Babble-Zone-2.2a")

local WHITE = "|cffFFFFFF";

function AtlasLoot_WorldBossMenu()
	AtlasLoot_PrepMenu(nil, AL["World Bosses"])
	AtlasLootCharDB.LastBoss = "WORLDBOSSMENU"
	AtlasLootCharDB.LastBossText = AL["World Bosses"]
	--Azuregos
	AtlasLootMenuItem_1_Name:SetText(BB["Azuregos"]);
	AtlasLootMenuItem_1_Extra:SetText(WHITE..BZ["Azshara"]);
	AtlasLootMenuItem_1_Icon:SetTexture("Interface\\Icons\\INV_Misc_Head_Dragon_Blue");
	AtlasLootMenuItem_1.lootpage="AAzuregos";
	AtlasLootMenuItem_1:Show();
	--Emeriss
	AtlasLootMenuItem_2_Name:SetText(BB["Emeriss"]);
	AtlasLootMenuItem_2_Extra:SetText(WHITE..AL["Various Locations"]);
	AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\INV_Misc_Head_Dragon_Green");
	AtlasLootMenuItem_2.lootpage="DEmeriss";
	AtlasLootMenuItem_2:Show();
	--Lethon
	AtlasLootMenuItem_3_Name:SetText(BB["Lethon"]);
	AtlasLootMenuItem_3_Extra:SetText(WHITE..AL["Various Locations"]);
	AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\INV_Misc_Head_Dragon_Green");
	AtlasLootMenuItem_3.lootpage="DLethon";
	AtlasLootMenuItem_3:Show();
	--Taerar
	AtlasLootMenuItem_4_Name:SetText(BB["Taerar"]);
	AtlasLootMenuItem_4_Extra:SetText(WHITE..AL["Various Locations"]);
	AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\INV_Misc_Head_Dragon_Green");
	AtlasLootMenuItem_4.lootpage="DTaerar";
	AtlasLootMenuItem_4:Show();
	--Ysondre
	AtlasLootMenuItem_5_Name:SetText(BB["Ysondre"]);
	AtlasLootMenuItem_5_Extra:SetText(WHITE..AL["Various Locations"]);
	AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\INV_Misc_Head_Dragon_Green");
	AtlasLootMenuItem_5.lootpage="DYsondre";
	AtlasLootMenuItem_5:Show();
	--Lord Kazzak
	AtlasLootMenuItem_7_Name:SetText(BB["Lord Kazzak"]);
	AtlasLootMenuItem_7_Extra:SetText(WHITE..BZ["Blasted Lands"]);
	AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\warlock_summon_doomguard");
	AtlasLootMenuItem_7.lootpage="KKazzak";
	AtlasLootMenuItem_7:Show();
	--Nerubian Overseer
	AtlasLootMenuItem_8_Name:SetText(BB["Nerubian Overseer"]);
	AtlasLootMenuItem_8_Extra:SetText(WHITE..BZ["Eastern Plaguelands"]);
	AtlasLootMenuItem_8_Icon:SetTexture("Interface\\Icons\\Spell_Nature_Web");
	AtlasLootMenuItem_8.lootpage="Nerubian";
	AtlasLootMenuItem_8:Show();
	--Dark Reaver
	AtlasLootMenuItem_9_Name:SetText(BB["Dark Reaver of Karazhan"]);
	AtlasLootMenuItem_9_Extra:SetText(WHITE..BZ["Deadwind Pass"]);
	AtlasLootMenuItem_9_Icon:SetTexture("Interface\\Icons\\Ability_Mount_Dreadsteed");
	AtlasLootMenuItem_9.lootpage="Reaver";
	AtlasLootMenuItem_9:Show();
	--Ostarius
	AtlasLootMenuItem_10_Name:SetText(BB["Ostarius"]);
	AtlasLootMenuItem_10_Extra:SetText(WHITE..BZ["Tanaris"]);
	AtlasLootMenuItem_10_Icon:SetTexture("Interface\\Icons\\INV_Misc_Platnumdisks");
	AtlasLootMenuItem_10.lootpage="Ostarius";
	AtlasLootMenuItem_10:Show();
	--Concavius
	AtlasLootMenuItem_11_Name:SetText(BB["Concavius"]);
	AtlasLootMenuItem_11_Extra:SetText(WHITE..BZ["Desolace"]);
	AtlasLootMenuItem_11_Icon:SetTexture("Interface\\Icons\\Spell_Shadow_SummonVoidWalker");
	AtlasLootMenuItem_11.lootpage="Concavius";
	AtlasLootMenuItem_11:Show();
	--Cow level
	AtlasLootMenuItem_13_Name:SetText(BB["Moo"]);
	AtlasLootMenuItem_13_Extra:SetText(WHITE..BZ["Moomoo Grove"]);
	AtlasLootMenuItem_13_Icon:SetTexture("Interface\\Icons\\Spell_Nature_Polymorph_Cow");
	AtlasLootMenuItem_13.lootpage="CowKing";
	AtlasLootMenuItem_13:Show();
	--Cla'ckora
	AtlasLootMenuItem_14_Name:SetText(BB["Cla'ckora"]);
	AtlasLootMenuItem_14_Extra:SetText(WHITE..BZ["Azshara"]);
	AtlasLootMenuItem_14_Icon:SetTexture("Interface\\Icons\\INV_Misc_Birdbeck_02");
	AtlasLootMenuItem_14.lootpage="Clackora";
	AtlasLootMenuItem_14:Show();
end