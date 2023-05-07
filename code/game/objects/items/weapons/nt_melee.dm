//Warning! If you change icon_state or item_state, make sure you change path for sneath as well. icons/obj/sneath.dmi
/obj/item/tool/sword/nt // not supposed to be in the game, had to make the shortsword its own type to prevent fucking up the scourge. sorry.
	name = "base item"
	desc = "If you can see this in-game, report it."
	icon = 'icons/obj/nt_melee.dmi'
	icon_state = "ulfberth_sword"
	item_state = "ulfberth_sword"
	force = WEAPON_FORCE_DANGEROUS
	throwforce = WEAPON_FORCE_WEAK
	armor_penetration = ARMOR_PEN_DEEP
	price_tag = 300
	matter = list(MATERIAL_BIO_SILK = 25, MATERIAL_STEEL = 5)

/obj/item/tool/sword/nt/equipped(mob/living/M)
	. = ..()
	if(is_held() && is_neotheology_disciple(M))
		embed_mult = 0.05
	else
		embed_mult = initial(embed_mult)

/obj/item/tool/sword/nt/shortsword
	name = "ulfberth"
	desc = "As much as the swords may be underused by the Custodians in exchange for polearms and axes, many short swords are produced with a cheap price. \
	The ulfberth are regarded as a work of art rather than a weapon - yet more effective than a machete nonetheless."
	icon = 'icons/obj/nt_melee.dmi'
	icon_state = "ulfberth_sword"
	item_state = "ulfberth_sword"
	force = WEAPON_FORCE_DANGEROUS
	throwforce = WEAPON_FORCE_WEAK
	armor_penetration = ARMOR_PEN_DEEP
	price_tag = 300
	matter = list(MATERIAL_BIO_SILK = 25, MATERIAL_STEEL = 5)

/obj/item/tool/sword/nt/longsword
	name = "horseman axe"
	desc = "An efficient tin-opener of a weapon, excellent for penetrating armor - the sight of such a large axe is not far-fetched from horror stories, as such blade and weight can easily chop an arm. \
	This piece of equipment is the most well used piece of melee weaponry of the Custodians."
	icon_state = "horsemans_axe"
	item_state = "horsemans_axe"
	wielded_icon = "horsemans_axe_wielded"
	force = WEAPON_FORCE_ROBUST
	armor_penetration = ARMOR_PEN_EXTREME
	w_class = ITEM_SIZE_BULKY
	price_tag = 500
	matter = list(MATERIAL_BIO_SILK = 75, MATERIAL_STEEL = 10, MATERIAL_CARBON_FIBER = 5)

/obj/item/tool/knife/dagger/nt
	name = "custodian seax"
	desc = "A really small sword used to puncture enemies in between armor, or to be used as a tool for cutting like a knife, even if clearly more efficient for stabbing."
	icon = 'icons/obj/nt_melee.dmi'
	icon_state = "custodian_seax"
	item_state = "custodian_seax"
	force = WEAPON_FORCE_PAINFUL
	armor_penetration = ARMOR_PEN_MASSIVE
	price_tag = 120
	matter = list(MATERIAL_BIO_SILK = 10, MATERIAL_STEEL = 1)

/obj/item/tool/spear/halberd
	name = "custodian atgeir"
	desc = "The polearm that anticipates bloodshed, serving in the battlefield as a multipurpose staff with a spearhead mixed with the blade of an axe. \
	The weapon is large and heavy, very difficult to store - yet way more brutal than any average melee weapon."
	icon = 'icons/obj/nt_melee.dmi'
	icon_state = "custodian_atgeir"
	item_state = "custodian_atgeir"
	wielded_icon = "custodian_atgeir_wielded"
	force = WEAPON_FORCE_BRUTAL
	armor_penetration = ARMOR_PEN_MASSIVE
	price_tag = 600
	matter = list(MATERIAL_BIO_SILK = 80, MATERIAL_STEEL = 8, MATERIAL_WOOD = 10, MATERIAL_CARBON_FIBER = 2)

