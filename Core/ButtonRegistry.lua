local AL = AceLibrary("AceLocale-2.2"):new("AtlasLoot");

AtlasLoot_ButtonRegistry = {
	--WoW Instances
	["DUNGEONSMENU1"] = {
		Title = AL["Dungeons & Raids"];
		Next_Page = "DUNGEONSMENU1";
	};
	["DUNGEONSMENU2"] = {
		Title = AL["Dungeons & Raids"];
		Prev_Page = "DUNGEONSMENU1";
	};
	-- Dragonmaw Retreat
	["DMRGowlfang"] = {
		Title = AL["Gowlfang"],
		Next_Page = "DMRBroodmother",
		Back_Page = "DUNGEONSMENU1",
	};
	["DMRBroodmother"] = {
		Title = AL["Cavernweb Broodmother"],
		Prev_Page = "DMRGowlfang",
		Next_Page = "DMRWebMaster",
		Back_Page = "DUNGEONSMENU1",
	};
	["DMRWebMaster"] = {
		Title = AL["Web Master Torkon"],
		Prev_Page = "DMRBroodmother",
		Next_Page = "DMRGarlok",
		Back_Page = "DUNGEONSMENU1",
	};
	["DMRGarlok"] = {
		Title = AL["Garlok Flamekeeper"],
		Prev_Page = "DMRWebMaster",
		Next_Page = "DMRHalgan",
		Back_Page = "DUNGEONSMENU1",
	};
	["DMRHalgan"] = {
		Title = AL["Halgan Redbrand"],
		Prev_Page = "DMRGarlok",
		Next_Page = "DMRSlagfist",
		Back_Page = "DUNGEONSMENU1",
	};
	["DMRSlagfist"] = {
		Title = AL["Slagfist Destroyer"],
		Prev_Page = "DMRHalgan",
		Next_Page = "DMROverlord",
		Back_Page = "DUNGEONSMENU1",
	};
	["DMROverlord"] = {
		Title = AL["Overlord Blackheart"],
		Prev_Page = "DMRSlagfist",
		Next_Page = "DMRElderHollowblood",
		Back_Page = "DUNGEONSMENU1",
	};
	["DMRElderHollowblood"] = {
		Title = AL["Elder Hollowblood"],
		Prev_Page = "DMROverlord",
		Next_Page = "DMRSearistrasz",
		Back_Page = "DUNGEONSMENU1",
	};
	["DMRSearistrasz"] = {
		Title = AL["Searistrasz"],
		Prev_Page = "DMRElderHollowblood",
		Next_Page = "DMRZuluhed",
		Back_Page = "DUNGEONSMENU1",
	};
	["DMRZuluhed"] = {
		Title = AL["Zuluhed the Whacked"],
		Prev_Page = "DMRSearistrasz",
		Next_Page = "DMRTrash",
		Back_Page = "DUNGEONSMENU1",
	};
	["DMRTrash"] = {
		Title = AL["Trash Mobs"],
		Prev_Page = "DMRZuluhed",
		Back_Page = "DUNGEONSMENU1",
	};
	-- Stormwrought Ruins
	["SWROronok"] = {
		Title = AL["Oronok Torn-Heart"],
		Next_Page = "SWRDagar",
		Back_Page = "DUNGEONSMENU1",
	};
	["SWRDagar"] = {
		Title = AL["Dagar the Glutton"],
		Prev_Page = "SWROronok",
		Next_Page = "SWRDukeBalor",
		Back_Page = "DUNGEONSMENU1",
	};
	["SWRDukeBalor"] = {
		Title = AL["Duke Balor the IV"],
		Prev_Page = "SWRDagar",
		Next_Page = "SWRLibrarian",
		Back_Page = "DUNGEONSMENU1",
	};
	["SWRLibrarian"] = {
		Title = AL["Librarian Theodorus"],
		Prev_Page = "SWRDukeBalor",
		Next_Page = "SWRChieftain",
		Back_Page = "DUNGEONSMENU1",
	};
	["SWRChieftain"] = {
		Title = AL["Chieftain Stormsong"],
		Prev_Page = "SWRLibrarian",
		Next_Page = "SWRDeathlord",
		Back_Page = "DUNGEONSMENU1",
	};
	["SWRDeathlord"] = {
		Title = AL["Deathlord Tidebane"],
		Prev_Page = "SWRChieftain",
		Next_Page = "SWRSubjugator",
		Back_Page = "DUNGEONSMENU1",
	};
	["SWRSubjugator"] = {
		Title = AL["Subjugator Halthas Shadecrest"],
		Prev_Page = "SWRDeathlord",
		Next_Page = "SWRMycellakos",
		Back_Page = "DUNGEONSMENU1",
	};
	["SWRMycellakos"] = {
		Title = AL["Mycellakos"],
		Prev_Page = "SWRSubjugator",
		Next_Page = "SWREldermaw",
		Back_Page = "DUNGEONSMENU1",
	};
	["SWREldermaw"] = {
		Title = AL["Eldermaw the Primordial"],
		Prev_Page = "SWRMycellakos",
		Next_Page = "SWRLadyDrazare",
		Back_Page = "DUNGEONSMENU1",
	};
	["SWRLadyDrazare"] = {
		Title = AL["Lady Drazare"],
		Prev_Page = "SWREldermaw",
		Next_Page = "SWRRemains",
		Back_Page = "DUNGEONSMENU1",
	};
	["SWRRemains"] = {
		Title = AL["Remains of the Innocent"],
		Prev_Page = "SWRLadyDrazare",
		Next_Page = "SWRMergothid",
		Back_Page = "DUNGEONSMENU1",
	};
	["SWRMergothid"] = {
		Title = AL["Mergothid"],
		Prev_Page = "SWRRemains",
		Next_Page = "SWRTrash",
		Back_Page = "DUNGEONSMENU1",
	};
	["SWRTrash"] = {
		Title = AL["Trash Mobs"],
		Prev_Page = "SWRMergothid",
		Back_Page = "DUNGEONSMENU1",
	};
	-- Hateforge Quarry
	["HQHighForemanBargulBlackhammer"] = {
		Title = AL["High Foreman Bargul Blackhammer"];
		Next_Page = "HQEngineerFiggles";
		Back_Page = "DUNGEONSMENU1";
	};
	["HQEngineerFiggles"] = {
		Title = AL["Engineer Figgles"];
		Next_Page = "HQCorrosis";
		Prev_Page = "HQHighForemanBargulBlackhammer";
		Back_Page = "DUNGEONSMENU1";
	};
	["HQCorrosis"] = {
		Title = AL["Corrosis"];
		Next_Page = "HQHatereaverAnnihilator";
		Prev_Page = "HQEngineerFiggles";
		Back_Page = "DUNGEONSMENU1";
	};
	["HQHatereaverAnnihilator"] = {
		Title = AL["Hatereaver Annihilator"];
		Next_Page = "HQHargeshDoomcaller";
		Prev_Page = "HQCorrosis";
		Back_Page = "DUNGEONSMENU1";
	};
	["HQHargeshDoomcaller"] = {
		Title = AL["Har'gesh Doomcaller"];
		Next_Page = "HQTrash";
		Prev_Page = "HQHatereaverAnnihilator";
		Back_Page = "DUNGEONSMENU1";
	};
	["HQTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "HQHargeshDoomcaller";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Karazhan Crypt
	["KCMarrowspike"] = {
		Title = AL["Marrowspike"];
		Next_Page = "KCHivaxxis";
		Back_Page = "DUNGEONSMENU1";
	};
	["KCHivaxxis"] = {
		Title = AL["Hivaxxis"];
		Next_Page = "KCCorpsemuncher";
		Prev_Page = "KCMarrowspike";
		Back_Page = "DUNGEONSMENU1";
	};
	["KCCorpsemuncher"] = {
		Title = AL["Corpsemuncher"];
		Next_Page = "KCGuardCaptainGort";
		Prev_Page = "KCHivaxxis";
		Back_Page = "DUNGEONSMENU1";
	};
	["KCGuardCaptainGort"] = {
		Title = AL["Guard Captain Gort"];
		Next_Page = "KCArchlichEnkhraz";
		Prev_Page = "KCCorpsemuncher";
		Back_Page = "DUNGEONSMENU1";
	};
	["KCArchlichEnkhraz"] = {
		Title = AL["Archlich Enkhraz"];
		Next_Page = "KCCommanderAndreon";
		Prev_Page = "KCGuardCaptainGort";
		Back_Page = "DUNGEONSMENU1";
	};
	["KCCommanderAndreon"] = {
		Title = AL["Commander Andreon"];
		Next_Page = "KCAlarus";
		Prev_Page = "KCArchlichEnkhraz";
		Back_Page = "DUNGEONSMENU1";
	};
	["KCAlarus"] = {
		Title = AL["Alarus"];
		Next_Page = "KCTreasure";
		Prev_Page = "KCCommanderAndreon";
		Back_Page = "DUNGEONSMENU1";
	};
	["KCTreasure"] = {
		Title = AL["Half-Buried Treasure Chest"];
		Prev_Page = "KCAlarus";
		Next_Page = "KCTrash";
		Back_Page = "DUNGEONSMENU1";
	};
	["KCTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "KCTreasure";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Caverns of Time: Black Morass
	["COTBMChronar"] = {
		Title = AL["Chronar"];
		Next_Page = "COTBMEpidamu";
		Back_Page = "DUNGEONSMENU1";
	};
	["COTBMEpidamu"] = {
		Title = AL["Epidamu"];
		Next_Page = "COTBMDriftingAvatar";
		Prev_Page = "COTBMChronar";
		Back_Page = "DUNGEONSMENU1";
	};
	["COTBMDriftingAvatar"] = {
		Title = AL["Drifting Avatar of Sand"];
		Next_Page = "COTBMTimeLordEpochronos";
		Prev_Page = "COTBMEpidamu";
		Back_Page = "DUNGEONSMENU1";
	};
	["COTBMTimeLordEpochronos"] = {
		Title = AL["Time-Lord Epochronos"];
		Next_Page = "COTBMMossheart";
		Prev_Page = "COTBMDriftingAvatar";
		Back_Page = "DUNGEONSMENU1";
	};
	["COTBMMossheart"] = {
		Title = AL["Mossheart"];
		Next_Page = "COTBMRotmaw";
		Prev_Page = "COTBMTimeLordEpochronos";
		Back_Page = "DUNGEONSMENU1";
	};
	["COTBMRotmaw"] = {
		Title = AL["Rotmaw"];
		Next_Page = "COTBMAntnormi";
		Prev_Page = "COTBMMossheart";
		Back_Page = "DUNGEONSMENU1";
	};
	["COTBMAntnormi"] = {
		Title = AL["Antnormi"];
		Next_Page = "COTTrash";
		Prev_Page = "COTBMRotmaw";
		Back_Page = "DUNGEONSMENU1";
	};
	["COTTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "COTBMAntnormi";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Stormwind Vault
	["SWVAszoshGrimflame"] = {
		Title = AL["Aszosh Grimflame"];
		Next_Page = "SWVThamGrarr";
		Back_Page = "DUNGEONSMENU2";
	};
	["SWVThamGrarr"] = {
		Title = AL["Tham'Grarr"];
		Next_Page = "SWVBlackBride";
		Prev_Page = "SWVAszoshGrimflame";
		Back_Page = "DUNGEONSMENU2";
	};
	["SWVBlackBride"] = {
		Title = AL["Black Bride"];
		Next_Page = "SWVDamian";
		Prev_Page = "SWVThamGrarr";
		Back_Page = "DUNGEONSMENU2";
	};
	["SWVDamian"] = {
		Title = AL["Damian"];
		Next_Page = "SWVVolkanCruelblade";
		Prev_Page = "SWVBlackBride";
		Back_Page = "DUNGEONSMENU2";
	};
	["SWVVolkanCruelblade"] = {
		Title = AL["Volkan Cruelblade"];
		Next_Page = "SWVVaultArmoryEquipment";
		Prev_Page = "SWVDamian";
		Back_Page = "DUNGEONSMENU2";
	};
	["SWVVaultArmoryEquipment"] = {
		Title = AL["Arc'tiras"];
		Prev_Page = "SWVVolkanCruelblade";
		Next_Page = "SWVTrash";
		Back_Page = "DUNGEONSMENU2";
	};
	["SWVTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "SWVVaultArmoryEquipment";
		Back_Page = "DUNGEONSMENU2";
	};
	-- The Crescent Grove
	["TCGGrovetenderEngryss"] = {
		Title = AL["Grovetender Engryss"];
		Next_Page = "TCGKeeperRanathos";
		Back_Page = "DUNGEONSMENU1";
	};
	["TCGKeeperRanathos"] = {
		Title = AL["Keeper Ranathos"];
		Next_Page = "TCGHighPriestessAlathea";
		Prev_Page = "TCGGrovetenderEngryss";
		Back_Page = "DUNGEONSMENU1";
	};
	["TCGHighPriestessAlathea"] = {
		Title = AL["High Priestess A'lathea"];
		Next_Page = "TCGFenektistheDeceiver";
		Prev_Page = "TCGKeeperRanathos";
		Back_Page = "DUNGEONSMENU1";
	};
	["TCGFenektistheDeceiver"] = {
		Title = AL["Fenektis the Deceiver"];
		Next_Page = "TCGMasterRaxxieth";
		Prev_Page = "TCGHighPriestessAlathea";
		Back_Page = "DUNGEONSMENU1";
	};
	["TCGMasterRaxxieth"] = {
		Title = AL["Master Raxxieth"];
		Next_Page = "TCGTrash";
		Prev_Page = "TCGFenektistheDeceiver";
		Back_Page = "DUNGEONSMENU1";
	};
	["TCGTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "TCGMasterRaxxieth";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Upper Karazhan Halls
    ["UKHGnarlmoon"] = {
		Title = AL["Keeper Gnarlmoon"];
		Next_Page = "UKHIncantagos";
		Back_Page = "DUNGEONSMENU2";
	};
	["UKHIncantagos"] = {
		Title = AL["Ley-Watcher Incantagos"];
		Next_Page = "UKHAnomalus";
		Prev_Page = "UKHGnarlmoon";
		Back_Page = "DUNGEONSMENU2";
	};
	["UKHAnomalus"] = {
		Title = AL["Anomalus"];
		Next_Page = "UKHEcho";
		Prev_Page = "UKHIncantagos";
		Back_Page = "DUNGEONSMENU2";
	};
	["UKHEcho"] = {
		Title = AL["Echo of Medivh"];
		Next_Page = "UKHKing";
		Prev_Page = "UKHAnomalus";
		Back_Page = "DUNGEONSMENU2";
	};
	["UKHKing"] = {
		Title = AL["King (Chess fight)"];
		Next_Page = "UKHSanvTasdal";
		Prev_Page = "UKHEcho";
		Back_Page = "DUNGEONSMENU2";
	};
	["UKHSanvTasdal"] = {
		Title = AL["Sanv Tas'dal"];
		Next_Page = "UKHKruul";
		Prev_Page = "UKHKing";
		Back_Page = "DUNGEONSMENU2";
	};
	["UKHKruul"] = {
		Title = AL["Kruul"];
		Next_Page = "UKHRupturan";
		Prev_Page = "UKHSanvTasdal";
		Back_Page = "DUNGEONSMENU2";
	};
	["UKHRupturan"] = {
		Title = AL["Rupturan the Broken"];
		Prev_Page = "UKHKruul";
		Next_Page = "UKHMephistroth";
		Back_Page = "DUNGEONSMENU2";
	},
	["UKHMephistroth"] = {
		Title = AL["Mephistroth"];
		Prev_Page = "UKHRupturan";
		Next_Page = "UKHTrash";
		Back_Page = "DUNGEONSMENU2";
	},
	["UKHTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "UKHMephistroth";
		Back_Page = "DUNGEONSMENU2";
	};
	-- Gilneas City
	["GCMatthiasHoltz"] = {
		Title = AL["Matthias Holtz"];
		Next_Page = "GCPackmasterRagetooth";
		Back_Page = "DUNGEONSMENU1";
	};
	["GCPackmasterRagetooth"] = {
		Title = AL["Packmaster Ragetooth"];
		Next_Page = "GCJudgeSutherland";
		Prev_Page = "GCMatthiasHoltz";
		Back_Page = "DUNGEONSMENU1";
	};
	["GCJudgeSutherland"] = {
		Title = AL["Judge Sutherland"];
		Prev_Page = "GCPackmasterRagetooth";
		Next_Page = "GCDustivanBlackcowl";
		Back_Page = "DUNGEONSMENU1";
	};
	["GCDustivanBlackcowl"] = {
		Title = AL["Dustivan Blackcowl"];
		Prev_Page = "GCJudgeSutherland";
		Next_Page = "GCMarshalMagnusGreystone";
		Back_Page = "DUNGEONSMENU1";
	};
	["GCMarshalMagnusGreystone"] = {
		Title = AL["Marshal Magnus Greystone"];
		Prev_Page = "GCDustivanBlackcowl";
		Next_Page = "GCHorsemasterLevvin";
		Back_Page = "DUNGEONSMENU1";
	};
	["GCHorsemasterLevvin"] = {
		Title = AL["Horsemaster Levvin"];
		Prev_Page = "GCMarshalMagnusGreystone";
		Next_Page = "GCHarlowFamilyChest";
		Back_Page = "DUNGEONSMENU1";
	};
	["GCHarlowFamilyChest"] = {
		Title = AL["Harlow Family Chest"];
		Prev_Page = "GCHorsemasterLevvin";
		Next_Page = "GCGennGreymane";
		Back_Page = "DUNGEONSMENU1";
	};
	["GCGennGreymane"] = {
		Title = AL["Genn Greymane"];
		Prev_Page = "GCHarlowFamilyChest";
		Next_Page = "GCTrash";
		Back_Page = "DUNGEONSMENU1";
	};
	["GCTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "GCGennGreymane";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Blackrock Depths
	["BRDLordRoccor"] = {
		Title = AL["Lord Roccor"];
		Next_Page = "BRDHighInterrogatorGerstahn";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDHighInterrogatorGerstahn"] = {
		Title = AL["High Interrogator Gerstahn"];
		Next_Page = "BRDAnubshiah";
		Prev_Page = "BRDLordRoccor";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDAnubshiah"] = {
		Title = AL["Anub'shiah"];
		Next_Page = "BRDEviscerator";
		Prev_Page = "BRDHighInterrogatorGerstahn";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDEviscerator"] = {
		Title = AL["Eviscerator"];
		Next_Page = "BRDGorosh";
		Prev_Page = "BRDAnubshiah";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDGorosh"] = {
		Title = AL["Gorosh the Dervish"];
		Next_Page = "BRDGrizzle";
		Prev_Page = "BRDEviscerator";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDGrizzle"] = {
		Title = AL["Grizzle"];
		Next_Page = "BRDHedrum";
		Prev_Page = "BRDGorosh";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDHedrum"] = {
		Title = AL["Hedrum the Creeper"];
		Next_Page = "BRDOkthor";
		Prev_Page = "BRDGrizzle";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDOkthor"] = {
		Title = AL["Ok'thor the Breaker"];
		Next_Page = "BRDTheldren";
		Prev_Page = "BRDHedrum";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDTheldren"] = {
		Title = AL["Theldren"];
		Next_Page = "BRDHoundmaster";
		Prev_Page = "BRDOkthor";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDHoundmaster"] = {
		Title = AL["Houndmaster Grebmar"];
		Next_Page = "BRDPyromancerLoregrain";
		Prev_Page = "BRDTheldren";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDPyromancerLoregrain"] = {
		Title = AL["Pyromancer Loregrain"].." ("..AL["Rare"]..")";
		Next_Page = "BRDTheVault";
		Prev_Page = "BRDHoundmaster";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDTheVault"] = {
		Title = AL["The Vault"];
		Next_Page = "BRDWarderStilgiss";
		Prev_Page = "BRDPyromancerLoregrain";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDWarderStilgiss"] = {
		Title = AL["Warder Stilgiss"].." ("..AL["Rare"]..")";
		Next_Page = "BRDVerek";
		Prev_Page = "BRDTheVault";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDVerek"] = {
		Title = AL["Verek"].." ("..AL["Rare"]..")";
		Next_Page = "BRDFineousDarkvire";
		Prev_Page = "BRDWarderStilgiss";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDFineousDarkvire"] = {
		Title = AL["Fineous Darkvire"];
		Next_Page = "BRDLordIncendius";
		Prev_Page = "BRDVerek";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDLordIncendius"] = {
		Title = AL["Lord Incendius"];
		Next_Page = "BRDBaelGar";
		Prev_Page = "BRDFineousDarkvire";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDBaelGar"] = {
		Title = AL["Bael'Gar"];
		Next_Page = "BRDGeneralAngerforge";
		Prev_Page = "BRDLordIncendius";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDGeneralAngerforge"] = {
		Title = AL["General Angerforge"];
		Next_Page = "BRDGolemLordArgelmach";
		Prev_Page = "BRDBaelGar";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDGolemLordArgelmach"] = {
		Title = AL["Golem Lord Argelmach"];
		Next_Page = "BRDGuzzler";
		Prev_Page = "BRDGeneralAngerforge";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDGuzzler"] = {
		Title = AL["The Grim Guzzler"];
		Next_Page = "BRDFlamelash";
		Prev_Page = "BRDGolemLordArgelmach";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDFlamelash"] = {
		Title = AL["Ambassador Flamelash"];
		Next_Page = "BRDPanzor";
		Prev_Page = "BRDGuzzler";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDPanzor"] = {
		Title = AL["Panzor the Invincible"].." ("..AL["Rare"]..")";
		Next_Page = "BRDTomb";
		Prev_Page = "BRDFlamelash";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDTomb"] = {
		Title = AL["Summoner's Tomb"];
		Next_Page = "BRDMagmus";
		Prev_Page = "BRDPanzor";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDMagmus"] = {
		Title = AL["Magmus"];
		Next_Page = "BRDPrincess";
		Prev_Page = "BRDTomb";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDPrincess"] = {
		Title = AL["Princess Moira Bronzebeard"];
		Next_Page = "BRDEmperorDagranThaurissan";
		Prev_Page = "BRDMagmus";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDEmperorDagranThaurissan"] = {
		Title = AL["Emperor Dagran Thaurissan"];
		Next_Page = "BRDTrash";
		Prev_Page = "BRDPrincess";
		Back_Page = "DUNGEONSMENU1";
	};
	["BRDTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "BRDEmperorDagranThaurissan";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Lower Blackrock Spire
	["LBRSSpirestoneButcher"] = {
		Title = AL["Spirestone Butcher"].." ("..AL["Rare"]..")";
		Next_Page = "LBRSSpirestoneBattleLord";
		Back_Page = "DUNGEONSMENU1";
	};
	["LBRSSpirestoneBattleLord"] = {
		Title = AL["Spirestone Battle Lord"].." ("..AL["Rare"]..")";
		Next_Page = "LBRSSpirestoneLordMagus";
		Prev_Page = "LBRSSpirestoneButcher";
		Back_Page = "DUNGEONSMENU1";
	};
	["LBRSSpirestoneLordMagus"] = {
		Title = AL["Spirestone Lord Magus"].." ("..AL["Rare"]..")";
		Next_Page = "LBRSOmokk";
		Prev_Page = "LBRSSpirestoneBattleLord";
		Back_Page = "DUNGEONSMENU1";
	};
	["LBRSOmokk"] = {
		Title = AL["Highlord Omokk"];
		Next_Page = "LBRSVosh";
		Prev_Page = "LBRSSpirestoneLordMagus";
		Back_Page = "DUNGEONSMENU1";
	};
	["LBRSVosh"] = {
		Title = AL["Shadow Hunter Vosh'gajin"];
		Next_Page = "LBRSVoone";
		Prev_Page = "LBRSOmokk";
		Back_Page = "DUNGEONSMENU1";
	};
	["LBRSVoone"] = {
		Title = AL["War Master Voone"];
		Next_Page = "LBRSFelguard";
		Prev_Page = "LBRSVosh";
		Back_Page = "DUNGEONSMENU1";
	};
	["LBRSFelguard"] = {
		Title = AL["Burning Felguard"].." ("..AL["Rare"]..")";
		Next_Page = "LBRSGrayhoof";
		Prev_Page = "LBRSVoone";
		Back_Page = "DUNGEONSMENU1";
	};
	["LBRSGrayhoof"] = {
		Title = AL["Mor Grayhoof"];
		Next_Page = "LBRSGrimaxe";
		Prev_Page = "LBRSFelguard";
		Back_Page = "DUNGEONSMENU1";
	};
	["LBRSGrimaxe"] = {
		Title = AL["Bannok Grimaxe"].." ("..AL["Rare"]..")";
		Next_Page = "LBRSSmolderweb";
		Prev_Page = "LBRSGrayhoof";
		Back_Page = "DUNGEONSMENU1";
	};
	["LBRSSmolderweb"] = {
		Title = AL["Mother Smolderweb"];
		Next_Page = "LBRSCrystalFang";
		Prev_Page = "LBRSGrimaxe";
		Back_Page = "DUNGEONSMENU1";
	};
	["LBRSCrystalFang"] = {
		Title = AL["Crystal Fang"].." ("..AL["Rare"]..")";
		Next_Page = "LBRSDoomhowl";
		Prev_Page = "LBRSSmolderweb";
		Back_Page = "DUNGEONSMENU1";
	};
	["LBRSDoomhowl"] = {
		Title = AL["Urok Doomhowl"];
		Next_Page = "LBRSZigris";
		Prev_Page = "LBRSCrystalFang";
		Back_Page = "DUNGEONSMENU1";
	};
	["LBRSZigris"] = {
		Title = AL["Quartermaster Zigris"];
		Next_Page = "LBRSHalycon";
		Prev_Page = "LBRSDoomhowl";
		Back_Page = "DUNGEONSMENU1";
	};
	["LBRSHalycon"] = {
		Title = AL["Halycon"];
		Next_Page = "LBRSSlavener";
		Prev_Page = "LBRSZigris";
		Back_Page = "DUNGEONSMENU1";
	};
	["LBRSSlavener"] = {
		Title = AL["Gizrul the Slavener"];
		Next_Page = "LBRSBashguud";
		Prev_Page = "LBRSHalycon";
		Back_Page = "DUNGEONSMENU1";
	};
	["LBRSBashguud"] = {
		Title = AL["Ghok Bashguud"].." ("..AL["Rare"]..")";
		Next_Page = "LBRSWyrmthalak";
		Prev_Page = "LBRSSlavener";
		Back_Page = "DUNGEONSMENU1";
	};
	["LBRSWyrmthalak"] = {
		Title = AL["Overlord Wyrmthalak"];
		Next_Page = "LBRSTrash";
		Prev_Page = "LBRSBashguud";
		Back_Page = "DUNGEONSMENU1";
	};
	["LBRSTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "LBRSWyrmthalak";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Upper Blackrock Spire
	["UBRSEmberseer"] = {
		Title = AL["Pyroguard Emberseer"];
		Next_Page = "UBRSSolakar";
		Back_Page = "DUNGEONSMENU1";
	};
	["UBRSSolakar"] = {
		Title = AL["Solakar Flamewreath"];
		Next_Page = "UBRSFlame";
		Prev_Page = "UBRSEmberseer";
		Back_Page = "DUNGEONSMENU1";
	};
	["UBRSFlame"] = {
		Title = AL["Father Flame"];
		Next_Page = "UBRSRunewatcher";
		Prev_Page = "UBRSSolakar";
		Back_Page = "DUNGEONSMENU1";
	};
	["UBRSRunewatcher"] = {
		Title = AL["Jed Runewatcher"].." ("..AL["Rare"]..")";
		Next_Page = "UBRSAnvilcrack";
		Prev_Page = "UBRSFlame";
		Back_Page = "DUNGEONSMENU1";
	};
	["UBRSAnvilcrack"] = {
		Title = AL["Goraluk Anvilcrack"].." ("..AL["Rare"]..")";
		Next_Page = "UBRSRend";
		Prev_Page = "UBRSRunewatcher";
		Back_Page = "DUNGEONSMENU1";
	};
	["UBRSRend"] = {
		Title = AL["Warchief Rend Blackhand"];
		Next_Page = "UBRSGyth";
		Prev_Page = "UBRSAnvilcrack";
		Back_Page = "DUNGEONSMENU1";
	};
	["UBRSGyth"] = {
		Title = AL["Gyth"];
		Next_Page = "UBRSBeast";
		Prev_Page = "UBRSRend";
		Back_Page = "DUNGEONSMENU1";
	};
	["UBRSBeast"] = {
		Title = AL["The Beast"];
		Next_Page = "UBRSValthalak";
		Prev_Page = "UBRSGyth";
		Back_Page = "DUNGEONSMENU1";
	};
	["UBRSValthalak"] = {
		Title = AL["Lord Valthalak"];
		Next_Page = "UBRSDrakkisath";
		Prev_Page = "UBRSBeast";
		Back_Page = "DUNGEONSMENU1";
	};
	["UBRSDrakkisath"] = {
		Title = AL["General Drakkisath"];
		Next_Page = "UBRSTrash";
		Prev_Page = "UBRSValthalak";
		Back_Page = "DUNGEONSMENU1";
	};
	["UBRSTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "UBRSDrakkisath";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Blackwing Lair
	["BWLRazorgore"] = {
		Title = AL["Razorgore the Untamed"];
		Next_Page = "BWLVaelastrasz";
		Back_Page = "DUNGEONSMENU2";
	};
	["BWLVaelastrasz"] = {
		Title = AL["Vaelastrasz the Corrupt"];
		Next_Page = "BWLLashlayer";
		Prev_Page = "BWLRazorgore";
		Back_Page = "DUNGEONSMENU2";
	};
	["BWLLashlayer"] = {
		Title = AL["Broodlord Lashlayer"];
		Next_Page = "BWLFiremaw";
		Prev_Page = "BWLVaelastrasz";
		Back_Page = "DUNGEONSMENU2";
	};
	["BWLFiremaw"] = {
		Title = AL["Firemaw"];
		Next_Page = "BWLEbonroc";
		Prev_Page = "BWLLashlayer";
		Back_Page = "DUNGEONSMENU2";
	};
	["BWLEbonroc"] = {
		Title = AL["Ebonroc"];
		Next_Page = "BWLFlamegor";
		Prev_Page = "BWLFiremaw";
		Back_Page = "DUNGEONSMENU2";
	};
	["BWLFlamegor"] = {
		Title = AL["Flamegor"];
		Next_Page = "BWLChromaggus";
		Prev_Page = "BWLEbonroc";
		Back_Page = "DUNGEONSMENU2";
	};
	["BWLChromaggus"] = {
		Title = AL["Chromaggus"];
		Next_Page = "BWLNefarian";
		Prev_Page = "BWLFlamegor";
		Back_Page = "DUNGEONSMENU2";
	};
	["BWLNefarian"] = {
		Title = AL["Nefarian"];
		Next_Page = "BWLTrashMobs";
		Prev_Page = "BWLChromaggus";
		Back_Page = "DUNGEONSMENU2";
	};
	["BWLTrashMobs"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "BWLNefarian";
		Back_Page = "DUNGEONSMENU2";
	};
	-- The Deadmines
    ["DMJaredVoss"] = {
		Title = AL["Jared Voss"];
		Next_Page = "DMRhahkZor";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMRhahkZor"] = {
		Title = AL["Rhahk'Zor"];
		Next_Page = "DMMinerJohnson";
        Prev_Page = "DMJaredVoss";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMMinerJohnson"] = {
		Title = AL["Miner Johnson"].." ("..AL["Rare"]..")";
		Next_Page = "DMSneed";
		Prev_Page = "DMRhahkZor";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMSneed"] = {
		Title = AL["Sneed"];
		Next_Page = "DMSneedsShredder";
		Prev_Page = "DMMinerJohnson";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMSneedsShredder"] = {
		Title = AL["Sneed's Shredder"];
		Next_Page = "DMGilnid";
		Prev_Page = "DMSneed";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMGilnid"] = {
		Title = AL["Gilnid"];
		Next_Page = "DMHarvester";
		Prev_Page = "DMSneedsShredder";
		Back_Page = "DUNGEONSMENU1";
	};
    ["DMHarvester"] = {
		Title = AL["Masterpiece Harvester"];
		Next_Page = "DMMrSmite";
		Prev_Page = "DMGilnid";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMMrSmite"] = {
		Title = AL["Mr. Smite"];
		Next_Page = "DMCookie";
		Prev_Page = "DMHarvester";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMCookie"] = {
		Title = AL["Cookie"];
		Next_Page = "DMCaptainGreenskin";
		Prev_Page = "DMMrSmite";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMCaptainGreenskin"] = {
		Title = AL["Captain Greenskin"];
		Next_Page = "DMVanCleef";
		Prev_Page = "DMCookie";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMVanCleef"] = {
		Title = AL["Edwin VanCleef"];
		Next_Page = "DMTrash";
		Prev_Page = "DMCaptainGreenskin";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "DMVanCleef";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Gnomeregan
	["GnGrubbis"] = {
		Title = AL["Grubbis"];
		Next_Page = "GnViscousFallout";
		Back_Page = "DUNGEONSMENU1";
	};
	["GnViscousFallout"] = {
		Title = AL["Viscous Fallout"];
		Next_Page = "GnElectrocutioner6000";
		Prev_Page = "GnGrubbis";
		Back_Page = "DUNGEONSMENU1";
	};
	["GnElectrocutioner6000"] = {
		Title = AL["Electrocutioner 6000"];
		Next_Page = "GnCrowdPummeler960";
		Prev_Page = "GnViscousFallout";
		Back_Page = "DUNGEONSMENU1";
	};
	["GnCrowdPummeler960"] = {
		Title = AL["Crowd Pummeler 9-60"];
		Next_Page = "GnDIAmbassador";
		Prev_Page = "GnElectrocutioner6000";
		Back_Page = "DUNGEONSMENU1";
	};
	["GnDIAmbassador"] = {
		Title = AL["Dark Iron Ambassador"];
		Next_Page = "GnMekgineerThermaplugg";
		Prev_Page = "GnCrowdPummeler960";
		Back_Page = "DUNGEONSMENU1";
	};
	["GnMekgineerThermaplugg"] = {
		Title = AL["Mekgineer Thermaplugg"];
		Next_Page = "GnTrash";
		Prev_Page = "GnDIAmbassador";
		Back_Page = "DUNGEONSMENU1";
	};
	["GnTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "GnMekgineerThermaplugg";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Molten Core
	["MCIncindis"] = {
		Title = AL["Incindis"];
		Next_Page = "MCLucifron";
		Back_Page = "DUNGEONSMENU2";
	};
	["MCLucifron"] = {
		Title = AL["Lucifron"];
		Next_Page = "MCMagmadar";
		Prev_Page = "MCIncindis";
		Back_Page = "DUNGEONSMENU2";
	};
	["MCMagmadar"] = {
		Title = AL["Magmadar"];
		Next_Page = "MCGarr";
		Prev_Page = "MCLucifron";
		Back_Page = "DUNGEONSMENU2";
	};
	-- ["MCGehennas"] = {
	-- 	Title = AL["Gehennas"];
	-- 	Next_Page = "MCGarr";
	-- 	Prev_Page = "MCMagmadar";
	-- 	Back_Page = "DUNGEONSMENU2";
	-- };
	["MCGarr"] = {
		Title = AL["Garr"];
		Next_Page = "MCShazzrah";
		Prev_Page = "MCMagmadar";
		Back_Page = "DUNGEONSMENU2";
	};
	["MCShazzrah"] = {
		Title = AL["Shazzrah"];
		Next_Page = "MCGeddon";
		Prev_Page = "MCGarr";
		Back_Page = "DUNGEONSMENU2";
	};
	["MCGeddon"] = {
		Title = AL["Baron Geddon"];
		Next_Page = "MCGolemagg";
		Prev_Page = "MCShazzrah";
		Back_Page = "DUNGEONSMENU2";
	};
	["MCGolemagg"] = {
		Title = AL["Golemagg the Incinerator"];
		Next_Page = "MCTwins";
		Prev_Page = "MCGeddon";
		Back_Page = "DUNGEONSMENU2";
	};
	["MCTwins"] = {
		Title = AL["Basalthar & Smoldaris"];
		Next_Page = "MCThaurissan";
		Next_Title =AL["Sorcerer-Thane Thaurissan"];
		Prev_Page = "MCGolemagg";
		Back_Page = "DUNGEONSMENU2";
	};
	["MCThaurissan"] = {
		Title = AL["Sorcerer-Thane Thaurissan"];
		Next_Page = "MCSulfuron";
		Prev_Page = "MCTwins";
		Back_Page = "DUNGEONSMENU2";
	};
	["MCSulfuron"] = {
		Title = AL["Sulfuron Harbinger"];
		Next_Page = "MCMajordomo";
		Prev_Page = "MCThaurissan";
		Back_Page = "DUNGEONSMENU2";
	};
	["MCMajordomo"] = {
		Title = AL["Majordomo Executus"];
		Next_Page = "MCRagnaros";
		Prev_Page = "MCSulfuron";
		Back_Page = "DUNGEONSMENU2";
	};
	["MCRagnaros"] = {
		Title = AL["Ragnaros"];
		Next_Page = "MCTrashMobs";
		Prev_Page = "MCMajordomo";
		Back_Page = "DUNGEONSMENU2";
	};
	["MCTrashMobs"] = {
		Title = AL["Trash Mobs"];
		Next_Page = "MCRANDOMBOSSDROPS";
		Prev_Page = "MCRagnaros";
		Back_Page = "DUNGEONSMENU2";
	};
	["MCRANDOMBOSSDROPS"] = {
		Title = AL["Random Boss Loot"];
		Prev_Page = "MCTrashMobs";
		Back_Page = "DUNGEONSMENU2";
	};
	-- Naxxramas
	["NAXPatchwerk"] = {
		Title = AL["Patchwerk"];
		Next_Page = "NAXGrobbulus";
		Back_Page = "DUNGEONSMENU2";
	};
	["NAXGrobbulus"] = {
		Title = AL["Grobbulus"];
		Next_Page = "NAXGluth";
		Prev_Page = "NAXPatchwerk";
		Back_Page = "DUNGEONSMENU2";
	};
	["NAXGluth"] = {
		Title = AL["Gluth"];
		Next_Page = "NAXThaddius";
		Prev_Page = "NAXGrobbulus";
		Back_Page = "DUNGEONSMENU2";
	};
	["NAXThaddius"] = {
		Title = AL["Thaddius"];
		Next_Page = "NAXAnubRekhan";
		Prev_Page = "NAXGluth";
		Back_Page = "DUNGEONSMENU2";
	};
	["NAXAnubRekhan"] = {
		Title = AL["Anub'Rekhan"];
		Next_Page = "NAXGrandWidowFaerlina";
		Prev_Page = "NAXThaddius";
		Back_Page = "DUNGEONSMENU2";
	};
	["NAXGrandWidowFaerlina"] = {
		Title = AL["Grand Widow Faerlina"];
		Next_Page = "NAXMaexxna";
		Prev_Page = "NAXAnubRekhan";
		Back_Page = "DUNGEONSMENU2";
	};
	["NAXMaexxna"] = {
		Title = AL["Maexxna"];
		Next_Page = "NAXNoththePlaguebringer";
		Prev_Page = "NAXGrandWidowFaerlina";
		Back_Page = "DUNGEONSMENU2";
	};
	["NAXNoththePlaguebringer"] = {
		Title = AL["Noth the Plaguebringer"];
		Next_Page = "NAXHeigantheUnclean";
		Prev_Page = "NAXMaexxna";
		Back_Page = "DUNGEONSMENU2";
	};
	["NAXHeigantheUnclean"] = {
		Title = AL["Heigan the Unclean"];
		Next_Page = "NAXLoatheb";
		Prev_Page = "NAXNoththePlaguebringer";
		Back_Page = "DUNGEONSMENU2";
	};
	["NAXLoatheb"] = {
		Title = AL["Loatheb"];
		Next_Page = "NAXInstructorRazuvious";
		Prev_Page = "NAXHeigantheUnclean";
		Back_Page = "DUNGEONSMENU2";
	};
	["NAXInstructorRazuvious"] = {
		Title = AL["Instructor Razuvious"];
		Next_Page = "NAXGothiktheHarvester";
		Prev_Page = "NAXLoatheb";
		Back_Page = "DUNGEONSMENU2";
	};
	["NAXGothiktheHarvester"] = {
		Title = AL["Gothik the Harvester"];
		Next_Page = "NAXTheFourHorsemen";
		Prev_Page = "NAXInstructorRazuvious";
		Back_Page = "DUNGEONSMENU2";
	};
	["NAXTheFourHorsemen"] = {
		Title = AL["The Four Horsemen"];
		Next_Page = "NAXSapphiron";
		Prev_Page = "NAXGothiktheHarvester";
		Back_Page = "DUNGEONSMENU2";
	};
	["NAXSapphiron"] = {
		Title = AL["Sapphiron"];
		Next_Page = "NAXKelThuzard";
		Prev_Page = "NAXTheFourHorsemen";
		Back_Page = "DUNGEONSMENU2";
	};
	["NAXKelThuzard"] = {
		Title = AL["Kel'Thuzad"];
		Next_Page = "NAXTrash";
		Prev_Page = "NAXSapphiron";
		Back_Page = "DUNGEONSMENU2";
	};
	["NAXTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "NAXKelThuzard";
		Back_Page = "DUNGEONSMENU2";
	};
	-- Scarlet Monastery
	["SMVishas"] = {
		Title = AL["Interrogator Vishas"];
		Next_Page = "SMDukeDreadmoore";
		Back_Page = "DUNGEONSMENU1";
	};
    ["SMDukeDreadmoore"] = {
		Title = AL["Duke Dreadmoore"];
		Next_Page = "SMScorn";
		Prev_Page = "SMVishas";
		Back_Page = "DUNGEONSMENU1";
	};
	["SMScorn"] = {
		Title = AL["Scorn"].." ("..AL["Scourge Invasion"]..")";
		Next_Page = "SMIronspine";
		Prev_Page = "SMDukeDreadmoore";
		Back_Page = "DUNGEONSMENU1";
	};
	["SMIronspine"] = {
		Title = AL["Ironspine"].." ("..AL["Rare"]..")";
		Next_Page = "SMAzshir";
		Prev_Page = "SMScorn";
		Back_Page = "DUNGEONSMENU1";
	};
	["SMAzshir"] = {
		Title = AL["Azshir the Sleepless"].." ("..AL["Rare"]..")";
		Next_Page = "SMFallenChampion";
		Prev_Page = "SMIronspine";
		Back_Page = "DUNGEONSMENU1";
	};
	["SMFallenChampion"] = {
		Title = AL["Fallen Champion"].." ("..AL["Rare"]..")";
		Next_Page = "SMBloodmageThalnos";
		Prev_Page = "SMAzshir";
		Back_Page = "DUNGEONSMENU1";
	};
	["SMBloodmageThalnos"] = {
		Title = AL["Bloodmage Thalnos"];
		Next_Page = "SMGTrash";
		Prev_Page = "SMFallenChampion";
		Back_Page = "DUNGEONSMENU1";
	};
	["SMGTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "SMBloodmageThalnos";
		Back_Page = "DUNGEONSMENU1";
	};
	["SMHoundmasterLoksey"] = {
		Title = AL["Houndmaster Loksey"];
		Next_Page = "SMBrotherWystan";
		Back_Page = "DUNGEONSMENU1";
	};
    ["SMBrotherWystan"] = {
		Title = AL["Brother Wystan"];
		Next_Page = "SMDoan";
        Prev_Page = "SMHoundmasterLoksey";
		Back_Page = "DUNGEONSMENU1";
	};
	["SMDoan"] = {
		Title = AL["Arcanist Doan"];
		Next_Page = "SMLTrash";
		Prev_Page = "SMBrotherWystan";
		Back_Page = "DUNGEONSMENU1";
	};
	["SMLTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "SMDoan";
		Back_Page = "DUNGEONSMENU1";
	};
	["SMHerod"] = {
		Title = AL["Herod"];
		Next_Page = "SMQuartermaster";
		Back_Page = "DUNGEONSMENU1";
	};
    ["SMQuartermaster"] = {
		Title = AL["Armory Quartermaster Daghelm"];
		Next_Page = "SMATrash";
        Prev_Page = "SMHerod";
		Back_Page = "DUNGEONSMENU1";
	};
	["SMATrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "SMQuartermaster";
		Back_Page = "DUNGEONSMENU1";
	};
	["SMFairbanks"] = {
		Title = AL["High Inquisitor Fairbanks"];
		Next_Page = "SMMograine";
		Back_Page = "DUNGEONSMENU1";
	};
	["SMMograine"] = {
		Title = AL["Scarlet Commander Mograine"];
		Next_Page = "SMWhitemane";
		Prev_Page = "SMFairbanks";
		Back_Page = "DUNGEONSMENU1";
	};
	["SMWhitemane"] = {
		Title = AL["High Inquisitor Whitemane"];
		Next_Page = "SMCTrash";
		Prev_Page = "SMMograine";
		Back_Page = "DUNGEONSMENU1";
	};
	["SMCTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "SMWhitemane";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Scholomance
	["SCHOLOBlood"] = {
		Title = AL["Blood Steward of Kirtonos"];
		Next_Page = "SCHOLOKirtonostheHerald";
		Back_Page = "DUNGEONSMENU1";
	};
	["SCHOLOKirtonostheHerald"] = {
		Title = AL["Kirtonos the Herald"];
		Next_Page = "SCHOLOJandiceBarov";
		--Prev_Page = "SCHOLOBlood";
		Back_Page = "DUNGEONSMENU1";
	};
	["SCHOLOJandiceBarov"] = {
		Title = AL["Jandice Barov"];
		Next_Page = "SCHOLOLordBlackwood";
		Prev_Page = "SCHOLOKirtonostheHerald";
		Back_Page = "DUNGEONSMENU1";
	};
	["SCHOLOLordBlackwood"] = {
		Title = AL["Lord Blackwood"].." ("..AL["Scourge Invasion"]..")";
		Next_Page = "SCHOLORattlegore";
		Prev_Page = "SCHOLOJandiceBarov";
		Back_Page = "DUNGEONSMENU1";
	};
	["SCHOLORattlegore"] = {
		Title = AL["Rattlegore"];
		Next_Page = "SCHOLODeathKnight";
		Prev_Page = "SCHOLOLordBlackwood";
		Back_Page = "DUNGEONSMENU1";
	};
	["SCHOLODeathKnight"] = {
		Title = AL["Death Knight Darkreaver"];
		Next_Page = "SCHOLOMarduk";
		Prev_Page = "SCHOLORattlegore";
		Back_Page = "DUNGEONSMENU1";
	};
	["SCHOLOMarduk"] = {
		Title = AL["Marduk Blackpool"];
		Next_Page = "SCHOLOVectus";
		Prev_Page = "SCHOLODeathKnight";
		Back_Page = "DUNGEONSMENU1";
	};
	["SCHOLOVectus"] = {
		Title = AL["Vectus"];
		Next_Page = "SCHOLORasFrostwhisper";
		Prev_Page = "SCHOLOMarduk";
		Back_Page = "DUNGEONSMENU1";
	};
	["SCHOLORasFrostwhisper"] = {
		Title = AL["Ras Frostwhisper"];
		Next_Page = "SCHOLOKormok";
		Prev_Page = "SCHOLOVectus";
		Back_Page = "DUNGEONSMENU1";
	};
	["SCHOLOKormok"] = {
		Title = AL["Kormok"];
		Next_Page = "SCHOLOInstructorMalicia";
		Prev_Page = "SCHOLORasFrostwhisper";
		Back_Page = "DUNGEONSMENU1";
	};
	["SCHOLOInstructorMalicia"] = {
		Title = AL["Instructor Malicia"];
		Next_Page = "SCHOLODoctorTheolenKrastinov";
		Prev_Page = "SCHOLOKormok";
		Back_Page = "DUNGEONSMENU1";
	};
	["SCHOLODoctorTheolenKrastinov"] = {
		Title = AL["Doctor Theolen Krastinov"];
		Next_Page = "SCHOLOLorekeeperPolkelt";
		Prev_Page = "SCHOLOInstructorMalicia";
		Back_Page = "DUNGEONSMENU1";
	};
	["SCHOLOLorekeeperPolkelt"] = {
		Title = AL["Lorekeeper Polkelt"];
		Next_Page = "SCHOLOTheRavenian";
		Prev_Page = "SCHOLODoctorTheolenKrastinov";
		Back_Page = "DUNGEONSMENU1";
	};
	["SCHOLOTheRavenian"] = {
		Title = AL["The Ravenian"];
		Next_Page = "SCHOLOLordAlexeiBarov";
		Prev_Page = "SCHOLOLorekeeperPolkelt";
		Back_Page = "DUNGEONSMENU1";
	};
	["SCHOLOLordAlexeiBarov"] = {
		Title = AL["Lord Alexei Barov"];
		Next_Page = "SCHOLOLadyIlluciaBarov";
		Prev_Page = "SCHOLOTheRavenian";
		Back_Page = "DUNGEONSMENU1";
	};
	["SCHOLOLadyIlluciaBarov"] = {
		Title = AL["Lady Illucia Barov"];
		Next_Page = "SCHOLODarkmasterGandling";
		Prev_Page = "SCHOLOLordAlexeiBarov";
		Back_Page = "DUNGEONSMENU1";
	};
	["SCHOLODarkmasterGandling"] = {
		Title = AL["Darkmaster Gandling"];
		Next_Page = "SCHOLOTrash";
		Prev_Page = "SCHOLOLadyIlluciaBarov";
		Back_Page = "DUNGEONSMENU1";
	};
	["SCHOLOTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "SCHOLODarkmasterGandling";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Shadowfang Keep
	["SFKRethilgore"] = {
		Title = AL["Rethilgore"];
		Next_Page = "SFKFelSteed";
		Back_Page = "DUNGEONSMENU1";
	};
	["SFKFelSteed"] = {
		Title = AL["Fel Steed"];
		Next_Page = "SFKRazorclawtheButcher";
		Prev_Page = "SFKRethilgore";
		Back_Page = "DUNGEONSMENU1";
	};
	["SFKRazorclawtheButcher"] = {
		Title = AL["Razorclaw the Butcher"];
		Next_Page = "SFKSilverlaine";
		Prev_Page = "SFKFelSteed";
		Back_Page = "DUNGEONSMENU1";
	};
	["SFKSilverlaine"] = {
		Title = AL["Baron Silverlaine"];
		Next_Page = "SFKSpringvale";
		Prev_Page = "SFKRazorclawtheButcher";
		Back_Page = "DUNGEONSMENU1";
	};
	["SFKSpringvale"] = {
		Title = AL["Commander Springvale"];
		Next_Page = "SFKSever";
		Prev_Page = "SFKSilverlaine";
		Back_Page = "DUNGEONSMENU1";
	};
	["SFKSever"] = {
		Title = AL["Sever"].." ("..AL["Scourge Invasion"]..")";
		Next_Page = "SFKOdotheBlindwatcher";
		Prev_Page = "SFKSpringvale";
		Back_Page = "DUNGEONSMENU1";
	};
	["SFKOdotheBlindwatcher"] = {
		Title = AL["Odo the Blindwatcher"];
		Next_Page = "SFKDeathswornCaptain";
		Prev_Page = "SFKSever";
		Back_Page = "DUNGEONSMENU1";
	};
	["SFKDeathswornCaptain"] = {
		Title = AL["Deathsworn Captain"].." ("..AL["Rare"]..")";
		Next_Page = "SFKFenrustheDevourer";
		Prev_Page = "SFKOdotheBlindwatcher";
		Back_Page = "DUNGEONSMENU1";
	};
	["SFKFenrustheDevourer"] = {
		Title = AL["Fenrus the Devourer"];
		Next_Page = "SFKArugalsVoidwalker";
		Prev_Page = "SFKDeathswornCaptain";
		Back_Page = "DUNGEONSMENU1";
	};
	["SFKArugalsVoidwalker"] = {
		Title = AL["Arugal's Voidwalker"];
		Next_Page = "SFKWolfMasterNandos";
		Prev_Page = "SFKFenrustheDevourer";
		Back_Page = "DUNGEONSMENU1";
	};
	["SFKWolfMasterNandos"] = {
		Title = AL["Wolf Master Nandos"];
		Next_Page = "SFKArchmageArugal";
		Prev_Page = "SFKArugalsVoidwalker";
		Back_Page = "DUNGEONSMENU1";
	};
	["SFKArchmageArugal"] = {
		Title = AL["Archmage Arugal"];
		Next_Page = "SFKPrelate";
		Prev_Page = "SFKWolfMasterNandos";
		Back_Page = "DUNGEONSMENU1";
	};
    ["SFKPrelate"] = {
		Prev_Page = "SFKArchmageArugal";
		Title = AL["Prelate Ironmane"];
        Next_Page = "SFKTrash";
		Back_Page = "DUNGEONSMENU1";
	};
	["SFKTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "SFKPrelate";
		Back_Page = "DUNGEONSMENU1";
	};
	-- The Stockade
	["SWStTargorr"] = {
		Title = AL["Targorr the Dread"];
		Next_Page = "SWStKamDeepfury";
		Back_Page = "DUNGEONSMENU1";
	};
	["SWStKamDeepfury"] = {
		Title = AL["Kam Deepfury"];
		Next_Page = "SWStHamhock";
		Prev_Page = "SWStTargorr";
		Back_Page = "DUNGEONSMENU1";
	};
	["SWStHamhock"] = {
		Title = AL["Hamhock"];
		Next_Page = "SWStDextren";
		Prev_Page = "SWStKamDeepfury";
		Back_Page = "DUNGEONSMENU1";
	};
	["SWStDextren"] = {
		Title = AL["Dextren Ward"];
		Next_Page = "SWStBazil";
		Prev_Page = "SWStHamhock";
		Back_Page = "DUNGEONSMENU1";
	};
	["SWStBazil"] = {
		Title = AL["Bazil Thredd"];
		Next_Page = "SWStBruegalIronknuckle";
		Prev_Page = "SWStDextren";
		Back_Page = "DUNGEONSMENU1";
	};
	["SWStBruegalIronknuckle"] = {
		Title = AL["Bruegal Ironknuckle"].." ("..AL["Rare"]..")";
		Next_Page = "SWStTrash";
		Prev_Page = "SWStBazil";
		Back_Page = "DUNGEONSMENU1";
	};
	["SWStTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "SWStBruegalIronknuckle";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Stratholme
	["STRATSkull"] = {
		Title = AL["Skul"].." ("..AL["Rare"]..")";
		Next_Page = "STRATStratholmeCourier";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATStratholmeCourier"] = {
		Title = AL["Stratholme Courier"];
		Next_Page = "STRATPostmaster";
		Prev_Page = "STRATSkull";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATPostmaster"] = {
		Title = AL["Postmaster Malown"];
		Next_Page = "STRATFrasSiabi";
		Prev_Page = "STRATStratholmeCourier";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATFrasSiabi"] = {
		Title = AL["Fras Siabi"];
		Next_Page = "STRATAtiesh";
		Prev_Page = "STRATPostmaster";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATAtiesh"] = {
		Title = AL["Atiesh"];
		Next_Page = "STRATBalzaphon";
		Prev_Page = "STRATFrasSiabi";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATBalzaphon"] = {
		Title = AL["Balzaphon"].." ("..AL["Scourge Invasion"]..")";
		Next_Page = "STRATHearthsingerForresten";
		Prev_Page = "STRATAtiesh";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATHearthsingerForresten"] = {
		Title = AL["Hearthsinger Forresten"].." ("..AL["Rare"]..")";
		Next_Page = "STRATTheUnforgiven";
		Prev_Page = "STRATBalzaphon";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATTheUnforgiven"] = {
		Title = AL["The Unforgiven"];
		Next_Page = "STRATTimmytheCruel";
		Prev_Page = "STRATHearthsingerForresten";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATTimmytheCruel"] = {
		Title = AL["Timmy the Cruel"];
		Next_Page = "STRATMalor";
		Prev_Page = "STRATTheUnforgiven";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATMalor"] = {
		Title = AL["Malor the Zealous"];
		Next_Page = "STRATMalorsStrongbox";
		Prev_Page = "STRATTimmytheCruel";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATMalorsStrongbox"] = {
		Title = AL["Malor's Strongbox"];
		Next_Page = "STRATCrimsonHammersmith";
		Prev_Page = "STRATMalor";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATCrimsonHammersmith"] = {
		Title = AL["Crimson Hammersmith"];
		Next_Page = "STRATCannonMasterWilley";
		Prev_Page = "STRATMalorsStrongbox";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATCannonMasterWilley"] = {
		Title = AL["Cannon Master Willey"];
		Next_Page = "STRATArchivistGalford";
		Prev_Page = "STRATCrimsonHammersmith";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATArchivistGalford"] = {
		Title = AL["Archivist Galford"];
		Next_Page = "STRATBalnazzar";
		Prev_Page = "STRATCannonMasterWilley";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATBalnazzar"] = {
		Title = AL["Balnazzar"];
		Next_Page = "STRATSothosJarien";
		Prev_Page = "STRATArchivistGalford";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATSothosJarien"] = {
		Title = AL["Sothos"].." & "..AL["Jarien"];
		Next_Page = "STRATStonespine";
		Prev_Page = "STRATBalnazzar";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATStonespine"] = {
		Title = AL["Stonespine"].." ("..AL["Rare"]..")";
		Next_Page = "STRATBaronessAnastari";
		Prev_Page = "STRATSothosJarien";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATBaronessAnastari"] = {
		Title = AL["Baroness Anastari"];
		Next_Page = "STRATBlackGuardSwordsmith";
		Prev_Page = "STRATStonespine";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATBlackGuardSwordsmith"] = {
		Title = AL["Black Guard Swordsmith"];
		Next_Page = "STRATNerubenkan";
		Prev_Page = "STRATBaronessAnastari";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATNerubenkan"] = {
		Title = AL["Nerub'enkan"];
		Next_Page = "STRATMalekithePallid";
		Prev_Page = "STRATBlackGuardSwordsmith";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATMalekithePallid"] = {
		Title = AL["Maleki the Pallid"];
		Next_Page = "STRATMagistrateBarthilas";
		Prev_Page = "STRATNerubenkan";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATMagistrateBarthilas"] = {
		Title = AL["Magistrate Barthilas"];
		Next_Page = "STRATRamsteintheGorger";
		Prev_Page = "STRATMalekithePallid";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATRamsteintheGorger"] = {
		Title = AL["Ramstein the Gorger"];
		Next_Page = "STRATBaronRivendare";
		Prev_Page = "STRATMagistrateBarthilas";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATBaronRivendare"] = {
		Title = AL["Baron Rivendare"];
		Next_Page = "STRATTrash";
		Prev_Page = "STRATRamsteintheGorger";
		Back_Page = "DUNGEONSMENU1";
	};
	["STRATTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "STRATBaronRivendare";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Sunken Temple
	["STBalconyMinibosses"] = {
		Title = AL["Balcony Minibosses"];
		Next_Page = "STAtalalarion";
		Back_Page = "DUNGEONSMENU1";
	};
	["STAtalalarion"] = {
		Title = AL["Atal'alarion"];
		Next_Page = "STSpawnOfHakkar";
		Prev_Page = "STBalconyMinibosses";
		Back_Page = "DUNGEONSMENU1";
	};
	["STSpawnOfHakkar"] = {
		Title = AL["Spawn of Hakkar"];
		Next_Page = "STAvatarofHakkar";
		Prev_Page = "STAtalalarion";
		Back_Page = "DUNGEONSMENU1";
	};
	["STAvatarofHakkar"] = {
		Title = AL["Avatar of Hakkar"];
		Next_Page = "STJammalan";
		Prev_Page = "STSpawnOfHakkar";
		Back_Page = "DUNGEONSMENU1";
	};
	["STJammalan"] = {
		Title = AL["Jammal'an the Prophet"];
		Next_Page = "STOgom";
		Prev_Page = "STAvatarofHakkar";
		Back_Page = "DUNGEONSMENU1";
	};
	["STOgom"] = {
		Title = AL["Ogom the Wretched"];
		Next_Page = "STDreamscythe";
		Prev_Page = "STJammalan";
		Back_Page = "DUNGEONSMENU1";
	};
	["STDreamscythe"] = {
		Title = AL["Dreamscythe"];
		Next_Page = "STWeaver";
		Prev_Page = "STOgom";
		Back_Page = "DUNGEONSMENU1";
	};
	["STWeaver"] = {
		Title = AL["Weaver"];
		Next_Page = "STMorphaz";
		Prev_Page = "STDreamscythe";
		Back_Page = "DUNGEONSMENU1";
	};
	["STMorphaz"] = {
		Title = AL["Morphaz"];
		Next_Page = "STHazzas";
		Prev_Page = "STWeaver";
		Back_Page = "DUNGEONSMENU1";
	};
	["STHazzas"] = {
		Title = AL["Hazzas"];
		Next_Page = "STEranikus";
		Prev_Page = "STMorphaz";
		Back_Page = "DUNGEONSMENU1";
	};
	["STEranikus"] = {
		Title = AL["Shade of Eranikus"];
		Next_Page = "STTrash";
		Prev_Page = "STHazzas";
		Back_Page = "DUNGEONSMENU1";
	};
	["STTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "STEranikus";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Uldaman
	["UldBaelog"] = {
		Title = AL["Baelog"];
		Next_Page = "UldOlaf";
		Back_Page = "DUNGEONSMENU1";
	};
	["UldOlaf"] = {
		Title = AL["Olaf"];
		Next_Page = "UldEric";
		Prev_Page = "UldBaelog";
		Back_Page = "DUNGEONSMENU1";
	};
	["UldEric"] = {
		Title = AL["Eric 'The Swift'"];
		Next_Page = "UldRevelosh";
		Prev_Page = "UldOlaf";
		Back_Page = "DUNGEONSMENU1";
	};
	["UldRevelosh"] = {
		Title = AL["Revelosh"];
		Next_Page = "UldIronaya";
		Prev_Page = "UldEric";
		Back_Page = "DUNGEONSMENU1";
	};
	["UldIronaya"] = {
		Title = AL["Ironaya"];
		Next_Page = "UldAncientStoneKeeper";
		Prev_Page = "UldRevelosh";
		Back_Page = "DUNGEONSMENU1";
	};
	["UldAncientStoneKeeper"] = {
		Title = AL["Ancient Stone Keeper"];
		Next_Page = "UldGalgannFirehammer";
		Prev_Page = "UldIronaya";
		Back_Page = "DUNGEONSMENU1";
	};
	["UldGalgannFirehammer"] = {
		Title = AL["Galgann Firehammer"];
		Next_Page = "UldGrimlok";
		Prev_Page = "UldAncientStoneKeeper";
		Back_Page = "DUNGEONSMENU1";
	};
	["UldGrimlok"] = {
		Title = AL["Grimlok"];
		Next_Page = "UldArchaedas";
		Prev_Page = "UldGalgannFirehammer";
		Back_Page = "DUNGEONSMENU1";
	};
	["UldArchaedas"] = {
		Title = AL["Archaedas"];
		Next_Page = "UldTrash";
		Prev_Page = "UldGrimlok";
		Back_Page = "DUNGEONSMENU1";
	};
	["UldTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "UldArchaedas";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Zul'Gurub
	["ZGJeklik"] = {
		Title = AL["High Priestess Jeklik"];
		Next_Page = "ZGVenoxis";
		Back_Page = "DUNGEONSMENU2";
	};
	["ZGVenoxis"] = {
		Title = AL["High Priest Venoxis"];
		Next_Page = "ZGMarli";
		Prev_Page = "ZGJeklik";
		Back_Page = "DUNGEONSMENU2";
	};
	["ZGMarli"] = {
		Title = AL["High Priestess Mar'li"];
		Next_Page = "ZGMandokir";
		Prev_Page = "ZGVenoxis";
		Back_Page = "DUNGEONSMENU2";

	};
	["ZGMandokir"] = {
		Title = AL["Bloodlord Mandokir"];
		Next_Page = "ZGGrilek";
		Prev_Page = "ZGMarli";
		Back_Page = "DUNGEONSMENU2";
	};
	["ZGGrilek"] = {
		Title = AL["Gri'lek"];
		Next_Page = "ZGHazzarah";
		Prev_Page = "ZGMandokir";
		Back_Page = "DUNGEONSMENU2";
	};
	["ZGHazzarah"] = {
		Title = AL["Hazza'rah"];
		Next_Page = "ZGRenataki";
		Prev_Page = "ZGGrilek";
		Back_Page = "DUNGEONSMENU2";
	};
	["ZGRenataki"] = {
		Title = AL["Renataki"];
		Next_Page = "ZGWushoolay";
		Prev_Page = "ZGHazzarah";
		Back_Page = "DUNGEONSMENU2";
	};
	["ZGWushoolay"] = {
		Title = AL["Wushoolay"];
		Next_Page = "ZGGahzranka";
		Prev_Page = "ZGRenataki";
		Back_Page = "DUNGEONSMENU2";
	};
	["ZGGahzranka"] = {
		Title = AL["Gahz'ranka"];
		Next_Page = "ZGThekal";
		Prev_Page = "ZGWushoolay";
		Back_Page = "DUNGEONSMENU2";
	};
	["ZGThekal"] = {
		Title = AL["High Priest Thekal"];
		Next_Page = "ZGArlokk";
		Prev_Page = "ZGGahzranka";
		Back_Page = "DUNGEONSMENU2";
	};
	["ZGArlokk"] = {
		Title = AL["High Priestess Arlokk"];
		Next_Page = "ZGJindo";
		Prev_Page = "ZGThekal";
		Back_Page = "DUNGEONSMENU2";
	};
	["ZGJindo"] = {
		Title = AL["Jin'do the Hexxer"];
		Next_Page = "ZGHakkar";
		Prev_Page = "ZGArlokk";
		Back_Page = "DUNGEONSMENU2";
	};
	["ZGHakkar"] = {
		Title = AL["Hakkar"];
		Next_Page = "ZGShared";
		Prev_Page = "ZGJindo";
		Back_Page = "DUNGEONSMENU2";
	};
	["ZGShared"] = {
		Title = AL["Random Boss Loot"];
		Next_Page = "ZGTrash1";
		Prev_Page = "ZGHakkar";
		Back_Page = "DUNGEONSMENU2";
	};
	["ZGTrash1"] = {
		Title = AL["Trash Mobs"];
		Next_Page = "ZGTrash2";
		Prev_Page = "ZGShared";
		Back_Page = "DUNGEONSMENU2";
	};
	["ZGTrash2"] = {
		Title = AL["Trash Mobs"];
		Next_Page = "ZGEnchants";
		Prev_Page = "ZGTrash1";
		Back_Page = "DUNGEONSMENU2";
	};
	["ZGEnchants"] = {
		Title = AL["ZG Enchants"];
		Prev_Page = "ZGTrash2";
		Back_Page = "DUNGEONSMENU2";
	};
	-- Blackfathom Deeps
	["BFDGhamoora"] = {
		Title = AL["Ghamoo-ra"];
		Next_Page = "BFDLadySarevess";
		Back_Page = "DUNGEONSMENU1";
	};
	["BFDLadySarevess"] = {
		Title = AL["Lady Sarevess"];
		Next_Page = "BFDGelihast";
		Prev_Page = "BFDGhamoora";
		Back_Page = "DUNGEONSMENU1";
	};
	["BFDGelihast"] = {
		Title = AL["Gelihast"];
		Next_Page = "BFDBaronAquanis";
		Prev_Page = "BFDLadySarevess";
		Back_Page = "DUNGEONSMENU1";
	};
	["BFDBaronAquanis"] = {
		Title = AL["Baron Aquanis"];
		Next_Page = "BFDVelthelaxx";
		Prev_Page = "BFDGelihast";
		Back_Page = "DUNGEONSMENU1";
	};
	["BFDVelthelaxx"] = {
		Title = AL["Velthelaxx the Defiler"],
		Prev_Page = "BFDBaronAquanis",
		Next_Page = "BFDTwilightLordKelris",
		Back_Page = "DUNGEONSMENU1",
	};
	["BFDTwilightLordKelris"] = {
		Title = AL["Twilight Lord Kelris"];
		Next_Page = "BFDOldSerrakis";
		Prev_Page = "BFDVelthelaxx";
		Back_Page = "DUNGEONSMENU1";
	};
	["BFDOldSerrakis"] = {
		Title = AL["Old Serra'kis"];
		Next_Page = "BFDAkumai";
		Prev_Page = "BFDTwilightLordKelris";
		Back_Page = "DUNGEONSMENU1";
	};
	["BFDAkumai"] = {
		Title = AL["Aku'mai"];
		Next_Page = "BFDTrash";
		Prev_Page = "BFDOldSerrakis";
		Back_Page = "DUNGEONSMENU1";
	};
	["BFDTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "BFDAkumai";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Dire Maul East
	["DMEPusillin"] = {
		Title = AL["Pusillin"];
		Next_Page = "DMEZevrimThornhoof";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMEZevrimThornhoof"] = {
		Title = AL["Zevrim Thornhoof"];
		Next_Page = "DMEHydro";
		Prev_Page = "DMEPusillin";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMEHydro"] = {
		Title = AL["Hydrospawn"];
		Next_Page = "DMELethtendris";
		Prev_Page = "DMEZevrimThornhoof";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMELethtendris"] = {
		Title = AL["Lethtendris"];
		Next_Page = "DMEPimgib";
		Prev_Page = "DMEHydro";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMEPimgib"] = {
		Title = AL["Pimgib"];
		Next_Page = "DMEIsalien";
		Prev_Page = "DMELethtendris";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMEIsalien"] = {
		Title = AL["Isalien"];
		Next_Page = "DMEAlzzin";
		Prev_Page = "DMEPimgib";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMEAlzzin"] = {
		Title = AL["Alzzin the Wildshaper"];
		Next_Page = "DMETrash";
		Prev_Page = "DMEIsalien";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMETrash"] = {
		Title = AL["Trash Mobs"];
		Next_Page = "DMEBooks";
		Prev_Page = "DMEAlzzin";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMEBooks"] = {
		Title = AL["Dire Maul Books"];
		Prev_Page = "DMETrash";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Dire Maul West
	["DMWTendrisWarpwood"] = {
		Title = AL["Tendris Warpwood"];
		Next_Page = "DMWIllyannaRavenoak";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMWIllyannaRavenoak"] = {
		Title = AL["Illyanna Ravenoak"];
		Next_Page = "DMWMagisterKalendris";
		Prev_Page = "DMWTendrisWarpwood";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMWMagisterKalendris"] = {
		Title = AL["Magister Kalendris"];
		Next_Page = "DMWTsuzee";
		Prev_Page = "DMWIllyannaRavenoak";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMWTsuzee"] = {
		Title = AL["Tsu'zee"].." ("..AL["Rare"]..")";
		Next_Page = "DMWRevanchion";
		Prev_Page = "DMWMagisterKalendris";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMWRevanchion"] = {
		Title = AL["Revanchion"].." ("..AL["Scourge Invasion"]..")";
		Next_Page = "DMWImmolthar";
		Prev_Page = "DMWTsuzee";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMWImmolthar"] = {
		Title = AL["Immol'thar"];
		Next_Page = "DMWHelnurath";
		Prev_Page = "DMWRevanchion";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMWHelnurath"] = {
		Title = AL["Lord Hel'nurath"].." ("..AL["Rare"]..")";
		Next_Page = "DMWPrinceTortheldrin";
		Prev_Page = "DMWImmolthar";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMWPrinceTortheldrin"] = {
		Title = AL["Prince Tortheldrin"];
		Next_Page = "DMWTrash";
		Prev_Page = "DMWHelnurath";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMWTrash"] = {
		Title = AL["Trash Mobs"];
		Next_Page = "DMWBooks";
		Prev_Page = "DMWPrinceTortheldrin";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMWBooks"] = {
		Title = AL["Dire Maul Books"];
		Prev_Page = "DMWTrash";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Dire Maul North
	["DMNGuardMoldar"] = {
		Title = AL["Guard Mol'dar"];
		Next_Page = "DMNStomperKreeg";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMNStomperKreeg"] = {
		Title = AL["Stomper Kreeg"];
		Next_Page = "DMNGuardFengus";
		Prev_Page = "DMNGuardMoldar";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMNGuardFengus"] = {
		Title = AL["Guard Fengus"];
		Next_Page = "DMNThimblejack";
		Prev_Page = "DMNStomperKreeg";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMNThimblejack"] = {
		Title = AL["Knot Thimblejack"];
		Next_Page = "DMNGuardSlipkik";
		Prev_Page = "DMNGuardFengus";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMNGuardSlipkik"] = {
		Title = AL["Guard Slip'kik"];
		Next_Page = "DMNCaptainKromcrush";
		Prev_Page = "DMNThimblejack";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMNCaptainKromcrush"] = {
		Title = AL["Captain Kromcrush"];
		Next_Page = "DMNChoRush";
		Prev_Page = "DMNGuardSlipkik";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMNChoRush"] = {
		Title = AL["Cho'Rush the Observer"];
		Next_Page = "DMNKingGordok";
		Prev_Page = "DMNCaptainKromcrush";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMNKingGordok"] = {
		Title = AL["King Gordok"];
		Next_Page = "DMNTRIBUTERUN";
		Prev_Page = "DMNChoRush";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMNTRIBUTERUN"] = {
		Title = AL["Tribute Run"];
		Next_Page = "DMNTrash";
		Prev_Page = "DMNKingGordok";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMNTrash"] = {
		Title = AL["Trash Mobs"];
		Next_Page = "DMNBooks";
		Prev_Page = "DMNTRIBUTERUN";
		Back_Page = "DUNGEONSMENU1";
	};
	["DMNBooks"] = {
		Title = AL["Dire Maul Books"];
		Prev_Page = "DMNTrash";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Maraudon
	["MaraNoxxion"] = {
		Title = AL["Noxxion"];
		Next_Page = "MaraRazorlash";
		Back_Page = "DUNGEONSMENU1";
	};
	["MaraRazorlash"] = {
		Title = AL["Razorlash"];
		Next_Page = "MaraLordVyletongue";
		Prev_Page = "MaraNoxxion";
		Back_Page = "DUNGEONSMENU1";
	};
	["MaraLordVyletongue"] = {
		Title = AL["Lord Vyletongue"];
		Next_Page = "MaraMeshlok";
		Prev_Page = "MaraRazorlash";
		Back_Page = "DUNGEONSMENU1";
	};
	["MaraMeshlok"] = {
		Title = AL["Meshlok the Harvester"].." ("..AL["Rare"]..")";
		Next_Page = "MaraCelebras";
		Prev_Page = "MaraLordVyletongue";
		Back_Page = "DUNGEONSMENU1";
	};
	["MaraCelebras"] = {
		Title = AL["Celebras the Cursed"];
		Next_Page = "MaraLandslide";
		Prev_Page = "MaraMeshlok";
		Back_Page = "DUNGEONSMENU1";
	};
	["MaraLandslide"] = {
		Title = AL["Landslide"];
		Next_Page = "MaraTinkererGizlock";
		Prev_Page = "MaraCelebras";
		Back_Page = "DUNGEONSMENU1";
	};
	["MaraTinkererGizlock"] = {
		Title = AL["Tinkerer Gizlock"];
		Next_Page = "MaraRotgrip";
		Prev_Page = "MaraLandslide";
		Back_Page = "DUNGEONSMENU1";
	};
	["MaraRotgrip"] = {
		Title = AL["Rotgrip"];
		Next_Page = "MaraPrincessTheradras";
		Prev_Page = "MaraTinkererGizlock";
		Back_Page = "DUNGEONSMENU1";
	};
	["MaraPrincessTheradras"] = {
		Title = AL["Princess Theradras"];
		Next_Page = "MaraTrash";
		Prev_Page = "MaraRotgrip";
		Back_Page = "DUNGEONSMENU1";
	};
	["MaraTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "MaraPrincessTheradras";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Ragefire Chasm
	["RFCTaragaman"] = {
		Title = AL["Taragaman the Hungerer"];
		Next_Page = "RFCOggleflint";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFCOggleflint"] = {
		Title = AL["Oggleflint"];
		Next_Page = "RFCJergosh";
		Prev_Page = "RFCTaragaman";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFCJergosh"] = {
		Title = AL["Jergosh the Invoker"];
		Next_Page = "RFCBazzalan";
		Prev_Page = "RFCOggleflint";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFCBazzalan"] = {
		Title = AL["Bazzalan"];
		Prev_Page = "RFCJergosh";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Razorfen Downs
	["RFDTutenkash"] = {
		Title = AL["Tuten'kash"];
		Next_Page = "RFDLadyF";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFDLadyF"] = {
		Title = AL["Lady Falther'ess"].." ("..AL["Scourge Invasion"]..")";
		Next_Page = "RFDPlaguemaw";
		Prev_Page = "RFDTutenkash";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFDPlaguemaw"] = {
		Title = AL["Plaguemaw the Rotting"];
		Next_Page = "RFDMordreshFireEye";
		Prev_Page = "RFDLadyF";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFDMordreshFireEye"] = {
		Title = AL["Mordresh Fire Eye"];
		Next_Page = "RFDGlutton";
		Prev_Page = "RFDPlaguemaw";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFDGlutton"] = {
		Title = AL["Glutton"];
		Next_Page = "RFDDeathProphet";
		Prev_Page = "RFDMordreshFireEye";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFDDeathProphet"] = {
		Title = AL["Death Prophet Rakameg"],
		Next_Page = "RFDRagglesnout";
		Prev_Page = "RFDGlutton";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFDRagglesnout"] = {
		Title = AL["Ragglesnout"].." ("..AL["Rare"]..")";
		Next_Page = "RFDAmnennar";
		Prev_Page = "RFDDeathProphet";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFDAmnennar"] = {
		Title = AL["Amnennar the Coldbringer"];
		Next_Page = "RFDTrash";
		Prev_Page = "RFDRagglesnout";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFDTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "RFDAmnennar";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Razorfen Kraul
	["RFKAggem"] = {
		Title = AL["Aggem Thorncurse"];
		Next_Page = "RFKDeathSpeakerJargba";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFKDeathSpeakerJargba"] = {
		Title = AL["Death Speaker Jargba"];
		Next_Page = "RFKOverlordRamtusk";
		Prev_Page = "RFKAggem";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFKOverlordRamtusk"] = {
		Title = AL["Overlord Ramtusk"];
		Next_Page = "RFKRazorfenSpearhide";
		Prev_Page = "RFKDeathSpeakerJargba";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFKRazorfenSpearhide"] = {
		Title = AL["Razorfen Spearhide"].." ("..AL["Rare"]..")";
		Next_Page = "RFKAgathelos";
		Prev_Page = "RFKOverlordRamtusk";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFKAgathelos"] = {
		Title = AL["Agathelos the Raging"];
		Next_Page = "RFKBlindHunter";
		Prev_Page = "RFKRazorfenSpearhide";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFKBlindHunter"] = {
		Title = AL["Blind Hunter"].." ("..AL["Rare"]..")";
		Next_Page = "RFKCharlgaRazorflank";
		Prev_Page = "RFKAgathelos";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFKCharlgaRazorflank"] = {
		Title = AL["Charlga Razorflank"];
		Next_Page = "RFKEarthcallerHalmgar";
		Prev_Page = "RFKBlindHunter";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFKEarthcallerHalmgar"] = {
		Title = AL["Earthcaller Halmgar"].." ("..AL["Rare"]..")";
		Next_Page = "RFKRotthorn";
		Prev_Page = "RFKCharlgaRazorflank";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFKRotthorn"] = {
		Title = AL["Rotthorn"],
		Next_Page = "RFKTrash";
		Prev_Page = "RFKEarthcallerHalmgar";
		Back_Page = "DUNGEONSMENU1";
	};
	["RFKTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "RFKRotthorn";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Ruins of Ahn'Qiraj
	["AQ20Kurinnaxx"] = {
		Title = AL["Kurinnaxx"];
		Next_Page = "AQ20Andorov";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ20Andorov"] = {
		Title = AL["Lieutenant General Andorov"];
		Next_Page = "AQ20CAPTAIN";
		Prev_Page = "AQ20Kurinnaxx";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ20CAPTAIN"] = {
		Title = AL["Rajaxx's Captains"];
		Next_Page = "AQ20Rajaxx";
		Prev_Page = "AQ20Andorov";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ20Rajaxx"] = {
		Title = AL["General Rajaxx"];
		Next_Page = "AQ20Moam";
		Prev_Page = "AQ20CAPTAIN";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ20Moam"] = {
		Title = AL["Moam"];
		Next_Page = "AQ20Buru";
		Prev_Page = "AQ20Rajaxx";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ20Buru"] = {
		Title = AL["Buru the Gorger"];
		Next_Page = "AQ20Ayamiss";
		Prev_Page = "AQ20Moam";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ20Ayamiss"] = {
		Title = AL["Ayamiss the Hunter"];
		Next_Page = "AQ20Ossirian";
		Prev_Page = "AQ20Buru";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ20Ossirian"] = {
		Title = AL["Ossirian the Unscarred"];
		Next_Page = "AQ20Trash";
		Prev_Page = "AQ20Ayamiss";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ20Trash"] = {
		Title = AL["Trash Mobs"];
		Next_Page = "AQ20ClassBooks";
		Prev_Page = "AQ20Ossirian";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ20ClassBooks"] = {
		Title = AL["Class Books"];
		Next_Page = "AQ20Enchants";
		Prev_Page = "AQ20Trash";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ20Enchants"] = {
		Title = AL["AQ Enchants"];
		Prev_Page = "AQ20ClassBooks";
		Back_Page = "DUNGEONSMENU2";
	};
	-- Temple of Ahn'Qiraj
	["AQ40Skeram"] = {
		Title = AL["The Prophet Skeram"];
		Next_Page = "AQ40Trio";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ40Trio"] = {
		Title = AL["The Bug Family"];
		Next_Page = "AQ40Sartura";
		Prev_Page = "AQ40Skeram";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ40Sartura"] = {
		Title = AL["Battleguard Sartura"];
		Next_Page = "AQ40Fankriss";
		Prev_Page = "AQ40Trio";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ40Fankriss"] = {
		Title = AL["Fankriss the Unyielding"];
		Next_Page = "AQ40Viscidus";
		Prev_Page = "AQ40Sartura";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ40Viscidus"] = {
		Title = AL["Viscidus"];
		Next_Page = "AQ40Huhuran";
		Prev_Page = "AQ40Fankriss";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ40Huhuran"] = {
		Title = AL["Princess Huhuran"];
		Next_Page = "AQ40Emperors";
		Prev_Page = "AQ40Viscidus";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ40Emperors"] = {
		Title = AL["The Twin Emperors"];
		Next_Page = "AQ40Ouro";
		Prev_Page = "AQ40Huhuran";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ40Ouro"] = {
		Title = AL["Ouro"];
		Next_Page = "AQ40CThun";
		Prev_Page = "AQ40Emperors";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ40CThun"] = {
		Title = AL["C'Thun"];
		Next_Page = "AQ40Trash1";
		Prev_Page = "AQ40Ouro";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ40Trash1"] = {
		Title = AL["Trash Mobs"];
		Next_Page = "AQ40Trash2";
		Prev_Page = "AQ40CThun";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQ40Trash2"] = {
		Title = AL["Trash Mobs"];
		Next_Page = "AQEnchants";
		Prev_Page = "AQ40Trash1";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQEnchants"] = {
		Title = AL["AQ Enchants"];
		Next_Page = "AQOpening";
		Prev_Page = "AQ40Trash2";
		Back_Page = "DUNGEONSMENU2";
	};
	["AQOpening"] = {
		Title = AL["AQ Opening Quest Chain"];
		Prev_Page = "AQEnchants";
		Back_Page = "DUNGEONSMENU2";
	};
	-- Wailing Caverns
	["WCLordCobrahn"] = {
		Title = AL["Lord Cobrahn"];
		Next_Page = "WCLadyAnacondra";
		Back_Page = "DUNGEONSMENU1";
	};
	["WCLadyAnacondra"] = {
		Title = AL["Lady Anacondra"];
		Next_Page = "WCKresh";
		Prev_Page = "WCLordCobrahn";
		Back_Page = "DUNGEONSMENU1";
	};
	["WCKresh"] = {
		Title = AL["Kresh"];
		Next_Page = "WCDeviateFaerieDragon";
		Prev_Page = "WCLadyAnacondra";
		Back_Page = "DUNGEONSMENU1";
	};
	["WCDeviateFaerieDragon"] = {
		Title = AL["Deviate Faerie Dragon"].." ("..AL["Rare"]..")";
		Next_Page = "WCZandara";
		Prev_Page = "WCKresh";
		Back_Page = "DUNGEONSMENU1";
	};
    ["WCZandara"] = {
		Title = AL["Zandara Windhoof"];
		Next_Page = "WCLordPythas";
		Prev_Page = "WCDeviateFaerieDragon";
		Back_Page = "DUNGEONSMENU1";
    };
	["WCLordPythas"] = {
		Title = AL["Lord Pythas"];
		Next_Page = "WCSkum";
		Prev_Page = "WCZandara";
		Back_Page = "DUNGEONSMENU1";
	};
	["WCSkum"] = {
		Title = AL["Skum"];
		Next_Page = "WCVangros";
		Prev_Page = "WCLordPythas";
		Back_Page = "DUNGEONSMENU1";
	};
    ["WCVangros"] = {
		Title = AL["Vangros"];
		Next_Page = "WCLordSerpentis";
		Prev_Page = "WCSkum";
		Back_Page = "DUNGEONSMENU1";
	};
	["WCLordSerpentis"] = {
		Title = AL["Lord Serpentis"];
		Next_Page = "WCVerdan";
		Prev_Page = "WCVangros";
		Back_Page = "DUNGEONSMENU1";
	};
	["WCVerdan"] = {
		Title = AL["Verdan the Everliving"];
		Next_Page = "WCMutanus";
		Prev_Page = "WCLordSerpentis";
		Back_Page = "DUNGEONSMENU1";
	};
	["WCMutanus"] = {
		Title = AL["Mutanus the Devourer"];
		Next_Page = "WCTrash";
		Prev_Page = "WCVerdan";
		Back_Page = "DUNGEONSMENU1";
	};
	["WCTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "WCMutanus";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Zul'Farrak
	["ZFAntusul"] = {
		Title = AL["Antu'sul"];
		Next_Page = "ZFWitchDoctorZumrah";
		Back_Page = "DUNGEONSMENU1";
	};
	["ZFWitchDoctorZumrah"] = {
		Title = AL["Witch Doctor Zum'rah"];
		Next_Page = "ZFSezzziz";
		Prev_Page = "ZFAntusul";
		Back_Page = "DUNGEONSMENU1";
	};
	["ZFSezzziz"] = {
		Title = AL["Shadowpriest Sezz'ziz"];
		Next_Page = "ZFDustwraith";
		Prev_Page = "ZFWitchDoctorZumrah";
		Back_Page = "DUNGEONSMENU1";
	};
	["ZFDustwraith"] = {
		Title = AL["Dustwraith"].." ("..AL["Rare"]..")";
		Next_Page = "ZFZerillis";
		Prev_Page = "ZFSezzziz";
		Back_Page = "DUNGEONSMENU1";
	};
	["ZFZerillis"] = {
		Title = AL["Zerillis"].." ("..AL["Rare"]..")";
		Next_Page = "ZFGahzrilla";
		Prev_Page = "ZFDustwraith";
		Back_Page = "DUNGEONSMENU1";
	};
	["ZFGahzrilla"] = {
		Title = AL["Gahz'rilla"];
		Next_Page = "ZFChiefUkorzSandscalp";
		Prev_Page = "ZFZerillis";
		Back_Page = "DUNGEONSMENU1";
	};
	["ZFChiefUkorzSandscalp"] = {
		Title = AL["Chief Ukorz Sandscalp"];
		Next_Page = "ZFZeljeb";
		Prev_Page = "ZFGahzrilla";
		Back_Page = "DUNGEONSMENU1";
	};
	["ZFZeljeb"] = {
		Title = AL["Zel'jeb the Ancient"],
		Prev_Page = "ZFChiefUkorzSandscalp",
		Next_Page = "ZFChampion",
		Back_Page = "DUNGEONSMENU1",
	};
	["ZFChampion"] = {
		Title = AL["Champion Razjal the Quick"],
		Prev_Page = "ZFZeljeb",
		Next_Page = "ZFTrash",
		Back_Page = "DUNGEONSMENU1",
	};
	["ZFTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "ZFChampion";
		Back_Page = "DUNGEONSMENU1";
	};
	-- Emerald Sanctum
	["ESErennius"] = {
		Title = AL["Erennius"];
		Next_Page = "ESSolnius1";
		Back_Page = "DUNGEONSMENU2";
	};
	["ESSolnius1"] = {
		Title = AL["Solnius the Awakener"];
		Next_Page = "ESHardMode";
		Prev_Page = "ESErennius";
		Back_Page = "DUNGEONSMENU2";
	};
	["ESHardMode"] = {
		Title = AL["Favor of Erennius (ES Hard Mode)"];
		Next_Page = "ESTrash";
		Prev_Page = "ESSolnius1";
		Back_Page = "DUNGEONSMENU2";
	};
	["ESTrash"] = {
		Title = AL["Trash Mobs"];
		Prev_Page = "ESHardMode";
		Back_Page = "DUNGEONSMENU2";
	};
	-- Lower Karazhan Halls
	["LKHRolfen"] = {
		Title = AL["Master Blacksmith Rolfen"];
		Next_Page = "LKHBroodQueenAraxxna";
		Back_Page = "DUNGEONSMENU2";
	};
	["LKHBroodQueenAraxxna"] = {
		Title = AL["Brood Queen Araxxna"];
		Next_Page = "LKHGrizikil";
		Prev_Page = "LKHRolfen";
		Back_Page = "DUNGEONSMENU2";
	};
	["LKHGrizikil"] = {
		Title = AL["Grizikil"];
		Next_Page = "LKHClawlordHowlfang";
		Prev_Page = "LKHBroodQueenAraxxna";
		Back_Page = "DUNGEONSMENU2";
	};
	["LKHClawlordHowlfang"] = {
		Title = AL["Clawlord Howlfang"];
		Next_Page = "LKHLordBlackwaldII";
		Prev_Page = "LKHGrizikil";
		Back_Page = "DUNGEONSMENU2";
	};
	["LKHLordBlackwaldII"] = {
		Title = AL["Lord Blackwald II"];
		Next_Page = "LKHMoroes";
		Prev_Page = "LKHClawlordHowlfang";
		Back_Page = "DUNGEONSMENU2";
	};
	["LKHMoroes"] = {
		Title = AL["Moroes"];
		Next_Page = "LKHTrash";
		Prev_Page = "LKHLordBlackwaldII";
		Back_Page = "DUNGEONSMENU2";
	};
	["LKHTrash"] = {
		Title = AL["Trash Mobs"];
		Next_Page = "LKHEnchants";
		Prev_Page = "LKHMoroes";
		Back_Page = "DUNGEONSMENU2";
	};
	["LKHEnchants"] = {
		Title = AL["LKH Enchants"];
		Prev_Page = "LKHTrash";
		Back_Page = "DUNGEONSMENU2";
	};
	-- Onyxia's Lair
	["Onyxia"] = {
		Title = AL["Onyxia's Lair"];
		Back_Page = "DUNGEONSMENU2";
	};
	-- World Bosses
	["AAzuregos"] = {
		Title = AL["Azuregos"];
		Next_Page = "DEmeriss";
		Back_Page = "WORLDBOSSMENU",
	};
	["DEmeriss"] = {
		Title = AL["Emeriss"];
		Next_Page = "DLethon";
		Prev_Page = "AAzuregos";
		Back_Page = "WORLDBOSSMENU",
	};
	["DLethon"] = {
		Title = AL["Lethon"];
		Next_Page = "DTaerar";
		Prev_Page = "DEmeriss";
		Back_Page = "WORLDBOSSMENU",
	};
	["DTaerar"] = {
		Title = AL["Taerar"];
		Next_Page = "DYsondre";
		Prev_Page = "DLethon";
		Back_Page = "WORLDBOSSMENU",
	};
	["DYsondre"] = {
		Title = AL["Ysondre"];
		Next_Page = "KKazzak";
		Prev_Page = "DTaerar";
		Back_Page = "WORLDBOSSMENU",
	};
	["KKazzak"] = {
		Title = AL["Lord Kazzak"];
		Next_Page = "Nerubian";
		Prev_Page = "DYsondre";
		Back_Page = "WORLDBOSSMENU",
	};
	["Nerubian"] = {
		Title = AL["Nerubian Overseer"];
		Next_Page = "Reaver";
		Prev_Page = "KKazzak";
		Back_Page = "WORLDBOSSMENU",
	};
	["Reaver"] = {
		Title = AL["Dark Reaver of Karazhan"];
		Next_Page = "Ostarius";
		Prev_Page = "Nerubian";
		Back_Page = "WORLDBOSSMENU",
	};
	["Ostarius"] = {
		Title = AL["Ostarius"];
		Next_Page = "Concavius";
		Prev_Page = "Reaver";
		Back_Page = "WORLDBOSSMENU",
	};
	["Concavius"] = {
		Title = AL["Concavius"];
		Next_Page = "CowKing";
		Prev_Page = "Ostarius";
		Back_Page = "WORLDBOSSMENU",
	};
	["CowKing"] = {
		Title = AL["Moo"];
		Prev_Page = "Concavius";
		Next_Page = "Clackora";
		Back_Page = "WORLDBOSSMENU",
	};
	["Clackora"] = {
		Title = AL["Cla'ckora"];
		Prev_Page = "CowKing";
		Back_Page = "WORLDBOSSMENU",
	};
	-- Rare Spawns
	["EarthcallerRezengal"] = {
		Title = AL["Earthcaller Rezengal"];
		Next_Page = "ShadeMage";
	};
	["ShadeMage"] = {
		Title = AL["Shade Mage"];
		Next_Page = "GraypawAlpha";
		Prev_Page = "EarthcallerRezengal";
	};
	["GraypawAlpha"] = {
		Title = AL["Graypaw Alpha"];
		Next_Page = "Blazespark";
		Prev_Page = "ShadeMage";
	};
	["Blazespark"] = {
		Title = AL["Blazespark"];
		Next_Page = "WitchDoctorTanzo";
		Prev_Page = "GraypawAlpha";
	};
	["WitchDoctorTanzo"] = {
		Title = AL["Witch Doctor Tan'zo"];
		Next_Page = "Dawnhowl";
		Prev_Page = "Blazespark";
	};
	["Dawnhowl"] = {
		Title = AL["Dawnhowl"];
		Next_Page = "MaltimorsPrototype";
		Prev_Page = "WitchDoctorTanzo";
	};
	["MaltimorsPrototype"] = {
		Title = AL["Maltimor's Prototype"];
		Next_Page = "Bonecruncher";
		Prev_Page = "Dawnhowl";
	};
	["Bonecruncher"] = {
		Title = AL["Bonecruncher"];
		Next_Page = "Duskskitter";
		Prev_Page = "MaltimorsPrototype";
	};
	["Duskskitter"] = {
		Title = AL["Duskskitter"];
		Next_Page = "BaronPerenolde";
		Prev_Page = "Bonecruncher";
	};
	["BaronPerenolde"] = {
		Title = AL["Baron Perenolde"];
		Next_Page = "Grugthok";
		Prev_Page = "Duskskitter";
	};
	["Grugthok"] = {
		Title = AL["Grug'thok the Seer"];
		Next_Page = "Ashbeard";
		Prev_Page = "BaronPerenolde";
	};
	["Ashbeard"] = {
		Title = AL["Explorer Ashbeard"];
		Next_Page = "Jalakar";
		Prev_Page = "Grugthok";
	};
	["Jalakar"] = {
		Title = AL["Jal'akar"];
		Next_Page = "Embereye";
		Prev_Page = "Ashbeard";
	};
	["Embereye"] = {
		Title = AL["Embereye"];
		Next_Page = "Rukthok";
		Prev_Page = "Jalakar";
	};
	["Rukthok"] = {
		Title = AL["Ruk'thok the Pyromancer"];
		Next_Page = "Tarangos";
		Prev_Page = "Embereye";
	};
	["Tarangos"] = {
		Title = AL["Tarangos"];
		Next_Page = "Ripjaw";
		Prev_Page = "Rukthok";
	};
	["Ripjaw"] = {
		Title = AL["Ripjaw"];
		Next_Page = "Xalvic";
		Prev_Page = "Tarangos";
	};
	["Xalvic"] = {
		Title = AL["Xalvic Blackclaw"];
		Next_Page = "Aquitus";
		Prev_Page = "Ripjaw";
	};
	["Aquitus"] = {
		Title = AL["Aquitus"];
		Next_Page = "FirstbornofArugal";
		Prev_Page = "Xalvic";
	};
	["FirstbornofArugal"] = {
		Title = AL["Firstborn of Arugal"];
		Next_Page = "Letashaz";
		Prev_Page = "Aquitus";
	};
	["Letashaz"] = {
		Title = AL["Letashaz"];
		Next_Page = "MargontheMighty";
		Prev_Page = "FirstbornofArugal";
	};
	["MargontheMighty"] = {
		Title = AL["Margon the Mighty"];
		Next_Page = "WanderingKnight";
		Prev_Page = "Letashaz";
	};
	["WanderingKnight"] = {
		Title = AL["The Wandering Knight"];
		Next_Page = "Stoneshell";
		Prev_Page = "MargontheMighty";
	};
	["Stoneshell"] = {
		Title = AL["Stoneshell"];
		Next_Page = "Zareth";
		Prev_Page = "WanderingKnight";
	};
	["Zareth"] = {
		Title = AL["Zareth Terrorblade"];
		Next_Page = "HighvaleSilverback";
		Prev_Page = "Stoneshell";
	};
	["HighvaleSilverback"] = {
		Title = AL["Highvale Silverback"];
		Next_Page = "Mallon";
		Prev_Page = "Zareth";
	};
	["Mallon"] = {
		Title = AL["Mallon The Moontouched"];
		Next_Page = "Kargron";
		Prev_Page = "HighvaleSilverback";
	};
	["Kargron"] = {
		Title = AL["Blademaster Kargron"];
		Next_Page = "AdmiralBareanWestwind";
		Prev_Page = "Mallon";
	};
	["ProfessorLysander"] = {
		Title = AL["Professor Lysander"];
		Next_Page = "AdmiralBareanWestwind";
		Prev_Page = "Kargron";
	};
	["AdmiralBareanWestwind"] = {
		Title = AL["Admiral Barean Westwind"];
		Next_Page = "Azurebeak";
		Prev_Page = "ProfessorLysander";
	};
	["Azurebeak"] = {
		Title = AL["Azurebeak"];
		Next_Page = "BarkskinFisher";
		Prev_Page = "AdmiralBareanWestwind";
	};
	["BarkskinFisher"] = {
		Title = AL["Barkskin Fisher"];
		Next_Page = "CrusaderLarsarius";
		Prev_Page = "Azurebeak";
	};
	["CrusaderLarsarius"] = {
		Title = AL["Crusader Larsarius"];
		Next_Page = "ShadeflayerGoliath";
		Prev_Page = "BarkskinFisher";
	};
	["ShadeflayerGoliath"] = {
		Title = AL["Shadeflayer Goliath"];
		Next_Page = "WidowoftheWoods";
		Prev_Page = "CrusaderLarsarius";
	};
	["WidowoftheWoods"] = {
		Title = AL["Widow of the Woods"];
		Next_Page = "M0L1Y";
		Prev_Page = "ShadeflayerGoliath";
	};
	["M0L1Y"] = {
		Title = AL["M-0L1Y"];
		Prev_Page = "WidowoftheWoods";
	};
	-- Factions
	["Argent1"] = {
		Title = AL["Argent Dawn"] .. ": " .. AL["Token Hand-Ins"];
		Next_Page = "Argent2";
		Back_Page = "REPMENU";
	};
	["Argent2"] = {
		Title = AL["Argent Dawn"] .. ": " .. AL["Friendly"] .. "-" .. AL["Honored"];
		Prev_Page = "Argent1";
		Next_Page = "Argent3";
		Back_Page = "REPMENU";
	};
	["Argent3"] = {
		Title = AL["Argent Dawn"] .. ": " .. AL["Revered"] .. "-" .. AL["Exalted"];
		Prev_Page = "Argent2";
		Back_Page = "REPMENU";
	};
	["Bloodsail1"] = {
		Title = AL["Bloodsail Buccaneers"];
		Back_Page = "REPMENU";
	};
	["Wardens1"] = {
		Title = AL["Wardens of Time"] .. ": " .. AL["Friendly"] .. " & " .. AL["Honored"];
		Back_Page = "REPMENU";
		Next_Page = "Wardens2";
	};
	["Wardens2"] = {
		Title = AL["Wardens of Time"] .. ": " .. AL["Revered"] .. " & " .. AL["Exalted"];
		Back_Page = "REPMENU";
		Prev_Page = "Wardens1";
	};
	["AQBroodRings"] = {
		Title = AL["Brood of Nozdormu"];
		Back_Page = "REPMENU";
	};
	["Cenarion1"] = {
		Title = AL["Cenarion Circle"] .. ": " .. AL["Friendly"];
		Next_Page = "Cenarion2";
		Back_Page = "REPMENU";
	};
	["Cenarion2"] = {
		Title = AL["Cenarion Circle"] .. ": " .. AL["Honored"];
		Next_Page = "Cenarion3";
		Prev_Page = "Cenarion1";
		Back_Page = "REPMENU";
	};
	["Cenarion3"] = {
		Title = AL["Cenarion Circle"] .. ": " .. AL["Revered"];
		Next_Page = "Cenarion4";
		Prev_Page = "Cenarion2";
		Back_Page = "REPMENU";
	};
	["Cenarion4"] = {
		Title = AL["Cenarion Circle"] .. ": " .. AL["Exalted"];
		Prev_Page = "Cenarion3";
		Back_Page = "REPMENU";
	};
	["Darkmoon"] = {
		Title = AL["Darkmoon Faire"];
		Back_Page = "REPMENU";
	};
	["Defilers"] = {
		Title = AL["The Defilers"];
		Back_Page = "REPMENU";
	};
	["Frostwolf1"] = {
		Title = AL["Frostwolf Clan"];
		Back_Page = "REPMENU";
	};
	["GelkisClan1"] = {
		Title = AL["Gelkis Clan Centaur"];
		Back_Page = "REPMENU";
	};
	["WaterLords1"] = {
		Title = AL["Hydraxian Waterlords"];
		Back_Page = "REPMENU";
	};
	["LeagueofArathor"] = {
		Title = AL["The League of Arathor"];
		Back_Page = "REPMENU";
	};
	["Ironforge"] = {
		Title = AL["Ironforge"];
		Back_Page = "REPMENU";
	};
	["Darnassus"] = {
		Title = AL["Darnassus"];
		Back_Page = "REPMENU";
	};
	["Stormwind"] = {
		Title = AL["Stormwind"];
		Back_Page = "REPMENU";
	};
	["GnomereganExiles"] = {
		Title = AL["Gnomeregan Exiles"];
		Back_Page = "REPMENU";
	};
	["DarkspearTrolls"] = {
		Title = AL["Darkspear Trolls"];
		Back_Page = "REPMENU";
	};
	["DurotarLaborUnion"] = {
		Title = AL["Durotar Labor Union"];
		Back_Page = "REPMENU";
	};
	["Undercity"] = {
		Title = AL["Undercity"];
		Back_Page = "REPMENU";
	};
	["Orgrimmar"] = {
		Title = AL["Orgrimmar"];
		Back_Page = "REPMENU";
	};
	["ThunderBluff"] = {
		Title = AL["Thunder Bluff"];
		Back_Page = "REPMENU";
	};
	["Dalaran"] = {
		Title = AL["Dalaran"];
		Back_Page = "REPMENU";
	};
	["Helf"] = {
		Title = AL["Silvermoon Remnant"];
		Next_Page = "Helf2";
		Back_Page = "REPMENU";
	};
	["Helf2"] = {
		Title = AL["Silvermoon Remnant"];
		Next_Page = "Helf3";
		Prev_Page = "Helf";
		Back_Page = "REPMENU";
	};
	["Helf3"] = {
		Title = AL["Silvermoon Remnant"];
		Prev_Page = "Helf2";
		Back_Page = "REPMENU";
	};
	["Revantusk"] = {
		Title = AL["Revantusk Trolls"];
		Next_Page = "Revantusk2";
		Back_Page = "REPMENU";
	};
	["Revantusk2"] = {
		Title = AL["Revantusk Trolls"];
		Next_Page = "Revantusk3";
		Prev_Page = "Revantusk";
		Back_Page = "REPMENU";
	};
	["Revantusk3"] = {
		Title = AL["Revantusk Trolls"];
		Prev_Page = "Revantusk2";
		Back_Page = "REPMENU";
	};
	["MagramClan1"] = {
		Title = AL["Magram Clan Centaur"];
		Back_Page = "REPMENU";
	};
	["Stormpike1"] = {
		Title = AL["Stormpike Guard"];
		Back_Page = "REPMENU";
	};
	["Thorium1"] = {
		Title = AL["Thorium Brotherhood"] .. ": " .. AL["Friendly"] .. "/" .. AL["Honored"];
		Next_Page = "Thorium2";
		Back_Page = "REPMENU";
	};
	["Thorium2"] = {
		Title = AL["Thorium Brotherhood"] .. ": " .. AL["Revered"] .. "/" .. AL["Exalted"];
		Prev_Page = "Thorium1";
		Back_Page = "REPMENU";
	};
	["Timbermaw"] = {
		Title = AL["Timbermaw Hold"];
		Back_Page = "REPMENU";
	};
	["Wildhammer"] = {
		Title = AL["Wildhammer Clan"];
		Back_Page = "REPMENU";
	};
	["Shendralar"] = {
		Title = AL["Shen'dralar"];
		Back_Page = "REPMENU";
	};
	["Wintersaber1"] = {
		Title = AL["Wintersaber Trainers"];
		Back_Page = "REPMENU";
	};
	["Zandalar1"] = {
		Title = AL["Zandalar Tribe"] .. ": " .. AL["Friendly"] .. "/" .. AL["Honored"];
		Next_Page = "Zandalar2";
		Back_Page = "REPMENU";
	};
	["Zandalar2"] = {
		Title = AL["Zandalar Tribe"] .. ": " .. AL["Revered"] .. "/" .. AL["Exalted"];
		Prev_Page = "Zandalar1";
		Back_Page = "REPMENU";
	};
	["BRRepFriendly"] = {
		Title = AL["Blood Ring Friendly Rewards"];
		Back_Page = "BRRepMenu";
		Next_Page = "BRRepHonored";
	};
	["BRRepHonored"] = {
		Title = AL["Blood Ring Honored Rewards"];
		Back_Page = "BRRepMenu";
		Prev_Page = "BRRepFriendly";
		Next_Page = "BRRepRevered";
	};
	["BRRepRevered"] = {
		Title = AL["Blood Ring Revered Rewards"];
		Back_Page = "BRRepMenu";
		Prev_Page = "BRRepHonored";
		Next_Page = "BRRepExalted";
	};
	["BRRepExalted"] = {
		Title = AL["Blood Ring Exalted Rewards"];
		Back_Page = "BRRepMenu";
		Prev_Page = "BRRepRevered";
		Next_Page = "BRRepTokens";
	};
	["BRRepTokens"] = {
		Title = AL["Token of Blood Rewards"];
		Back_Page = "BRRepMenu";
		Prev_Page = "BRRepExalted";
	};
	["ABRepFriendly"] = {
		Back_Page = "ABRepMenu";
		Title = AL["AB Friendly Rewards"];
		Next_Page = "ABRepHonored2029";
	};
	["ABRepHonored2029"] = {
		Back_Page = "ABRepMenu";
		Title = AL["AB 20-29 Honored Rewards"];
		Next_Page = "ABRepHonored3039";
		Prev_Page = "ABRepFriendly";
	};
	["ABRepHonored3039"] = {
		Back_Page = "ABRepMenu";
		Title = AL["AB 30-39 Honored Rewards"];
		Next_Page = "ABRepHonored4049";
		Prev_Page = "ABRepHonored2029";
	};
	["ABRepHonored4049"] = {
		Back_Page = "ABRepMenu";
		Title = AL["AB 40-49 Honored Rewards"];
		Next_Page = "ABRepHonored5059";
		Prev_Page = "ABRepHonored3039";
	};
	["ABRepHonored5059"] = {
		Back_Page = "ABRepMenu";
		Title = AL["AB 50-59 Honored Rewards"];
		Next_Page = "ABRepRevered2029";
		Prev_Page = "ABRepHonored4049";
	};
	["ABRepRevered2029"] = {
		Back_Page = "ABRepMenu";
		Title = AL["AB 20-29 Revered Rewards"];
		Next_Page = "ABRepRevered3039";
		Prev_Page = "ABRepHonored5059";
	};
	["ABRepRevered3039"] = {
		Back_Page = "ABRepMenu";
		Title = AL["AB 30-39 Revered Rewards"];
		Next_Page = "ABRepRevered4049";
		Prev_Page = "ABRepRevered2029";
	};
	["ABRepRevered4049"] = {
		Back_Page = "ABRepMenu";
		Title = AL["AB 40-49 Revered Rewards"];
		Next_Page = "ABRepRevered5059";
		Prev_Page = "ABRepRevered3039";
	};
	["ABRepRevered5059"] = {
		Back_Page = "ABRepMenu";
		Title = AL["AB 50-59 Revered Rewards"];
		Next_Page = "ABRepExalted";
		Prev_Page = "ABRepRevered4049";
	};
	["ABRepExalted"] = {
		Back_Page = "ABRepMenu";
		Title = AL["AB Exalted Rewards"];
		Prev_Page = "ABRepRevered5059";
	};
	["AVRepFriendly"] = {
		Title = AL["AV Friendly Rewards"];
		Back_Page = "AVRepMenu";
		Next_Page = "AVRepHonored";
	};
	["AVRepHonored"] = {
		Title = AL["AV Honored Rewards"];
		Back_Page = "AVRepMenu";
		Prev_Page = "AVRepFriendly";
		Next_Page = "AVRepRevered";
	};
	["AVRepRevered"] = {
		Title = AL["AV Revered Rewards"];
		Back_Page = "AVRepMenu";
		Prev_Page = "AVRepHonored";
		Next_Page = "AVRepExalted";
	};
	["AVRepExalted"] = {
		Title = AL["AV Exalted Rewards"];
		Back_Page = "AVRepMenu";
		Prev_Page = "AVRepRevered";
		Next_Page = "AVKorrak";
	};
	["AVKorrak"] = {
		Title = AL["Korrak the Bloodrager"];
		Back_Page = "AVRepMenu";
		Prev_Page = "AVRepExalted";
		Next_Page = "AVLokholarIvus";
	};
	["AVLokholarIvus"] = {
		Title = AL["Ivus & Lokholar"];
		Back_Page = "AVRepMenu";
		Prev_Page = "AVKorrak";
	};
	["WSGRepFriendly"] = {
		Back_Page = "WSGRepMenu";
		Title = AL["WSG Friendly Rewards"];
		Next_Page = "WSGRepHonored1019";
	};
	["WSGRepHonored1019"] = {
		Back_Page = "WSGRepMenu";
		Title = AL["WSG 10-19 Honored Rewards"];
		Next_Page = "WSGRepHonored2029";
		Prev_Page = "WSGRepFriendly";
	};
	["WSGRepHonored2029"] = {
		Back_Page = "WSGRepMenu";
		Title = AL["WSG 20-29 Honored Rewards"];
		Next_Page = "WSGRepHonored3039";
		Prev_Page = "WSGRepHonored1019";
	};
	["WSGRepHonored3039"] = {
		Back_Page = "WSGRepMenu";
		Title = AL["WSG 30-39 Honored Rewards"];
		Next_Page = "WSGRepHonored4049";
		Prev_Page = "WSGRepHonored2029";
	};
	["WSGRepHonored4049"] = {
		Back_Page = "WSGRepMenu";
		Title = AL["WSG 40-49 Honored Rewards"];
		Next_Page = "WSGRepHonored5059";
		Prev_Page = "WSGRepHonored3039";
	};
	["WSGRepHonored5059"] = {
		Back_Page = "WSGRepMenu";
		Title = AL["WSG 50-59 Honored Rewards"];
		Next_Page = "WSGRepRevered1019";
		Prev_Page = "WSGRepHonored4049";
	};
	["WSGRepRevered1019"] = {
		Back_Page = "WSGRepMenu";
		Title = AL["WSG 10-19 Revered Rewards"];
		Next_Page = "WSGRepRevered2029";
		Prev_Page = "WSGRepHonored5059";
	};
	["WSGRepRevered2029"] = {
		Back_Page = "WSGRepMenu";
		Title = AL["WSG 20-29 Revered Rewards"];
		Next_Page = "WSGRepRevered3039";
		Prev_Page = "WSGRepRevered1019";
	};
	["WSGRepRevered3039"] = {
		Back_Page = "WSGRepMenu";
		Title = AL["WSG 30-39 Revered Rewards"];
		Next_Page = "WSGRepRevered4049";
		Prev_Page = "WSGRepRevered2029";
	};
	["WSGRepRevered4049"] = {
		Back_Page = "WSGRepMenu";
		Title = AL["WSG 40-49 Revered Rewards"];
		Next_Page = "WSGRepRevered5059";
		Prev_Page = "WSGRepRevered3039";
	};
	["WSGRepRevered5059"] = {
		Back_Page = "WSGRepMenu";
		Title = AL["WSG 50-59 Revered Rewards"];
		Next_Page = "WSGRepExalted4049";
		Prev_Page = "WSGRepRevered4049";
	};
	["WSGRepExalted4049"] = {
		Back_Page = "WSGRepMenu";
		Title = AL["WSG 40-49 Exalted Rewards"];
		Next_Page = "WSGRepExalted5059";
		Prev_Page = "WSGRepRevered5059";
	};
	["WSGRepExalted5059"] = {
		Back_Page = "WSGRepMenu";
		Title = AL["WSG 50-59 Exalted Rewards"];
		Next_Page = "WSGRepExalted60";
		Prev_Page = "WSGRepExalted4049";
	};
	["WSGRepExalted60"] = {
		Back_Page = "WSGRepMenu";
		Title = AL["WSG 60 Exalted Rewards"];
		Prev_Page = "WSGRepExalted5059";
	};
	["PvP60Accessories1"] = {
		Title = AL["PvP Accessories"];
		Next_Page = "PvP60Accessories2";
		Back_Page = "PVPMENU";
	};
	["PvP60Accessories2"] = {
		Title = AL["Rank 2-9"];
		Next_Page = "PvP60Accessories3";
		Prev_Page = "PvP60Accessories1";
		Back_Page = "PVPMENU";
	};
	["PvP60Accessories3"] = {
		Title = AL["Rank 2-9"];
		Prev_Page = "PvP60Accessories2";
		Back_Page = "PVPMENU";
	};
	["PVPWeapons1"] = {
		Title = AL["PvP Weapons"];
		Next_Page = "PVPWeapons2";
		Back_Page = "PVPMENU";
	};
	["PVPWeapons2"] = {
		Title = AL["PvP Weapons"];
		Prev_Page = "PVPWeapons1";
		Back_Page = "PVPMENU";
	};
	["PVPDruid"] = {
		Title = AL["Druid"];
		Back_Page = "PVPSET";
	};
	["PVPHunter"] = {
		Title = AL["Hunter"];
		Back_Page = "PVPSET";
	};
	["PVPMage"] = {
		Title = AL["Mage"];
		Back_Page = "PVPSET";
	};
	["PVPPaladin"] = {
		Title = AL["Paladin"];
		Back_Page = "PVPSET";
	};
	["PVPPriest"] = {
		Title = AL["Priest"];
		Back_Page = "PVPSET";
	};
	["PVPRogue"] = {
		Title = AL["Rogue"];
		Back_Page = "PVPSET";
	};
	["PVPShaman"] = {
		Title = AL["Shaman"];
		Back_Page = "PVPSET";
	};
	["PVPWarlock"] = {
		Title = AL["Warlock"];
		Back_Page = "PVPSET";
	};
	["PVPWarrior"] = {
		Title = AL["Warrior"];
		Back_Page = "PVPSET";
	};
	["T0Druid"] = {
		Title = AL["Druid"];
		Back_Page = "T0SET";
	};
	["T0Hunter"] = {
		Title = AL["Hunter"];
		Back_Page = "T0SET";
	};
	["T0Mage"] = {
		Title = AL["Mage"];
		Back_Page = "T0SET";
	};
	["T0Paladin"] = {
		Title = AL["Paladin"];
		Back_Page = "T0SET";
	};
	["T0Priest"] = {
		Title = AL["Priest"];
		Back_Page = "T0SET";
	};
	["T0Rogue"] = {
		Title = AL["Rogue"];
		Back_Page = "T0SET";
	};
	["T0Shaman"] = {
		Title = AL["Shaman"];
		Back_Page = "T0SET";
	};
	["T0Warlock"] = {
		Title = AL["Warlock"];
		Back_Page = "T0SET";
	};
	["T0Warrior"] = {
		Title = AL["Warrior"];
		Back_Page = "T0SET";
	};
	["T1Druid"] = {
		Title = AL["Druid"];
		Back_Page = "T1SET";
	};
	["T1Hunter"] = {
		Title = AL["Hunter"];
		Back_Page = "T1SET";
	};
	["T1Mage"] = {
		Title = AL["Mage"];
		Back_Page = "T1SET";
	};
	["T1Paladin"] = {
		Title = AL["Paladin"];
		Back_Page = "T1SET";
	};
	["T1Priest"] = {
		Title = AL["Priest"];
		Back_Page = "T1SET";
	};
	["T1Rogue"] = {
		Title = AL["Rogue"];
		Back_Page = "T1SET";
	};
	["T1Shaman"] = {
		Title = AL["Shaman"];
		Back_Page = "T1SET";
	};
	["T1Warlock"] = {
		Title = AL["Warlock"];
		Back_Page = "T1SET";
	};
	["T1Warrior"] = {
		Title = AL["Warrior"];
		Back_Page = "T1SET";
	};
	["T2Druid"] = {
		Title = AL["Druid"];
		Back_Page = "T2SET";
	};
	["T2Hunter"] = {
		Title = AL["Hunter"];
		Back_Page = "T2SET";
	};
	["T2Mage"] = {
		Title = AL["Mage"];
		Back_Page = "T2SET";
	};
	["T2Paladin"] = {
		Title = AL["Paladin"];
		Back_Page = "T2SET";
	};
	["T2Priest"] = {
		Title = AL["Priest"];
		Back_Page = "T2SET";
	};
	["T2Rogue"] = {
		Title = AL["Rogue"];
		Back_Page = "T2SET";
	};
	["T2Shaman"] = {
		Title = AL["Shaman"];
		Back_Page = "T2SET";
	};
	["T2Warlock"] = {
		Title = AL["Warlock"];
		Back_Page = "T2SET";
	};
	["T2Warrior"] = {
		Title = AL["Warrior"];
		Back_Page = "T2SET";
	};
	["T3Druid"] = {
		Title = AL["Druid"];
		Back_Page = "T3SET";
	};
	["T3Hunter"] = {
		Title = AL["Hunter"];
		Back_Page = "T3SET";
	};
	["T3Mage"] = {
		Title = AL["Mage"];
		Back_Page = "T3SET";
	};
	["T3Paladin"] = {
		Title = AL["Paladin"];
		Back_Page = "T3SET";
	};
	["T3Priest"] = {
		Title = AL["Priest"];
		Back_Page = "T3SET";
	};
	["T3Rogue"] = {
		Title = AL["Rogue"];
		Back_Page = "T3SET";
	};
	["T3Shaman"] = {
		Title = AL["Shaman"];
		Back_Page = "T3SET";
	};
	["T3Warlock"] = {
		Title = AL["Warlock"];
		Back_Page = "T3SET";
	};
	["T3Warrior"] = {
		Title = AL["Warrior"];
		Back_Page = "T3SET";
	};
	["T35Druid"] = {
		Title = AL["Druid"];
		Back_Page = "KARASET";
	};
	["T35Hunter"] = {
		Title = AL["Hunter"];
		Back_Page = "KARASET";
	};
	["T35Mage"] = {
		Title = AL["Mage"];
		Back_Page = "KARASET";
	};
	["T35Paladin"] = {
		Title = AL["Paladin"];
		Back_Page = "KARASET";
	};
	["T35Priest"] = {
		Title = AL["Priest"];
		Back_Page = "KARASET";
	};
	["T35Rogue"] = {
		Title = AL["Rogue"];
		Back_Page = "KARASET";
	};
	["T35Shaman"] = {
		Title = AL["Shaman"];
		Back_Page = "KARASET";
	};
	["T35Warlock"] = {
		Title = AL["Warlock"];
		Back_Page = "KARASET";
	};
	["T35Warrior"] = {
		Title = AL["Warrior"];
		Back_Page = "KARASET";
	};
	["AQ40Druid"] = {
		Title = AL["Druid"];
		Back_Page = "AQ40SET";
	};
	["AQ40Hunter"] = {
		Title = AL["Hunter"];
		Back_Page = "AQ40SET";
	};
	["AQ40Mage"] = {
		Title = AL["Mage"];
		Back_Page = "AQ40SET";
	};
	["AQ40Paladin"] = {
		Title = AL["Paladin"];
		Back_Page = "AQ40SET";
	};
	["AQ40Priest"] = {
		Title = AL["Priest"];
		Back_Page = "AQ40SET";
	};
	["AQ40Rogue"] = {
		Title = AL["Rogue"];
		Back_Page = "AQ40SET";
	};
	["AQ40Shaman"] = {
		Title = AL["Shaman"];
		Back_Page = "AQ40SET";
	};
	["AQ40Warlock"] = {
		Title = AL["Warlock"];
		Back_Page = "AQ40SET";
	};
	["AQ40Warrior"] = {
		Title = AL["Warrior"];
		Back_Page = "AQ40SET";
	};
	["AQ20Druid"] = {
		Title = AL["Druid"];
		Back_Page = "AQ20SET";
	};
	["AQ20Hunter"] = {
		Title = AL["Hunter"];
		Back_Page = "AQ20SET";
	};
	["AQ20Mage"] = {
		Title = AL["Mage"];
		Back_Page = "AQ20SET";
	};
	["AQ20Paladin"] = {
		Title = AL["Paladin"];
		Back_Page = "AQ20SET";
	};
	["AQ20Priest"] = {
		Title = AL["Priest"];
		Back_Page = "AQ20SET";
	};
	["AQ20Rogue"] = {
		Title = AL["Rogue"];
		Back_Page = "AQ20SET";
	};
	["AQ20Shaman"] = {
		Title = AL["Shaman"];
		Back_Page = "AQ20SET";
	};
	["AQ20Warlock"] = {
		Title = AL["Warlock"];
		Back_Page = "AQ20SET";
	};
	["AQ20Warrior"] = {
		Title = AL["Warrior"];
		Back_Page = "AQ20SET";
	};
	["ZGDruid"] = {
		Title = AL["Druid"];
		Back_Page = "ZGSET";
	};
	["ZGHunter"] = {
		Title = AL["Hunter"];
		Back_Page = "ZGSET";
	};
	["ZGMage"] = {
		Title = AL["Mage"];
		Back_Page = "ZGSET";
	};
	["ZGPaladin"] = {
		Title = AL["Paladin"];
		Back_Page = "ZGSET";
	};
	["ZGPriest"] = {
		Title = AL["Priest"];
		Back_Page = "ZGSET";
	};
	["ZGRogue"] = {
		Title = AL["Rogue"];
		Back_Page = "ZGSET";
	};
	["ZGShaman"] = {
		Title = AL["Shaman"];
		Back_Page = "ZGSET";
	};
	["ZGWarlock"] = {
		Title = AL["Warlock"];
		Back_Page = "ZGSET";
	};
	["ZGWarrior"] = {
		Title = AL["Warrior"];
		Back_Page = "ZGSET";
	};
	["DEADMINES"] = {
		Title = AL["Defias Leather"];
		Back_Page = "PRE60SET";
	};
	["WAILING"] = {
		Title = AL["Embrace of the Viper"];
		Back_Page = "PRE60SET";
	};
	["SCARLET"] = {
		Title = AL["Chain of the Scarlet Crusade"];
		Back_Page = "PRE60SET";
	};
	["BLACKROCKD"] = {
		Title = AL["The Gladiator"];
		Back_Page = "PRE60SET";
	};
	["IRONWEAVE"] = {
		Title = AL["Ironweave Battlesuit"];
		Back_Page = "PRE60SET";
	};
	["ScholoCloth"] = {
		Title = AL["Scholomance"];
		Back_Page = "PRE60SET";
	};
	["ScholoLeather"] = {
		Title = AL["Scholomance"];
		Back_Page = "PRE60SET";
	};
	["ScholoMail"] = {
		Title = AL["Scholomance"];
		Back_Page = "PRE60SET";
	};
	["ScholoPlate"] = {
		Title = AL["Scholomance"];
		Back_Page = "PRE60SET";
	};
	["STRAT"] = {
		Title = AL["The Postmaster"];
		Back_Page = "PRE60SET";
	};
	["ScourgeInvasion"] = {
		Title = AL["Scourge Invasion"];
		Back_Page = "PRE60SET";
	};
	["ShardOfGods"] = {
		Title = AL["Shard of the Gods"];
		Back_Page = "PRE60SET";
	};
	["ZGRings"] = {
		Title = AL["Zul'Gurub Rings"];
		Back_Page = "ZGSET";
	};
	["HakkariBlades"] = {
		Title = AL["The Twin Blades of Hakkari"];
		Back_Page = "ZGSET";
	};
	["PrimalBlessing"] = {
		Title = AL["Primal Blessing"];
		Back_Page = "ZGSET";
	};
	["SpiritofEskhandar"] = {
		Title = AL["Spirit of Eskhandar"];
		Back_Page = "PRE60SET";
	};
	["DalRend"] = {
		Title = AL["Dal'Rend's Arms"];
		Back_Page = "PRE60SET";
	};
	["SpiderKiss"] = {
		Title = AL["Spider's Kiss"];
		Back_Page = "PRE60SET";
	};
	["SteelPlate"] = {
		Title = AL["Steel Plate"];
		Back_Page = "CRAFTSET";
	};
	["ImperialPlate"] = {
		Title = AL["Imperial Plate"];
		Back_Page = "CRAFTSET";
	};
	["TheDarksoul"] = {
		Title = AL["The Darksoul"];
		Back_Page = "CRAFTSET";
	};
	["BloodsoulEmbrace"] = {
		Title = AL["Bloodsoul Embrace"];
		Back_Page = "CRAFTSET";
	};
	["AugerersAttire"] = {
		Title = AL["Augerer's Attire"];
		Back_Page = "CRAFTSET";
	};
	["ShadoweaveSet"] = {
		Title = AL["Shadoweave"];
		Back_Page = "CRAFTSET";
	};
	["DivinersGarments"] = {
		Title = AL["Diviner's Garments"];
		Back_Page = "CRAFTSET";
	};
	["PillagersGarb"] = {
		Title = AL["Pillager's Garb"];
		Back_Page = "CRAFTSET";
	};
	["BloodvineG"] = {
		Title = AL["Bloodvine Garb"];
		Back_Page = "CRAFTSET";
	};
	["MoonclothSet"] = {
		Title = AL["Mooncloth Regalia"];
		Back_Page = "CRAFTSET";
	};
	["GriftersArmor"] = {
		Title = AL["Grifter's Armor"];
		Back_Page = "CRAFTSET";
	};
	["PrimalistsTrappings"] = {
		Title = AL["Primalist's Trappings"];
		Back_Page = "CRAFTSET";
	};
	["VolcanicArmor"] = {
		Title = AL["Volcanic Armor"];
		Back_Page = "CRAFTSET";
	};
	["IronfeatherArmor"] = {
		Title = AL["Ironfeather Armor"];
		Back_Page = "CRAFTSET";
	};
	["StormshroudArmor"] = {
		Title = AL["Stormshroud Armor"];
		Back_Page = "CRAFTSET";
	};
	["DevilsaurArmor"] = {
		Title = AL["Devilsaur Armor"];
		Back_Page = "CRAFTSET";
	};
	["BloodTigerH"] = {
		Title = AL["Blood Tiger Harness"];
		Back_Page = "CRAFTSET";
	};
	["PrimalBatskin"] = {
		Title = AL["Primal Batskin"];
		Back_Page = "CRAFTSET";
	};
	["RedDragonM"] = {
		Title = AL["Red Dragon Mail"];
		Back_Page = "CRAFTSET";
	};
	["GreenDragonM"] = {
		Title = AL["Green Dragon Mail"];
		Back_Page = "CRAFTSET";
	};
	["BlueDragonM"] = {
		Title = AL["Blue Dragon Mail"];
		Back_Page = "CRAFTSET";
	};
	["BlackDragonM"] = {
		Title = AL["Black Dragon Mail"];
		Back_Page = "CRAFTSET";
	};
	["CraftedWeapons1"] = {
		Title = AL["Crafted Epic Weapons"];
		Back_Page = "CRAFTINGMENU";
	};
	["Tabards"] = {
		Title = AL["Tabards"];
		Back_Page = "SETMENU";
	};
	["Legendaries"] = {
		Title = AL["Legendary Items"];
		Back_Page = "SETMENU";
	};
	["PvPMountsPvP"] = {
		Title = AL["PvP Mounts"];
		Back_Page = "PVPMENU";
	};
	["RareMounts"] = {
		Title = AL["Rare Mounts"];
		Back_Page = "SETMENU";
	};
	["RarePets1"] = {
		Title = AL["Rare Pets"];
		Next_Page = "RarePets2";
		Back_Page = "SETMENU";
	};
	["RarePets2"] = {
		Title = AL["Rare Pets"];
		Prev_Page = "RarePets1";
		Back_Page = "SETMENU";
	};
	["WorldEpics1"] = {
		Title = AtlasLoot_TableNames["WorldEpics1"][1];
		Next_Page = "WorldEpics2";
		Back_Page = "SETMENU";
	};
	["WorldEpics2"] = {
		Title = AtlasLoot_TableNames["WorldEpics2"][1];
		Next_Page = "WorldEpics3";
		Prev_Page = "WorldEpics1";
		Back_Page = "SETMENU";
	};
	["WorldEpics3"] = {
		Title = AtlasLoot_TableNames["WorldEpics3"][1];
		Prev_Page = "WorldEpics2";
		Back_Page = "SETMENU";
	};
	["ChildrensWeek"] = {
		Title = AL["Children's Week"];
		Back_Page = "WORLDEVENTMENU";
	};
	["Winterviel1"] = {
		Title = AL["Feast of Winter Veil"];
		Next_Page = "Winterviel2";
		Back_Page = "WORLDEVENTMENU";
	};
	["Winterviel2"] = {
		Title = AL["Feast of Winter Veil"];
		Prev_Page = "Winterviel1";
		Back_Page = "WORLDEVENTMENU";
	};
	["Halloween1"] = {
		Title = AL["Hallow's End"];
		Next_Page = "Halloween2";
		Back_Page = "WORLDEVENTMENU";
	};
	["Halloween2"] = {
		Title = AL["Hallow's End"];
		Prev_Page = "Halloween1";
		Back_Page = "WORLDEVENTMENU";
	};
	["HarvestFestival"] = {
		Title = AL["Harvest Festival"];
		Back_Page = "WORLDEVENTMENU";
	};
	["Valentineday"] = {
		Title = AL["Love is in the Air"];
		Back_Page = "WORLDEVENTMENU";
	};
	["LunarFestival1"] = {
		Title = AL["Lunar Festival"];
		Next_Page = "LunarFestival2";
		Back_Page = "WORLDEVENTMENU";
	};
	["LunarFestival2"] = {
		Title = AL["Lunar Festival"];
		Prev_Page = "LunarFestival1";
		Back_Page = "WORLDEVENTMENU";
	};
	["MidsummerFestival"] = {
		Title = AL["Midsummer Fire Festival"];
		Back_Page = "WORLDEVENTMENU";
	};
	["Noblegarden"] = {
		Title = AL["Noblegarden"];
		Back_Page = "WORLDEVENTMENU";
	};
	["ElementalInvasion"] = {
		Title = AL["Elemental Invasion"];
		Back_Page = "WORLDEVENTMENU";
	};
	["GurubashiArena"] = {
		Title = AL["Gurubashi Arena"];
		Back_Page = "WORLDEVENTMENU";
	};
	["ScourgeInvasionEvent1"] = {
		Title = AL["Scourge Invasion"];
		Next_Page = "ScourgeInvasionEvent2";
		Back_Page = "WORLDEVENTMENU";
	};
	["ScourgeInvasionEvent2"] = {
		Title = AL["Scourge Invasion Bosses"];
		Prev_Page = "ScourgeInvasionEvent1";
		Back_Page = "WORLDEVENTMENU";
	};
	["FishingExtravaganza"] = {
		Title = AL["Stranglethorn Fishing Extravaganza"];
		Back_Page = "WORLDEVENTMENU";
	};
	["AbyssalTemplars"] = {
		Title = AL["Templars"];
		Back_Page = "WORLDEVENTMENU";
		Next_Page = "AbyssalDukes";
	};
	["AbyssalDukes"] = {
		Title = AL["Dukes"];
		Back_Page = "WORLDEVENTMENU";
		Next_Page = "AbyssalLords";
		Prev_Page = "AbyssalTemplars";
	};
	["AbyssalLords"] = {
		Title = AL["High Council"];
		Back_Page = "WORLDEVENTMENU";
		Prev_Page = "AbyssalDukes";
	};
	["AlchemyApprentice1"] = {
		Title = AL["Alchemy"] .. ": " .. AL["Apprentice"];
		Back_Page = "ALCHEMYMENU";
		Next_Page = "AlchemyJourneyman1";
	};
	["AlchemyJourneyman1"] = {
		Title = AL["Alchemy"] .. ": " .. AL["Journeyman"];
		Back_Page = "ALCHEMYMENU";
		Next_Page = "AlchemyExpert1";
		Prev_Page = "AlchemyApprentice1";
	};
	["AlchemyExpert1"] = {
		Title = AL["Alchemy"] .. ": " .. AL["Expert"];
		Back_Page = "ALCHEMYMENU";
		Next_Page = "AlchemyArtisan1";
		Prev_Page = "AlchemyJourneyman1";
	};
	["AlchemyArtisan1"] = {
		Title = AL["Alchemy"] .. ": " .. AL["Artisan"];
		Back_Page = "ALCHEMYMENU";
		Next_Page = "AlchemyArtisan2";
		Prev_Page = "AlchemyExpert1";
	};
	["AlchemyArtisan2"] = {
		Title = AL["Alchemy"] .. ": " .. AL["Artisan"];
		Back_Page = "ALCHEMYMENU";
		Prev_Page = "AlchemyArtisan1";
		Next_Page = "AlchemyArtisan3";
	};
	["AlchemyArtisan3"] = {
		Title = AL["Alchemy"] .. ": " .. AL["Artisan"];
		Back_Page = "ALCHEMYMENU";
		Prev_Page = "AlchemyArtisan2";
		Next_Page = "AlchemyFlasks1";
	};
	["AlchemyFlasks1"] = {
		Title = AL["Flasks"];
		Back_Page = "ALCHEMYMENU";
		Next_Page = "AlchemyProtectionPots1";
		Prev_Page = "AlchemyArtisan3";
	},
	["AlchemyProtectionPots1"] = {
		Title = AL["Protection Potions"];
		Back_Page = "ALCHEMYMENU";
		Next_Page = "AlchemyHealingAndMana1";
		Prev_Page = "AlchemyFlasks1";
	},
	["AlchemyHealingAndMana1"] = {
		Title = AL["Health and Mana Potions"];
		Back_Page = "ALCHEMYMENU";
		Next_Page = "AlchemyTransmutes1";
		Prev_Page = "AlchemyProtectionPots1";
	},
	["AlchemyTransmutes1"] = {
		Title = AL["Transmutes"];
		Back_Page = "ALCHEMYMENU";
		Next_Page = "AlchemyDefensive1";
		Prev_Page = "AlchemyHealingAndMana1";
	},
	["AlchemyDefensive1"] = {
		Title = AL["Defensive Potions and Elixirs"];
		Back_Page = "ALCHEMYMENU";
		Next_Page = "AlchemyOffensive1";
		Prev_Page = "AlchemyTransmutes1";
	},
	["AlchemyOffensive1"] = {
		Title = AL["Offensive Potions and Elixirs"];
		Back_Page = "ALCHEMYMENU";
		Next_Page = "AlchemyOffensive2";
		Prev_Page = "AlchemyDefensive1";
	},
	["AlchemyOffensive2"] = {
		Title = AL["Offensive Potions and Elixirs"];
		Back_Page = "ALCHEMYMENU";
		Next_Page = "AlchemyMisc1";
		Prev_Page = "AlchemyOffensive1";
	},
	["AlchemyMisc1"] = {
		Title = AL["Miscellaneous"];
		Back_Page = "ALCHEMYMENU";
		Prev_Page = "AlchemyOffensive2";
	},
	["SmithingApprentice1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Apprentice"];
		Back_Page = "SMITHINGMENU";
		Next_Page = "SmithingJourneyman1";
	};
	["SmithingJourneyman1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Journeyman"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingApprentice1";
		Next_Page = "SmithingJourneyman2";
	};
	["SmithingJourneyman2"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Journeyman"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingJourneyman1";
		Next_Page = "SmithingExpert1";
	};
	["SmithingExpert1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Expert"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingJourneyman2";
		Next_Page = "SmithingExpert2";
	};
	["SmithingExpert2"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Expert"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingExpert1";
		Next_Page = "SmithingExpert3";
	};
	["SmithingExpert3"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Expert"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingExpert2";
		Next_Page = "SmithingArtisan1";
	};
	["SmithingArtisan1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Artisan"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingExpert3";
		Next_Page = "SmithingArtisan2";
	};
	["SmithingArtisan2"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Artisan"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingArtisan1";
		Next_Page = "SmithingArtisan3";
	};
	["SmithingArtisan3"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Artisan"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingArtisan2";
		Next_Page = "SmithingArtisan4";
	};
	["SmithingArtisan4"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Artisan"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingArtisan3";
		Next_Page = "SmithingHelm1";
	};
	["SmithingHelm1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Helm"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingArtisan4";
		Next_Page = "SmithingShoulders1";
	};
	["SmithingShoulders1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Shoulders"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingHelm1";
		Next_Page = "SmithingChest1";
	};
	["SmithingChest1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Chest"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingShoulders1";
		Next_Page = "SmithingChest2";
	};
	["SmithingChest2"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Chest"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingChest1";
		Next_Page = "SmithingBracers1";
	};
	["SmithingBracers1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Bracers"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingChest2";
		Next_Page = "SmithingGloves1";
	};
	["SmithingGloves1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Gloves"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingBracers1";
		Next_Page = "SmithingBelt1";
	};
	["SmithingBelt1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Belt"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingGloves1";
		Next_Page = "SmithingPants1";
	};
	["SmithingPants1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Pants"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingBelt1";
		Next_Page = "SmithingBoots1";
	};
	["SmithingBoots1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Boots"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingPants1";
		Next_Page = "SmithingBuckles1";
	};
	["SmithingBuckles1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Belt Buckles"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingBoots1";
		Next_Page = "SmithingAxes1";
	};
	["SmithingAxes1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Axes"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingBuckles1";
		Next_Page = "SmithingSwords1";
	};
	["SmithingSwords1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Swords"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingAxes1";
		Next_Page = "SmithingMaces1";
	};
	["SmithingMaces1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Maces"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingSwords1";
		Next_Page = "SmithingFist1";
	};
	["SmithingFist1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Fist"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingMaces1";
		Next_Page = "SmithingDaggers1";
	};
	["SmithingDaggers1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Daggers"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingFist1";
		Next_Page = "SmithingMisc1";
	};
	["SmithingMisc1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Misc"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingDaggers1";
		Next_Page = "SmithingMisc2";
	};
	["SmithingMisc2"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Misc"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingMisc1";
		Next_Page = "Armorsmith1";
	};
	["Armorsmith1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Armorsmith"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "SmithingMisc2";
		Next_Page = "Weaponsmith1";
	};
	["Weaponsmith1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Weaponsmith"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "Armorsmith1";
		Next_Page = "Axesmith1";
	};
	["Axesmith1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Master Axesmith"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "Weaponsmith1";
		Next_Page = "Hammersmith1";
	};
	["Hammersmith1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Master Hammersmith"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "Axesmith1";
		Next_Page = "Swordsmith1";
	};
	["Swordsmith1"] = {
		Title = AL["Blacksmithing"] .. ": " .. AL["Master Swordsmith"];
		Back_Page = "SMITHINGMENU";
		Prev_Page = "Hammersmith1";
	};
	["EnchantingApprentice1"] = {
		Title = AL["Enchanting"] .. ": " .. AL["Apprentice"];
		Back_Page = "ENCHANTINGMENU";
		Next_Page = "EnchantingJourneyman1";
	};
	["EnchantingJourneyman1"] = {
		Title = AL["Enchanting"] .. ": " .. AL["Journeyman"];
		Back_Page = "ENCHANTINGMENU";
		Prev_Page = "EnchantingApprentice1";
		Next_Page = "EnchantingJourneyman2";
	};
	["EnchantingJourneyman2"] = {
		Title = AL["Enchanting"] .. ": " .. AL["Journeyman"];
		Back_Page = "ENCHANTINGMENU";
		Prev_Page = "EnchantingJourneyman1";
		Next_Page = "EnchantingExpert1";
	};
	["EnchantingExpert1"] = {
		Title = AL["Enchanting"] .. ": " .. AL["Expert"];
		Back_Page = "ENCHANTINGMENU";
		Prev_Page = "EnchantingJourneyman2";
		Next_Page = "EnchantingExpert2";
	};
	["EnchantingExpert2"] = {
		Title = AL["Enchanting"] .. ": " .. AL["Expert"];
		Back_Page = "ENCHANTINGMENU";
		Prev_Page = "EnchantingExpert1";
		Next_Page = "EnchantingArtisan1";
	};
	["EnchantingArtisan1"] = {
		Title = AL["Enchanting"] .. ": " .. AL["Artisan"];
		Back_Page = "ENCHANTINGMENU";
		Prev_Page = "EnchantingExpert2";
		Next_Page = "EnchantingArtisan2";
	};
	["EnchantingArtisan2"] = {
		Title = AL["Enchanting"] .. ": " .. AL["Artisan"];
		Back_Page = "ENCHANTINGMENU";
		Prev_Page = "EnchantingArtisan1";
		Next_Page = "EnchantingArtisan3";
	};
	["EnchantingArtisan3"] = {
		Title = AL["Enchanting"] .. ": " .. AL["Artisan"];
		Back_Page = "ENCHANTINGMENU";
		Prev_Page = "EnchantingArtisan2";
		Next_Page = "EnchantingCloak1";
	};
	["EnchantingCloak1"] = {
		Title = AL["Enchanting"] .. ": " .. AL["Cloak"];
		Back_Page = "ENCHANTINGMENU";
		Prev_Page = "EnchantingArtisan3";
		Next_Page = "EnchantingChest1";
	};
	["EnchantingChest1"] = {
		Title = AL["Enchanting"] .. ": " .. AL["Chest"];
		Back_Page = "ENCHANTINGMENU";
		Prev_Page = "EnchantingCloak1";
		Next_Page = "EnchantingBracer1";
	};
	["EnchantingBracer1"] = {
		Title = AL["Enchanting"] .. ": " .. AL["Bracer"];
		Back_Page = "ENCHANTINGMENU";
		Prev_Page = "EnchantingChest1";
		Next_Page = "EnchantingGlove1";
	};
	["EnchantingGlove1"] = {
		Title = AL["Enchanting"] .. ": " .. AL["Gloves"];
		Back_Page = "ENCHANTINGMENU";
		Prev_Page = "EnchantingBracer1";
		Next_Page = "EnchantingBoots1";
	};
	["EnchantingBoots1"] = {
		Title = AL["Enchanting"] .. ": " .. AL["Boots"];
		Back_Page = "ENCHANTINGMENU";
		Prev_Page = "EnchantingGlove1";
		Next_Page = "Enchanting2HWeapon1";
	};
	["Enchanting2HWeapon1"] = {
		Title = AL["Enchanting"] .. ": " .. AL["2H Weapon"];
		Back_Page = "ENCHANTINGMENU";
		Prev_Page = "EnchantingBoots1";
		Next_Page = "EnchantingWeapon1";
	};
	["EnchantingWeapon1"] = {
		Title = AL["Enchanting"] .. ": " .. AL["Weapon"];
		Back_Page = "ENCHANTINGMENU";
		Prev_Page = "Enchanting2HWeapon1";
		Next_Page = "EnchantingShield1";
	};
	["EnchantingShield1"] = {
		Title = AL["Enchanting"] .. ": " .. AL["Shield"];
		Back_Page = "ENCHANTINGMENU";
		Prev_Page = "EnchantingWeapon1";
		Next_Page = "EnchantingMisc1";
	};
	["EnchantingMisc1"] = {
		Title = AL["Enchanting"] .. ": " .. AL["Misc"];
		Back_Page = "ENCHANTINGMENU";
		Prev_Page = "EnchantingShield1";
	};
	["EngineeringApprentice1"] = {
		Title = AL["Engineering"] .. ": " .. AL["Apprentice"];
		Back_Page = "ENGINEERINGMENU";
		Next_Page = "EngineeringJourneyman1";
	};
	["EngineeringJourneyman1"] = {
		Title = AL["Engineering"] .. ": " .. AL["Journeyman"];
		Back_Page = "ENGINEERINGMENU";
		Prev_Page = "EngineeringApprentice1";
		Next_Page = "EngineeringJourneyman2";
	};
	["EngineeringJourneyman2"] = {
		Title = AL["Engineering"] .. ": " .. AL["Journeyman"];
		Back_Page = "ENGINEERINGMENU";
		Prev_Page = "EngineeringJourneyman1";
		Next_Page = "EngineeringExpert1";
	};
	["EngineeringExpert1"] = {
		Title = AL["Engineering"] .. ": " .. AL["Expert"];
		Back_Page = "ENGINEERINGMENU";
		Prev_Page = "EngineeringJourneyman2";
		Next_Page = "EngineeringExpert2";
	};
	["EngineeringExpert2"] = {
		Title = AL["Engineering"] .. ": " .. AL["Expert"];
		Back_Page = "ENGINEERINGMENU";
		Prev_Page = "EngineeringExpert1";
		Next_Page = "EngineeringArtisan1";
	};
	["EngineeringArtisan1"] = {
		Title = AL["Engineering"] .. ": " .. AL["Artisan"];
		Back_Page = "ENGINEERINGMENU";
		Prev_Page = "EngineeringExpert2";
		Next_Page = "EngineeringArtisan2";
	};
	["EngineeringArtisan2"] = {
		Title = AL["Engineering"] .. ": " .. AL["Artisan"];
		Back_Page = "ENGINEERINGMENU";
		Prev_Page = "EngineeringArtisan1";
		Next_Page = "EngineeringEquipment1";
	};
	["EngineeringEquipment1"] = {
		Title = AL["Engineering"] .. ": " .. AL["Equipment"];
		Back_Page = "ENGINEERINGMENU";
		Prev_Page = "EngineeringArtisan2";
		Next_Page = "EngineeringTrinkets1";
	};
	["EngineeringTrinkets1"] = {
		Title = AL["Engineering"] .. ": " .. AL["Trinkets"];
		Back_Page = "ENGINEERINGMENU";
		Prev_Page = "EngineeringEquipment1";
		Next_Page = "EngineeringExplosives1";
	};
	["EngineeringExplosives1"] = {
		Title = AL["Engineering"] .. ": " .. AL["Explosives"];
		Back_Page = "ENGINEERINGMENU";
		Prev_Page = "EngineeringTrinkets1";
		Next_Page = "EngineeringWeapons1";
	};
	["EngineeringWeapons1"] = {
		Title = AL["Engineering"] .. ": " .. AL["Weapons"];
		Back_Page = "ENGINEERINGMENU";
		Prev_Page = "EngineeringExplosives1";
		Next_Page = "EngineeringParts1";
	};
	["EngineeringParts1"] = {
		Title = AL["Engineering"] .. ": " .. AL["Parts"];
		Back_Page = "ENGINEERINGMENU";
		Prev_Page = "EngineeringWeapons1";
		Next_Page = "EngineeringMisc1";
	};
	["EngineeringMisc1"] = {
		Title = AL["Engineering"] .. ": " .. AL["Misc"];
		Back_Page = "ENGINEERINGMENU";
		Prev_Page = "EngineeringParts1";
		Next_Page = "EngineeringMisc2";
	};
	["EngineeringMisc2"] = {
		Title = AL["Engineering"] .. ": " .. AL["Misc"];
		Back_Page = "ENGINEERINGMENU";
		Prev_Page = "EngineeringMisc1";
		Next_Page = "EngineeringMisc3";
	};
	["EngineeringMisc3"] = {
		Title = AL["Engineering"] .. ": " .. AL["Misc"];
		Back_Page = "ENGINEERINGMENU";
		Prev_Page = "EngineeringMisc2";
		Next_Page = "Gnomish1";
	};
	["Gnomish1"] = {
		Title = AL["Gnomish Engineering"];
		Back_Page = "ENGINEERINGMENU";
		Prev_Page = "EngineeringMisc3";
		Next_Page = "Goblin1";
	};
	["Goblin1"] = {
		Title = AL["Goblin Engineering"];
		Back_Page = "ENGINEERINGMENU";
		Prev_Page = "Gnomish1";
	};
	["LeatherApprentice1"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Apprentice"];
		Back_Page = "LEATHERWORKINGMENU";
		Next_Page = "LeatherJourneyman1";
	};
	["LeatherJourneyman1"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Journeyman"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherApprentice1";
		Next_Page = "LeatherJourneyman2";
	};
	["LeatherJourneyman2"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Journeyman"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherJourneyman1";
		Next_Page = "LeatherExpert1";
	};
	["LeatherExpert1"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Expert"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherJourneyman2";
		Next_Page = "LeatherExpert2";
	};
	["LeatherExpert2"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Expert"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherExpert1";
		Next_Page = "LeatherArtisan1";
	};
	["LeatherArtisan1"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Artisan"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherExpert2";
		Next_Page = "LeatherArtisan2";
	};
	["LeatherArtisan2"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Artisan"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherArtisan1";
		Next_Page = "LeatherArtisan3";
	};
	["LeatherArtisan3"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Artisan"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherArtisan2";
		Next_Page = "LeatherArtisan4";
	};
	["LeatherArtisan4"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Artisan"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherArtisan3";
		Next_Page = "LeatherHelm1";
	};
	["LeatherHelm1"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Helm"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherArtisan4";
		Next_Page = "LeatherShoulders1";
	};
	["LeatherShoulders1"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Shoulders"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherHelm1";
		Next_Page = "LeatherCloak1";
	};
	["LeatherCloak1"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Cloak"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherShoulders1";
		Next_Page = "LeatherChest1";
	};
	["LeatherChest1"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Chest"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherCloak1";
		Next_Page = "LeatherChest2";
	};
	["LeatherChest2"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Chest"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherChest1";
		Next_Page = "LeatherBracers1";
	};
	["LeatherBracers1"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Bracers"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherChest2";
		Next_Page = "LeatherGloves1";
	};
	["LeatherGloves1"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Gloves"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherBracers1";
		Next_Page = "LeatherGloves2";
	};
	["LeatherGloves2"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Gloves"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherGloves1";
		Next_Page = "LeatherBelt1";
	};
	["LeatherBelt1"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Belt"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherGloves2";
		Next_Page = "LeatherPants1";
	};
	["LeatherPants1"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Pants"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherBelt1";
		Next_Page = "LeatherPants2";
	};
	["LeatherPants2"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Pants"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherPants1";
		Next_Page = "LeatherBoots1";
	};
	["LeatherBoots1"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Boots"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherPants2";
		Next_Page = "LeatherBags1";
	};
	["LeatherBags1"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Bags"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherBoots1";
		Next_Page = "LeatherMisc1";
	};
	["LeatherMisc1"] = {
		Title = AL["Leatherworking"] .. ": " .. AL["Misc"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherBags1";
		Next_Page = "Dragonscale1";
	},
	["Dragonscale1"] = {
		Title = AL["Dragonscale Leatherworking"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "LeatherMisc1";
		Next_Page = "Elemental1";
	};
	["Elemental1"] = {
		Title = AL["Elemental Leatherworking"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "Dragonscale1";
		Next_Page = "Tribal1";
	};
	["Tribal1"] = {
		Title = AL["Tribal Leatherworking"];
		Back_Page = "LEATHERWORKINGMENU";
		Prev_Page = "Elemental1";
	};
	["JewelcraftingApprentice1"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Apprentice"];
		Back_Page = "JEWELCRAFTMENU";
		Next_Page = "JewelcraftingJourneyman1";
	};
	["JewelcraftingJourneyman1"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Journeyman"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingApprentice1";
		Next_Page = "JewelcraftingJourneyman2";
	};
	["JewelcraftingJourneyman2"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Journeyman"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingJourneyman1";
		Next_Page = "JewelcraftingExpert1";
	};
	["JewelcraftingExpert1"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Expert"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingJourneyman2";
		Next_Page = "JewelcraftingExpert2";
	};
	["JewelcraftingExpert2"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Expert"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingExpert1";
		Next_Page = "JewelcraftingExpert3";
	};
	["JewelcraftingExpert3"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Expert"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingExpert2";
		Next_Page = "JewelcraftingArtisan1";
	};
	["JewelcraftingArtisan1"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Artisan"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingExpert3";
		Next_Page = "JewelcraftingArtisan2";
	};
	["JewelcraftingArtisan2"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Artisan"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingArtisan1";
		Next_Page = "JewelcraftingGemstones1";
	};
	["JewelcraftingGemstones1"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Gemstones"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingArtisan2";
		Next_Page = "JewelcraftingRings1";
	};
	["JewelcraftingRings1"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Rings"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingGemstones1";
		Next_Page = "JewelcraftingRings2";
	};
	["JewelcraftingRings2"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Rings"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingRings1";
		Next_Page = "JewelcraftingAmulets1";
	};
	["JewelcraftingAmulets1"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Amulets"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingRings2";
		Next_Page = "JewelcraftingHelm1";
	};
	["JewelcraftingHelm1"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Head"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingAmulets1";
		Next_Page = "JewelcraftingBracers1";
	};
	["JewelcraftingBracers1"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Bracers"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingHelm1";
		Next_Page = "JewelcraftingOffHands1";
	};
	["JewelcraftingOffHands1"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Off-hand"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingBracers1";
		Next_Page = "JewelcraftingStaves1";
	};
	["JewelcraftingStaves1"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Staff"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingOffHands1";
		Next_Page = "JewelcraftingTrinkets1";
	};
	["JewelcraftingTrinkets1"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Trinkets"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingStaves1";
		Next_Page = "JewelcraftingMisc1";
	};
	["JewelcraftingMisc1"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Misc"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingTrinkets1";
		Next_Page = "JewelcraftingGemology1";
	};
	["JewelcraftingGemology1"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Gemology"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingMisc1";
		Next_Page = "JewelcraftingGoldsmithing1";
	};
	["JewelcraftingGoldsmithing1"] = {
		Title = AL["Jewelcrafting"] .. ": " .. AL["Goldsmithing"];
		Back_Page = "JEWELCRAFTMENU";
		Prev_Page = "JewelcraftingGemology1";
	};
	["Herbalism1"] = {
		Title = AL["Herbalism"];
		Back_Page = "CRAFTINGMENU";
		Next_Page = "Herbalism2";
	};
	["Herbalism2"] = {
		Title = AL["Herbalism"];
		Back_Page = "CRAFTINGMENU";
		Prev_Page = "Herbalism1";
	};
	["Mining1"] = {
		Title = AL["Mining"];
		Back_Page = "CRAFTINGMENU";
		Next_Page = "Smelting1";
	};
	["Smelting1"] = {
		Title = AL["Smelting"];
		Back_Page = "CRAFTINGMENU";
		Prev_Page = "Mining1";
	};
	["TailoringApprentice1"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Apprentice"];
		Back_Page = "TAILORINGMENU";
		Next_Page = "TailoringApprentice2";
	};
	["TailoringApprentice2"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Apprentice"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringApprentice1";
		Next_Page = "TailoringJourneyman1";
	};
	["TailoringJourneyman1"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Journeyman"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringApprentice2";
		Next_Page = "TailoringJourneyman2";
	};
	["TailoringJourneyman2"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Journeyman"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringJourneyman1";
		Next_Page = "TailoringExpert1";
	};
	["TailoringExpert1"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Expert"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringJourneyman2";
		Next_Page = "TailoringExpert2";
	};
	["TailoringExpert2"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Expert"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringExpert1";
		Next_Page = "TailoringExpert3";
	};
	["TailoringExpert3"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Expert"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringExpert2";
		Next_Page = "TailoringArtisan1";
	};
	["TailoringArtisan1"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Artisan"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringExpert3";
		Next_Page = "TailoringArtisan2";
	};
	["TailoringArtisan2"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Artisan"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringArtisan1";
		Next_Page = "TailoringArtisan3";
	};
	["TailoringArtisan3"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Artisan"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringArtisan2";
		Next_Page = "TailoringArtisan4";
	};
	["TailoringArtisan4"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Artisan"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringArtisan3";
		Next_Page = "TailoringArtisan5";
	};
	["TailoringArtisan5"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Artisan"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringArtisan4";
		Next_Page = "TailoringHelm1";
	};
	["TailoringHelm1"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Helm"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringArtisan5";
		Next_Page = "TailoringShoulders1";
	};
	["TailoringShoulders1"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Shoulders"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringHelm1";
		Next_Page = "TailoringCloak1";
	};
	["TailoringCloak1"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Cloak"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringShoulders1";
		Next_Page = "TailoringChest1";
	};
	["TailoringChest1"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Chest"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringCloak1";
		Next_Page = "TailoringChest2";
	};
	["TailoringChest2"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Chest"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringChest1";
		Next_Page = "TailoringBracers1";
	};
	["TailoringBracers1"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Bracers"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringChest2";
		Next_Page = "TailoringGloves1";
	};
	["TailoringGloves1"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Gloves"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringBracers1";
		Next_Page = "TailoringGloves2";
	};
	["TailoringGloves2"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Gloves"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringGloves1";
		Next_Page = "TailoringBelt1";
	};
	["TailoringBelt1"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Belt"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringGloves2";
		Next_Page = "TailoringPants1";
	};
	["TailoringPants1"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Pants"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringBelt1";
		Next_Page = "TailoringBoots1";
	};
	["TailoringBoots1"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Boots"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringPants1";
		Next_Page = "TailoringShirt1";
	};
	["TailoringShirt1"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Shirt"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringBoots1";
		Next_Page = "TailoringBags1";
	};
	["TailoringBags1"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Bags"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringShirt1";
		Next_Page = "TailoringMisc1";
	};
	["TailoringMisc1"] = {
		Title = AL["Tailoring"] .. ": " .. AL["Misc"];
		Back_Page = "TAILORINGMENU";
		Prev_Page = "TailoringBags1";
	};
	["CookingApprentice1"] = {
		Title = AL["Cooking"] .. ": " .. AL["Apprentice"];
		Back_Page = "COOKINGMENU";
		Next_Page = "CookingJourneyman1";
	};
	["CookingJourneyman1"] = {
		Title = AL["Cooking"] .. ": " .. AL["Journeyman"];
		Back_Page = "COOKINGMENU";
		Prev_Page = "CookingApprentice1";
		Next_Page = "CookingExpert1";
	};
	["CookingExpert1"] = {
		Title = AL["Cooking"] .. ": " .. AL["Expert"];
		Back_Page = "COOKINGMENU";
		Prev_Page = "CookingJourneyman1";
		Next_Page = "CookingArtisan1";
	};
	["CookingArtisan1"] = {
		Title = AL["Cooking"] .. ": " .. AL["Artisan"];
		Back_Page = "COOKINGMENU";
		Prev_Page = "CookingExpert1";
	};
	["FirstAid1"] = {
		Title = AL["First Aid"];
		Back_Page = "CRAFTINGMENU";
	};
	["Survival1"] = {
		Title = AL["Survival"];
		Back_Page = "CRAFTINGMENU";
	};
	["Survival2"] = {
		Title = AL["Gardening"];
		Back_Page = "CRAFTINGMENU";
	};
	["Poisons1"] = {
		Title = AL["Poisons"];
		Back_Page = "CRAFTINGMENU";
	};
};
