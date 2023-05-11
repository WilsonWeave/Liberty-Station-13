/atom/movable/proc/get_mob()
	return

/obj/machinery/bot/mulebot/get_mob()
	if(load && isliving(load))
		return load

/obj/mecha/get_mob()
	return occupant

/obj/vehicle/train/get_mob()
	return buckled_mob

/mob/get_mob()
	return src

/**
 * Returns a list of all mobs within view(), using given arguments to determine the range of the search
 * and the source of the proc.
 *
 * Args:
 * range - How far, in a square, around this mob, will we search.
 * source - The source of the search.
**/
/proc/mobs_in_view(range, atom/source)
	var/list/mobs = list()
	for(var/mob/target_mob in view(range, source))
		mobs += target_mob
	return mobs

/**
 * Returns a list of all LIVING mobs within view(), using given arguments to determine the range of the search
 * and the source of the proc.
 *
 * Args:
 * range - How far, in a square, around this mob, will we search.
 * source - The source of the search.
**/
/proc/living_mobs_in_view(var/range, var/atom/source)
	var/list/mobs = list()
	for(var/mob/living/target_mob in view(range, source))
		mobs += target_mob
	return mobs


/**
 * Returns a list of all mobs within view(), even those within mechs, using given arguments to determine the range of the search
 * and the source of the proc.
 *
 * Args:
 * range - How far, in a square, around this mob, will we search.
 * source - The source of the search.
**/
/proc/all_mobs_in_view(var/range, var/atom/source)
	var/list/mobs = list()
	for(var/mob/target_mob in view(range, source))
		mobs += target_mob
	for(var/obj/mecha/potential_mech in GLOB.mechas_list)
		if(potential_mech.z == source.z && get_dist(potential_mech, source) < range && can_see(source, potential_mech, range))
			var/mob/living/occupant = potential_mech.get_mob()
			if (occupant)
				mobs += occupant
    return mobs

/proc/random_hair_style(gender, species = "Human")
	var/h_style = "Bald"

	var/datum/species/mob_species = all_species[species]
	var/list/valid_hairstyles = mob_species.get_hair_styles()
	if(valid_hairstyles.len)
		h_style = pick(valid_hairstyles)

	return h_style

/proc/random_facial_hair_style(gender, species = "Human")
	var/f_style = "Shaved"
	var/datum/species/mob_species = all_species[species]
	var/list/valid_facialhairstyles = mob_species.get_facial_hair_styles(gender)
	if(valid_facialhairstyles.len)
		f_style = pick(valid_facialhairstyles)
		return f_style

/proc/sanitize_name(name, species = "Human")
	var/datum/species/current_species
	if(species)
		current_species = all_species[species]

	return current_species ? current_species.sanitize_name(name) : sanitizeName(name)

/proc/random_name(gender, species = "Human")

	var/datum/species/current_species
	if(species)
		current_species = all_species[species]

	if(!current_species || current_species.name_language == null)
		if(gender==FEMALE)
			return capitalize(pick(GLOB.first_names_female)) + " " + capitalize(pick(GLOB.last_names))
		else
			return capitalize(pick(GLOB.first_names_male)) + " " + capitalize(pick(GLOB.last_names))
	else
		return current_species.get_random_name(gender)

/proc/random_skin_tone()
	switch(pick(60;"caucasian", 15;"afroamerican", 10;"african", 10;"latino", 5;"albino"))
		if("caucasian")		. = -10
		if("afroamerican")	. = -115
		if("african")		. = -165
		if("latino")		. = -55
		if("albino")		. = 34
		else				. = rand(-185, 34)
	return min(max( .+rand(-25, 25), -185), 34)

/proc/skintone2racedescription(tone)
	switch (tone)
		if(30 to INFINITY)		return "albino"
		if(20 to 30)			return "pale"
		if(5 to 15)				return "light skinned"
		if(-10 to 5)			return "white"
		if(-25 to -10)			return "tan"
		if(-45 to -25)			return "darker skinned"
		if(-65 to -45)			return "brown"
		if(-INFINITY to -65)	return "black"
		else					return "unknown"