/obj/item/tool/sword/nt/scourge
	name = "custodian nagaika"
	desc = "A whip made from compacted and oil-hardened silk with dense dark silver on its tip, with protubing blades that open and close on impact to inflict superfluous injury, the very same reason why Hollow-points are considered a war crime to use. \
	Good thing whoever wrote that only included “bullets”."
	icon_state = "custodian_nagaika"
	item_state = "custodian_nagaika"
	force = WEAPON_FORCE_ROBUST
	var/force_extended = WEAPON_FORCE_PAINFUL
	armor_penetration = ARMOR_PEN_MASSIVE
	var/armor_penetration_extended = ARMOR_PEN_HALF
	var/extended = FALSE
	var/agony = 20
	var/agony_extended = 45 //Church harmbaton! This is legit better then a normal baton as it can be upgraded AND has base 15 damage
	var/stun = 0
	w_class = ITEM_SIZE_BULKY
	price_tag = 800
	matter = list(MATERIAL_BIO_SILK = 50, MATERIAL_STEEL = 5, MATERIAL_CARBON_FIBER = 2)
	has_alt_mode = FALSE

/obj/item/tool/sword/nt/scourge/attack_self(mob/user)
	if(extended)
		unextend()
	else
		extend()

/obj/item/tool/sword/nt/scourge/proc/extend()
	extended = TRUE
	force += (force_extended - initial(force))
	armor_penetration += (armor_penetration_extended - initial(armor_penetration))
	agony += (agony_extended - initial(agony))
	slot_flags = null
	w_class = ITEM_SIZE_HUGE
	refresh_upgrades() //it's also sets all to default
	update_icon()

/obj/item/tool/sword/nt/scourge/proc/unextend()
	extended = FALSE
	w_class = initial(w_class)
	agony = initial(agony)
	slot_flags = initial(slot_flags)
	armor_penetration = initial(armor_penetration)
	refresh_upgrades() //it's also sets all to default
	update_icon()

/obj/item/tool/sword/nt/scourge/update_icon()
	if(extended)
		icon_state = initial(icon_state) + "_extended"
	else
		icon_state = initial(icon_state)
	..()

/obj/item/tool/sword/nt/scourge/apply_hit_effect(mob/living/carbon/human/target, mob/living/user, hit_zone)
	. = ..()
	if(ishuman(target))
		var/mob/living/carbon/human/O = target
		target.stun_effect_act(stun, agony, hit_zone, src)
		O.say(pick("LORD", "MERCY", "SPARE", "ME", "HAVE", "PLEASE"))

/obj/item/tool/sword/nt/spear
	name = "custodian francisca"
	desc = "The Francisca is an efficient throwing axe with an arch-shaped head. Small and concealable, the angle of the blade allows better breaking of shields, disrupting enemy lines and wounding an enemy hand-to-hand combat would happen. \
	Even if the blade were not to strike the target, its weight has the potential of breaking necks."
	icon_state = "custodian_francisca"
	item_state = "custodian_francisca"
	force = WEAPON_FORCE_DANGEROUS
	var/tipbroken = FALSE
	w_class = ITEM_SIZE_HUGE
	slot_flags = SLOT_BACK | SLOT_BELT
	throwforce = WEAPON_FORCE_LETHAL * 1.5
	armor_penetration = ARMOR_PEN_HALF
	throw_speed = 3
	price_tag = 150
	matter = list(MATERIAL_BIO_SILK = 20, MATERIAL_CARBON_FIBER = 10) // More expensive, high-end spear

/obj/item/tool/sword/nt/spear/equipped(mob/living/W)
	. = ..()
	if(is_held() && is_neotheology_disciple(W))
		embed_mult = 0.2
	else
		embed_mult = initial(embed_mult)

/obj/item/tool/sword/nt/spear/dropped(mob/living/W)
	embed_mult = 600
	..()

/obj/item/tool/sword/nt/spear/on_embed(mob/user)
	. = ..()
	tipbroken = TRUE

/obj/item/tool/sword/nt/spear/examine(mob/user)
	. = ..()
	if (tipbroken)
		to_chat(user, SPAN_WARNING("\The [src] is broken. It looks like it could be repaired with a hammer."))

