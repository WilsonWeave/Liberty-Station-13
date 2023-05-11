// Disks formated as /designpath = pointcost , if no point cost is specified it defaults to 1.
// To make a design unprotect use -1
// Bonfire

/obj/item/computer_hardware/hard_drive/portable/design/nt
	disk_name = "Bonfire Armory"
	icon_state = "neotheology"
	license = -1

/obj/item/computer_hardware/hard_drive/portable/design/nt/textials
	disk_name = "textials disk"
	icon_state = "neotheology"
	license = -1

	designs = list(
		//Misc
		/datum/design/bioprinter/nt_clothes/oathbound,
		/datum/design/bioprinter/nt_clothes/enkindled,
		/datum/design/bioprinter/nt_clothes/forgemaster,
		/datum/design/bioprinter/nt_clothes/oathpledge,
		/datum/design/bioprinter/belt/utility/neotheology,
		/datum/design/bioprinter/belt/security/neotheology,
		/datum/design/bioprinter/nt_clothes/custodian_boots,
		//backpacks
		/datum/design/bioprinter/leather/storage/backpack/satchel/custodian,
		/datum/design/bioprinter/leather/storage/backpack/custodian,
		/datum/design/bioprinter/leather/storage/backpack/sport/custodian,
		//pouches
		/datum/design/bioprinter/pouch/janitor_supply,
		/datum/design/bioprinter/pouch/medium_generic,
		/datum/design/bioprinter/pouch/large_generic,
		/datum/design/bioprinter/pouch/tubular,
		/datum/design/bioprinter/pouch/tubular/vial,
		//armor
		/datum/design/bioprinter/nt_clothes/oathbound_armor,
		/datum/design/bioprinter/nt_clothes/oathbound_helmet,
		/datum/design/bioprinter/nt_clothes/enkindled_armor,
		/datum/design/bioprinter/nt_clothes/enkindled_helmet,
		/datum/design/bioprinter/nt_clothes/forgemaster_armor,
		/datum/design/bioprinter/nt_clothes/forgemaster_helmet,
		/datum/design/bioprinter/nt_clothes/oathpledge_armor,
		/datum/design/bioprinter/nt_clothes/oathpledge_helmet,
		/datum/design/bioprinter/nt_clothes/huscarl,
//		/datum/design/bioprinter/nt_clothes/knight_rig, Pending Custodian IRR sprites later
		//holsters
//		/datum/design/bioprinter/leather/holster/saber/greatsword/churchprint, getting replaced
		/datum/design/bioprinter/leather/holster,
		/datum/design/bioprinter/leather/holster/armpit,
		/datum/design/bioprinter/leather/holster/waist,
		/datum/design/bioprinter/leather/holster/hip,
		/datum/design/bioprinter/leather/holster/leg,
		//pouches
		/datum/design/bioprinter/pouch/ammo,
		/datum/design/bioprinter/pouch/baton_holster,
		/datum/design/bioprinter/pouch/pistol_holster,
		/datum/design/bioprinter/pouch/pistol_double,
		/datum/design/bioprinter/pouch/kniferig,
		/datum/design/bioprinter/pouch/quiver,
		/datum/design/bioprinter/pouch/xbowquiver,
	)

/obj/item/computer_hardware/hard_drive/portable/design/nt/bioprinter
	disk_name = "Custodians of Bonfire Utilities Plus"
	desc = "This disk is sole property of the custodians, the files within are encrypted and should not be used, taken, or tested by anyone not affiliated with the Custodians."
	icon_state = "neotheology_testament_u"
	license = -1
	designs = list(
		//products
		/datum/design/bioprinter/meat,
		/datum/design/bioprinter/milk,
		/datum/design/bioprinter/soap,
		/datum/design/bioprinter/ez,
		/datum/design/bioprinter/l4z,
		/datum/design/bioprinter/rh,
		//armor upgrades
		/datum/design/autolathe/armor_upgrade/melee,
		/datum/design/autolathe/armor_upgrade/bullet,
		/datum/design/autolathe/armor_upgrade/energy,
		/datum/design/autolathe/armor_upgrade/bomb,
		//utilities
		/datum/design/bioprinter/holyvacuum,
		/datum/design/autolathe/gun/nt_sprayer,
		/datum/design/autolathe/device/grenade/nt_cleaner,
		/datum/design/autolathe/device/grenade/nt_weedkiller
	)

/obj/item/computer_hardware/hard_drive/portable/design/nt/bioprinter/public
	disk_name = "Custodians of Bonfire Products and Utilities Basic"
	desc = "A limited design disk for cleaning, gardening and some production of meats and milk."
	license = 20