/proc/age2agedescription(age)
	switch(age)
		if(0 to 1)			return "infant"
		if(1 to 3)			return "toddler"
		if(3 to 13)			return "child"
		if(13 to 19)		return "teenager"
		if(19 to 30)		return "young adult"
		if(30 to 45)		return "adult"
		if(45 to 60)		return "middle-aged"
		if(60 to 70)		return "aging"
		if(70 to INFINITY)	return "elderly"
		else				return "unknown"

/proc/RoundHealth(health)
	switch(health)
		if(100 to INFINITY)
			return "health100"
		if(70 to 100)
			return "health80"
		if(50 to 70)
			return "health60"
		if(30 to 50)
			return "health40"
		if(18 to 30)
			return "health25"
		if(5 to 18)
			return "health10"
		if(1 to 5)
			return "health1"
		if(-99 to 0)
			return "health0"
		else
			return "health-100"

/*
Proc for attack log creation, because really why not
1 argument is the actor
2 argument is the target of action
3 is the description of action(like punched, throwed, or any other verb)
4 should it make adminlog note or not
5 is the tool with which the action was made(usually item)					5 and 6 are very similar(5 have "by " before it, that it) and are separated just to keep things in a bit more in order
6 is additional information, anything that needs to be added
*/

/proc/add_logs(mob/user, mob/target, what_done, var/admin=1, var/object=null, var/addition=null)
	if(user && ismob(user))
		user.attack_log += text("\[[time_stamp()]\] <font color='red'>Has [what_done] [target ? "[target.name][(ismob(target) && target.ckey) ? "([target.ckey])" : ""]" : "NON-EXISTANT SUBJECT"][object ? " with [object]" : " "][addition]</font>")
	if(target && ismob(target))
		target.attack_log += text("\[[time_stamp()]\] <font color='orange'>Has been [what_done] by [user ? "[user.name][(ismob(user) && user.ckey) ? "([user.ckey])" : ""]" : "NON-EXISTANT SUBJECT"][object ? " with [object]" : " "][addition]</font>")
	if(admin)
		log_attack("<font color='red'>[user ? "[user.name][(ismob(user) && user.ckey) ? "([user.ckey])" : ""]" : "NON-EXISTANT SUBJECT"] [what_done] [target ? "[target.name][(ismob(target) && target.ckey)? "([target.ckey])" : ""]" : "NON-EXISTANT SUBJECT"][object ? " with [object]" : " "][addition]</font>")

//checks whether this item is a module of the robot it is located in.
/proc/is_robot_module(var/obj/item/thing)
	if (!thing || !isrobot(thing.loc))
		return 0
	var/mob/living/silicon/robot/R = thing.loc
	return (thing in R.module.modules)

/proc/get_exposed_defense_zone(var/atom/movable/target)
	var/obj/item/grab/G = locate() in target
	if(G && G.state >= GRAB_NECK) //works because mobs are currently not allowed to upgrade to NECK if they are grabbing two people.
		return pick(BP_ALL_LIMBS - list(BP_CHEST, BP_GROIN))
	else
		return pick(BP_CHEST, BP_GROIN)

/proc/do_mob(mob/user , mob/target, time = 30, uninterruptible = 0, progress = 1)
	if(!user || !target)
		return 0
	var/user_loc = user.loc
	var/target_loc = target.loc

	var/holding = user.get_active_hand()
	var/datum/progressbar/progbar
	if (progress)
		progbar = new(user, time, target)

	var/endtime = world.time+time
	var/starttime = world.time
	. = 1
	while (world.time < endtime)
		sleep(1)
		if (progress)
			progbar.update(world.time - starttime)
		if(!user || !target)
			. = 0
			break
		if(uninterruptible)
			continue

		if(!user || user.incapacitated() || user.loc != user_loc)
			. = 0
			break

		if(target.loc != target_loc)
			. = 0
			break

		if(user.get_active_hand() != holding)
			. = 0
			break

	if (progbar)
		qdel(progbar)

