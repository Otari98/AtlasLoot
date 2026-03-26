local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");
local _G = getfenv(0)
local buttonsPerPage = 30
local ButtonsInfo1
local RED = "|cffff0000"
local BLUE = "|cff0070dd"

function AtlasLootRepMenu()
	AtlasLoot_PrepMenu(nil, AL["Factions"])
	AtlasLootCharDB.LastBoss = "REPMENU"
	AtlasLootCharDB.LastBossText = AL["Factions"]
	if not ButtonsInfo1 then
		ButtonsInfo1 = {
			{ name = AL["Argent Dawn"], extra = "", lootpage = "Argent1", icon = "Interface\\Icons\\INV_Jewelry_Talisman_08" },
			{ name = AL["Brood of Nozdormu"], extra = "", lootpage = "AQBroodRings", icon = "Interface\\Icons\\INV_Jewelry_Ring_40" },
			{ name = AL["Darkmoon Faire"], extra = "", lootpage = "Darkmoon", icon = "Interface\\Icons\\INV_Misc_Ticket_Tarot_Maelstrom_01" },
			{ name = AL["Hydraxian Waterlords"], extra = "", lootpage = "WaterLords1", icon = "Interface\\Icons\\Spell_Frost_SummonWaterElemental_2" },
			{ name = AL["Thorium Brotherhood"], extra = "", lootpage = "Thorium1", icon = "Interface\\Icons\\INV_Ingot_Mithril" },
			{ name = AL["Cenarion Circle"], extra = "", lootpage = "Cenarion1", icon = "Interface\\Icons\\Spell_Nature_HealingTouch" },
			{ name = AL["Shen'dralar"], extra = "", lootpage = "Shendralar", icon = "Interface\\Icons\\INV_Misc_Book_04" },
			{ name = AL["Draenei Exiles"], extra = "", lootpage = "DraeneiExiles", icon = "Interface\\Icons\\INV_Enchant_ShardGlowingLarge" },
			{ name = AL["Bloodsail Buccaneers"], extra = "", lootpage = "Bloodsail1", icon = "Interface\\Icons\\INV_Helmet_66" },
			{ name = AL["Zandalar Tribe"], extra = "", lootpage = "Zandalar1", icon = "Interface\\Icons\\INV_Misc_Coin_08" },
			{ name = AL["Timbermaw Hold"], extra = "", lootpage = "Timbermaw", icon = "Interface\\Icons\\INV_Misc_Horn_01" },
			{ name = AL["Wardens of Time"], extra = "", lootpage = "Wardens1", icon = "Interface\\Icons\\INV_Misc_Head_Dragon_Bronze" },
			{ name = AL["Gelkis Clan Centaur"], extra = "", lootpage = "GelkisClan1", icon = "Interface\\Icons\\INV_Misc_Head_Centaur_01" },
			{ name = AL["Magram Clan Centaur"], extra = "", lootpage = "MagramClan1", icon = "Interface\\Icons\\INV_Misc_Head_Centaur_01" },
			{},
			{ name = AL["Stormwind"], extra = BLUE..AL["Alliance"], lootpage = "Stormwind", icon = "Interface\\Icons\\race_human"--[[INV_BannerPVP_02]] },
			{ name = AL["Ironforge"], extra = BLUE..AL["Alliance"], lootpage = "Ironforge", icon = "Interface\\Icons\\race_dwarf"--[[Ability_Racial_Avatar]] },
			{ name = AL["Gnomeregan Exiles"], extra = BLUE..AL["Alliance"], lootpage = "GnomereganExiles", icon = "Interface\\Icons\\race_gnome"--[[INV_Gizmo_02]] },
			{ name = AL["Darnassus"], extra = BLUE..AL["Alliance"], lootpage = "Darnassus", icon = "Interface\\Icons\\race_night_elf"--[[Ability_Racial_ShadowMeld]] },
			{ name = AL["Silvermoon Remnant"], extra = BLUE..AL["Alliance"], lootpage = "Helf", icon = "Interface\\Icons\\race_high_elf"--[[inv_misc_tournaments_symbol_bloodelf]] },
			{ name = AL["Dalaran"], extra = BLUE..AL["Alliance"], lootpage = "Dalaran", icon = "Interface\\Icons\\Spell_Holy_MagicalSentry" },
			{ name = AL["Wintersaber Trainers"], extra = BLUE..AL["Alliance"], lootpage = "Wintersaber1", icon = "Interface\\Icons\\Ability_Mount_PinkTiger" },
			{ name = AL["Wildhammer Clan"], extra = BLUE..AL["Alliance"], lootpage = "Wildhammer", icon = "Interface\\Icons\\Ability_Hunter_EagleEye" },
			{ name = AL["Orgrimmar"], extra = RED..AL["Horde"], lootpage = "Orgrimmar", icon = "Interface\\Icons\\race_orc"--[[INV_BannerPVP_01]] },
			{ name = AL["Darkspear Trolls"], extra = RED..AL["Horde"], lootpage = "DarkspearTrolls", icon = "Interface\\Icons\\race_troll"--[[Racial_Troll_Berserk]] },
			{ name = AL["Thunder Bluff"], extra = RED..AL["Horde"], lootpage = "ThunderBluff", icon = "Interface\\Icons\\race_tauren"--[[INV_Misc_Foot_Centaur]] },
			{ name = AL["Undercity"], extra = RED..AL["Horde"], lootpage = "Undercity", icon = "Interface\\Icons\\race_forsaken"--[[Spell_Shadow_RaiseDead]] },
			{ name = AL["Durotar Labor Union"], extra = RED..AL["Horde"], lootpage = "DurotarLaborUnion", icon = "Interface\\Icons\\race_goblin"--[[INV_Misc_Coin_01]] },
			{ name = AL["Revantusk Trolls"], extra = RED..AL["Horde"], lootpage = "Revantusk", icon = "Interface\\Icons\\INV_Misc_Head_Troll_01" },
			{ name = AL["Earthen Ring"], extra = RED..AL["Horde"], lootpage = "EarthenRing", icon = "Interface\\Icons\\Spell_Nature_EarthShock" },
		}
	end
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
