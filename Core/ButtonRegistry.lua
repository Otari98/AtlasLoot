local AL = AtlasLoot.L

AtlasLoot_ButtonRegistry = {
	-- Dungeons & Raids
	["DUNGEONSMENU1"] = {
		Next_Page = "DUNGEONSMENU2",
	},
	["DUNGEONSMENU2"] = {
		Prev_Page = "DUNGEONSMENU1",
	},

	["TMHSET"] = {
		Back_Page = "SETMENU"
	},
	["KARASET"] = {
		Back_Page = "SETMENU"
	},
    ["PRE60SET"] = {
		Back_Page = "SETMENU"
    },
    ["ZGSET"] = {
		Back_Page = "SETMENU"
    },
    ["AQ20SET"] = {
		Back_Page = "SETMENU"
    },
    ["AQ40SET"] = {
		Back_Page = "SETMENU"
    },
    ["T0SET"] = {
		Back_Page = "SETMENU"
    },
    ["T1SET"] = {
		Back_Page = "SETMENU"
    },
    ["T2SET"] = {
		Back_Page = "SETMENU"
    },
    ["T3SET"] = {
		Back_Page = "SETMENU"
    },

	["ALCHEMYMENU"] = {
		Back_Page = "CRAFTINGMENU"
	},
	["SMITHINGMENU"] = {
		Back_Page = "CRAFTINGMENU"
	},
	["ENCHANTINGMENU"] = {
		Back_Page = "CRAFTINGMENU"
	},
	["ENGINEERINGMENU"] = {
		Back_Page = "CRAFTINGMENU"
	},
	["LEATHERWORKINGMENU"] = {
		Back_Page = "CRAFTINGMENU"
	},
	["TAILORINGMENU"] = {
		Back_Page = "CRAFTINGMENU"
	},
	["JEWELCRAFTMENU"] = {
		Back_Page = "CRAFTINGMENU"
	},
	["CRAFTSET"] = {
		Back_Page = "CRAFTINGMENU"
	},

	["BRRepMenu"] = {
		Back_Page = "PVPMENU"
	},
	["WSGRepMenu"] = {
		Back_Page = "PVPMENU"
	},
	["ABRepMenu"] = {
		Back_Page = "PVPMENU"
	},
	["AVRepMenu"] = {
		Back_Page = "PVPMENU"
	},
	["PVPSET"] = {
		Back_Page = "PVPMENU"
	},

	-- Timbermaw Hold
	["TMHKarrsh"] = {
		Next_Page = "TMHRotgrowl",
		Back_Page = "DUNGEONSMENU2"
	},
	["TMHRotgrowl"] = {
		Prev_Page = "TMHKarrsh",
		Next_Page = "TMHLoktanag",
		Back_Page = "DUNGEONSMENU2"
	},
	["TMHLoktanag"] = {
		Prev_Page = "TMHRotgrowl",
		Next_Page = "TMHOrmanos",
		Back_Page = "DUNGEONSMENU2"
	},
	["TMHOrmanos"] = {
		Prev_Page = "TMHLoktanag",
		Next_Page = "TMHPartath",
		Back_Page = "DUNGEONSMENU2"
	},
	["TMHPartath"] = {
		Prev_Page = "TMHOrmanos",
		Next_Page = "TMHKronn",
		Back_Page = "DUNGEONSMENU2"
	},
	["TMHKronn"] = {
		Prev_Page = "TMHPartath",
		Next_Page = "TMHSelenaxx",
		Back_Page = "DUNGEONSMENU2"
	},
	["TMHSelenaxx"] = {
		Prev_Page = "TMHKronn",
		Next_Page = "TMHTrioch",
		Back_Page = "DUNGEONSMENU2"
	},
	["TMHTrioch"] = {
		Prev_Page = "TMHSelenaxx",
		Next_Page = "TMHUrsol",
		Back_Page = "DUNGEONSMENU2"
	},
	["TMHUrsol"] = {
		Prev_Page = "TMHTrioch",
		Next_Page = "TMHPerotharn",
		Back_Page = "DUNGEONSMENU2"
	},
	["TMHPerotharn"] = {
		Prev_Page = "TMHUrsol",
		Back_Page = "DUNGEONSMENU2"
	},

	-- Frostmane Hollow
	["FMHTansha"] = {
		Next_Page = "FMHKanza",
		Back_Page = "DUNGEONSMENU1"
	},
	["FMHKanza"] = {
		Prev_Page = "FMHTansha",
		Next_Page = "FMHBattlemaster",
		Back_Page = "DUNGEONSMENU1"
	},
	["FMHBattlemaster"] = {
		Prev_Page = "FMHKanza",
		Next_Page = "FMHHailar",
		Back_Page = "DUNGEONSMENU1"
	},
	["FMHHailar"] = {
		Prev_Page = "FMHBattlemaster",
		Back_Page = "DUNGEONSMENU1"
	},

	-- Windhorn Canyon
	["WHCPathun"] = {
		Next_Page = "WHCAhgktos",
		Back_Page = "DUNGEONSMENU1",
	},
	["WHCAhgktos"] = {
		Prev_Page = "WHCPathun",
		Next_Page = "WHCAmbassador",
		Back_Page = "DUNGEONSMENU1",
	},
	["WHCAmbassador"] = {
		Prev_Page = "WHCAhgktos",
		Next_Page = "WHCWalgan",
		Back_Page = "DUNGEONSMENU1",
	},
	["WHCWalgan"] = {
		Prev_Page = "WHCAmbassador",
		Next_Page = "WHCBonespeaker",
		Back_Page = "DUNGEONSMENU1",
	},
	["WHCBonespeaker"] = {
		Prev_Page = "WHCWalgan",
		Next_Page = "WHCProphet",
		Back_Page = "DUNGEONSMENU1",
	},
	["WHCProphet"] = {
		Prev_Page = "WHCBonespeaker",
		Next_Page = "WHCChieftan",
		Back_Page = "DUNGEONSMENU1",
	},
	["WHCChieftan"] = {
		Prev_Page = "WHCProphet",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Dragonmaw Retreat
	["DMRGowlfang"] = {
		Next_Page = "DMRBroodmother",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMRBroodmother"] = {
		Prev_Page = "DMRGowlfang",
		Next_Page = "DMRWebMaster",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMRWebMaster"] = {
		Prev_Page = "DMRBroodmother",
		Next_Page = "DMRGarlok",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMRGarlok"] = {
		Prev_Page = "DMRWebMaster",
		Next_Page = "DMRHalgan",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMRHalgan"] = {
		Prev_Page = "DMRGarlok",
		Next_Page = "DMRSlagfist",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMRSlagfist"] = {
		Prev_Page = "DMRHalgan",
		Next_Page = "DMROverlord",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMROverlord"] = {
		Prev_Page = "DMRSlagfist",
		Next_Page = "DMRElderHollowblood",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMRElderHollowblood"] = {
		Prev_Page = "DMROverlord",
		Next_Page = "DMRSearistrasz",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMRSearistrasz"] = {
		Prev_Page = "DMRElderHollowblood",
		Next_Page = "DMRZuluhed",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMRZuluhed"] = {
		Prev_Page = "DMRSearistrasz",
		Next_Page = "DMRTrash",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMRTrash"] = {
		Prev_Page = "DMRZuluhed",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Stormwrought Ruins
	["SWROronok"] = {
		Next_Page = "SWRDagar",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWRDagar"] = {
		Prev_Page = "SWROronok",
		Next_Page = "SWRDukeBalor",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWRDukeBalor"] = {
		Prev_Page = "SWRDagar",
		Next_Page = "SWRLibrarian",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWRLibrarian"] = {
		Prev_Page = "SWRDukeBalor",
		Next_Page = "SWRChieftain",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWRChieftain"] = {
		Prev_Page = "SWRLibrarian",
		Next_Page = "SWRDeathlord",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWRDeathlord"] = {
		Prev_Page = "SWRChieftain",
		Next_Page = "SWRSubjugator",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWRSubjugator"] = {
		Prev_Page = "SWRDeathlord",
		Next_Page = "SWRMycellakos",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWRMycellakos"] = {
		Prev_Page = "SWRSubjugator",
		Next_Page = "SWREldermaw",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWREldermaw"] = {
		Prev_Page = "SWRMycellakos",
		Next_Page = "SWRLadyDrazare",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWRLadyDrazare"] = {
		Prev_Page = "SWREldermaw",
		Next_Page = "SWRRemains",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWRRemains"] = {
		Prev_Page = "SWRLadyDrazare",
		Next_Page = "SWRMergothid",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWRMergothid"] = {
		Prev_Page = "SWRRemains",
		Next_Page = "SWRTrash",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWRTrash"] = {
		Prev_Page = "SWRMergothid",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Hateforge Quarry
	["HQHighForemanBargulBlackhammer"] = {
		Next_Page = "HQEngineerFiggles",
		Back_Page = "DUNGEONSMENU1",
	},
	["HQEngineerFiggles"] = {
		Next_Page = "HQCorrosis",
		Prev_Page = "HQHighForemanBargulBlackhammer",
		Back_Page = "DUNGEONSMENU1",
	},
	["HQCorrosis"] = {
		Next_Page = "HQHatereaverAnnihilator",
		Prev_Page = "HQEngineerFiggles",
		Back_Page = "DUNGEONSMENU1",
	},
	["HQHatereaverAnnihilator"] = {
		Next_Page = "HQHargeshDoomcaller",
		Prev_Page = "HQCorrosis",
		Back_Page = "DUNGEONSMENU1",
	},
	["HQHargeshDoomcaller"] = {
		Next_Page = "HQTrash",
		Prev_Page = "HQHatereaverAnnihilator",
		Back_Page = "DUNGEONSMENU1",
	},
	["HQTrash"] = {
		Prev_Page = "HQHargeshDoomcaller",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Karazhan Crypt
	["KCMarrowspike"] = {
		Next_Page = "KCHivaxxis",
		Back_Page = "DUNGEONSMENU2",
	},
	["KCHivaxxis"] = {
		Next_Page = "KCCorpsemuncher",
		Prev_Page = "KCMarrowspike",
		Back_Page = "DUNGEONSMENU2",
	},
	["KCCorpsemuncher"] = {
		Next_Page = "KCGuardCaptainGort",
		Prev_Page = "KCHivaxxis",
		Back_Page = "DUNGEONSMENU2",
	},
	["KCGuardCaptainGort"] = {
		Next_Page = "KCArchlichEnkhraz",
		Prev_Page = "KCCorpsemuncher",
		Back_Page = "DUNGEONSMENU2",
	},
	["KCArchlichEnkhraz"] = {
		Next_Page = "KCCommanderAndreon",
		Prev_Page = "KCGuardCaptainGort",
		Back_Page = "DUNGEONSMENU2",
	},
	["KCCommanderAndreon"] = {
		Next_Page = "KCAlarus",
		Prev_Page = "KCArchlichEnkhraz",
		Back_Page = "DUNGEONSMENU2",
	},
	["KCAlarus"] = {
		Next_Page = "KCTreasure",
		Prev_Page = "KCCommanderAndreon",
		Back_Page = "DUNGEONSMENU2",
	},
	["KCTreasure"] = {
		Prev_Page = "KCAlarus",
		Next_Page = "KCTrash",
		Back_Page = "DUNGEONSMENU2",
	},
	["KCTrash"] = {
		Prev_Page = "KCTreasure",
		Back_Page = "DUNGEONSMENU2",
	},

	-- Caverns of Time: Black Morass
	["COTBMChronar"] = {
		Next_Page = "COTBMEpidamu",
		Back_Page = "DUNGEONSMENU2",
	},
	["COTBMEpidamu"] = {
		Next_Page = "COTBMDriftingAvatar",
		Prev_Page = "COTBMChronar",
		Back_Page = "DUNGEONSMENU2",
	},
	["COTBMDriftingAvatar"] = {
		Next_Page = "COTBMTimeLordEpochronos",
		Prev_Page = "COTBMEpidamu",
		Back_Page = "DUNGEONSMENU2",
	},
	["COTBMTimeLordEpochronos"] = {
		Next_Page = "COTBMMossheart",
		Prev_Page = "COTBMDriftingAvatar",
		Back_Page = "DUNGEONSMENU2",
	},
	["COTBMMossheart"] = {
		Next_Page = "COTBMRotmaw",
		Prev_Page = "COTBMTimeLordEpochronos",
		Back_Page = "DUNGEONSMENU2",
	},
	["COTBMRotmaw"] = {
		Next_Page = "COTBMAntnormi",
		Prev_Page = "COTBMMossheart",
		Back_Page = "DUNGEONSMENU2",
	},
	["COTBMAntnormi"] = {
		Next_Page = "COTTrash",
		Prev_Page = "COTBMRotmaw",
		Back_Page = "DUNGEONSMENU2",
	},
	["COTTrash"] = {
		Prev_Page = "COTBMAntnormi",
		Back_Page = "DUNGEONSMENU2",
	},

	-- Stormwind Vault
	["SWVAszoshGrimflame"] = {
		Next_Page = "SWVThamGrarr",
		Back_Page = "DUNGEONSMENU2",
	},
	["SWVThamGrarr"] = {
		Next_Page = "SWVBlackBride",
		Prev_Page = "SWVAszoshGrimflame",
		Back_Page = "DUNGEONSMENU2",
	},
	["SWVBlackBride"] = {
		Next_Page = "SWVDamian",
		Prev_Page = "SWVThamGrarr",
		Back_Page = "DUNGEONSMENU2",
	},
	["SWVDamian"] = {
		Next_Page = "SWVVolkanCruelblade",
		Prev_Page = "SWVBlackBride",
		Back_Page = "DUNGEONSMENU2",
	},
	["SWVVolkanCruelblade"] = {
		Next_Page = "SWVVaultArmoryEquipment",
		Prev_Page = "SWVDamian",
		Back_Page = "DUNGEONSMENU2",
	},
	["SWVVaultArmoryEquipment"] = {
		Prev_Page = "SWVVolkanCruelblade",
		Next_Page = "SWVTrash",
		Back_Page = "DUNGEONSMENU2",
	},
	["SWVTrash"] = {
		Prev_Page = "SWVVaultArmoryEquipment",
		Back_Page = "DUNGEONSMENU2",
	},

	-- The Crescent Grove
	["TCGGrovetenderEngryss"] = {
		Next_Page = "TCGKeeperRanathos",
		Back_Page = "DUNGEONSMENU1",
	},
	["TCGKeeperRanathos"] = {
		Next_Page = "TCGHighPriestessAlathea",
		Prev_Page = "TCGGrovetenderEngryss",
		Back_Page = "DUNGEONSMENU1",
	},
	["TCGHighPriestessAlathea"] = {
		Next_Page = "TCGFenektistheDeceiver",
		Prev_Page = "TCGKeeperRanathos",
		Back_Page = "DUNGEONSMENU1",
	},
	["TCGFenektistheDeceiver"] = {
		Next_Page = "TCGMasterRaxxieth",
		Prev_Page = "TCGHighPriestessAlathea",
		Back_Page = "DUNGEONSMENU1",
	},
	["TCGMasterRaxxieth"] = {
		Next_Page = "TCGTrash",
		Prev_Page = "TCGFenektistheDeceiver",
		Back_Page = "DUNGEONSMENU1",
	},
	["TCGTrash"] = {
		Prev_Page = "TCGMasterRaxxieth",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Upper Karazhan Halls
	["UKHGnarlmoon"] = {
		Next_Page = "UKHIncantagos",
		Back_Page = "DUNGEONSMENU2",
	},
	["UKHIncantagos"] = {
		Next_Page = "UKHAnomalus",
		Prev_Page = "UKHGnarlmoon",
		Back_Page = "DUNGEONSMENU2",
	},
	["UKHAnomalus"] = {
		Next_Page = "UKHEcho",
		Prev_Page = "UKHIncantagos",
		Back_Page = "DUNGEONSMENU2",
	},
	["UKHEcho"] = {
		Next_Page = "UKHKing",
		Prev_Page = "UKHAnomalus",
		Back_Page = "DUNGEONSMENU2",
	},
	["UKHKing"] = {
		Next_Page = "UKHSanvTasdal",
		Prev_Page = "UKHEcho",
		Back_Page = "DUNGEONSMENU2",
	},
	["UKHSanvTasdal"] = {
		Next_Page = "UKHRupturan",
		Prev_Page = "UKHKing",
		Back_Page = "DUNGEONSMENU2",
	},
	["UKHRupturan"] = {
		Prev_Page = "UKHSanvTasdal",
		Next_Page = "UKHKruul",
		Back_Page = "DUNGEONSMENU2",
	},
	["UKHKruul"] = {
		Next_Page = "UKHMephistroth",
		Prev_Page = "UKHRupturan",
		Back_Page = "DUNGEONSMENU2",
	},
	["UKHMephistroth"] = {
		Prev_Page = "UKHRupturan",
		Next_Page = "UKHTrash",
		Back_Page = "DUNGEONSMENU2",
	},
	["UKHTrash"] = {
		Prev_Page = "UKHMephistroth",
		Back_Page = "DUNGEONSMENU2",
	},

	-- Gilneas City
	["GCMatthiasHoltz"] = {
		Next_Page = "GCPackmasterRagetooth",
		Back_Page = "DUNGEONSMENU1",
	},
	["GCPackmasterRagetooth"] = {
		Next_Page = "GCJudgeSutherland",
		Prev_Page = "GCMatthiasHoltz",
		Back_Page = "DUNGEONSMENU1",
	},
	["GCJudgeSutherland"] = {
		Prev_Page = "GCPackmasterRagetooth",
		Next_Page = "GCDustivanBlackcowl",
		Back_Page = "DUNGEONSMENU1",
	},
	["GCDustivanBlackcowl"] = {
		Prev_Page = "GCJudgeSutherland",
		Next_Page = "GCMarshalMagnusGreystone",
		Back_Page = "DUNGEONSMENU1",
	},
	["GCMarshalMagnusGreystone"] = {
		Prev_Page = "GCDustivanBlackcowl",
		Next_Page = "GCHorsemasterLevvin",
		Back_Page = "DUNGEONSMENU1",
	},
	["GCHorsemasterLevvin"] = {
		Prev_Page = "GCMarshalMagnusGreystone",
		Next_Page = "GCHarlowFamilyChest",
		Back_Page = "DUNGEONSMENU1",
	},
	["GCHarlowFamilyChest"] = {
		Prev_Page = "GCHorsemasterLevvin",
		Next_Page = "GCGennGreymane",
		Back_Page = "DUNGEONSMENU1",
	},
	["GCGennGreymane"] = {
		Prev_Page = "GCHarlowFamilyChest",
		Next_Page = "GCTrash",
		Back_Page = "DUNGEONSMENU1",
	},
	["GCTrash"] = {
		Prev_Page = "GCGennGreymane",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Blackrock Depths
	["BRDLordRoccor"] = {
		Next_Page = "BRDHighInterrogatorGerstahn",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDHighInterrogatorGerstahn"] = {
		Next_Page = "BRDAnubshiah",
		Prev_Page = "BRDLordRoccor",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDAnubshiah"] = {
		Next_Page = "BRDEviscerator",
		Prev_Page = "BRDHighInterrogatorGerstahn",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDEviscerator"] = {
		Next_Page = "BRDGorosh",
		Prev_Page = "BRDAnubshiah",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDGorosh"] = {
		Next_Page = "BRDGrizzle",
		Prev_Page = "BRDEviscerator",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDGrizzle"] = {
		Next_Page = "BRDHedrum",
		Prev_Page = "BRDGorosh",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDHedrum"] = {
		Next_Page = "BRDOkthor",
		Prev_Page = "BRDGrizzle",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDOkthor"] = {
		Next_Page = "BRDTheldren",
		Prev_Page = "BRDHedrum",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDTheldren"] = {
		Next_Page = "BRDHoundmaster",
		Prev_Page = "BRDOkthor",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDHoundmaster"] = {
		Next_Page = "BRDPyromancerLoregrain",
		Prev_Page = "BRDTheldren",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDPyromancerLoregrain"] = {
		Next_Page = "BRDTheVault",
		Prev_Page = "BRDHoundmaster",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDTheVault"] = {
		Next_Page = "BRDWarderStilgiss",
		Prev_Page = "BRDPyromancerLoregrain",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDWarderStilgiss"] = {
		Next_Page = "BRDVerek",
		Prev_Page = "BRDTheVault",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDVerek"] = {
		Next_Page = "BRDFineousDarkvire",
		Prev_Page = "BRDWarderStilgiss",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDFineousDarkvire"] = {
		Next_Page = "BRDLordIncendius",
		Prev_Page = "BRDVerek",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDLordIncendius"] = {
		Next_Page = "BRDBaelGar",
		Prev_Page = "BRDFineousDarkvire",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDBaelGar"] = {
		Next_Page = "BRDGeneralAngerforge",
		Prev_Page = "BRDLordIncendius",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDGeneralAngerforge"] = {
		Next_Page = "BRDGolemLordArgelmach",
		Prev_Page = "BRDBaelGar",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDGolemLordArgelmach"] = {
		Next_Page = "BRDGuzzler",
		Prev_Page = "BRDGeneralAngerforge",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDGuzzler"] = {
		Next_Page = "BRDFlamelash",
		Prev_Page = "BRDGolemLordArgelmach",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDFlamelash"] = {
		Next_Page = "BRDPanzor",
		Prev_Page = "BRDGuzzler",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDPanzor"] = {
		Next_Page = "BRDTomb",
		Prev_Page = "BRDFlamelash",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDTomb"] = {
		Next_Page = "BRDMagmus",
		Prev_Page = "BRDPanzor",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDMagmus"] = {
		Next_Page = "BRDPrincess",
		Prev_Page = "BRDTomb",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDPrincess"] = {
		Next_Page = "BRDEmperorDagranThaurissan",
		Prev_Page = "BRDMagmus",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDEmperorDagranThaurissan"] = {
		Next_Page = "BRDTrash",
		Prev_Page = "BRDPrincess",
		Back_Page = "DUNGEONSMENU1",
	},
	["BRDTrash"] = {
		Prev_Page = "BRDEmperorDagranThaurissan",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Lower Blackrock Spire
	["LBRSSpirestoneButcher"] = {
		Next_Page = "LBRSSpirestoneBattleLord",
		Back_Page = "DUNGEONSMENU2",
	},
	["LBRSSpirestoneBattleLord"] = {
		Next_Page = "LBRSSpirestoneLordMagus",
		Prev_Page = "LBRSSpirestoneButcher",
		Back_Page = "DUNGEONSMENU2",
	},
	["LBRSSpirestoneLordMagus"] = {
		Next_Page = "LBRSOmokk",
		Prev_Page = "LBRSSpirestoneBattleLord",
		Back_Page = "DUNGEONSMENU2",
	},
	["LBRSOmokk"] = {
		Next_Page = "LBRSVosh",
		Prev_Page = "LBRSSpirestoneLordMagus",
		Back_Page = "DUNGEONSMENU2",
	},
	["LBRSVosh"] = {
		Next_Page = "LBRSVoone",
		Prev_Page = "LBRSOmokk",
		Back_Page = "DUNGEONSMENU2",
	},
	["LBRSVoone"] = {
		Next_Page = "LBRSFelguard",
		Prev_Page = "LBRSVosh",
		Back_Page = "DUNGEONSMENU2",
	},
	["LBRSFelguard"] = {
		Next_Page = "LBRSGrayhoof",
		Prev_Page = "LBRSVoone",
		Back_Page = "DUNGEONSMENU2",
	},
	["LBRSGrayhoof"] = {
		Next_Page = "LBRSGrimaxe",
		Prev_Page = "LBRSFelguard",
		Back_Page = "DUNGEONSMENU2",
	},
	["LBRSGrimaxe"] = {
		Next_Page = "LBRSSmolderweb",
		Prev_Page = "LBRSGrayhoof",
		Back_Page = "DUNGEONSMENU2",
	},
	["LBRSSmolderweb"] = {
		Next_Page = "LBRSCrystalFang",
		Prev_Page = "LBRSGrimaxe",
		Back_Page = "DUNGEONSMENU2",
	},
	["LBRSCrystalFang"] = {
		Next_Page = "LBRSDoomhowl",
		Prev_Page = "LBRSSmolderweb",
		Back_Page = "DUNGEONSMENU2",
	},
	["LBRSDoomhowl"] = {
		Next_Page = "LBRSZigris",
		Prev_Page = "LBRSCrystalFang",
		Back_Page = "DUNGEONSMENU2",
	},
	["LBRSZigris"] = {
		Next_Page = "LBRSHalycon",
		Prev_Page = "LBRSDoomhowl",
		Back_Page = "DUNGEONSMENU2",
	},
	["LBRSHalycon"] = {
		Next_Page = "LBRSSlavener",
		Prev_Page = "LBRSZigris",
		Back_Page = "DUNGEONSMENU2",
	},
	["LBRSSlavener"] = {
		Next_Page = "LBRSBashguud",
		Prev_Page = "LBRSHalycon",
		Back_Page = "DUNGEONSMENU2",
	},
	["LBRSBashguud"] = {
		Next_Page = "LBRSWyrmthalak",
		Prev_Page = "LBRSSlavener",
		Back_Page = "DUNGEONSMENU2",
	},
	["LBRSWyrmthalak"] = {
		Next_Page = "LBRSTrash",
		Prev_Page = "LBRSBashguud",
		Back_Page = "DUNGEONSMENU2",
	},
	["LBRSTrash"] = {
		Prev_Page = "LBRSWyrmthalak",
		Back_Page = "DUNGEONSMENU2",
	},

	-- Upper Blackrock Spire
	["UBRSEmberseer"] = {
		Next_Page = "UBRSSolakar",
		Back_Page = "DUNGEONSMENU2",
	},
	["UBRSSolakar"] = {
		Next_Page = "UBRSFlame",
		Prev_Page = "UBRSEmberseer",
		Back_Page = "DUNGEONSMENU2",
	},
	["UBRSFlame"] = {
		Next_Page = "UBRSRunewatcher",
		Prev_Page = "UBRSSolakar",
		Back_Page = "DUNGEONSMENU2",
	},
	["UBRSRunewatcher"] = {
		Next_Page = "UBRSAnvilcrack",
		Prev_Page = "UBRSFlame",
		Back_Page = "DUNGEONSMENU2",
	},
	["UBRSAnvilcrack"] = {
		Next_Page = "UBRSRend",
		Prev_Page = "UBRSRunewatcher",
		Back_Page = "DUNGEONSMENU2",
	},
	["UBRSRend"] = {
		Next_Page = "UBRSGyth",
		Prev_Page = "UBRSAnvilcrack",
		Back_Page = "DUNGEONSMENU2",
	},
	["UBRSGyth"] = {
		Next_Page = "UBRSBeast",
		Prev_Page = "UBRSRend",
		Back_Page = "DUNGEONSMENU2",
	},
	["UBRSBeast"] = {
		Next_Page = "UBRSValthalak",
		Prev_Page = "UBRSGyth",
		Back_Page = "DUNGEONSMENU2",
	},
	["UBRSValthalak"] = {
		Next_Page = "UBRSDrakkisath",
		Prev_Page = "UBRSBeast",
		Back_Page = "DUNGEONSMENU2",
	},
	["UBRSDrakkisath"] = {
		Next_Page = "UBRSTrash",
		Prev_Page = "UBRSValthalak",
		Back_Page = "DUNGEONSMENU2",
	},
	["UBRSTrash"] = {
		Prev_Page = "UBRSDrakkisath",
		Back_Page = "DUNGEONSMENU2",
	},

	-- Blackwing Lair
	["BWLRazorgore"] = {
		Next_Page = "BWLVaelastrasz",
		Back_Page = "DUNGEONSMENU2",
	},
	["BWLVaelastrasz"] = {
		Next_Page = "BWLLashlayer",
		Prev_Page = "BWLRazorgore",
		Back_Page = "DUNGEONSMENU2",
	},
	["BWLLashlayer"] = {
		Next_Page = "BWLFiremaw",
		Prev_Page = "BWLVaelastrasz",
		Back_Page = "DUNGEONSMENU2",
	},
	["BWLFiremaw"] = {
		Next_Page = "BWLEzzel",
		Prev_Page = "BWLLashlayer",
		Back_Page = "DUNGEONSMENU2",
	},
	["BWLEzzel"] = {
		Next_Page = "BWLEbonroc",
		Prev_Page = "BWLFiremaw",
		Back_Page = "DUNGEONSMENU2",
	},
	["BWLEbonroc"] = {
		Next_Page = "BWLFlamegor",
		Prev_Page = "BWLEzzel",
		Back_Page = "DUNGEONSMENU2",
	},
	["BWLFlamegor"] = {
		Next_Page = "BWLChromaggus",
		Prev_Page = "BWLEbonroc",
		Back_Page = "DUNGEONSMENU2",
	},
	["BWLChromaggus"] = {
		Next_Page = "BWLNefarian",
		Prev_Page = "BWLFlamegor",
		Back_Page = "DUNGEONSMENU2",
	},
	["BWLNefarian"] = {
		Next_Page = "BWLTrashMobs",
		Prev_Page = "BWLChromaggus",
		Back_Page = "DUNGEONSMENU2",
	},
	["BWLTrashMobs"] = {
		Prev_Page = "BWLNefarian",
		Back_Page = "DUNGEONSMENU2",
	},

	-- The Deadmines
	["DMJaredVoss"] = {
		Next_Page = "DMRhahkZor",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMRhahkZor"] = {
		Next_Page = "DMMinerJohnson",
		Prev_Page = "DMJaredVoss",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMMinerJohnson"] = {
		Next_Page = "DMSneed",
		Prev_Page = "DMRhahkZor",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMSneed"] = {
		Next_Page = "DMSneedsShredder",
		Prev_Page = "DMMinerJohnson",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMSneedsShredder"] = {
		Next_Page = "DMGilnid",
		Prev_Page = "DMSneed",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMGilnid"] = {
		Next_Page = "DMHarvester",
		Prev_Page = "DMSneedsShredder",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMHarvester"] = {
		Next_Page = "DMMrSmite",
		Prev_Page = "DMGilnid",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMMrSmite"] = {
		Next_Page = "DMCookie",
		Prev_Page = "DMHarvester",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMCookie"] = {
		Next_Page = "DMCaptainGreenskin",
		Prev_Page = "DMMrSmite",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMCaptainGreenskin"] = {
		Next_Page = "DMVanCleef",
		Prev_Page = "DMCookie",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMVanCleef"] = {
		Next_Page = "DMTrash",
		Prev_Page = "DMCaptainGreenskin",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMTrash"] = {
		Prev_Page = "DMVanCleef",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Gnomeregan
	["GnGrubbis"] = {
		Next_Page = "GnViscousFallout",
		Back_Page = "DUNGEONSMENU1",
	},
	["GnViscousFallout"] = {
		Next_Page = "GnElectrocutioner6000",
		Prev_Page = "GnGrubbis",
		Back_Page = "DUNGEONSMENU1",
	},
	["GnElectrocutioner6000"] = {
		Next_Page = "GnCrowdPummeler960",
		Prev_Page = "GnViscousFallout",
		Back_Page = "DUNGEONSMENU1",
	},
	["GnCrowdPummeler960"] = {
		Next_Page = "GnDIAmbassador",
		Prev_Page = "GnElectrocutioner6000",
		Back_Page = "DUNGEONSMENU1",
	},
	["GnDIAmbassador"] = {
		Next_Page = "GnMekgineerThermaplugg",
		Prev_Page = "GnCrowdPummeler960",
		Back_Page = "DUNGEONSMENU1",
	},
	["GnMekgineerThermaplugg"] = {
		Next_Page = "GnTrash",
		Prev_Page = "GnDIAmbassador",
		Back_Page = "DUNGEONSMENU1",
	},
	["GnTrash"] = {
		Prev_Page = "GnMekgineerThermaplugg",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Molten Core
	["MCIncindis"] = {
		Next_Page = "MCLucifron",
		Back_Page = "DUNGEONSMENU2",
	},
	["MCLucifron"] = {
		Next_Page = "MCMagmadar",
		Prev_Page = "MCIncindis",
		Back_Page = "DUNGEONSMENU2",
	},
	["MCMagmadar"] = {
		Next_Page = "MCGarr",
		Prev_Page = "MCLucifron",
		Back_Page = "DUNGEONSMENU2",
	},

	-- ["MCGehennas"] = {
	-- 	Next_Page = "MCGarr";
	-- 	Prev_Page = "MCMagmadar";
	-- 	Back_Page = "DUNGEONSMENU2";
	-- };
	["MCGarr"] = {
		Next_Page = "MCShazzrah",
		Prev_Page = "MCMagmadar",
		Back_Page = "DUNGEONSMENU2",
	},
	["MCShazzrah"] = {
		Next_Page = "MCGeddon",
		Prev_Page = "MCGarr",
		Back_Page = "DUNGEONSMENU2",
	},
	["MCGeddon"] = {
		Next_Page = "MCGolemagg",
		Prev_Page = "MCShazzrah",
		Back_Page = "DUNGEONSMENU2",
	},
	["MCGolemagg"] = {
		Next_Page = "MCTwins",
		Prev_Page = "MCGeddon",
		Back_Page = "DUNGEONSMENU2",
	},
	["MCTwins"] = {
		Next_Page = "MCThaurissan",
		Prev_Page = "MCGolemagg",
		Back_Page = "DUNGEONSMENU2",
	},
	["MCThaurissan"] = {
		Next_Page = "MCSulfuron",
		Prev_Page = "MCTwins",
		Back_Page = "DUNGEONSMENU2",
	},
	["MCSulfuron"] = {
		Next_Page = "MCMajordomo",
		Prev_Page = "MCThaurissan",
		Back_Page = "DUNGEONSMENU2",
	},
	["MCMajordomo"] = {
		Next_Page = "MCRagnaros",
		Prev_Page = "MCSulfuron",
		Back_Page = "DUNGEONSMENU2",
	},
	["MCRagnaros"] = {
		Next_Page = "MCTrashMobs",
		Prev_Page = "MCMajordomo",
		Back_Page = "DUNGEONSMENU2",
	},
	["MCTrashMobs"] = {
		Next_Page = "MCRANDOMBOSSDROPS",
		Prev_Page = "MCRagnaros",
		Back_Page = "DUNGEONSMENU2",
	},
	["MCRANDOMBOSSDROPS"] = {
		Prev_Page = "MCTrashMobs",
		Back_Page = "DUNGEONSMENU2",
	},

	-- Naxxramas
	["NAXPatchwerk"] = {
		Next_Page = "NAXGrobbulus",
		Back_Page = "DUNGEONSMENU2",
	},
	["NAXGrobbulus"] = {
		Next_Page = "NAXGluth",
		Prev_Page = "NAXPatchwerk",
		Back_Page = "DUNGEONSMENU2",
	},
	["NAXGluth"] = {
		Next_Page = "NAXThaddius",
		Prev_Page = "NAXGrobbulus",
		Back_Page = "DUNGEONSMENU2",
	},
	["NAXThaddius"] = {
		Next_Page = "NAXAnubRekhan",
		Prev_Page = "NAXGluth",
		Back_Page = "DUNGEONSMENU2",
	},
	["NAXAnubRekhan"] = {
		Next_Page = "NAXGrandWidowFaerlina",
		Prev_Page = "NAXThaddius",
		Back_Page = "DUNGEONSMENU2",
	},
	["NAXGrandWidowFaerlina"] = {
		Next_Page = "NAXMaexxna",
		Prev_Page = "NAXAnubRekhan",
		Back_Page = "DUNGEONSMENU2",
	},
	["NAXMaexxna"] = {
		Next_Page = "NAXNoththePlaguebringer",
		Prev_Page = "NAXGrandWidowFaerlina",
		Back_Page = "DUNGEONSMENU2",
	},
	["NAXNoththePlaguebringer"] = {
		Next_Page = "NAXHeigantheUnclean",
		Prev_Page = "NAXMaexxna",
		Back_Page = "DUNGEONSMENU2",
	},
	["NAXHeigantheUnclean"] = {
		Next_Page = "NAXLoatheb",
		Prev_Page = "NAXNoththePlaguebringer",
		Back_Page = "DUNGEONSMENU2",
	},
	["NAXLoatheb"] = {
		Next_Page = "NAXInstructorRazuvious",
		Prev_Page = "NAXHeigantheUnclean",
		Back_Page = "DUNGEONSMENU2",
	},
	["NAXInstructorRazuvious"] = {
		Next_Page = "NAXGothiktheHarvester",
		Prev_Page = "NAXLoatheb",
		Back_Page = "DUNGEONSMENU2",
	},
	["NAXGothiktheHarvester"] = {
		Next_Page = "NAXTheFourHorsemen",
		Prev_Page = "NAXInstructorRazuvious",
		Back_Page = "DUNGEONSMENU2",
	},
	["NAXTheFourHorsemen"] = {
		Next_Page = "NAXSapphiron",
		Prev_Page = "NAXGothiktheHarvester",
		Back_Page = "DUNGEONSMENU2",
	},
	["NAXSapphiron"] = {
		Next_Page = "NAXKelThuzard",
		Prev_Page = "NAXTheFourHorsemen",
		Back_Page = "DUNGEONSMENU2",
	},
	["NAXKelThuzard"] = {
		Next_Page = "NAXTrash",
		Prev_Page = "NAXSapphiron",
		Back_Page = "DUNGEONSMENU2",
	},
	["NAXTrash"] = {
		Prev_Page = "NAXKelThuzard",
		Back_Page = "DUNGEONSMENU2",
	},

	-- Scarlet Monastery
	["SMVishas"] = {
		Next_Page = "SMDukeDreadmoore",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMDukeDreadmoore"] = {
		Next_Page = "SMScorn",
		Prev_Page = "SMVishas",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMScorn"] = {
		Next_Page = "SMIronspine",
		Prev_Page = "SMDukeDreadmoore",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMIronspine"] = {
		Next_Page = "SMAzshir",
		Prev_Page = "SMScorn",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMAzshir"] = {
		Next_Page = "SMFallenChampion",
		Prev_Page = "SMIronspine",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMFallenChampion"] = {
		Next_Page = "SMBloodmageThalnos",
		Prev_Page = "SMAzshir",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMBloodmageThalnos"] = {
		Next_Page = "SMGTrash",
		Prev_Page = "SMFallenChampion",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMGTrash"] = {
		Prev_Page = "SMBloodmageThalnos",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMHoundmasterLoksey"] = {
		Next_Page = "SMBrotherWystan",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMBrotherWystan"] = {
		Next_Page = "SMDoan",
		Prev_Page = "SMHoundmasterLoksey",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMDoan"] = {
		Next_Page = "SMLTrash",
		Prev_Page = "SMBrotherWystan",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMLTrash"] = {
		Prev_Page = "SMDoan",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMHerod"] = {
		Next_Page = "SMQuartermaster",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMQuartermaster"] = {
		Next_Page = "SMATrash",
		Prev_Page = "SMHerod",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMATrash"] = {
		Prev_Page = "SMQuartermaster",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMFairbanks"] = {
		Next_Page = "SMMograine",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMMograine"] = {
		Next_Page = "SMWhitemane",
		Prev_Page = "SMFairbanks",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMWhitemane"] = {
		Next_Page = "SMCTrash",
		Prev_Page = "SMMograine",
		Back_Page = "DUNGEONSMENU1",
	},
	["SMCTrash"] = {
		Prev_Page = "SMWhitemane",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Scholomance
	["SCHOLOBlood"] = {
		Next_Page = "SCHOLOKirtonostheHerald",
		Back_Page = "DUNGEONSMENU1",
	},
	["SCHOLOKirtonostheHerald"] = {
		Next_Page = "SCHOLOJandiceBarov",
		--Prev_Page = "SCHOLOBlood";
		Back_Page = "DUNGEONSMENU1",
	},
	["SCHOLOJandiceBarov"] = {
		Next_Page = "SCHOLOLordBlackwood",
		Prev_Page = "SCHOLOKirtonostheHerald",
		Back_Page = "DUNGEONSMENU1",
	},
	["SCHOLOLordBlackwood"] = {
		Next_Page = "SCHOLORattlegore",
		Prev_Page = "SCHOLOJandiceBarov",
		Back_Page = "DUNGEONSMENU1",
	},
	["SCHOLORattlegore"] = {
		Next_Page = "SCHOLODeathKnight",
		Prev_Page = "SCHOLOLordBlackwood",
		Back_Page = "DUNGEONSMENU1",
	},
	["SCHOLODeathKnight"] = {
		Next_Page = "SCHOLOMarduk",
		Prev_Page = "SCHOLORattlegore",
		Back_Page = "DUNGEONSMENU1",
	},
	["SCHOLOMarduk"] = {
		Next_Page = "SCHOLOVectus",
		Prev_Page = "SCHOLODeathKnight",
		Back_Page = "DUNGEONSMENU1",
	},
	["SCHOLOVectus"] = {
		Next_Page = "SCHOLORasFrostwhisper",
		Prev_Page = "SCHOLOMarduk",
		Back_Page = "DUNGEONSMENU1",
	},
	["SCHOLORasFrostwhisper"] = {
		Next_Page = "SCHOLOKormok",
		Prev_Page = "SCHOLOVectus",
		Back_Page = "DUNGEONSMENU1",
	},
	["SCHOLOKormok"] = {
		Next_Page = "SCHOLOInstructorMalicia",
		Prev_Page = "SCHOLORasFrostwhisper",
		Back_Page = "DUNGEONSMENU1",
	},
	["SCHOLOInstructorMalicia"] = {
		Next_Page = "SCHOLODoctorTheolenKrastinov",
		Prev_Page = "SCHOLOKormok",
		Back_Page = "DUNGEONSMENU1",
	},
	["SCHOLODoctorTheolenKrastinov"] = {
		Next_Page = "SCHOLOLorekeeperPolkelt",
		Prev_Page = "SCHOLOInstructorMalicia",
		Back_Page = "DUNGEONSMENU1",
	},
	["SCHOLOLorekeeperPolkelt"] = {
		Next_Page = "SCHOLOTheRavenian",
		Prev_Page = "SCHOLODoctorTheolenKrastinov",
		Back_Page = "DUNGEONSMENU1",
	},
	["SCHOLOTheRavenian"] = {
		Next_Page = "SCHOLOLordAlexeiBarov",
		Prev_Page = "SCHOLOLorekeeperPolkelt",
		Back_Page = "DUNGEONSMENU1",
	},
	["SCHOLOLordAlexeiBarov"] = {
		Next_Page = "SCHOLOLadyIlluciaBarov",
		Prev_Page = "SCHOLOTheRavenian",
		Back_Page = "DUNGEONSMENU1",
	},
	["SCHOLOLadyIlluciaBarov"] = {
		Next_Page = "SCHOLODarkmasterGandling",
		Prev_Page = "SCHOLOLordAlexeiBarov",
		Back_Page = "DUNGEONSMENU1",
	},
	["SCHOLODarkmasterGandling"] = {
		Next_Page = "SCHOLOTrash",
		Prev_Page = "SCHOLOLadyIlluciaBarov",
		Back_Page = "DUNGEONSMENU1",
	},
	["SCHOLOTrash"] = {
		Prev_Page = "SCHOLODarkmasterGandling",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Shadowfang Keep
	["SFKRethilgore"] = {
		Next_Page = "SFKFelSteed",
		Back_Page = "DUNGEONSMENU1",
	},
	["SFKFelSteed"] = {
		Next_Page = "SFKRazorclawtheButcher",
		Prev_Page = "SFKRethilgore",
		Back_Page = "DUNGEONSMENU1",
	},
	["SFKRazorclawtheButcher"] = {
		Next_Page = "SFKSilverlaine",
		Prev_Page = "SFKFelSteed",
		Back_Page = "DUNGEONSMENU1",
	},
	["SFKSilverlaine"] = {
		Next_Page = "SFKSpringvale",
		Prev_Page = "SFKRazorclawtheButcher",
		Back_Page = "DUNGEONSMENU1",
	},
	["SFKSpringvale"] = {
		Next_Page = "SFKSever",
		Prev_Page = "SFKSilverlaine",
		Back_Page = "DUNGEONSMENU1",
	},
	["SFKSever"] = {
		Next_Page = "SFKOdotheBlindwatcher",
		Prev_Page = "SFKSpringvale",
		Back_Page = "DUNGEONSMENU1",
	},
	["SFKOdotheBlindwatcher"] = {
		Next_Page = "SFKDeathswornCaptain",
		Prev_Page = "SFKSever",
		Back_Page = "DUNGEONSMENU1",
	},
	["SFKDeathswornCaptain"] = {
		Next_Page = "SFKFenrustheDevourer",
		Prev_Page = "SFKOdotheBlindwatcher",
		Back_Page = "DUNGEONSMENU1",
	},
	["SFKFenrustheDevourer"] = {
		Next_Page = "SFKArugalsVoidwalker",
		Prev_Page = "SFKDeathswornCaptain",
		Back_Page = "DUNGEONSMENU1",
	},
	["SFKArugalsVoidwalker"] = {
		Next_Page = "SFKWolfMasterNandos",
		Prev_Page = "SFKFenrustheDevourer",
		Back_Page = "DUNGEONSMENU1",
	},
	["SFKWolfMasterNandos"] = {
		Next_Page = "SFKArchmageArugal",
		Prev_Page = "SFKArugalsVoidwalker",
		Back_Page = "DUNGEONSMENU1",
	},
	["SFKArchmageArugal"] = {
		Next_Page = "SFKPrelate",
		Prev_Page = "SFKWolfMasterNandos",
		Back_Page = "DUNGEONSMENU1",
	},
	["SFKPrelate"] = {
		Prev_Page = "SFKArchmageArugal",
		Next_Page = "SFKTrash",
		Back_Page = "DUNGEONSMENU1",
	},
	["SFKTrash"] = {
		Prev_Page = "SFKPrelate",
		Back_Page = "DUNGEONSMENU1",
	},

	-- The Stockade
	["SWStTargorr"] = {
		Next_Page = "SWStKamDeepfury",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWStKamDeepfury"] = {
		Next_Page = "SWStHamhock",
		Prev_Page = "SWStTargorr",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWStHamhock"] = {
		Next_Page = "SWStDextren",
		Prev_Page = "SWStKamDeepfury",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWStDextren"] = {
		Next_Page = "SWStBazil",
		Prev_Page = "SWStHamhock",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWStBazil"] = {
		Next_Page = "SWStBruegalIronknuckle",
		Prev_Page = "SWStDextren",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWStBruegalIronknuckle"] = {
		Next_Page = "SWStTrash",
		Prev_Page = "SWStBazil",
		Back_Page = "DUNGEONSMENU1",
	},
	["SWStTrash"] = {
		Prev_Page = "SWStBruegalIronknuckle",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Stratholme
	["STRATSkull"] = {
		Next_Page = "STRATStratholmeCourier",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATStratholmeCourier"] = {
		Next_Page = "STRATPostmaster",
		Prev_Page = "STRATSkull",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATPostmaster"] = {
		Next_Page = "STRATFrasSiabi",
		Prev_Page = "STRATStratholmeCourier",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATFrasSiabi"] = {
		Next_Page = "STRATAtiesh",
		Prev_Page = "STRATPostmaster",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATAtiesh"] = {
		Next_Page = "STRATBalzaphon",
		Prev_Page = "STRATFrasSiabi",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATBalzaphon"] = {
		Next_Page = "STRATHearthsingerForresten",
		Prev_Page = "STRATAtiesh",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATHearthsingerForresten"] = {
		Next_Page = "STRATTheUnforgiven",
		Prev_Page = "STRATBalzaphon",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATTheUnforgiven"] = {
		Next_Page = "STRATTimmytheCruel",
		Prev_Page = "STRATHearthsingerForresten",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATTimmytheCruel"] = {
		Next_Page = "STRATMalor",
		Prev_Page = "STRATTheUnforgiven",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATMalor"] = {
		Next_Page = "STRATMalorsStrongbox",
		Prev_Page = "STRATTimmytheCruel",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATMalorsStrongbox"] = {
		Next_Page = "STRATCrimsonHammersmith",
		Prev_Page = "STRATMalor",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATCrimsonHammersmith"] = {
		Next_Page = "STRATCannonMasterWilley",
		Prev_Page = "STRATMalorsStrongbox",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATCannonMasterWilley"] = {
		Next_Page = "STRATArchivistGalford",
		Prev_Page = "STRATCrimsonHammersmith",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATArchivistGalford"] = {
		Next_Page = "STRATBalnazzar",
		Prev_Page = "STRATCannonMasterWilley",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATBalnazzar"] = {
		Next_Page = "STRATSothosJarien",
		Prev_Page = "STRATArchivistGalford",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATSothosJarien"] = {
		Next_Page = "STRATStonespine",
		Prev_Page = "STRATBalnazzar",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATStonespine"] = {
		Next_Page = "STRATBaronessAnastari",
		Prev_Page = "STRATSothosJarien",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATBaronessAnastari"] = {
		Next_Page = "STRATBlackGuardSwordsmith",
		Prev_Page = "STRATStonespine",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATBlackGuardSwordsmith"] = {
		Next_Page = "STRATNerubenkan",
		Prev_Page = "STRATBaronessAnastari",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATNerubenkan"] = {
		Next_Page = "STRATMalekithePallid",
		Prev_Page = "STRATBlackGuardSwordsmith",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATMalekithePallid"] = {
		Next_Page = "STRATMagistrateBarthilas",
		Prev_Page = "STRATNerubenkan",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATMagistrateBarthilas"] = {
		Next_Page = "STRATRamsteintheGorger",
		Prev_Page = "STRATMalekithePallid",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATRamsteintheGorger"] = {
		Next_Page = "STRATBaronRivendare",
		Prev_Page = "STRATMagistrateBarthilas",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATBaronRivendare"] = {
		Next_Page = "STRATTrash",
		Prev_Page = "STRATRamsteintheGorger",
		Back_Page = "DUNGEONSMENU1",
	},
	["STRATTrash"] = {
		Prev_Page = "STRATBaronRivendare",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Sunken Temple
	["STBalconyMinibosses"] = {
		Next_Page = "STAtalalarion",
		Back_Page = "DUNGEONSMENU1",
	},
	["STAtalalarion"] = {
		Next_Page = "STSpawnOfHakkar",
		Prev_Page = "STBalconyMinibosses",
		Back_Page = "DUNGEONSMENU1",
	},
	["STSpawnOfHakkar"] = {
		Next_Page = "STAvatarofHakkar",
		Prev_Page = "STAtalalarion",
		Back_Page = "DUNGEONSMENU1",
	},
	["STAvatarofHakkar"] = {
		Next_Page = "STJammalan",
		Prev_Page = "STSpawnOfHakkar",
		Back_Page = "DUNGEONSMENU1",
	},
	["STJammalan"] = {
		Next_Page = "STOgom",
		Prev_Page = "STAvatarofHakkar",
		Back_Page = "DUNGEONSMENU1",
	},
	["STOgom"] = {
		Next_Page = "STDreamscythe",
		Prev_Page = "STJammalan",
		Back_Page = "DUNGEONSMENU1",
	},
	["STDreamscythe"] = {
		Next_Page = "STWeaver",
		Prev_Page = "STOgom",
		Back_Page = "DUNGEONSMENU1",
	},
	["STWeaver"] = {
		Next_Page = "STMorphaz",
		Prev_Page = "STDreamscythe",
		Back_Page = "DUNGEONSMENU1",
	},
	["STMorphaz"] = {
		Next_Page = "STHazzas",
		Prev_Page = "STWeaver",
		Back_Page = "DUNGEONSMENU1",
	},
	["STHazzas"] = {
		Next_Page = "STEranikus",
		Prev_Page = "STMorphaz",
		Back_Page = "DUNGEONSMENU1",
	},
	["STEranikus"] = {
		Next_Page = "STTrash",
		Prev_Page = "STHazzas",
		Back_Page = "DUNGEONSMENU1",
	},
	["STTrash"] = {
		Prev_Page = "STEranikus",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Uldaman
	["UldBaelog"] = {
		Next_Page = "UldOlaf",
		Back_Page = "DUNGEONSMENU1",
	},
	["UldOlaf"] = {
		Next_Page = "UldEric",
		Prev_Page = "UldBaelog",
		Back_Page = "DUNGEONSMENU1",
	},
	["UldEric"] = {
		Next_Page = "UldRevelosh",
		Prev_Page = "UldOlaf",
		Back_Page = "DUNGEONSMENU1",
	},
	["UldRevelosh"] = {
		Next_Page = "UldIronaya",
		Prev_Page = "UldEric",
		Back_Page = "DUNGEONSMENU1",
	},
	["UldIronaya"] = {
		Next_Page = "UldAncientStoneKeeper",
		Prev_Page = "UldRevelosh",
		Back_Page = "DUNGEONSMENU1",
	},
	["UldAncientStoneKeeper"] = {
		Next_Page = "UldGalgannFirehammer",
		Prev_Page = "UldIronaya",
		Back_Page = "DUNGEONSMENU1",
	},
	["UldGalgannFirehammer"] = {
		Next_Page = "UldGrimlok",
		Prev_Page = "UldAncientStoneKeeper",
		Back_Page = "DUNGEONSMENU1",
	},
	["UldGrimlok"] = {
		Next_Page = "UldArchaedas",
		Prev_Page = "UldGalgannFirehammer",
		Back_Page = "DUNGEONSMENU1",
	},
	["UldArchaedas"] = {
		Next_Page = "UldTrash",
		Prev_Page = "UldGrimlok",
		Back_Page = "DUNGEONSMENU1",
	},
	["UldTrash"] = {
		Prev_Page = "UldArchaedas",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Zul'Gurub
	["ZGJeklik"] = {
		Next_Page = "ZGVenoxis",
		Back_Page = "DUNGEONSMENU2",
	},
	["ZGVenoxis"] = {
		Next_Page = "ZGMarli",
		Prev_Page = "ZGJeklik",
		Back_Page = "DUNGEONSMENU2",
	},
	["ZGMarli"] = {
		Next_Page = "ZGMandokir",
		Prev_Page = "ZGVenoxis",
		Back_Page = "DUNGEONSMENU2",

	},
	["ZGMandokir"] = {
		Next_Page = "ZGGrilek",
		Prev_Page = "ZGMarli",
		Back_Page = "DUNGEONSMENU2",
	},
	["ZGGrilek"] = {
		Next_Page = "ZGHazzarah",
		Prev_Page = "ZGMandokir",
		Back_Page = "DUNGEONSMENU2",
	},
	["ZGHazzarah"] = {
		Next_Page = "ZGRenataki",
		Prev_Page = "ZGGrilek",
		Back_Page = "DUNGEONSMENU2",
	},
	["ZGRenataki"] = {
		Next_Page = "ZGWushoolay",
		Prev_Page = "ZGHazzarah",
		Back_Page = "DUNGEONSMENU2",
	},
	["ZGWushoolay"] = {
		Next_Page = "ZGGahzranka",
		Prev_Page = "ZGRenataki",
		Back_Page = "DUNGEONSMENU2",
	},
	["ZGGahzranka"] = {
		Next_Page = "ZGThekal",
		Prev_Page = "ZGWushoolay",
		Back_Page = "DUNGEONSMENU2",
	},
	["ZGThekal"] = {
		Next_Page = "ZGArlokk",
		Prev_Page = "ZGGahzranka",
		Back_Page = "DUNGEONSMENU2",
	},
	["ZGArlokk"] = {
		Next_Page = "ZGJindo",
		Prev_Page = "ZGThekal",
		Back_Page = "DUNGEONSMENU2",
	},
	["ZGJindo"] = {
		Next_Page = "ZGHakkar",
		Prev_Page = "ZGArlokk",
		Back_Page = "DUNGEONSMENU2",
	},
	["ZGHakkar"] = {
		Next_Page = "ZGShared",
		Prev_Page = "ZGJindo",
		Back_Page = "DUNGEONSMENU2",
	},
	["ZGShared"] = {
		Next_Page = "ZGTrash1",
		Prev_Page = "ZGHakkar",
		Back_Page = "DUNGEONSMENU2",
	},
	["ZGTrash1"] = {
		Next_Page = "ZGTrash2",
		Prev_Page = "ZGShared",
		Back_Page = "DUNGEONSMENU2",
	},
	["ZGTrash2"] = {
		Next_Page = "ZGEnchants",
		Prev_Page = "ZGTrash1",
		Back_Page = "DUNGEONSMENU2",
	},
	["ZGEnchants"] = {
		Prev_Page = "ZGTrash2",
		Back_Page = "DUNGEONSMENU2",
	},

	-- Blackfathom Deeps
	["BFDGhamoora"] = {
		Next_Page = "BFDLadySarevess",
		Back_Page = "DUNGEONSMENU1",
	},
	["BFDLadySarevess"] = {
		Next_Page = "BFDGelihast",
		Prev_Page = "BFDGhamoora",
		Back_Page = "DUNGEONSMENU1",
	},
	["BFDGelihast"] = {
		Next_Page = "BFDBaronAquanis",
		Prev_Page = "BFDLadySarevess",
		Back_Page = "DUNGEONSMENU1",
	},
	["BFDBaronAquanis"] = {
		Next_Page = "BFDVelthelaxx",
		Prev_Page = "BFDGelihast",
		Back_Page = "DUNGEONSMENU1",
	},
	["BFDVelthelaxx"] = {
		Prev_Page = "BFDBaronAquanis",
		Next_Page = "BFDTwilightLordKelris",
		Back_Page = "DUNGEONSMENU1",
	},
	["BFDTwilightLordKelris"] = {
		Next_Page = "BFDOldSerrakis",
		Prev_Page = "BFDVelthelaxx",
		Back_Page = "DUNGEONSMENU1",
	},
	["BFDOldSerrakis"] = {
		Next_Page = "BFDAkumai",
		Prev_Page = "BFDTwilightLordKelris",
		Back_Page = "DUNGEONSMENU1",
	},
	["BFDAkumai"] = {
		Next_Page = "BFDTrash",
		Prev_Page = "BFDOldSerrakis",
		Back_Page = "DUNGEONSMENU1",
	},
	["BFDTrash"] = {
		Prev_Page = "BFDAkumai",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Dire Maul East
	["DMEPusillin"] = {
		Next_Page = "DMEZevrimThornhoof",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMEZevrimThornhoof"] = {
		Next_Page = "DMEHydro",
		Prev_Page = "DMEPusillin",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMEHydro"] = {
		Next_Page = "DMELethtendris",
		Prev_Page = "DMEZevrimThornhoof",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMELethtendris"] = {
		Next_Page = "DMEPimgib",
		Prev_Page = "DMEHydro",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMEPimgib"] = {
		Next_Page = "DMEIsalien",
		Prev_Page = "DMELethtendris",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMEIsalien"] = {
		Next_Page = "DMEAlzzin",
		Prev_Page = "DMEPimgib",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMEAlzzin"] = {
		Next_Page = "DMETrash",
		Prev_Page = "DMEIsalien",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMETrash"] = {
		Next_Page = "DMEBooks",
		Prev_Page = "DMEAlzzin",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMEBooks"] = {
		Prev_Page = "DMETrash",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Dire Maul West
	["DMWTendrisWarpwood"] = {
		Next_Page = "DMWIllyannaRavenoak",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMWIllyannaRavenoak"] = {
		Next_Page = "DMWMagisterKalendris",
		Prev_Page = "DMWTendrisWarpwood",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMWMagisterKalendris"] = {
		Next_Page = "DMWTsuzee",
		Prev_Page = "DMWIllyannaRavenoak",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMWTsuzee"] = {
		Next_Page = "DMWRevanchion",
		Prev_Page = "DMWMagisterKalendris",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMWRevanchion"] = {
		Next_Page = "DMWImmolthar",
		Prev_Page = "DMWTsuzee",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMWImmolthar"] = {
		Next_Page = "DMWHelnurath",
		Prev_Page = "DMWRevanchion",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMWHelnurath"] = {
		Next_Page = "DMWPrinceTortheldrin",
		Prev_Page = "DMWImmolthar",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMWPrinceTortheldrin"] = {
		Next_Page = "DMWTrash",
		Prev_Page = "DMWHelnurath",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMWTrash"] = {
		Next_Page = "DMWBooks",
		Prev_Page = "DMWPrinceTortheldrin",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMWBooks"] = {
		Prev_Page = "DMWTrash",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Dire Maul North
	["DMNGuardMoldar"] = {
		Next_Page = "DMNStomperKreeg",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMNStomperKreeg"] = {
		Next_Page = "DMNGuardFengus",
		Prev_Page = "DMNGuardMoldar",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMNGuardFengus"] = {
		Next_Page = "DMNThimblejack",
		Prev_Page = "DMNStomperKreeg",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMNThimblejack"] = {
		Next_Page = "DMNGuardSlipkik",
		Prev_Page = "DMNGuardFengus",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMNGuardSlipkik"] = {
		Next_Page = "DMNCaptainKromcrush",
		Prev_Page = "DMNThimblejack",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMNCaptainKromcrush"] = {
		Next_Page = "DMNChoRush",
		Prev_Page = "DMNGuardSlipkik",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMNChoRush"] = {
		Next_Page = "DMNKingGordok",
		Prev_Page = "DMNCaptainKromcrush",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMNKingGordok"] = {
		Next_Page = "DMNTRIBUTERUN",
		Prev_Page = "DMNChoRush",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMNTRIBUTERUN"] = {
		Next_Page = "DMNTrash",
		Prev_Page = "DMNKingGordok",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMNTrash"] = {
		Next_Page = "DMNBooks",
		Prev_Page = "DMNTRIBUTERUN",
		Back_Page = "DUNGEONSMENU1",
	},
	["DMNBooks"] = {
		Prev_Page = "DMNTrash",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Maraudon
	["MaraNoxxion"] = {
		Next_Page = "MaraRazorlash",
		Back_Page = "DUNGEONSMENU1",
	},
	["MaraRazorlash"] = {
		Next_Page = "MaraLordVyletongue",
		Prev_Page = "MaraNoxxion",
		Back_Page = "DUNGEONSMENU1",
	},
	["MaraLordVyletongue"] = {
		Next_Page = "MaraMeshlok",
		Prev_Page = "MaraRazorlash",
		Back_Page = "DUNGEONSMENU1",
	},
	["MaraMeshlok"] = {
		Next_Page = "MaraCelebras",
		Prev_Page = "MaraLordVyletongue",
		Back_Page = "DUNGEONSMENU1",
	},
	["MaraCelebras"] = {
		Next_Page = "MaraLandslide",
		Prev_Page = "MaraMeshlok",
		Back_Page = "DUNGEONSMENU1",
	},
	["MaraLandslide"] = {
		Next_Page = "MaraTinkererGizlock",
		Prev_Page = "MaraCelebras",
		Back_Page = "DUNGEONSMENU1",
	},
	["MaraTinkererGizlock"] = {
		Next_Page = "MaraRotgrip",
		Prev_Page = "MaraLandslide",
		Back_Page = "DUNGEONSMENU1",
	},
	["MaraRotgrip"] = {
		Next_Page = "MaraPrincessTheradras",
		Prev_Page = "MaraTinkererGizlock",
		Back_Page = "DUNGEONSMENU1",
	},
	["MaraPrincessTheradras"] = {
		Next_Page = "MaraTrash",
		Prev_Page = "MaraRotgrip",
		Back_Page = "DUNGEONSMENU1",
	},
	["MaraTrash"] = {
		Prev_Page = "MaraPrincessTheradras",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Ragefire Chasm
	["RFCTaragaman"] = {
		Next_Page = "RFCOggleflint",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFCOggleflint"] = {
		Next_Page = "RFCJergosh",
		Prev_Page = "RFCTaragaman",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFCJergosh"] = {
		Next_Page = "RFCBazzalan",
		Prev_Page = "RFCOggleflint",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFCBazzalan"] = {
		Prev_Page = "RFCJergosh",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Razorfen Downs
	["RFDTutenkash"] = {
		Next_Page = "RFDLadyF",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFDLadyF"] = {
		Next_Page = "RFDPlaguemaw",
		Prev_Page = "RFDTutenkash",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFDPlaguemaw"] = {
		Next_Page = "RFDMordreshFireEye",
		Prev_Page = "RFDLadyF",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFDMordreshFireEye"] = {
		Next_Page = "RFDGlutton",
		Prev_Page = "RFDPlaguemaw",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFDGlutton"] = {
		Next_Page = "RFDDeathProphet",
		Prev_Page = "RFDMordreshFireEye",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFDDeathProphet"] = {
		Next_Page = "RFDRagglesnout",
		Prev_Page = "RFDGlutton",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFDRagglesnout"] = {
		Next_Page = "RFDAmnennar",
		Prev_Page = "RFDDeathProphet",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFDAmnennar"] = {
		Next_Page = "RFDTrash",
		Prev_Page = "RFDRagglesnout",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFDTrash"] = {
		Prev_Page = "RFDAmnennar",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Razorfen Kraul
	["RFKAggem"] = {
		Next_Page = "RFKDeathSpeakerJargba",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFKDeathSpeakerJargba"] = {
		Next_Page = "RFKOverlordRamtusk",
		Prev_Page = "RFKAggem",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFKOverlordRamtusk"] = {
		Next_Page = "RFKRazorfenSpearhide",
		Prev_Page = "RFKDeathSpeakerJargba",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFKRazorfenSpearhide"] = {
		Next_Page = "RFKAgathelos",
		Prev_Page = "RFKOverlordRamtusk",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFKAgathelos"] = {
		Next_Page = "RFKBlindHunter",
		Prev_Page = "RFKRazorfenSpearhide",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFKBlindHunter"] = {
		Next_Page = "RFKCharlgaRazorflank",
		Prev_Page = "RFKAgathelos",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFKCharlgaRazorflank"] = {
		Next_Page = "RFKEarthcallerHalmgar",
		Prev_Page = "RFKBlindHunter",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFKEarthcallerHalmgar"] = {
		Next_Page = "RFKRotthorn",
		Prev_Page = "RFKCharlgaRazorflank",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFKRotthorn"] = {
		Next_Page = "RFKTrash",
		Prev_Page = "RFKEarthcallerHalmgar",
		Back_Page = "DUNGEONSMENU1",
	},
	["RFKTrash"] = {
		Prev_Page = "RFKRotthorn",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Ruins of Ahn'Qiraj
	["AQ20Kurinnaxx"] = {
		Next_Page = "AQ20Andorov",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ20Andorov"] = {
		Next_Page = "AQ20CAPTAIN",
		Prev_Page = "AQ20Kurinnaxx",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ20CAPTAIN"] = {
		Next_Page = "AQ20Rajaxx",
		Prev_Page = "AQ20Andorov",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ20Rajaxx"] = {
		Next_Page = "AQ20Moam",
		Prev_Page = "AQ20CAPTAIN",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ20Moam"] = {
		Next_Page = "AQ20Buru",
		Prev_Page = "AQ20Rajaxx",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ20Buru"] = {
		Next_Page = "AQ20Ayamiss",
		Prev_Page = "AQ20Moam",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ20Ayamiss"] = {
		Next_Page = "AQ20Ossirian",
		Prev_Page = "AQ20Buru",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ20Ossirian"] = {
		Next_Page = "AQ20Trash",
		Prev_Page = "AQ20Ayamiss",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ20Trash"] = {
		Next_Page = "AQ20ClassBooks",
		Prev_Page = "AQ20Ossirian",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ20ClassBooks"] = {
		Next_Page = "AQ20Enchants",
		Prev_Page = "AQ20Trash",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ20Enchants"] = {
		Prev_Page = "AQ20ClassBooks",
		Back_Page = "DUNGEONSMENU2",
	},

	-- Temple of Ahn'Qiraj
	["AQ40Skeram"] = {
		Next_Page = "AQ40Trio",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ40Trio"] = {
		Next_Page = "AQ40Sartura",
		Prev_Page = "AQ40Skeram",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ40Sartura"] = {
		Next_Page = "AQ40Fankriss",
		Prev_Page = "AQ40Trio",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ40Fankriss"] = {
		Next_Page = "AQ40Viscidus",
		Prev_Page = "AQ40Sartura",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ40Viscidus"] = {
		Next_Page = "AQ40Huhuran",
		Prev_Page = "AQ40Fankriss",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ40Huhuran"] = {
		Next_Page = "AQ40Emperors",
		Prev_Page = "AQ40Viscidus",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ40Emperors"] = {
		Next_Page = "AQ40Ouro",
		Prev_Page = "AQ40Huhuran",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ40Ouro"] = {
		Next_Page = "AQ40CThun",
		Prev_Page = "AQ40Emperors",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ40CThun"] = {
		Next_Page = "AQ40Trash1",
		Prev_Page = "AQ40Ouro",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ40Trash1"] = {
		Next_Page = "AQ40Trash2",
		Prev_Page = "AQ40CThun",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQ40Trash2"] = {
		Next_Page = "AQEnchants",
		Prev_Page = "AQ40Trash1",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQEnchants"] = {
		Next_Page = "AQOpening",
		Prev_Page = "AQ40Trash2",
		Back_Page = "DUNGEONSMENU2",
	},
	["AQOpening"] = {
		Prev_Page = "AQEnchants",
		Back_Page = "DUNGEONSMENU2",
	},

	-- Wailing Caverns
	["WCLordCobrahn"] = {
		Next_Page = "WCLadyAnacondra",
		Back_Page = "DUNGEONSMENU1",
	},
	["WCLadyAnacondra"] = {
		Next_Page = "WCKresh",
		Prev_Page = "WCLordCobrahn",
		Back_Page = "DUNGEONSMENU1",
	},
	["WCKresh"] = {
		Next_Page = "WCDeviateFaerieDragon",
		Prev_Page = "WCLadyAnacondra",
		Back_Page = "DUNGEONSMENU1",
	},
	["WCDeviateFaerieDragon"] = {
		Next_Page = "WCZandara",
		Prev_Page = "WCKresh",
		Back_Page = "DUNGEONSMENU1",
	},
	["WCZandara"] = {
		Next_Page = "WCLordPythas",
		Prev_Page = "WCDeviateFaerieDragon",
		Back_Page = "DUNGEONSMENU1",
	},
	["WCLordPythas"] = {
		Next_Page = "WCSkum",
		Prev_Page = "WCZandara",
		Back_Page = "DUNGEONSMENU1",
	},
	["WCSkum"] = {
		Next_Page = "WCVangros",
		Prev_Page = "WCLordPythas",
		Back_Page = "DUNGEONSMENU1",
	},
	["WCVangros"] = {
		Next_Page = "WCLordSerpentis",
		Prev_Page = "WCSkum",
		Back_Page = "DUNGEONSMENU1",
	},
	["WCLordSerpentis"] = {
		Next_Page = "WCVerdan",
		Prev_Page = "WCVangros",
		Back_Page = "DUNGEONSMENU1",
	},
	["WCVerdan"] = {
		Next_Page = "WCMutanus",
		Prev_Page = "WCLordSerpentis",
		Back_Page = "DUNGEONSMENU1",
	},
	["WCMutanus"] = {
		Next_Page = "WCTrash",
		Prev_Page = "WCVerdan",
		Back_Page = "DUNGEONSMENU1",
	},
	["WCTrash"] = {
		Prev_Page = "WCMutanus",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Zul'Farrak
	["ZFAntusul"] = {
		Next_Page = "ZFWitchDoctorZumrah",
		Back_Page = "DUNGEONSMENU1",
	},
	["ZFWitchDoctorZumrah"] = {
		Next_Page = "ZFSezzziz",
		Prev_Page = "ZFAntusul",
		Back_Page = "DUNGEONSMENU1",
	},
	["ZFSezzziz"] = {
		Next_Page = "ZFDustwraith",
		Prev_Page = "ZFWitchDoctorZumrah",
		Back_Page = "DUNGEONSMENU1",
	},
	["ZFDustwraith"] = {
		Next_Page = "ZFZerillis",
		Prev_Page = "ZFSezzziz",
		Back_Page = "DUNGEONSMENU1",
	},
	["ZFZerillis"] = {
		Next_Page = "ZFGahzrilla",
		Prev_Page = "ZFDustwraith",
		Back_Page = "DUNGEONSMENU1",
	},
	["ZFGahzrilla"] = {
		Next_Page = "ZFChiefUkorzSandscalp",
		Prev_Page = "ZFZerillis",
		Back_Page = "DUNGEONSMENU1",
	},
	["ZFChiefUkorzSandscalp"] = {
		Next_Page = "ZFZeljeb",
		Prev_Page = "ZFGahzrilla",
		Back_Page = "DUNGEONSMENU1",
	},
	["ZFZeljeb"] = {
		Prev_Page = "ZFChiefUkorzSandscalp",
		Next_Page = "ZFChampion",
		Back_Page = "DUNGEONSMENU1",
	},
	["ZFChampion"] = {
		Prev_Page = "ZFZeljeb",
		Next_Page = "ZFTrash",
		Back_Page = "DUNGEONSMENU1",
	},
	["ZFTrash"] = {
		Prev_Page = "ZFChampion",
		Back_Page = "DUNGEONSMENU1",
	},

	-- Emerald Sanctum
	["ESErennius"] = {
		Next_Page = "ESSolnius1",
		Back_Page = "DUNGEONSMENU2",
	},
	["ESSolnius1"] = {
		Next_Page = "ESHardMode",
		Prev_Page = "ESErennius",
		Back_Page = "DUNGEONSMENU2",
	},
	["ESHardMode"] = {
		Next_Page = "ESTrash",
		Prev_Page = "ESSolnius1",
		Back_Page = "DUNGEONSMENU2",
	},
	["ESTrash"] = {
		Prev_Page = "ESHardMode",
		Back_Page = "DUNGEONSMENU2",
	},

	-- Lower Karazhan Halls
	["LKHRolfen"] = {
		Next_Page = "LKHBroodQueenAraxxna",
		Back_Page = "DUNGEONSMENU2",
	},
	["LKHBroodQueenAraxxna"] = {
		Next_Page = "LKHGrizikil",
		Prev_Page = "LKHRolfen",
		Back_Page = "DUNGEONSMENU2",
	},
	["LKHGrizikil"] = {
		Next_Page = "LKHClawlordHowlfang",
		Prev_Page = "LKHBroodQueenAraxxna",
		Back_Page = "DUNGEONSMENU2",
	},
	["LKHClawlordHowlfang"] = {
		Next_Page = "LKHLordBlackwaldII",
		Prev_Page = "LKHGrizikil",
		Back_Page = "DUNGEONSMENU2",
	},
	["LKHLordBlackwaldII"] = {
		Next_Page = "LKHMoroes",
		Prev_Page = "LKHClawlordHowlfang",
		Back_Page = "DUNGEONSMENU2",
	},
	["LKHMoroes"] = {
		Next_Page = "LKHTrash",
		Prev_Page = "LKHLordBlackwaldII",
		Back_Page = "DUNGEONSMENU2",
	},
	["LKHTrash"] = {
		Next_Page = "LKHEnchants",
		Prev_Page = "LKHMoroes",
		Back_Page = "DUNGEONSMENU2",
	},
	["LKHEnchants"] = {
		Prev_Page = "LKHTrash",
		Back_Page = "DUNGEONSMENU2",
	},

	-- Onyxia's Lair
	["Axelus"] = {
		Next_Page = "Onyxia",
		Back_Page = "DUNGEONSMENU2",
	},
	["Onyxia"] = {
		Prev_Page = "Axelus",
		Back_Page = "DUNGEONSMENU2",
	},

	-- World Bosses
	["AAzuregos"] = {
		Next_Page = "DEmeriss",
		Back_Page = "WORLDBOSSMENU",
	},
	["DEmeriss"] = {
		Next_Page = "DLethon",
		Prev_Page = "AAzuregos",
		Back_Page = "WORLDBOSSMENU",
	},
	["DLethon"] = {
		Next_Page = "DTaerar",
		Prev_Page = "DEmeriss",
		Back_Page = "WORLDBOSSMENU",
	},
	["DTaerar"] = {
		Next_Page = "DYsondre",
		Prev_Page = "DLethon",
		Back_Page = "WORLDBOSSMENU",
	},
	["DYsondre"] = {
		Next_Page = "KKazzak",
		Prev_Page = "DTaerar",
		Back_Page = "WORLDBOSSMENU",
	},
	["KKazzak"] = {
		Next_Page = "Nerubian",
		Prev_Page = "DYsondre",
		Back_Page = "WORLDBOSSMENU",
	},
	["Nerubian"] = {
		Next_Page = "Reaver",
		Prev_Page = "KKazzak",
		Back_Page = "WORLDBOSSMENU",
	},
	["Reaver"] = {
		Next_Page = "Ostarius",
		Prev_Page = "Nerubian",
		Back_Page = "WORLDBOSSMENU",
	},
	["Ostarius"] = {
		Next_Page = "Concavius",
		Prev_Page = "Reaver",
		Back_Page = "WORLDBOSSMENU",
	},
	["Concavius"] = {
		Next_Page = "CowKing",
		Prev_Page = "Ostarius",
		Back_Page = "WORLDBOSSMENU",
	},
	["CowKing"] = {
		Prev_Page = "Concavius",
		Next_Page = "Clackora",
		Back_Page = "WORLDBOSSMENU",
	},
	["Clackora"] = {
		Prev_Page = "CowKing",
		Back_Page = "WORLDBOSSMENU",
	},

	-- Rare Spawns
	["EarthcallerRezengal"] = {
		Next_Page = "ShadeMage",
	},
	["ShadeMage"] = {
		Next_Page = "GraypawAlpha",
		Prev_Page = "EarthcallerRezengal",
	},
	["GraypawAlpha"] = {
		Next_Page = "Blazespark",
		Prev_Page = "ShadeMage",
	},
	["Blazespark"] = {
		Next_Page = "WitchDoctorTanzo",
		Prev_Page = "GraypawAlpha",
	},
	["WitchDoctorTanzo"] = {
		Next_Page = "Dawnhowl",
		Prev_Page = "Blazespark",
	},
	["Dawnhowl"] = {
		Next_Page = "MaltimorsPrototype",
		Prev_Page = "WitchDoctorTanzo",
	},
	["MaltimorsPrototype"] = {
		Next_Page = "Bonecruncher",
		Prev_Page = "Dawnhowl",
	},
	["Bonecruncher"] = {
		Next_Page = "Duskskitter",
		Prev_Page = "MaltimorsPrototype",
	},
	["Duskskitter"] = {
		Next_Page = "BaronPerenolde",
		Prev_Page = "Bonecruncher",
	},
	["BaronPerenolde"] = {
		Next_Page = "Grugthok",
		Prev_Page = "Duskskitter",
	},
	["Grugthok"] = {
		Next_Page = "Ashbeard",
		Prev_Page = "BaronPerenolde",
	},
	["Ashbeard"] = {
		Next_Page = "Jalakar",
		Prev_Page = "Grugthok",
	},
	["Jalakar"] = {
		Next_Page = "Embereye",
		Prev_Page = "Ashbeard",
	},
	["Embereye"] = {
		Next_Page = "Rukthok",
		Prev_Page = "Jalakar",
	},
	["Rukthok"] = {
		Next_Page = "Tarangos",
		Prev_Page = "Embereye",
	},
	["Tarangos"] = {
		Next_Page = "Ripjaw",
		Prev_Page = "Rukthok",
	},
	["Ripjaw"] = {
		Next_Page = "Xalvic",
		Prev_Page = "Tarangos",
	},
	["Xalvic"] = {
		Next_Page = "Aquitus",
		Prev_Page = "Ripjaw",
	},
	["Aquitus"] = {
		Next_Page = "FirstbornofArugal",
		Prev_Page = "Xalvic",
	},
	["FirstbornofArugal"] = {
		Next_Page = "Letashaz",
		Prev_Page = "Aquitus",
	},
	["Letashaz"] = {
		Next_Page = "MargontheMighty",
		Prev_Page = "FirstbornofArugal",
	},
	["MargontheMighty"] = {
		Next_Page = "WanderingKnight",
		Prev_Page = "Letashaz",
	},
	["WanderingKnight"] = {
		Next_Page = "Stoneshell",
		Prev_Page = "MargontheMighty",
	},
	["Stoneshell"] = {
		Next_Page = "Zareth",
		Prev_Page = "WanderingKnight",
	},
	["Zareth"] = {
		Next_Page = "HighvaleSilverback",
		Prev_Page = "Stoneshell",
	},
	["HighvaleSilverback"] = {
		Next_Page = "Mallon",
		Prev_Page = "Zareth",
	},
	["Mallon"] = {
		Next_Page = "Kargron",
		Prev_Page = "HighvaleSilverback",
	},
	["Kargron"] = {
		Next_Page = "AdmiralBareanWestwind",
		Prev_Page = "Mallon",
	},
	["ProfessorLysander"] = {
		Next_Page = "AdmiralBareanWestwind",
		Prev_Page = "Kargron",
	},
	["AdmiralBareanWestwind"] = {
		Next_Page = "Azurebeak",
		Prev_Page = "ProfessorLysander",
	},
	["Azurebeak"] = {
		Next_Page = "BarkskinFisher",
		Prev_Page = "AdmiralBareanWestwind",
	},
	["BarkskinFisher"] = {
		Next_Page = "CrusaderLarsarius",
		Prev_Page = "Azurebeak",
	},
	["CrusaderLarsarius"] = {
		Next_Page = "ShadeflayerGoliath",
		Prev_Page = "BarkskinFisher",
	},
	["ShadeflayerGoliath"] = {
		Next_Page = "WidowoftheWoods",
		Prev_Page = "CrusaderLarsarius",
	},
	["WidowoftheWoods"] = {
		Next_Page = "M0L1Y",
		Prev_Page = "ShadeflayerGoliath",
	},
	["M0L1Y"] = {
		Prev_Page = "WidowoftheWoods",
	},

	-- Factions
	["EarthenRing"] = {
		Back_Page = "REPMENU",
	},
	["DraeneiExiles"] = {
		Back_Page = "REPMENU",
	},
	["Argent1"] = {
		Next_Page = "Argent2",
		Back_Page = "REPMENU",
	},
	["Argent2"] = {
		Prev_Page = "Argent1",
		Next_Page = "Argent3",
		Back_Page = "REPMENU",
	},
	["Argent3"] = {
		Prev_Page = "Argent2",
		Back_Page = "REPMENU",
	},
	["Bloodsail1"] = {
		Back_Page = "REPMENU",
	},
	["Wardens1"] = {
		Back_Page = "REPMENU",
		Next_Page = "Wardens2",
	},
	["Wardens2"] = {
		Back_Page = "REPMENU",
		Prev_Page = "Wardens1",
	},
	["AQBroodRings"] = {
		Back_Page = "REPMENU",
	},
	["Cenarion1"] = {
		Next_Page = "Cenarion2",
		Back_Page = "REPMENU",
	},
	["Cenarion2"] = {
		Next_Page = "Cenarion3",
		Prev_Page = "Cenarion1",
		Back_Page = "REPMENU",
	},
	["Cenarion3"] = {
		Next_Page = "Cenarion4",
		Prev_Page = "Cenarion2",
		Back_Page = "REPMENU",
	},
	["Cenarion4"] = {
		Prev_Page = "Cenarion3",
		Back_Page = "REPMENU",
	},
	["Darkmoon"] = {
		Back_Page = "REPMENU",
	},
	["Defilers"] = {
		Back_Page = "REPMENU",
	},
	["Frostwolf1"] = {
		Back_Page = "REPMENU",
	},
	["GelkisClan1"] = {
		Back_Page = "REPMENU",
	},
	["WaterLords1"] = {
		Back_Page = "REPMENU",
	},
	["LeagueofArathor"] = {
		Back_Page = "REPMENU",
	},
	["Ironforge"] = {
		Back_Page = "REPMENU",
	},
	["Darnassus"] = {
		Back_Page = "REPMENU",
	},
	["Stormwind"] = {
		Back_Page = "REPMENU",
	},
	["GnomereganExiles"] = {
		Back_Page = "REPMENU",
	},
	["DarkspearTrolls"] = {
		Back_Page = "REPMENU",
	},
	["DurotarLaborUnion"] = {
		Back_Page = "REPMENU",
	},
	["Undercity"] = {
		Back_Page = "REPMENU",
	},
	["Orgrimmar"] = {
		Back_Page = "REPMENU",
	},
	["ThunderBluff"] = {
		Back_Page = "REPMENU",
	},
	["Dalaran"] = {
		Back_Page = "REPMENU",
	},
	["Helf"] = {
		Next_Page = "Helf2",
		Back_Page = "REPMENU",
	},
	["Helf2"] = {
		Next_Page = "Helf3",
		Prev_Page = "Helf",
		Back_Page = "REPMENU",
	},
	["Helf3"] = {
		Prev_Page = "Helf2",
		Back_Page = "REPMENU",
	},
	["Revantusk"] = {
		Next_Page = "Revantusk2",
		Back_Page = "REPMENU",
	},
	["Revantusk2"] = {
		Next_Page = "Revantusk3",
		Prev_Page = "Revantusk",
		Back_Page = "REPMENU",
	},
	["Revantusk3"] = {
		Prev_Page = "Revantusk2",
		Back_Page = "REPMENU",
	},
	["MagramClan1"] = {
		Back_Page = "REPMENU",
	},
	["Stormpike1"] = {
		Back_Page = "REPMENU",
	},
	["Thorium1"] = {
		Next_Page = "Thorium2",
		Back_Page = "REPMENU",
	},
	["Thorium2"] = {
		Prev_Page = "Thorium1",
		Back_Page = "REPMENU",
	},
	["Timbermaw"] = {
		Back_Page = "REPMENU",
	},
	["Wildhammer"] = {
		Back_Page = "REPMENU",
	},
	["Shendralar"] = {
		Back_Page = "REPMENU",
	},
	["Wintersaber1"] = {
		Back_Page = "REPMENU",
	},
	["Zandalar1"] = {
		Next_Page = "Zandalar2",
		Back_Page = "REPMENU",
	},
	["Zandalar2"] = {
		Prev_Page = "Zandalar1",
		Back_Page = "REPMENU",
	},
	["BRRepFriendly"] = {
		Back_Page = "BRRepMenu",
		Next_Page = "BRRepHonored",
	},
	["BRRepHonored"] = {
		Back_Page = "BRRepMenu",
		Prev_Page = "BRRepFriendly",
		Next_Page = "BRRepRevered",
	},
	["BRRepRevered"] = {
		Back_Page = "BRRepMenu",
		Prev_Page = "BRRepHonored",
		Next_Page = "BRRepExalted",
	},
	["BRRepExalted"] = {
		Back_Page = "BRRepMenu",
		Prev_Page = "BRRepRevered",
		Next_Page = "BRRepTokens",
	},
	["BRRepTokens"] = {
		Back_Page = "BRRepMenu",
		Prev_Page = "BRRepExalted",
	},
	["ABRepFriendly"] = {
		Back_Page = "ABRepMenu",
		Next_Page = "ABRepHonored2029",
	},
	["ABRepHonored2029"] = {
		Back_Page = "ABRepMenu",
		Next_Page = "ABRepHonored3039",
		Prev_Page = "ABRepFriendly",
	},
	["ABRepHonored3039"] = {
		Back_Page = "ABRepMenu",
		Next_Page = "ABRepHonored4049",
		Prev_Page = "ABRepHonored2029",
	},
	["ABRepHonored4049"] = {
		Back_Page = "ABRepMenu",
		Next_Page = "ABRepHonored5059",
		Prev_Page = "ABRepHonored3039",
	},
	["ABRepHonored5059"] = {
		Back_Page = "ABRepMenu",
		Next_Page = "ABRepRevered2029",
		Prev_Page = "ABRepHonored4049",
	},
	["ABRepRevered2029"] = {
		Back_Page = "ABRepMenu",
		Next_Page = "ABRepRevered3039",
		Prev_Page = "ABRepHonored5059",
	},
	["ABRepRevered3039"] = {
		Back_Page = "ABRepMenu",
		Next_Page = "ABRepRevered4049",
		Prev_Page = "ABRepRevered2029",
	},
	["ABRepRevered4049"] = {
		Back_Page = "ABRepMenu",
		Next_Page = "ABRepRevered5059",
		Prev_Page = "ABRepRevered3039",
	},
	["ABRepRevered5059"] = {
		Back_Page = "ABRepMenu",
		Next_Page = "ABRepExalted",
		Prev_Page = "ABRepRevered4049",
	},
	["ABRepExalted"] = {
		Back_Page = "ABRepMenu",
		Prev_Page = "ABRepRevered5059",
	},
	["AVRepFriendly"] = {
		Back_Page = "AVRepMenu",
		Next_Page = "AVRepHonored",
	},
	["AVRepHonored"] = {
		Back_Page = "AVRepMenu",
		Prev_Page = "AVRepFriendly",
		Next_Page = "AVRepRevered",
	},
	["AVRepRevered"] = {
		Back_Page = "AVRepMenu",
		Prev_Page = "AVRepHonored",
		Next_Page = "AVRepExalted",
	},
	["AVRepExalted"] = {
		Back_Page = "AVRepMenu",
		Prev_Page = "AVRepRevered",
		Next_Page = "AVKorrak",
	},
	["AVKorrak"] = {
		Back_Page = "AVRepMenu",
		Prev_Page = "AVRepExalted",
		Next_Page = "AVLokholarIvus",
	},
	["AVLokholarIvus"] = {
		Back_Page = "AVRepMenu",
		Prev_Page = "AVKorrak",
	},
	["WSGRepFriendly"] = {
		Back_Page = "WSGRepMenu",
		Next_Page = "WSGRepHonored1019",
	},
	["WSGRepHonored1019"] = {
		Back_Page = "WSGRepMenu",
		Next_Page = "WSGRepHonored2029",
		Prev_Page = "WSGRepFriendly",
	},
	["WSGRepHonored2029"] = {
		Back_Page = "WSGRepMenu",
		Next_Page = "WSGRepHonored3039",
		Prev_Page = "WSGRepHonored1019",
	},
	["WSGRepHonored3039"] = {
		Back_Page = "WSGRepMenu",
		Next_Page = "WSGRepHonored4049",
		Prev_Page = "WSGRepHonored2029",
	},
	["WSGRepHonored4049"] = {
		Back_Page = "WSGRepMenu",
		Next_Page = "WSGRepHonored5059",
		Prev_Page = "WSGRepHonored3039",
	},
	["WSGRepHonored5059"] = {
		Back_Page = "WSGRepMenu",
		Next_Page = "WSGRepRevered1019",
		Prev_Page = "WSGRepHonored4049",
	},
	["WSGRepRevered1019"] = {
		Back_Page = "WSGRepMenu",
		Next_Page = "WSGRepRevered2029",
		Prev_Page = "WSGRepHonored5059",
	},
	["WSGRepRevered2029"] = {
		Back_Page = "WSGRepMenu",
		Next_Page = "WSGRepRevered3039",
		Prev_Page = "WSGRepRevered1019",
	},
	["WSGRepRevered3039"] = {
		Back_Page = "WSGRepMenu",
		Next_Page = "WSGRepRevered4049",
		Prev_Page = "WSGRepRevered2029",
	},
	["WSGRepRevered4049"] = {
		Back_Page = "WSGRepMenu",
		Next_Page = "WSGRepRevered5059",
		Prev_Page = "WSGRepRevered3039",
	},
	["WSGRepRevered5059"] = {
		Back_Page = "WSGRepMenu",
		Next_Page = "WSGRepExalted4049",
		Prev_Page = "WSGRepRevered4049",
	},
	["WSGRepExalted4049"] = {
		Back_Page = "WSGRepMenu",
		Next_Page = "WSGRepExalted5059",
		Prev_Page = "WSGRepRevered5059",
	},
	["WSGRepExalted5059"] = {
		Back_Page = "WSGRepMenu",
		Next_Page = "WSGRepExalted60",
		Prev_Page = "WSGRepExalted4049",
	},
	["WSGRepExalted60"] = {
		Back_Page = "WSGRepMenu",
		Prev_Page = "WSGRepExalted5059",
	},
	["PvP60Accessories1"] = {
		Next_Page = "PvP60Accessories2",
		Back_Page = "PVPMENU",
	},
	["PvP60Accessories2"] = {
		Next_Page = "PvP60Accessories3",
		Prev_Page = "PvP60Accessories1",
		Back_Page = "PVPMENU",
	},
	["PvP60Accessories3"] = {
		Prev_Page = "PvP60Accessories2",
		Next_Page = "PvP60Accessories4",
		Back_Page = "PVPMENU",
	},
	["PvP60Accessories4"] = {
		Prev_Page = "PvP60Accessories3",
		Back_Page = "PVPMENU",
	},
	["PVPWeapons1"] = {
		Next_Page = "PVPWeapons2",
		Back_Page = "PVPMENU",
	},
	["PVPWeapons2"] = {
		Prev_Page = "PVPWeapons1",
		Back_Page = "PVPMENU",
	},
	["PVPDruid"] = {
		Back_Page = "PVPSET",
	},
	["PVPHunter"] = {
		Back_Page = "PVPSET",
	},
	["PVPMage"] = {
		Back_Page = "PVPSET",
	},
	["PVPPaladin"] = {
		Back_Page = "PVPSET",
	},
	["PVPPriest"] = {
		Back_Page = "PVPSET",
	},
	["PVPRogue"] = {
		Back_Page = "PVPSET",
	},
	["PVPShaman"] = {
		Back_Page = "PVPSET",
	},
	["PVPWarlock"] = {
		Back_Page = "PVPSET",
	},
	["PVPWarrior"] = {
		Back_Page = "PVPSET",
	},
	["T0Druid"] = {
		Back_Page = "T0SET",
	},
	["T0Hunter"] = {
		Back_Page = "T0SET",
	},
	["T0Mage"] = {
		Back_Page = "T0SET",
	},
	["T0Paladin"] = {
		Back_Page = "T0SET",
	},
	["T0Priest"] = {
		Back_Page = "T0SET",
	},
	["T0Rogue"] = {
		Back_Page = "T0SET",
	},
	["T0Shaman"] = {
		Back_Page = "T0SET",
	},
	["T0Warlock"] = {
		Back_Page = "T0SET",
	},
	["T0Warrior"] = {
		Back_Page = "T0SET",
	},
	["T1Druid"] = {
		Back_Page = "T1SET",
	},
	["T1Hunter"] = {
		Back_Page = "T1SET",
	},
	["T1Mage"] = {
		Back_Page = "T1SET",
	},
	["T1Paladin"] = {
		Back_Page = "T1SET",
	},
	["T1Priest"] = {
		Back_Page = "T1SET",
	},
	["T1Rogue"] = {
		Back_Page = "T1SET",
	},
	["T1Shaman"] = {
		Back_Page = "T1SET",
	},
	["T1Warlock"] = {
		Back_Page = "T1SET",
	},
	["T1Warrior"] = {
		Back_Page = "T1SET",
	},
	["T2Druid"] = {
		Back_Page = "T2SET",
	},
	["T2Hunter"] = {
		Back_Page = "T2SET",
	},
	["T2Mage"] = {
		Back_Page = "T2SET",
	},
	["T2Paladin"] = {
		Back_Page = "T2SET",
	},
	["T2Priest"] = {
		Back_Page = "T2SET",
	},
	["T2Rogue"] = {
		Back_Page = "T2SET",
	},
	["T2Shaman"] = {
		Back_Page = "T2SET",
	},
	["T2Warlock"] = {
		Back_Page = "T2SET",
	},
	["T2Warrior"] = {
		Back_Page = "T2SET",
	},
	["T3Druid"] = {
		Back_Page = "T3SET",
	},
	["T3Hunter"] = {
		Back_Page = "T3SET",
	},
	["T3Mage"] = {
		Back_Page = "T3SET",
	},
	["T3Paladin"] = {
		Back_Page = "T3SET",
	},
	["T3Priest"] = {
		Back_Page = "T3SET",
	},
	["T3Rogue"] = {
		Back_Page = "T3SET",
	},
	["T3Shaman"] = {
		Back_Page = "T3SET",
	},
	["T3Warlock"] = {
		Back_Page = "T3SET",
	},
	["T3Warrior"] = {
		Back_Page = "T3SET",
	},
	["T35Druid"] = {
		Back_Page = "KARASET",
	},
	["T35Hunter"] = {
		Back_Page = "KARASET",
	},
	["T35Mage"] = {
		Back_Page = "KARASET",
	},
	["T35Paladin"] = {
		Back_Page = "KARASET",
	},
	["T35Priest"] = {
		Back_Page = "KARASET",
	},
	["T35Rogue"] = {
		Back_Page = "KARASET",
	},
	["T35Shaman"] = {
		Back_Page = "KARASET",
	},
	["T35Warlock"] = {
		Back_Page = "KARASET",
	},
	["T35Warrior"] = {
		Back_Page = "KARASET",
	},
	["AQ40Druid"] = {
		Back_Page = "AQ40SET",
	},
	["AQ40Hunter"] = {
		Back_Page = "AQ40SET",
	},
	["AQ40Mage"] = {
		Back_Page = "AQ40SET",
	},
	["AQ40Paladin"] = {
		Back_Page = "AQ40SET",
	},
	["AQ40Priest"] = {
		Back_Page = "AQ40SET",
	},
	["AQ40Rogue"] = {
		Back_Page = "AQ40SET",
	},
	["AQ40Shaman"] = {
		Back_Page = "AQ40SET",
	},
	["AQ40Warlock"] = {
		Back_Page = "AQ40SET",
	},
	["AQ40Warrior"] = {
		Back_Page = "AQ40SET",
	},
	["AQ20Druid"] = {
		Back_Page = "AQ20SET",
	},
	["AQ20Hunter"] = {
		Back_Page = "AQ20SET",
	},
	["AQ20Mage"] = {
		Back_Page = "AQ20SET",
	},
	["AQ20Paladin"] = {
		Back_Page = "AQ20SET",
	},
	["AQ20Priest"] = {
		Back_Page = "AQ20SET",
	},
	["AQ20Rogue"] = {
		Back_Page = "AQ20SET",
	},
	["AQ20Shaman"] = {
		Back_Page = "AQ20SET",
	},
	["AQ20Warlock"] = {
		Back_Page = "AQ20SET",
	},
	["AQ20Warrior"] = {
		Back_Page = "AQ20SET",
	},
	["ZGDruid"] = {
		Back_Page = "ZGSET",
	},
	["ZGHunter"] = {
		Back_Page = "ZGSET",
	},
	["ZGMage"] = {
		Back_Page = "ZGSET",
	},
	["ZGPaladin"] = {
		Back_Page = "ZGSET",
	},
	["ZGPriest"] = {
		Back_Page = "ZGSET",
	},
	["ZGRogue"] = {
		Back_Page = "ZGSET",
	},
	["ZGShaman"] = {
		Back_Page = "ZGSET",
	},
	["ZGWarlock"] = {
		Back_Page = "ZGSET",
	},
	["ZGWarrior"] = {
		Back_Page = "ZGSET",
	},
	["DEADMINES"] = {
		Back_Page = "PRE60SET",
	},
	["WAILING"] = {
		Back_Page = "PRE60SET",
	},
	["SCARLET"] = {
		Back_Page = "PRE60SET",
	},
	["BLACKROCKD"] = {
		Back_Page = "PRE60SET",
	},
	["IRONWEAVE"] = {
		Back_Page = "PRE60SET",
	},
	["ScholoCloth"] = {
		Back_Page = "PRE60SET",
	},
	["ScholoLeather"] = {
		Back_Page = "PRE60SET",
	},
	["ScholoMail"] = {
		Back_Page = "PRE60SET",
	},
	["ScholoPlate"] = {
		Back_Page = "PRE60SET",
	},
	["STRAT"] = {
		Back_Page = "PRE60SET",
	},
	["ScourgeInvasion"] = {
		Back_Page = "PRE60SET",
	},
	["ShardOfGods"] = {
		Back_Page = "PRE60SET",
	},
	["ZGRings"] = {
		Back_Page = "ZGSET",
	},
	["HakkariBlades"] = {
		Back_Page = "ZGSET",
	},
	["PrimalBlessing"] = {
		Back_Page = "ZGSET",
	},
	["SpiritofEskhandar"] = {
		Back_Page = "PRE60SET",
	},
	["DalRend"] = {
		Back_Page = "PRE60SET",
	},
	["SpiderKiss"] = {
		Back_Page = "PRE60SET",
	},
	["SteelPlate"] = {
		Back_Page = "CRAFTSET",
	},
	["ImperialPlate"] = {
		Back_Page = "CRAFTSET",
	},
	["TheDarksoul"] = {
		Back_Page = "CRAFTSET",
	},
	["BloodsoulEmbrace"] = {
		Back_Page = "CRAFTSET",
	},
	["AugerersAttire"] = {
		Back_Page = "CRAFTSET",
	},
	["ShadoweaveSet"] = {
		Back_Page = "CRAFTSET",
	},
	["DivinersGarments"] = {
		Back_Page = "CRAFTSET",
	},
	["PillagersGarb"] = {
		Back_Page = "CRAFTSET",
	},
	["BloodvineG"] = {
		Back_Page = "CRAFTSET",
	},
	["MoonclothSet"] = {
		Back_Page = "CRAFTSET",
	},
	["GriftersArmor"] = {
		Back_Page = "CRAFTSET",
	},
	["PrimalistsTrappings"] = {
		Back_Page = "CRAFTSET",
	},
	["VolcanicArmor"] = {
		Back_Page = "CRAFTSET",
	},
	["IronfeatherArmor"] = {
		Back_Page = "CRAFTSET",
	},
	["StormshroudArmor"] = {
		Back_Page = "CRAFTSET",
	},
	["DevilsaurArmor"] = {
		Back_Page = "CRAFTSET",
	},
	["BloodTigerH"] = {
		Back_Page = "CRAFTSET",
	},
	["PrimalBatskin"] = {
		Back_Page = "CRAFTSET",
	},
	["RedDragonM"] = {
		Back_Page = "CRAFTSET",
	},
	["GreenDragonM"] = {
		Back_Page = "CRAFTSET",
	},
	["BlueDragonM"] = {
		Back_Page = "CRAFTSET",
	},
	["BlackDragonM"] = {
		Back_Page = "CRAFTSET",
	},
	["CraftedWeapons1"] = {
		Back_Page = "CRAFTINGMENU",
	},
	["Tabards"] = {
		Back_Page = "SETMENU",
	},
	["Legendaries"] = {
		Back_Page = "SETMENU",
	},
	["PvPMountsPvP"] = {
		Back_Page = "PVPMENU",
	},
	["RareMounts"] = {
		Back_Page = "SETMENU",
	},
	["RarePets1"] = {
		Next_Page = "RarePets2",
		Back_Page = "SETMENU",
	},
	["RarePets2"] = {
		Prev_Page = "RarePets1",
		Back_Page = "SETMENU",
	},
	["WorldEpics1"] = {
		Next_Page = "WorldEpics2",
		Back_Page = "SETMENU",
	},
	["WorldEpics2"] = {
		Next_Page = "WorldEpics3",
		Prev_Page = "WorldEpics1",
		Back_Page = "SETMENU",
	},
	["WorldEpics3"] = {
		Prev_Page = "WorldEpics2",
		Back_Page = "SETMENU",
	},
	["ChildrensWeek"] = {
		Back_Page = "WORLDEVENTMENU",
	},
	["Winterviel1"] = {
		Next_Page = "Winterviel2",
		Back_Page = "WORLDEVENTMENU",
	},
	["Winterviel2"] = {
		Prev_Page = "Winterviel1",
		Back_Page = "WORLDEVENTMENU",
	},
	["Halloween1"] = {
		Next_Page = "Halloween2",
		Back_Page = "WORLDEVENTMENU",
	},
	["Halloween2"] = {
		Prev_Page = "Halloween1",
		Back_Page = "WORLDEVENTMENU",
	},
	["HarvestFestival"] = {
		Back_Page = "WORLDEVENTMENU",
	},
	["Valentineday"] = {
		Back_Page = "WORLDEVENTMENU",
	},
	["LunarFestival1"] = {
		Next_Page = "LunarFestival2",
		Back_Page = "WORLDEVENTMENU",
	},
	["LunarFestival2"] = {
		Prev_Page = "LunarFestival1",
		Back_Page = "WORLDEVENTMENU",
	},
	["MidsummerFestival"] = {
		Back_Page = "WORLDEVENTMENU",
	},
	["Noblegarden"] = {
		Back_Page = "WORLDEVENTMENU",
	},
	["ElementalInvasion"] = {
		Back_Page = "WORLDEVENTMENU",
	},
	["GurubashiArena"] = {
		Back_Page = "WORLDEVENTMENU",
	},
	["ScourgeInvasionEvent1"] = {
		Next_Page = "ScourgeInvasionEvent2",
		Back_Page = "WORLDEVENTMENU",
	},
	["ScourgeInvasionEvent2"] = {
		Prev_Page = "ScourgeInvasionEvent1",
		Back_Page = "WORLDEVENTMENU",
	},
	["FishingExtravaganza"] = {
		Back_Page = "WORLDEVENTMENU",
	},
	["AbyssalTemplars"] = {
		Back_Page = "WORLDEVENTMENU",
		Next_Page = "AbyssalDukes",
	},
	["AbyssalDukes"] = {
		Back_Page = "WORLDEVENTMENU",
		Next_Page = "AbyssalLords",
		Prev_Page = "AbyssalTemplars",
	},
	["AbyssalLords"] = {
		Back_Page = "WORLDEVENTMENU",
		Prev_Page = "AbyssalDukes",
	},

	-- Alchemy
	["AlchemyApprentice1"] = {
		Back_Page = "ALCHEMYMENU",
		Next_Page = "AlchemyJourneyman1",
	},
	["AlchemyJourneyman1"] = {
		Back_Page = "ALCHEMYMENU",
		Next_Page = "AlchemyExpert1",
		Prev_Page = "AlchemyApprentice1",
	},
	["AlchemyExpert1"] = {
		Back_Page = "ALCHEMYMENU",
		Next_Page = "AlchemyArtisan1",
		Prev_Page = "AlchemyJourneyman1",
	},
	["AlchemyArtisan1"] = {
		Back_Page = "ALCHEMYMENU",
		Next_Page = "AlchemyArtisan2",
		Prev_Page = "AlchemyExpert1",
	},
	["AlchemyArtisan2"] = {
		Back_Page = "ALCHEMYMENU",
		Prev_Page = "AlchemyArtisan1",
		Next_Page = "AlchemyArtisan3",
	},
	["AlchemyArtisan3"] = {
		Back_Page = "ALCHEMYMENU",
		Prev_Page = "AlchemyArtisan2",
		Next_Page = "AlchemyFlasks1",
	},
	["AlchemyFlasks1"] = {
		Back_Page = "ALCHEMYMENU",
		Next_Page = "AlchemyProtectionPots1",
		Prev_Page = "AlchemyArtisan3",
	},
	["AlchemyProtectionPots1"] = {
		Back_Page = "ALCHEMYMENU",
		Next_Page = "AlchemyHealingAndMana1",
		Prev_Page = "AlchemyFlasks1",
	},
	["AlchemyHealingAndMana1"] = {
		Back_Page = "ALCHEMYMENU",
		Next_Page = "AlchemyTransmutes1",
		Prev_Page = "AlchemyProtectionPots1",
	},
	["AlchemyTransmutes1"] = {
		Back_Page = "ALCHEMYMENU",
		Next_Page = "AlchemyDefensive1",
		Prev_Page = "AlchemyHealingAndMana1",
	},
	["AlchemyDefensive1"] = {
		Back_Page = "ALCHEMYMENU",
		Next_Page = "AlchemyOffensive1",
		Prev_Page = "AlchemyTransmutes1",
	},
	["AlchemyOffensive1"] = {
		Back_Page = "ALCHEMYMENU",
		Next_Page = "AlchemyOffensive2",
		Prev_Page = "AlchemyDefensive1",
	},
	["AlchemyOffensive2"] = {
		Back_Page = "ALCHEMYMENU",
		Next_Page = "AlchemyMisc1",
		Prev_Page = "AlchemyOffensive1",
	},
	["AlchemyMisc1"] = {
		Back_Page = "ALCHEMYMENU",
		Prev_Page = "AlchemyOffensive2",
	},

	-- Blacksmithing
	["SmithingApprentice1"] = {
		Back_Page = "SMITHINGMENU",
		Next_Page = "SmithingJourneyman1",
	},
	["SmithingJourneyman1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingApprentice1",
		Next_Page = "SmithingJourneyman2",
	},
	["SmithingJourneyman2"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingJourneyman1",
		Next_Page = "SmithingExpert1",
	},
	["SmithingExpert1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingJourneyman2",
		Next_Page = "SmithingExpert2",
	},
	["SmithingExpert2"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingExpert1",
		Next_Page = "SmithingExpert3",
	},
	["SmithingExpert3"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingExpert2",
		Next_Page = "SmithingArtisan1",
	},
	["SmithingArtisan1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingExpert3",
		Next_Page = "SmithingArtisan2",
	},
	["SmithingArtisan2"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingArtisan1",
		Next_Page = "SmithingArtisan3",
	},
	["SmithingArtisan3"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingArtisan2",
		Next_Page = "SmithingArtisan4",
	},
	["SmithingArtisan4"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingArtisan3",
		Next_Page = "SmithingHelm1",
	},
	["SmithingHelm1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingArtisan4",
		Next_Page = "SmithingShoulders1",
	},
	["SmithingShoulders1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingHelm1",
		Next_Page = "SmithingChest1",
	},
	["SmithingChest1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingShoulders1",
		Next_Page = "SmithingChest2",
	},
	["SmithingChest2"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingChest1",
		Next_Page = "SmithingBracers1",
	},
	["SmithingBracers1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingChest2",
		Next_Page = "SmithingGloves1",
	},
	["SmithingGloves1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingBracers1",
		Next_Page = "SmithingBelt1",
	},
	["SmithingBelt1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingGloves1",
		Next_Page = "SmithingPants1",
	},
	["SmithingPants1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingBelt1",
		Next_Page = "SmithingBoots1",
	},
	["SmithingBoots1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingPants1",
		Next_Page = "SmithingBuckles1",
	},
	["SmithingBuckles1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingBoots1",
		Next_Page = "SmithingAxes1",
	},
	["SmithingAxes1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingBuckles1",
		Next_Page = "SmithingSwords1",
	},
	["SmithingSwords1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingAxes1",
		Next_Page = "SmithingMaces1",
	},
	["SmithingMaces1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingSwords1",
		Next_Page = "SmithingFist1",
	},
	["SmithingFist1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingMaces1",
		Next_Page = "SmithingDaggers1",
	},
	["SmithingDaggers1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingFist1",
		Next_Page = "SmithingMisc1",
	},
	["SmithingMisc1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingDaggers1",
		Next_Page = "SmithingMisc2",
	},
	["SmithingMisc2"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingMisc1",
		Next_Page = "Armorsmith1",
	},
	["Armorsmith1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "SmithingMisc2",
		Next_Page = "Weaponsmith1",
	},
	["Weaponsmith1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "Armorsmith1",
		Next_Page = "Axesmith1",
	},
	["Axesmith1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "Weaponsmith1",
		Next_Page = "Hammersmith1",
	},
	["Hammersmith1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "Axesmith1",
		Next_Page = "Swordsmith1",
	},
	["Swordsmith1"] = {
		Back_Page = "SMITHINGMENU",
		Prev_Page = "Hammersmith1",
	},

	-- Enchanting
	["EnchantingApprentice1"] = {
		Back_Page = "ENCHANTINGMENU",
		Next_Page = "EnchantingJourneyman1",
	},
	["EnchantingJourneyman1"] = {
		Back_Page = "ENCHANTINGMENU",
		Prev_Page = "EnchantingApprentice1",
		Next_Page = "EnchantingJourneyman2",
	},
	["EnchantingJourneyman2"] = {
		Back_Page = "ENCHANTINGMENU",
		Prev_Page = "EnchantingJourneyman1",
		Next_Page = "EnchantingExpert1",
	},
	["EnchantingExpert1"] = {
		Back_Page = "ENCHANTINGMENU",
		Prev_Page = "EnchantingJourneyman2",
		Next_Page = "EnchantingExpert2",
	},
	["EnchantingExpert2"] = {
		Back_Page = "ENCHANTINGMENU",
		Prev_Page = "EnchantingExpert1",
		Next_Page = "EnchantingArtisan1",
	},
	["EnchantingArtisan1"] = {
		Back_Page = "ENCHANTINGMENU",
		Prev_Page = "EnchantingExpert2",
		Next_Page = "EnchantingArtisan2",
	},
	["EnchantingArtisan2"] = {
		Back_Page = "ENCHANTINGMENU",
		Prev_Page = "EnchantingArtisan1",
		Next_Page = "EnchantingArtisan3",
	},
	["EnchantingArtisan3"] = {
		Back_Page = "ENCHANTINGMENU",
		Prev_Page = "EnchantingArtisan2",
		Next_Page = "EnchantingCloak1",
	},
	["EnchantingCloak1"] = {
		Back_Page = "ENCHANTINGMENU",
		Prev_Page = "EnchantingArtisan3",
		Next_Page = "EnchantingChest1",
	},
	["EnchantingChest1"] = {
		Back_Page = "ENCHANTINGMENU",
		Prev_Page = "EnchantingCloak1",
		Next_Page = "EnchantingBracer1",
	},
	["EnchantingBracer1"] = {
		Back_Page = "ENCHANTINGMENU",
		Prev_Page = "EnchantingChest1",
		Next_Page = "EnchantingGlove1",
	},
	["EnchantingGlove1"] = {
		Back_Page = "ENCHANTINGMENU",
		Prev_Page = "EnchantingBracer1",
		Next_Page = "EnchantingBoots1",
	},
	["EnchantingBoots1"] = {
		Back_Page = "ENCHANTINGMENU",
		Prev_Page = "EnchantingGlove1",
		Next_Page = "Enchanting2HWeapon1",
	},
	["Enchanting2HWeapon1"] = {
		Back_Page = "ENCHANTINGMENU",
		Prev_Page = "EnchantingBoots1",
		Next_Page = "EnchantingWeapon1",
	},
	["EnchantingWeapon1"] = {
		Back_Page = "ENCHANTINGMENU",
		Prev_Page = "Enchanting2HWeapon1",
		Next_Page = "EnchantingShield1",
	},
	["EnchantingShield1"] = {
		Back_Page = "ENCHANTINGMENU",
		Prev_Page = "EnchantingWeapon1",
		Next_Page = "EnchantingMisc1",
	},
	["EnchantingMisc1"] = {
		Back_Page = "ENCHANTINGMENU",
		Prev_Page = "EnchantingShield1",
	},

	-- Engineering
	["EngineeringApprentice1"] = {
		Back_Page = "ENGINEERINGMENU",
		Next_Page = "EngineeringJourneyman1",
	},
	["EngineeringJourneyman1"] = {
		Back_Page = "ENGINEERINGMENU",
		Prev_Page = "EngineeringApprentice1",
		Next_Page = "EngineeringJourneyman2",
	},
	["EngineeringJourneyman2"] = {
		Back_Page = "ENGINEERINGMENU",
		Prev_Page = "EngineeringJourneyman1",
		Next_Page = "EngineeringExpert1",
	},
	["EngineeringExpert1"] = {
		Back_Page = "ENGINEERINGMENU",
		Prev_Page = "EngineeringJourneyman2",
		Next_Page = "EngineeringExpert2",
	},
	["EngineeringExpert2"] = {
		Back_Page = "ENGINEERINGMENU",
		Prev_Page = "EngineeringExpert1",
		Next_Page = "EngineeringArtisan1",
	},
	["EngineeringArtisan1"] = {
		Back_Page = "ENGINEERINGMENU",
		Prev_Page = "EngineeringExpert2",
		Next_Page = "EngineeringArtisan2",
	},
	["EngineeringArtisan2"] = {
		Back_Page = "ENGINEERINGMENU",
		Prev_Page = "EngineeringArtisan1",
		Next_Page = "EngineeringEquipment1",
	},
	["EngineeringEquipment1"] = {
		Back_Page = "ENGINEERINGMENU",
		Prev_Page = "EngineeringArtisan2",
		Next_Page = "EngineeringTrinkets1",
	},
	["EngineeringTrinkets1"] = {
		Back_Page = "ENGINEERINGMENU",
		Prev_Page = "EngineeringEquipment1",
		Next_Page = "EngineeringExplosives1",
	},
	["EngineeringExplosives1"] = {
		Back_Page = "ENGINEERINGMENU",
		Prev_Page = "EngineeringTrinkets1",
		Next_Page = "EngineeringWeapons1",
	},
	["EngineeringWeapons1"] = {
		Back_Page = "ENGINEERINGMENU",
		Prev_Page = "EngineeringExplosives1",
		Next_Page = "EngineeringParts1",
	},
	["EngineeringParts1"] = {
		Back_Page = "ENGINEERINGMENU",
		Prev_Page = "EngineeringWeapons1",
		Next_Page = "EngineeringMisc1",
	},
	["EngineeringMisc1"] = {
		Back_Page = "ENGINEERINGMENU",
		Prev_Page = "EngineeringParts1",
		Next_Page = "EngineeringMisc2",
	},
	["EngineeringMisc2"] = {
		Back_Page = "ENGINEERINGMENU",
		Prev_Page = "EngineeringMisc1",
		Next_Page = "EngineeringMisc3",
	},
	["EngineeringMisc3"] = {
		Back_Page = "ENGINEERINGMENU",
		Prev_Page = "EngineeringMisc2",
		Next_Page = "Gnomish1",
	},
	["Gnomish1"] = {
		Back_Page = "ENGINEERINGMENU",
		Prev_Page = "EngineeringMisc3",
		Next_Page = "Goblin1",
	},
	["Goblin1"] = {
		Back_Page = "ENGINEERINGMENU",
		Prev_Page = "Gnomish1",
	},

	-- Leatherworking
	["LeatherApprentice1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Next_Page = "LeatherJourneyman1",
	},
	["LeatherJourneyman1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherApprentice1",
		Next_Page = "LeatherJourneyman2",
	},
	["LeatherJourneyman2"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherJourneyman1",
		Next_Page = "LeatherExpert1",
	},
	["LeatherExpert1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherJourneyman2",
		Next_Page = "LeatherExpert2",
	},
	["LeatherExpert2"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherExpert1",
		Next_Page = "LeatherArtisan1",
	},
	["LeatherArtisan1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherExpert2",
		Next_Page = "LeatherArtisan2",
	},
	["LeatherArtisan2"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherArtisan1",
		Next_Page = "LeatherArtisan3",
	},
	["LeatherArtisan3"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherArtisan2",
		Next_Page = "LeatherArtisan4",
	},
	["LeatherArtisan4"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherArtisan3",
		Next_Page = "LeatherHelm1",
	},
	["LeatherHelm1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherArtisan4",
		Next_Page = "LeatherShoulders1",
	},
	["LeatherShoulders1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherHelm1",
		Next_Page = "LeatherCloak1",
	},
	["LeatherCloak1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherShoulders1",
		Next_Page = "LeatherChest1",
	},
	["LeatherChest1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherCloak1",
		Next_Page = "LeatherChest2",
	},
	["LeatherChest2"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherChest1",
		Next_Page = "LeatherBracers1",
	},
	["LeatherBracers1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherChest2",
		Next_Page = "LeatherGloves1",
	},
	["LeatherGloves1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherBracers1",
		Next_Page = "LeatherGloves2",
	},
	["LeatherGloves2"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherGloves1",
		Next_Page = "LeatherBelt1",
	},
	["LeatherBelt1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherGloves2",
		Next_Page = "LeatherPants1",
	},
	["LeatherPants1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherBelt1",
		Next_Page = "LeatherPants2",
	},
	["LeatherPants2"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherPants1",
		Next_Page = "LeatherBoots1",
	},
	["LeatherBoots1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherPants2",
		Next_Page = "LeatherBags1",
	},
	["LeatherBags1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherBoots1",
		Next_Page = "LeatherMisc1",
	},
	["LeatherMisc1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherBags1",
		Next_Page = "Dragonscale1",
	},
	["Dragonscale1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "LeatherMisc1",
		Next_Page = "Elemental1",
	},
	["Elemental1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "Dragonscale1",
		Next_Page = "Tribal1",
	},
	["Tribal1"] = {
		Back_Page = "LEATHERWORKINGMENU",
		Prev_Page = "Elemental1",
	},

	-- Jewelcrafting
	["JewelcraftingApprentice1"] = {
		Back_Page = "JEWELCRAFTMENU",
		Next_Page = "JewelcraftingJourneyman1",
	},
	["JewelcraftingJourneyman1"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingApprentice1",
		Next_Page = "JewelcraftingJourneyman2",
	},
	["JewelcraftingJourneyman2"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingJourneyman1",
		Next_Page = "JewelcraftingExpert1",
	},
	["JewelcraftingExpert1"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingJourneyman2",
		Next_Page = "JewelcraftingExpert2",
	},
	["JewelcraftingExpert2"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingExpert1",
		Next_Page = "JewelcraftingExpert3",
	},
	["JewelcraftingExpert3"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingExpert2",
		Next_Page = "JewelcraftingArtisan1",
	},
	["JewelcraftingArtisan1"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingExpert3",
		Next_Page = "JewelcraftingArtisan2",
	},
	["JewelcraftingArtisan2"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingArtisan1",
		Next_Page = "JewelcraftingGemstones1",
	},
	["JewelcraftingGemstones1"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingArtisan2",
		Next_Page = "JewelcraftingRings1",
	},
	["JewelcraftingRings1"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingGemstones1",
		Next_Page = "JewelcraftingRings2",
	},
	["JewelcraftingRings2"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingRings1",
		Next_Page = "JewelcraftingAmulets1",
	},
	["JewelcraftingAmulets1"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingRings2",
		Next_Page = "JewelcraftingAmulets2",
	},
	["JewelcraftingAmulets2"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingAmulets1",
		Next_Page = "JewelcraftingHelm1",
	},
	["JewelcraftingHelm1"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingAmulets2",
		Next_Page = "JewelcraftingBracers1",
	},
	["JewelcraftingBracers1"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingHelm1",
		Next_Page = "JewelcraftingOffHands1",
	},
	["JewelcraftingOffHands1"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingBracers1",
		Next_Page = "JewelcraftingStaves1",
	},
	["JewelcraftingStaves1"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingOffHands1",
		Next_Page = "JewelcraftingTrinkets1",
	},
	["JewelcraftingTrinkets1"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingStaves1",
		Next_Page = "JewelcraftingMisc1",
	},
	["JewelcraftingMisc1"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingTrinkets1",
		Next_Page = "JewelcraftingGemology1",
	},
	["JewelcraftingGemology1"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingMisc1",
		Next_Page = "JewelcraftingGoldsmithing1",
	},
	["JewelcraftingGoldsmithing1"] = {
		Back_Page = "JEWELCRAFTMENU",
		Prev_Page = "JewelcraftingGemology1",
	},

	-- Herbalism
	["Herbalism1"] = {
		Back_Page = "CRAFTINGMENU",
		Next_Page = "Herbalism2",
	},
	["Herbalism2"] = {
		Back_Page = "CRAFTINGMENU",
		Prev_Page = "Herbalism1",
	},

	-- Mining
	["Mining1"] = {
		Back_Page = "CRAFTINGMENU",
		Next_Page = "Smelting1",
	},
	["Smelting1"] = {
		Back_Page = "CRAFTINGMENU",
		Prev_Page = "Mining1",
	},

	-- Tailoring
	["TailoringApprentice1"] = {
		Back_Page = "TAILORINGMENU",
		Next_Page = "TailoringApprentice2",
	},
	["TailoringApprentice2"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringApprentice1",
		Next_Page = "TailoringJourneyman1",
	},
	["TailoringJourneyman1"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringApprentice2",
		Next_Page = "TailoringJourneyman2",
	},
	["TailoringJourneyman2"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringJourneyman1",
		Next_Page = "TailoringExpert1",
	},
	["TailoringExpert1"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringJourneyman2",
		Next_Page = "TailoringExpert2",
	},
	["TailoringExpert2"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringExpert1",
		Next_Page = "TailoringExpert3",
	},
	["TailoringExpert3"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringExpert2",
		Next_Page = "TailoringArtisan1",
	},
	["TailoringArtisan1"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringExpert3",
		Next_Page = "TailoringArtisan2",
	},
	["TailoringArtisan2"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringArtisan1",
		Next_Page = "TailoringArtisan3",
	},
	["TailoringArtisan3"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringArtisan2",
		Next_Page = "TailoringArtisan4",
	},
	["TailoringArtisan4"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringArtisan3",
		Next_Page = "TailoringArtisan5",
	},
	["TailoringArtisan5"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringArtisan4",
		Next_Page = "TailoringHelm1",
	},
	["TailoringHelm1"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringArtisan5",
		Next_Page = "TailoringShoulders1",
	},
	["TailoringShoulders1"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringHelm1",
		Next_Page = "TailoringCloak1",
	},
	["TailoringCloak1"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringShoulders1",
		Next_Page = "TailoringChest1",
	},
	["TailoringChest1"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringCloak1",
		Next_Page = "TailoringChest2",
	},
	["TailoringChest2"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringChest1",
		Next_Page = "TailoringBracers1",
	},
	["TailoringBracers1"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringChest2",
		Next_Page = "TailoringGloves1",
	},
	["TailoringGloves1"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringBracers1",
		Next_Page = "TailoringGloves2",
	},
	["TailoringGloves2"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringGloves1",
		Next_Page = "TailoringBelt1",
	},
	["TailoringBelt1"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringGloves2",
		Next_Page = "TailoringPants1",
	},
	["TailoringPants1"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringBelt1",
		Next_Page = "TailoringBoots1",
	},
	["TailoringBoots1"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringPants1",
		Next_Page = "TailoringShirt1",
	},
	["TailoringShirt1"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringBoots1",
		Next_Page = "TailoringBags1",
	},
	["TailoringBags1"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringShirt1",
		Next_Page = "TailoringMisc1",
	},
	["TailoringMisc1"] = {
		Back_Page = "TAILORINGMENU",
		Prev_Page = "TailoringBags1",
	},

	-- Cooking
	["CookingApprentice1"] = {
		Back_Page = "CRAFTINGMENU",
		Next_Page = "CookingJourneyman1",
	},
	["CookingJourneyman1"] = {
		Back_Page = "CRAFTINGMENU",
		Prev_Page = "CookingApprentice1",
		Next_Page = "CookingExpert1",
	},
	["CookingExpert1"] = {
		Back_Page = "CRAFTINGMENU",
		Prev_Page = "CookingJourneyman1",
		Next_Page = "CookingArtisan1",
	},
	["CookingArtisan1"] = {
		Back_Page = "CRAFTINGMENU",
		Prev_Page = "CookingExpert1",
	},

	-- First Aid
	["FirstAid1"] = {
		Back_Page = "CRAFTINGMENU",
	},

	-- Survival
	["SurvivalApprentice1"] = {
		Next_Page = "SurvivalJourneyman1",
		Back_Page = "CRAFTINGMENU",
	},
	["SurvivalJourneyman1"] = {
		Prev_Page = "SurvivalApprentice1",
		Next_Page = "SurvivalExpert1",
		Back_Page = "CRAFTINGMENU",
	},
	["SurvivalExpert1"] = {
		Prev_Page = "SurvivalJourneyman1",
		Next_Page = "SurvivalArtisan1",
		Back_Page = "CRAFTINGMENU",
	},
	["SurvivalArtisan1"] = {
		Prev_Page = "SurvivalExpert1",
		Back_Page = "CRAFTINGMENU",
	},

	-- Gardening
	["Gardening1"] = {
		Back_Page = "CRAFTINGMENU",
	},

	-- Poisons
	["Poisons1"] = {
		Back_Page = "CRAFTINGMENU",
	},
};
