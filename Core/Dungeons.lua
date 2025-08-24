local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

function AtlasLoot_DungeonsMenu1()
	AtlasLoot_PrepMenu(nil, AL["Dungeons & Raids"])
	AtlasLootCharDB.LastBoss = "DUNGEONSMENU1"
	AtlasLootCharDB.LastBossText = AL["Dungeons & Raids"]
	AtlasLootItemsFrame_NEXT:Show()
    --RFC
    AtlasLootMenuItem_1_Name:SetText(AL["[13-18] Ragefire Chasm"]);
	AtlasLootMenuItem_1_Extra:SetText(AL["Orgrimmar"]);
	AtlasLootMenuItem_1_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_1.lootpage="RFCTaragaman";
	AtlasLootMenuItem_1:Show();
    --WC
    AtlasLootMenuItem_2_Name:SetText(AL["[17-24] Wailing Caverns"]);
	AtlasLootMenuItem_2_Extra:SetText(AL["Barrens"]);
	AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_2.lootpage="WCLordCobrahn";
	AtlasLootMenuItem_2:Show();
	--DM
	AtlasLootMenuItem_3_Name:SetText(AL["[17-24] The Deadmines"]);
	AtlasLootMenuItem_3_Extra:SetText(AL["Westfall"]);
	AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_3.lootpage="DMRhahkZor";
	AtlasLootMenuItem_3:Show();
	--SFK
	AtlasLootMenuItem_4_Name:SetText(AL["[22-30] Shadowfang Keep"]);
	AtlasLootMenuItem_4_Extra:SetText(AL["Silverpine Forest"]);
	AtlasLootMenuItem_4_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_4.lootpage="SFKRethilgore";
	AtlasLootMenuItem_4:Show();
	--BFD
	AtlasLootMenuItem_5_Name:SetText(AL["[23-32] Blackfathom Deeps"]);
	AtlasLootMenuItem_5_Extra:SetText(AL["Ashenvale"]);
	AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_5.lootpage="BFDGhamoora";
	AtlasLootMenuItem_5:Show();
	--Stockades
	AtlasLootMenuItem_6_Name:SetText(AL["[22-30] The Stockade"]);
	AtlasLootMenuItem_6_Extra:SetText(AL["Stormwind"]);
	AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_6.lootpage="SWStTargorr";
	AtlasLootMenuItem_6:Show();
	-- Dragonmaw Retreat
	AtlasLootMenuItem_7_Name:SetText(AL["[26-35] Dragonmaw Retreat"]);
	AtlasLootMenuItem_7_Extra:SetText(AL["Wetlands"]);
	AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_7.lootpage="DMRGowlfang";
	AtlasLootMenuItem_7:Show();
	--Gnomer
	AtlasLootMenuItem_8_Name:SetText(AL["[29-38] Gnomeregan"]);
	AtlasLootMenuItem_8_Extra:SetText(AL["Dun Morogh"]);
	AtlasLootMenuItem_8_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_8.lootpage="GnGrubbis";
	AtlasLootMenuItem_8:Show();
	--RFK
	AtlasLootMenuItem_9_Name:SetText(AL["[29-38] Razorfen Kraul"]);
	AtlasLootMenuItem_9_Extra:SetText(AL["Barrens"]);
	AtlasLootMenuItem_9_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_9.lootpage="RFKAggem";
	AtlasLootMenuItem_9:Show();
	--Crescent Grove
	AtlasLootMenuItem_10_Name:SetText(AL["[32-38] The Crescent Grove"]);
	AtlasLootMenuItem_10_Extra:SetText(AL["Ashenvale"]);
	AtlasLootMenuItem_10_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_10.lootpage="TCGGrovetenderEngryss";
	AtlasLootMenuItem_10:Show();
	--SM GY
	AtlasLootMenuItem_11_Name:SetText(AL["[27-36] Scarlet Monastery (Graveyard)"]);
	AtlasLootMenuItem_11_Extra:SetText(AL["Tirisfal Glades"]);
	AtlasLootMenuItem_11_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_11.lootpage="SMVishas";
	AtlasLootMenuItem_11:Show();
	--SM Library
	AtlasLootMenuItem_12_Name:SetText(AL["[28-39] Scarlet Monastery (Library)"]);
	AtlasLootMenuItem_12_Extra:SetText(AL["Tirisfal Glades"]);
	AtlasLootMenuItem_12_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_12.lootpage="SMHoundmasterLoksey";
	AtlasLootMenuItem_12:Show();
	--SM Armory
	AtlasLootMenuItem_13_Name:SetText(AL["[32-41] Scarlet Monastery (Armory)"]);
	AtlasLootMenuItem_13_Extra:SetText(AL["Tirisfal Glades"]);
	AtlasLootMenuItem_13_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_13.lootpage="SMHerod";
	AtlasLootMenuItem_13:Show();
	--SM Cathedral
	AtlasLootMenuItem_14_Name:SetText(AL["[35-45] Scarlet Monastery (Cathedral)"]);
	AtlasLootMenuItem_14_Extra:SetText(AL["Tirisfal Glades"]);
	AtlasLootMenuItem_14_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_14.lootpage="SMFairbanks";
	AtlasLootMenuItem_14:Show();
	-- Stormwrought Ruins
	AtlasLootMenuItem_15_Name:SetText(AL["[32-44] Stormwrought Ruins"]);
	AtlasLootMenuItem_15_Extra:SetText(AL["Balor"]);
	AtlasLootMenuItem_15_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_15.lootpage="SWROronok";
	AtlasLootMenuItem_15:Show();
	--RFD
	AtlasLootMenuItem_16_Name:SetText(AL["[36-46] Razorfen Downs"]);
	AtlasLootMenuItem_16_Extra:SetText(AL["Barrens"]);
	AtlasLootMenuItem_16_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_16.lootpage="RFDTutenkash";
	AtlasLootMenuItem_16:Show();
	--Uldaman
	AtlasLootMenuItem_17_Name:SetText(AL["[40-51] Uldaman"]);
	AtlasLootMenuItem_17_Extra:SetText(AL["Badlands"]);
	AtlasLootMenuItem_17_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_17.lootpage="UldBaelog";
	AtlasLootMenuItem_17:Show();
	--Gilneas
	AtlasLootMenuItem_18_Name:SetText(AL["[42-50] Gilneas City"]);
	AtlasLootMenuItem_18_Extra:SetText(AL["Gilneas"]);
	AtlasLootMenuItem_18_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_18.lootpage="GCMatthiasHoltz";
	AtlasLootMenuItem_18:Show();
	--Mara
	AtlasLootMenuItem_19_Name:SetText(AL["[45-55] Maraudon"]);
	AtlasLootMenuItem_19_Extra:SetText(AL["Desolace"]);
	AtlasLootMenuItem_19_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_19.lootpage="MaraNoxxion";
	AtlasLootMenuItem_19:Show();
	--ZF
	AtlasLootMenuItem_20_Name:SetText(AL["[44-54] Zul'Farrak"]);
	AtlasLootMenuItem_20_Extra:SetText(AL["Tanaris"]);
	AtlasLootMenuItem_20_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_20.lootpage="ZFAntusul";
	AtlasLootMenuItem_20:Show();
	--ST
	AtlasLootMenuItem_21_Name:SetText(AL["[50-60] The Sunken Temple"]);
	AtlasLootMenuItem_21_Extra:SetText(AL["Swamp of Sorrows"]);
	AtlasLootMenuItem_21_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_21.lootpage="STBalconyMinibosses";
	AtlasLootMenuItem_21:Show();
	--HFQ
	AtlasLootMenuItem_22_Name:SetText(AL["[50-60] Hateforge Quarry"]);
	AtlasLootMenuItem_22_Extra:SetText(AL["Burning Steppes"]);
	AtlasLootMenuItem_22_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_22.lootpage="HQHighForemanBargulBlackhammer";
	AtlasLootMenuItem_22:Show();
	--BRD
	AtlasLootMenuItem_23_Name:SetText(AL["[52-60] Blackrock Depths"]);
	AtlasLootMenuItem_23_Extra:SetText(AL["Burning Steppes"]);
	AtlasLootMenuItem_23_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_23.lootpage="BRDLordRoccor";
	AtlasLootMenuItem_23:Show();
	--DME
	AtlasLootMenuItem_24_Name:SetText(AL["[55-60] Dire Maul (East)"]);
	AtlasLootMenuItem_24_Extra:SetText(AL["Feralas"]);
	AtlasLootMenuItem_24_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_24.lootpage="DMEPusillin";
	AtlasLootMenuItem_24:Show();
	--DMW
	AtlasLootMenuItem_25_Name:SetText(AL["[57-60] Dire Maul (West)"]);
	AtlasLootMenuItem_25_Extra:SetText(AL["Feralas"]);
	AtlasLootMenuItem_25_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_25.lootpage="DMWTendrisWarpwood";
	AtlasLootMenuItem_25:Show();
	--DMN
	AtlasLootMenuItem_26_Name:SetText(AL["[57-60] Dire Maul (North)"]);
	AtlasLootMenuItem_26_Extra:SetText(AL["Feralas"]);
	AtlasLootMenuItem_26_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_26.lootpage="DMNGuardMoldar";
	AtlasLootMenuItem_26:Show();
	--Scholo
	AtlasLootMenuItem_27_Name:SetText(AL["[58-60] Scholomance"]);
	AtlasLootMenuItem_27_Extra:SetText(AL["Western Plaguelands"]);
	AtlasLootMenuItem_27_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_27.lootpage="SCHOLOKirtonostheHerald";
	AtlasLootMenuItem_27:Show();
	--Strat
	AtlasLootMenuItem_28_Name:SetText(AL["[58-60] Stratholme"]);
	AtlasLootMenuItem_28_Extra:SetText(AL["Eastern Plaguelands"]);
	AtlasLootMenuItem_28_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_28.lootpage="STRATSkull";
	AtlasLootMenuItem_28:Show();
	--LBRS
	AtlasLootMenuItem_29_Name:SetText(AL["[55-60] Lower Blackrock Spire"]);
	AtlasLootMenuItem_29_Extra:SetText(AL["Burning Steppes"]);
	AtlasLootMenuItem_29_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_29.lootpage="LBRSSpirestoneButcher";
	AtlasLootMenuItem_29:Show();
	--UBRS
	AtlasLootMenuItem_30_Name:SetText(AL["[58-60] Upper Blackrock Spire"]);
	AtlasLootMenuItem_30_Extra:SetText(AL["Burning Steppes"]);
	AtlasLootMenuItem_30_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_30.lootpage="UBRSEmberseer";
	AtlasLootMenuItem_30:Show();