/obj/item/tool/sword/nt/spear/attackby(obj/item/I, var/mob/user)
	. = ..()
	if (I.has_quality(QUALITY_HAMMERING))
		if(I.use_tool(user, src, WORKTIME_FAST, QUALITY_HAMMERING, FAILCHANCE_EASY, STAT_MEC))
			to_chat(user, SPAN_NOTICE("You repair \the damaged spear-tip."))
			tipbroken = FALSE

/obj/item/tool/sword/nt/flanged
	name = "emberblaze warhammer"
	desc = "An one handed Raven's beak that rapidly blazes when in connection with the Hearthcore and transfers its massive heat towards an chosen victim way worse than an laser sword would, enough to cause third-degree burns, and it is used to counter enemies using armor with high melee protection. \
	It is TOO efficient to cleanse the maintenance - to the point that it is more likely to dust giant insects rather than allowing the Custodian to gather its meat for materials."
	icon_state = "emberblaze_warhammer"
	item_state = "emberblaze_warhammer"
	wielded_icon = "emberblaze_warhammer_wielded"
	force = WEAPON_FORCE_ROBUST
	armor_penetration = ARMOR_PEN_MASSIVE
	w_class = ITEM_SIZE_BULKY
	price_tag = 800
	matter = list(MATERIAL_BIO_SILK = 50, MATERIAL_STEEL = 5, MATERIAL_CARBON_FIBER = 5, MATERIAL_SILVER = 3)
	tool_qualities = list(QUALITY_HAMMERING = 10) //Not designed for that fine nailing
	var/glowing = FALSE
	sharp = FALSE
	embed_mult = 0
	has_alt_mode = FALSE

/obj/item/tool/sword/nt/flanged/attack_self(mob/user)
	var/mob/living/carbon/human/theuser = user
	var/obj/item/implant/core_implant/cruciform/CI = theuser.get_core_implant()
	if(!CI || !CI.active || !CI.wearer || !istype(CI,/obj/item/implant/core_implant/cruciform))
		to_chat(user, SPAN_WARNING("You do not have a Hearthcore with which to light this beacon!"))
		return
	if(CI.power < 20)
		to_chat(user, SPAN_WARNING("You do not have enough power to light up the beacon!"))
		return
	if(glowing)
		to_chat(user, SPAN_WARNING("The warhammer is still lit up."))
		return
	else
		set_light(l_range = 4, l_power = 2, l_color = COLOR_YELLOW)
		to_chat(user, SPAN_WARNING("The warhammer has been lit!"))
		glowing = TRUE
		update_icon()
		damtype = BURN
		spawn(1200)
			set_light(l_range = 0, l_power = 0, l_color = COLOR_YELLOW)
			glowing = FALSE
			damtype = initial(damtype)
			update_icon()

/obj/item/tool/sword/nt/flanged/update_icon()
	if(glowing)
		icon_state = initial(icon_state) + "_lit"
		item_state = initial(item_state) + "_lit"
		wielded_icon = initial(wielded_icon) + "_lit"
	else
		icon_state = initial(icon_state)
		item_state = initial(item_state)
		wielded_icon = initial(wielded_icon)
	..()

/obj/item/shield/riot/nt
	name = "custodian scutum shield"
	desc = "A wall of a shield, oblong, convex and absurdly difficult to store, yet efficient to keep bullets and melee attacks at bay. \
	The reinforcements of the shield allows major protection for an experienced user, yet its efficiency is limited for the inexperienced. \
	It has leather straps behind it to store large equipment such as staves, throwing spears and others. This shield in specific constantly releases flames to light the way of it’s user."
	icon = 'icons/obj/nt_melee.dmi'
	icon_state = "custodian_scutum"
	item_state = "custodian_scutum"
	force = WEAPON_FORCE_DANGEROUS
	armor_list = list(melee = 20, bullet = 20, energy = 10, bomb = 15, bio = 0, rad = 0)
	matter = list(MATERIAL_BIO_SILK = 50, MATERIAL_STEEL = 10, MATERIAL_CARBON_FIBER = 10, MATERIAL_GOLD = 5)
	price_tag = 1000
	base_block_chance = 60
	item_flags = DRAG_AND_DROP_UNEQUIP

	max_durability = 180
	durability = 180

	item_icons = list(
		slot_back_str = 'icons/inventory/back/mob.dmi')
	item_state_slots = list(
		slot_back_str = "nt_shield"
		)

	var/obj/item/storage/internal/container
	var/storage_slots = 3
	var/max_w_class = ITEM_SIZE_HUGE
	var/list/can_hold = new/list(
		/obj/item/tool/sword/nt/shortsword,
		/obj/item/tool/sword/nt/spear,
		/obj/item/tool/knife/dagger/nt,
		/obj/item/tool/knife/neotritual,
		/obj/item/book/ritual/cruciform
		)

