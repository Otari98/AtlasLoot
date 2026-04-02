local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");
local _G = getfenv(0)
local buttonsPerPage = 30
local ButtonsInfo1
local ButtonsInfo2
local WHITE = "|cffFFFFFF"
local RED = "|cffff0000"

function AtlasLoot_DungeonsMenu1()
	if not ButtonsInfo1 then
		ButtonsInfo1 = {
			{ name = WHITE.."[13-18]|r "..AL["Ragefire Chasm"], extra = AL["Orgrimmar"], lootpage = "RFCTaragaman", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[13-20]|r "..AL["Frostmane Hollow"], extra = AL["Dun Morogh"], lootpage = "FMHTansha", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[17-24]|r "..AL["Wailing Caverns"], extra = AL["Barrens"], lootpage = "WCLordCobrahn", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[17-24]|r "..AL["The Deadmines"], extra = AL["Westfall"], lootpage = "DMRhahkZor", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[22-30]|r "..AL["Shadowfang Keep"], extra = AL["Silverpine Forest"], lootpage = "SFKRethilgore", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[22-30]|r "..AL["The Stockade"], extra = AL["Stormwind"], lootpage = "SWStTargorr", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[23-32]|r "..AL["Blackfathom Deeps"], extra = AL["Ashenvale"], lootpage = "BFDGhamoora", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[25-33]|r "..AL["Windhorn Canyon"], extra = AL["Thousand Needles"], lootpage = "WHCPathun", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[26-35]|r "..AL["Dragonmaw Retreat"], extra = AL["Wetlands"], lootpage = "DMRGowlfang", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[29-38]|r "..AL["Gnomeregan"], extra = AL["Dun Morogh"], lootpage = "GnGrubbis", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[29-38]|r "..AL["Razorfen Kraul"], extra = AL["Barrens"], lootpage = "RFKAggem", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[32-38]|r "..AL["The Crescent Grove"], extra = AL["Ashenvale"], lootpage = "TCGGrovetenderEngryss", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[27-36]|r "..AL["Scarlet Monastery (Graveyard)"], extra = AL["Tirisfal Glades"], lootpage = "SMVishas", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[28-39]|r "..AL["Scarlet Monastery (Library)"], extra = AL["Tirisfal Glades"], lootpage = "SMHoundmasterLoksey", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[32-41]|r "..AL["Scarlet Monastery (Armory)"], extra = AL["Tirisfal Glades"], lootpage = "SMHerod", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[35-45]|r "..AL["Scarlet Monastery (Cathedral)"], extra = AL["Tirisfal Glades"], lootpage = "SMFairbanks", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[32-44]|r "..AL["Stormwrought Ruins"], extra = AL["Balor"], lootpage = "SWROronok", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[36-46]|r "..AL["Razorfen Downs"], extra = AL["Barrens"], lootpage = "RFDTutenkash", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[40-51]|r "..AL["Uldaman"], extra = AL["Badlands"], lootpage = "UldBaelog", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[42-50]|r "..AL["Gilneas City"], extra = AL["Gilneas"], lootpage = "GCMatthiasHoltz", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[45-55]|r "..AL["Maraudon"], extra = AL["Desolace"], lootpage = "MaraNoxxion", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[44-54]|r "..AL["Zul'Farrak"], extra = AL["Tanaris"], lootpage = "ZFAntusul", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[50-60]|r "..AL["The Sunken Temple"], extra = AL["Swamp of Sorrows"], lootpage = "STBalconyMinibosses", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[50-60]|r "..AL["Hateforge Quarry"], extra = AL["Burning Steppes"], lootpage = "HQHighForemanBargulBlackhammer", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[52-60]|r "..AL["Blackrock Depths"], extra = AL["Burning Steppes"], lootpage = "BRDLordRoccor", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[55-60]|r "..AL["Dire Maul (East)"], extra = AL["Feralas"], lootpage = "DMEPusillin", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[57-60]|r "..AL["Dire Maul (West)"], extra = AL["Feralas"], lootpage = "DMWTendrisWarpwood", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[57-60]|r "..AL["Dire Maul (North)"], extra = AL["Feralas"], lootpage = "DMNGuardMoldar", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[58-60]|r "..AL["Scholomance"], extra = AL["Western Plaguelands"], lootpage = "SCHOLOKirtonostheHerald", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[58-60]|r "..AL["Stratholme"], extra = AL["Eastern Plaguelands"], lootpage = "STRATSkull", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
		}
	end
	AtlasLoot_PrepMenu(nil, AL["Dungeons & Raids"])
	AtlasLootCharDB.LastBoss = "DUNGEONSMENU1"
	AtlasLootCharDB.LastBossText = AL["Dungeons & Raids"]
	AtlasLootItemsFrame_NEXT:Show()
	for i = 1, min(buttonsPerPage, getn(ButtonsInfo1)) do
		if ButtonsInfo1[i].name then
			_G["AtlasLootMenuItem_"..i.."_Name"]:SetText(ButtonsInfo1[i].name)
			_G["AtlasLootMenuItem_"..i.."_Extra"]:SetText(ButtonsInfo1[i].extra)
			_G["AtlasLootMenuItem_"..i.."_Icon"]:SetTexture(ButtonsInfo1[i].icon)
			_G["AtlasLootMenuItem_"..i].lootpage = ButtonsInfo1[i].lootpage
			_G["AtlasLootMenuItem_"..i]:Show()
		end
	end
end

function AtlasLoot_DungeonsMenu2()
	if not ButtonsInfo2 then
		ButtonsInfo2 = {
			{ name = WHITE.."[55-60]|r "..AL["Lower Blackrock Spire"], extra = AL["Burning Steppes"], lootpage = "LBRSSpirestoneButcher", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[58-60]|r "..AL["Upper Blackrock Spire"], extra = AL["Burning Steppes"], lootpage = "UBRSEmberseer", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[60]|r "..AL["Caverns of Time: Black Morass"], extra = AL["Tanaris"], lootpage = "COTBMChronar", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[60]|r "..AL["Stormwind Vault"], extra = AL["Stormwind"], lootpage = "SWVAszoshGrimflame", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = WHITE.."[60]|r "..AL["Karazhan Crypt"], extra = AL["Deadwind Pass"], lootpage = "KCMarrowspike", icon = "Interface\\Icons\\Spell_Arcane_PortalIronForge" },
			{ name = RED.."[RAID]|r "..AL["Zul'Gurub"], extra = AL["Stranglethorn Vale"], lootpage = "ZGJeklik", icon = "Interface\\Icons\\Spell_Arcane_PortalOrgrimmar" },
			{ name = RED.."[RAID]|r "..AL["Ruins of Ahn'Qiraj"], extra = AL["Silithus"], lootpage = "AQ20Kurinnaxx", icon = "Interface\\Icons\\Spell_Arcane_PortalOrgrimmar" },
			{ name = RED.."[RAID]|r "..AL["Onyxia's Lair"], extra = AL["Dustwallow Marsh"], lootpage = "Axelus", icon = "Interface\\Icons\\Spell_Arcane_PortalOrgrimmar" },
			{ name = RED.."[RAID]|r "..AL["Lower Karazhan Halls"], extra = AL["Deadwind Pass"], lootpage = "LKHRolfen", icon = "Interface\\Icons\\Spell_Arcane_PortalOrgrimmar" },
			{ name = RED.."[RAID]|r "..AL["Blackwing Lair"], extra = AL["Burning Steppes"], lootpage = "BWLRazorgore", icon = "Interface\\Icons\\Spell_Arcane_PortalOrgrimmar" },
			{ name = RED.."[RAID]|r "..AL["Emerald Sanctum"], extra = AL["Hyjal"], lootpage = "ESErennius", icon = "Interface\\Icons\\Spell_Arcane_PortalOrgrimmar" },
			{ name = RED.."[RAID]|r "..AL["Timbermaw Hold"], extra = AL["Azshara"], lootpage = "TMHKarrsh", icon = "Interface\\Icons\\Spell_Arcane_PortalOrgrimmar" },
			{ name = RED.."[RAID]|r "..AL["Temple of Ahn'Qiraj"], extra = AL["Silithus"], lootpage = "AQ40Skeram", icon = "Interface\\Icons\\Spell_Arcane_PortalOrgrimmar" },
			{ name = RED.."[RAID]|r "..AL["Naxxramas"], extra = AL["Eastern Plaguelands"], lootpage = "NAXPatchwerk", icon = "Interface\\Icons\\Spell_Arcane_PortalOrgrimmar" },
			{ name = RED.."[RAID]|r "..AL["Upper Karazhan Halls"], extra = AL["Deadwind Pass"], lootpage = "UKHGnarlmoon", icon = "Interface\\Icons\\Spell_Arcane_PortalOrgrimmar" },
		}
	end
	AtlasLoot_PrepMenu(nil, AL["Dungeons & Raids"])
	AtlasLootCharDB.LastBoss = "DUNGEONSMENU2"
	AtlasLootCharDB.LastBossText = AL["Dungeons & Raids"]
	AtlasLootItemsFrame_PREV:Show()
	for i = 1, min(buttonsPerPage, getn(ButtonsInfo2)) do
		if ButtonsInfo2[i].name then
			_G["AtlasLootMenuItem_"..i.."_Name"]:SetText(ButtonsInfo2[i].name)
			_G["AtlasLootMenuItem_"..i.."_Extra"]:SetText(ButtonsInfo2[i].extra)
			_G["AtlasLootMenuItem_"..i.."_Icon"]:SetTexture(ButtonsInfo2[i].icon)
			_G["AtlasLootMenuItem_"..i].lootpage = ButtonsInfo2[i].lootpage
			_G["AtlasLootMenuItem_"..i]:Show()
		end
	end
end