/proc/do_after(mob/user, delay, atom/target, needhand = 1, progress = 1, var/incapacitation_flags = INCAPACITATION_DEFAULT, immobile = 1)
	if(!user)
		return 0

	var/atom/target_loc
	if(target)
		target_loc = target.loc

	var/atom/original_loc = user.loc

	var/holding = user.get_active_hand()

	var/datum/progressbar/progbar

	var/atom/progtarget = target
	if (!progtarget && progress) //Fallback behaviour. If no target is set, but the progress bar is enabled
		//Then we'll use the user as the target for the progress bar
		progtarget = user

		//This means there will always be a bar if progress is true

	if (progress)
		progbar = new(user, delay, progtarget)

	var/endtime = world.time + delay
	var/starttime = world.time
	. = 1
	while (world.time < endtime)
		sleep(1)
		if (progress)
			progbar.update(world.time - starttime)

		if(immobile)
			if(user.loc != original_loc)
				. = 0
				break

		if(target_loc && (!target || target_loc != target.loc))
			. = 0
			break

		if(needhand)
			if(user.get_active_hand() != holding)
				. = 0
				break

	if (progbar)
		qdel(progbar)

//Defined at mob level for ease of use
/mob/proc/body_part_covered(var/bodypart)
	return FALSE

/mob/living/carbon/body_part_covered(var/bodypart)
	var/list/bodyparts = list(
	BP_HEAD = HEAD,
	BP_CHEST = UPPER_TORSO,
	BP_GROIN = LOWER_TORSO,
	BP_L_ARM = ARM_LEFT,
	BP_R_ARM = ARM_RIGHT,
	BP_L_LEG = LEG_LEFT,
	BP_R_LEG = LEG_RIGHT,
	)

	for(var/obj/item/clothing/C in src)
		if(l_hand == C || r_hand == C)
			continue
		if(C.body_parts_covered & bodyparts[bodypart])
			return TRUE
	return FALSE


/proc/is_neotheology_disciple(mob/living/L)
	if(istype(L) && L.get_core_implant(/obj/item/implant/core_implant/cruciform))
		return TRUE
	return FALSE

/proc/is_acolyte(mob/living/L)
	if(!isliving(L))
		return FALSE
	var/obj/item/implant/core_implant/cruciform/C = L.get_core_implant(/obj/item/implant/core_implant/cruciform)
	if(C && C.get_module(CRUCIFORM_COMMON))
		return TRUE
	return FALSE

/proc/is_preacher(mob/living/L)
	if(!isliving(L))
		return FALSE
	var/obj/item/implant/core_implant/cruciform/C = L.get_core_implant(/obj/item/implant/core_implant/cruciform)
	if(C && C.get_module(CRUCIFORM_OATHPLEDGE))
		return TRUE
	return FALSE

/proc/is_carrion(mob/living/carbon/human/H)
	if(istype(H) && (H.organ_list_by_process(BP_SPCORE)).len)
		return TRUE
	return FALSE

/proc/is_excelsior(var/mob/M)
	var/obj/item/implant/excelsior/E = locate(/obj/item/implant/excelsior) in M
	if (E && E.wearer == M)
		return TRUE

	return FALSE

/proc/mob_hearers(var/atom/movable/heard_atom, var/range = world.view)
	. = list()

	for(var/mob/hmob in hearers(range, heard_atom))
		. |= hmob


// Returns a bitfield representing the mob's type as relevant to the devour system.
/mob/proc/get_classification()
	return mob_classification

/mob/living/carbon/human/get_classification()
	. = ..()
	. |= CLASSIFICATION_ORGANIC | CLASSIFICATION_HUMANOID