/obj/item/shield/riot/nt/New()
	container = new /obj/item/storage/internal(src)
	container.storage_slots = storage_slots
	container.can_hold = can_hold
	container.max_w_class = max_w_class
	container.master_item = src
	.=..()

/obj/item/shield/riot/nt/proc/handle_attack_hand(mob/user as mob)
	return container.handle_attack_hand(user)

/obj/item/shield/riot/nt/proc/handle_mousedrop(var/mob/user, var/atom/over_object)
	return container.handle_mousedrop(user, over_object)

/obj/item/shield/riot/nt/MouseDrop(obj/over_object)
	if(container.handle_mousedrop(usr, over_object))
		return TRUE
	return ..()

/obj/item/shield/riot/nt/attack_hand(mob/user as mob)
	if (loc == user)
		container.open(user)
	else
		container.close_all()
		..()

	src.add_fingerprint(user)
	return

/obj/item/shield/riot/nt/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/tool/baton) || istype(W, /obj/item/tool/sword/nt))
		on_bash(W, user)
	else
		..()

/obj/item/shield/riot/nt/get_block_chance(mob/user, var/damage, atom/damage_source = null, mob/attacker = null)
	return base_block_chance

/obj/item/shield/buckler/nt
	name = "custodian targe shield"
	desc = "A small shield efficient for bashing enemies in the head as much as it allows the user to protect themselves from damage. \
	Rather useless for the inexperienced, yet the ones who mastered the use of shields may have incredible capacity to protect themselves from harm."
	icon = 'icons/obj/nt_melee.dmi'
	icon_state = "custodian_heater"
	item_state = "custodian_heater"
	matter = list(MATERIAL_BIO_SILK = 15, MATERIAL_STEEL = 5, MATERIAL_CARBON_FIBER = 2, MATERIAL_GOLD = 1)
	//aspects = list(SANCTIFIED) todo:port this
	price_tag = 300
	base_block_chance = 45
	item_flags = DRAG_AND_DROP_UNEQUIP
	max_durability = 60 //So we can brake and need healing time to time
	durability = 60
	var/obj/item/storage/internal/container
	var/storage_slots = 1
	var/max_w_class = ITEM_SIZE_HUGE
	var/list/can_hold = list(
		/obj/item/tool/sword/nt/shortsword,
		/obj/item/tool/sword/nt/spear, //Romans would have these with their shield to ware down their foe
		/obj/item/tool/knife/dagger/nt,
		/obj/item/tool/knife/neotritual,
		/obj/item/book/ritual/cruciform
		)

/obj/item/shield/buckler/nt/New()
	container = new /obj/item/storage/internal(src)
	container.storage_slots = storage_slots
	container.can_hold = can_hold
	container.max_w_class = max_w_class
	container.master_item = src
	..()

/obj/item/shield/buckler/nt/proc/handle_attack_hand(mob/user as mob)
	return container.handle_attack_hand(user)

/obj/item/shield/buckler/nt/proc/handle_mousedrop(var/mob/user, var/atom/over_object)
	return container.handle_mousedrop(user, over_object)

/obj/item/shield/buckler/nt/MouseDrop(obj/over_object)
	if(container.handle_mousedrop(usr, over_object))
		return TRUE
	return ..()

/obj/item/shield/buckler/nt/attack_hand(mob/user as mob)
	if (loc == user)
		container.open(user)
	else
		container.close_all()
		..()

	add_fingerprint(user)
	return

/obj/item/shield/riot/nt/attackby(obj/item/W as obj, mob/user as mob)
	if(istype(W, /obj/item/tool/baton) || istype(W, /obj/item/tool/sword/nt))
		on_bash(W, user)
	else
		..()