/obj/item/computer_hardware/hard_drive/portable/design/nt/bioaugment
	disk_name = "Strange Disk"
	desc = "Now,where did this come from?"
	icon_state = "onestar"

	license = -1
	designs = list(
		/datum/design/bioprinter/bioimplant/osurgical,
		/datum/design/bioprinter/bioimplant/oengineering,
		/datum/design/bioprinter/bioimplant/oscythe,
		/datum/design/bioprinter/bioimplant/oarmor,
		/datum/design/bioprinter/bioimplant/omuscle,
		/datum/design/research/item/mechfab/modules/hud/welder_bio,
		/datum/design/research/item/mechfab/modules/hud/night_bio,
		/datum/design/research/item/mechfab/modules/hud/thermal_bio
	)

/obj/item/computer_hardware/hard_drive/portable/design/nt_basic_arms
	disk_name = "Bonfire Armory - New Testament Armaments"
	icon_state = "neotheology_testament"
	license = -1
	designs = list(
		//weapons
		/datum/design/autolathe/sword/custodian_sword,
		/datum/design/autolathe/sword/custodian_longsword,
		/datum/design/autolathe/sword/custodian_dagger,
		/datum/design/autolathe/sword/custodian_halberd,
		/datum/design/autolathe/sword/custodian_scourge,
		/datum/design/autolathe/sword/custodian_spear,
		/datum/design/autolathe/sword/custodian_flanged,
		/datum/design/autolathe/nt/shield/nt_buckler,
		/datum/design/autolathe/shield/nt_shield,
		//mods
		/datum/design/autolathe/tool_upgrade/sanctifier,
		/datum/design/autolathe/gun_upgrade/barrel/excruciator,
	)

/obj/item/computer_hardware/hard_drive/portable/design/nt_basic_arms/public
	disk_name = "Bonfire Armory - Crusade Starter Kit"
	license = 8

//for the EOTP
/obj/item/computer_hardware/hard_drive/portable/design/nt/new_guns
	disk_name = "Bonfire Armory of the New Testament Plus"
	desc = "A rare and expensive disk containing designs for highly advanced energy weapons from the Old Testament, the Absolutes arms division. Nicknamed the new testament for containing its latest weaponry designs."
	icon_state = "neotheology"
	license = 18
	designs = list(
		/datum/design/autolathe/gun/energy_crossbow = 10,
		/datum/design/autolathe/gun/ntpistol,
		/datum/design/autolathe/gun/laser = 2,
		/datum/design/autolathe/gun/pulse = 5,
		/datum/design/autolathe/gun/pulse_destroyer = 8,
		/datum/design/autolathe/gun/ionrifle = 3,
	)


/obj/item/computer_hardware/hard_drive/portable/design/nt_new_guns
	disk_name = "Bonfire Armory of the New Testament"
	desc = "A rare and expensive disk containing designs for highly advanced energy weapons from the Old Testament, the Absolutes arms division. Nicknamed the new testament for containing its latest weaponry designs."
	icon_state = "neotheology"
	license = 16
	designs = list(
		/datum/design/autolathe/gun/energy_crossbow = 10,
		/datum/design/autolathe/gun/ntpistol,
		/datum/design/autolathe/gun/pulse = 5,
		/datum/design/autolathe/gun/pulse_destroyer = 8,
		/datum/design/autolathe/gun/ionrifle = 3,
	)

/obj/item/computer_hardware/hard_drive/portable/design/nt_plasma_shells
	disk_name = "Bonfire Armory - Plasma Shell Pack"
	desc = "A rare and expensive disk containing designs for highly advanced plasma based shotgun shells."
	icon_state = "neotheology"
	license = 8 // 20 heavy plasma shells or 40 normal shots.
	designs = list(
		/datum/design/autolathe/ammo/shotgun_plasma_heavy = 2,
		/datum/design/autolathe/ammo/shotgun_plasma,
	)

//for the EOTP
/obj/item/computer_hardware/hard_drive/portable/design/nt/plasma_shells
	disk_name = "Bonfire Armory - Plasma Shell Pack Plus"
	desc = "A rare and expensive disk containing designs for highly advanced plasma based shotgun shells."
	icon_state = "neotheology"
	license = 10 // 36 heavy plasma shells or 56 normal shots.
	designs = list(
		/datum/design/autolathe/ammo/shotgun_plasma_heavy = 2,
		/datum/design/autolathe/ammo/shotgun_plasma,
	)