/mob/proc/can_see_reagents()
	return TRUE

/mob/proc/can_see_illegal_reagents()
	return TRUE

/mob/proc/can_see_common_reagents()
	return TRUE

// Returns true if M was not already in the dead mob list
/mob/proc/switch_from_living_to_dead_mob_list()
	remove_from_living_mob_list()
	. = add_to_dead_mob_list()

// Returns true if M was not already in the living mob list
/mob/proc/switch_from_dead_to_living_mob_list()
	remove_from_dead_mob_list()
	. = add_to_living_mob_list()

// Returns true if the mob was in neither the dead or living list
/mob/proc/add_to_living_mob_list()
	return FALSE
/mob/living/add_to_living_mob_list()
	if((src in GLOB.living_mob_list) || (src in GLOB.dead_mob_list))
		return FALSE
	GLOB.living_mob_list += src
	return TRUE

// Returns true if the mob was removed from the living list
/mob/proc/remove_from_living_mob_list()
	return GLOB.living_mob_list.Remove(src)

// Returns true if the mob was in neither the dead or living list
/mob/proc/add_to_dead_mob_list()
	return FALSE
/mob/living/add_to_dead_mob_list()
	if((src in GLOB.living_mob_list) || (src in GLOB.dead_mob_list))
		return FALSE
	GLOB.dead_mob_list += src
	return TRUE

// Returns true if the mob was removed form the dead list
/mob/proc/remove_from_dead_mob_list()
	return GLOB.dead_mob_list.Remove(src)

//Find a dead mob with a brain and client.
/proc/find_dead_player(var/find_key, var/include_observers = 0)
	if(isnull(find_key))
		return

	var/mob/selected = null

	if(include_observers)
		for(var/mob/M in GLOB.player_list)
			if((M.stat != DEAD) || (!M.client))
				continue
			if(M.ckey == find_key)
				selected = M
				break
	else
		for(var/mob/living/M in GLOB.player_list)
			//Dead people only thanks!
			if((M.stat != DEAD) || (!M.client))
				continue
			//They need a brain!
			if(ishuman(M))
				var/mob/living/carbon/human/H = M
				if(H.should_have_process(BP_BRAIN) && !H.has_brain())
					continue
			if(M.ckey == find_key)
				selected = M
				break
	return selected


//Returns true if this person has a job which is a department head
/mob/proc/is_head_role()
	.=FALSE
	if (!mind || !mind.assigned_job)
		return

	return mind.assigned_job.head_position

//This gets an input while also checking a mob for whether it is incapacitated or not.
/mob/proc/get_input(message, title, default, choice_type, obj/required_item)
	if(src.incapacitated() || (required_item && !GLOB.hands_state.can_use_topic(required_item,src)))
		return null
	var/choice
	if(islist(choice_type))
		choice = input(src, message, title, default) as null|anything in choice_type
	else
		switch(choice_type)
			if(MOB_INPUT_TEXT)
				choice = input(src, message, title, default) as null|text
			if(MOB_INPUT_NUM)
				choice = input(src, message, title, default) as null|num
			if(MOB_INPUT_MESSAGE)
				choice = input(src, message, title, default) as null|message
	if(isnull(choice) || src.incapacitated() || (required_item && !GLOB.hands_state.can_use_topic(required_item,src)))
		return null
	return choice

/// Gets the client of the mob, allowing for mocking of the client.
/// You only need to use this if you know you're going to be mocking clients somewhere else.
#define GET_CLIENT(mob) (##mob.client) //  || ##mob.mock_client

///Makes a call in the context of a different usr. Use sparingly
/world/proc/push_usr(mob/user_mob, datum/callback/invoked_callback, ...)
	var/temp = usr
	usr = user_mob
	if (length(args) > 2)
		. = invoked_callback.Invoke(arglist(args.Copy(3)))
	else
		. = invoked_callback.Invoke()
	usr = temp
