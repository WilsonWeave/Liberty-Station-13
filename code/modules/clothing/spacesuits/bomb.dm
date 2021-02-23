/*
 * Bomb protection
 */
/obj/item/clothing/head/helmet/space/bomb
	name = "bomb helmet"
	desc = "Use in case of bomb."
	icon_state = "bombsuit"
	armor = list(
		melee = 20,
		bullet = 20,
		energy = 30,
		bomb = 100,
		bio = 100,
		rad = 90
	)
	max_upgrades = 3
	siemens_coefficient = 0
	tint = TINT_HEAVY
	price_tag = 100

/obj/item/clothing/suit/space/bomb
	name = "bomb suit"
	desc = "A protective suit designed for safety when handling explosives."
	icon_state = "bombsuit"
	item_state = "bombsuit"
	gas_transfer_coefficient = 0.01
	permeability_coefficient = 0.01
	slowdown = 2
	armor = list(
		melee = 20,
		bullet = 20,
		energy = 30,
		bomb = 100,
		bio = 100,
		rad = 90
	)
	tool_qualities = list(QUALITY_ARMOR = 100)
	max_upgrades = 3
	heat_protection = UPPER_TORSO|LOWER_TORSO|LEGS|ARMS
	max_heat_protection_temperature = ARMOR_MAX_HEAT_PROTECTION_TEMPERATURE
	siemens_coefficient = 0
	equip_delay = 10 SECONDS
	price_tag = 300

/obj/item/clothing/head/helmet/space/bomb/security
	name = "juggernaut bomb helmet"
	desc = "Use in case of bomb well under fire."
	equip_delay = 16 SECONDS
	slowdown = 1.25 //so with full suit is 3.5 or 4.5
	armor = list(
		melee = 60,
		bullet = 60,
		energy = 60,
		bomb = 100,
		bio = 100,
		rad = 90
	)
	icon_state = "bombsuitsec"

/obj/item/clothing/suit/space/bomb/security
	name = "juggernaut bomb suit"
	desc = "A protective suit designed for safety when handling explosives well under fire."
	slowdown = 3.25
	equip_delay = 16 SECONDS
	armor = list(
		melee = 60,
		bullet = 60,
		energy = 60,
		bomb = 100,
		bio = 100,
		rad = 90
	)
	icon_state = "bombsuitsec"