end

function AtlasLoot_DungeonsMenu2()
	AtlasLoot_PrepMenu(nil, AL["Dungeons & Raids"])
	AtlasLootCharDB.LastBoss = "DUNGEONSMENU2"
	AtlasLootCharDB.LastBossText = AL["Dungeons & Raids"]
	AtlasLootItemsFrame_PREV:Show()
	--Kara crypt
	AtlasLootMenuItem_1_Name:SetText(AL["[58-60] Karazhan Crypt"]);
	AtlasLootMenuItem_1_Extra:SetText(AL["Deadwind Pass"]);
	AtlasLootMenuItem_1_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_1.lootpage="KCMarrowspike";
	AtlasLootMenuItem_1:Show()
	--CoT:BM
	AtlasLootMenuItem_2_Name:SetText(AL["[60] Caverns of Time: Black Morass"]);
	AtlasLootMenuItem_2_Extra:SetText(AL["Tanaris"]);
	AtlasLootMenuItem_2_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_2.lootpage="COTBMChronar";
	AtlasLootMenuItem_2:Show()
	--SWV
    AtlasLootMenuItem_3_Name:SetText(AL["[60] Stormwind Vault"]);
	AtlasLootMenuItem_3_Extra:SetText(AL["Stormwind"]);
	AtlasLootMenuItem_3_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalIronForge");
	AtlasLootMenuItem_3.lootpage="SWVAszoshGrimflame";
	AtlasLootMenuItem_3:Show();
	--ZG
    AtlasLootMenuItem_5_Name:SetText(AL["[RAID] Zul'Gurub"]);
	AtlasLootMenuItem_5_Extra:SetText(AL["Stranglethorn Vale"]);
	AtlasLootMenuItem_5_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalOrgrimmar");
	AtlasLootMenuItem_5.lootpage="ZGJeklik";
	AtlasLootMenuItem_5:Show();
	--AQ20
	AtlasLootMenuItem_6_Name:SetText(AL["[RAID] Ruins of Ahn'Qiraj"]);
	AtlasLootMenuItem_6_Extra:SetText(AL["Silithus"]);
	AtlasLootMenuItem_6_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalOrgrimmar");
	AtlasLootMenuItem_6.lootpage="AQ20Kurinnaxx";
	AtlasLootMenuItem_6:Show();
	--MC
	AtlasLootMenuItem_7_Name:SetText(AL["[RAID] Molten Core"]);
	AtlasLootMenuItem_7_Extra:SetText(AL["Burning Steppes"]);
	AtlasLootMenuItem_7_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalOrgrimmar");
	AtlasLootMenuItem_7.lootpage="MCIncindis";
	AtlasLootMenuItem_7:Show();
	--Ony
	AtlasLootMenuItem_8_Name:SetText(AL["[RAID] Onyxia's Lair"]);
	AtlasLootMenuItem_8_Extra:SetText(AL["Dustwallow Marsh"]);
	AtlasLootMenuItem_8_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalOrgrimmar");
	AtlasLootMenuItem_8.lootpage="Onyxia";
	AtlasLootMenuItem_8:Show();
	--LKH
	AtlasLootMenuItem_9_Name:SetText(AL["[RAID] Lower Karazhan Halls"]);
	AtlasLootMenuItem_9_Extra:SetText(AL["Deadwind Pass"]);
	AtlasLootMenuItem_9_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalOrgrimmar");
	AtlasLootMenuItem_9.lootpage="LKHRolfen";
	AtlasLootMenuItem_9:Show();
	--BWL
	AtlasLootMenuItem_10_Name:SetText(AL["[RAID] Blackwing Lair"]);
	AtlasLootMenuItem_10_Extra:SetText(AL["Burning Steppes"]);
	AtlasLootMenuItem_10_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalOrgrimmar");
	AtlasLootMenuItem_10.lootpage="BWLRazorgore";
	AtlasLootMenuItem_10:Show();
	--ES
	AtlasLootMenuItem_11_Name:SetText(AL["[RAID] Emerald Sanctum"]);
	AtlasLootMenuItem_11_Extra:SetText(AL["Hyjal"]);
	AtlasLootMenuItem_11_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalOrgrimmar");
	AtlasLootMenuItem_11.lootpage="ESErennius";
	AtlasLootMenuItem_11:Show();
	--AQ40
	AtlasLootMenuItem_12_Name:SetText(AL["[RAID] Temple of Ahn'Qiraj"]);
	AtlasLootMenuItem_12_Extra:SetText(AL["Silithus"]);
	AtlasLootMenuItem_12_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalOrgrimmar");
	AtlasLootMenuItem_12.lootpage="AQ40Skeram";
	AtlasLootMenuItem_12:Show();
	--Naxx
	AtlasLootMenuItem_13_Name:SetText(AL["[RAID] Naxxramas"]);
	AtlasLootMenuItem_13_Extra:SetText(AL["Eastern Plaguelands"]);
	AtlasLootMenuItem_13_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalOrgrimmar");
	AtlasLootMenuItem_13.lootpage="NAXPatchwerk";
	AtlasLootMenuItem_13:Show();
    --UKH
	AtlasLootMenuItem_14_Name:SetText(AL["[RAID] Upper Karazhan Halls"]);
	AtlasLootMenuItem_14_Extra:SetText(AL["Deadwind Pass"]);
	AtlasLootMenuItem_14_Icon:SetTexture("Interface\\Icons\\Spell_Arcane_PortalOrgrimmar");
	AtlasLootMenuItem_14.lootpage="UKHGnarlmoon";
	AtlasLootMenuItem_14:Show();
end