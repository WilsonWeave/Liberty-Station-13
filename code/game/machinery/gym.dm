/obj/machinery/gym
	name = "Advanced Arcade Machine"
	desc = "Links with your brain to reduce lag to minimum. Now, success really does depend only on your skill!"
	description_info = "Exercise machines can be used to increase your stats, either permanently, by using a rest point, or temporary."
	icon = 'icons/obj/machines/gym.dmi'
	icon_state = "vigilance"

	var/stat_used = STAT_VIG //STAT_TGH, STAT_ROB, STAT_VIG, STAT_COG, STAT_MEC, STAT_BIO
	var/mob/living/carbon/human/occupant
	var/unlocked = FALSE
	var/last_stats = 0

	density = TRUE
	anchored = TRUE
	circuit = null //cannot be deconstructed

	use_power = IDLE_POWER_USE
	idle_power_usage = 60
	active_power_usage = 400

/obj/machinery/gym/examine(mob/user)
	..()
	to_chat(user, "<span class='info'>Last User Score Was: [last_stats]</span>")

/obj/machinery/gym/robustness
	name = "Interim Resistive Exercise Device"
	desc = "This device uses a system of vacuum tubes and flywheel cables to simulate the process of free weight exercises that increase your strength. Are those barbells decorative...?"
	icon_state = "robustness"
	stat_used = STAT_ROB

/obj/machinery/gym/toughness
	name = "Total Resistance Punch Machine"
	desc = "Whatever the reason behind creating this thing is, experiencing the life of a punching bag really helps you become tougher."
	icon_state = "toughness"
	stat_used = STAT_TGH

/obj/machinery/gym/cognition
	name = "Crazy Jakes Puzzel Box"
	desc = "A 4D puzzel box designed to test your mind in every way known to humanity, shockingly it's party mode has been made into party games for decades."
	icon_state = "cognition"
	stat_used = STAT_COG

/obj/machinery/gym/bio
	name = "Dr. Terry Advanced Advenctures"
	desc = "A seemingly endless quest of medical misshaps and common to avdanced misstakes, well its boring for a lot of people, it has a cult following leading to it being rather successful in most locations."
	icon_state = "bio"
	stat_used = STAT_BIO

/obj/machinery/gym/mec
	name = "Shapers Of Atoms"
	desc = "An informational game found in many schools teaching things from welding to fine crafting of delicate items with rare materals. Shockingly this collection of knowlage is still update and maintained making it a invaulable resource for any up and coming crafter"
	icon_state = "mec"
	stat_used = STAT_MEC

/obj/machinery/gym/power_change()
	..()
	if(stat & BROKEN || stat & NOPOWER)
		update_icon()

/obj/machinery/gym/emag_act(remaining_charges, mob/user, emag_source)
	emagged = TRUE

/obj/machinery/gym/Destroy()
	if(occupant)
		go_out(FALSE)
	sleep(1) //we need to be sure occupant is not going to nullspace
	return ..()

/obj/machinery/gym/relaymove(mob/occupant)
	if(!occupant.incapacitated()) //Lost consciousness while lifting weights? Too bad, you HAVE to finish.
		go_out(FALSE)

/obj/machinery/gym/proc/go_out(finished_using)
	if(finished_using)
		spawn(1.5 SECONDS)
			state("Thank you for using club services! Please come back soon.")
			playsound(loc, "robot_talk_light", 100, 0, 0)

		if(occupant.rest_points > 0)
			to_chat(occupant, SPAN_NOTICE("You feel yourself become stronger..."))
			occupant.playsound_local(get_turf(occupant), 'sound/sanity/rest.ogg', 100)
			occupant.stats.changeStat(stat_used, rand(15, 20))
			occupant.rest_points--

			occupant.learnt_tasks.attempt_add_task_mastery(/datum/task_master/task/gym_goer, "GYM_GOER", skill_gained = 5, learner = occupant)

		else
			to_chat(occupant, SPAN_NOTICE("You did become stronger, you think... But not permanently. Perhaps you need to rest first?"))
			occupant.stats.addTempStat(stat_used, 15, 10 MINUTES, "Improved Guns[generate_gun_serial(pick(3,4,5,6,7,8))]") //This is so that we properly add are temp stats - reuses gun serial code for easy, and the joke
			occupant.learnt_tasks.attempt_add_task_mastery(/datum/task_master/task/gym_goer, "GYM_GOER", skill_gained = 1, learner = occupant)

		last_stats = occupant.stats.getStat(stat_used,pure = TRUE)
		occupant.stats.addPerk(PERK_COOLDOWN_EXERTION)
		unlocked = FALSE

	occupant.forceMove(loc)
	occupant.reset_view()
	occupant.unset_machine()
	occupant = null

	update_use_power(1)
	update_icon()

/obj/machinery/gym/attack_hand(mob/user)
	if(!ishuman(user))
		return

	if(stat & (NOPOWER|BROKEN))
		return

	if(user.stats.getPerk(PERK_COOLDOWN_REASON))
		to_chat(user, SPAN_WARNING("Your mind feels too dim to properly use this. You need to rest before you exercise again."))
		return

	if(user.stats.getPerk(PERK_COOLDOWN_EXERTION))
		to_chat(user, SPAN_WARNING("Your muscles hurt too much use this. You need to rest before you exercise again."))
		return

	if(!unlocked && !emagged)
		state(SPAN_WARNING("A payment ticket is required to use this machine."))
		return

	if(occupant)
		to_chat(user, SPAN_WARNING("The machine is already occupied!"))
		return

	user.forceMove(src)
	occupant = user
	update_use_power(2)
	user.set_machine(src)

	add_fingerprint(user)
	update_icon()
	sleep(15 SECONDS)

	if(occupant)//is user still using our machine?
		go_out(TRUE)
		update_icon()

/obj/machinery/gym/attackby(obj/item/I, mob/living/user)
	if(istype(I, /obj/item/gym_ticket))
		var/obj/item/gym_ticket/G = I
		if(G.use())
			state("This machine is now unlocked for use.")
			unlocked = TRUE
			return

	..()

/obj/machinery/gym/update_icon() // Vigilance animation
	cut_overlays()
	icon_state = (stat & (NOPOWER|BROKEN)) ? "vigilance_off" : "vigilance"
	if(occupant)
		var/image/occupant_image = image(occupant.icon, loc, occupant.icon_state, 4, NORTH)
		occupant_image.overlays = occupant.overlays
		add_overlay (occupant_image)
		icon_state = "vigilance_active"

/obj/machinery/gym/cognition/update_icon() // Vigilance animation
	cut_overlays()
	icon_state = (stat & (NOPOWER|BROKEN)) ? "cognition_off" : "cognition"
	if(occupant)
		var/image/occupant_image = image(occupant.icon, loc, occupant.icon_state, 4, NORTH)
		occupant_image.overlays = occupant.overlays
		add_overlay (occupant_image)
		icon_state = "cognition_active"

/obj/machinery/gym/bio/update_icon() // Vigilance animation
	cut_overlays()
	icon_state = (stat & (NOPOWER|BROKEN)) ? "bio_off" : "bio"
	if(occupant)
		var/image/occupant_image = image(occupant.icon, loc, occupant.icon_state, 4, NORTH)
		occupant_image.overlays = occupant.overlays
		add_overlay (occupant_image)
		icon_state = "bio_active"

/obj/machinery/gym/mec/update_icon() // Vigilance animation
	cut_overlays()
	icon_state = (stat & (NOPOWER|BROKEN)) ? "mec_off" : "mec"
	if(occupant)
		var/image/occupant_image = image(occupant.icon, loc, occupant.icon_state, 4, NORTH)
		occupant_image.overlays = occupant.overlays
		add_overlay (occupant_image)
		icon_state = "mec_active"

/obj/machinery/gym/toughness/update_icon() // Toughness animation
	cut_overlays()
	icon_state = (stat & (NOPOWER|BROKEN)) ? "toughness_off" : "toughness"
	if(occupant)
		var/image/occupant_image = image(occupant.icon, loc, occupant.icon_state, 4, NORTH, 0, 8)
		occupant_image.overlays = occupant.overlays
		add_overlay (occupant_image)
		add_overlay ("toughness_overlay")

/obj/machinery/gym/robustness/update_icon() // Robustness animation
	cut_overlays()
	icon_state = "robustness"
	if(occupant)
		var/image/occupant_image = image(occupant.icon, loc, occupant.icon_state, 4, SOUTH, 0, 16)
		var/image/robustness_overlay = image(icon, "robustness_overlay")
		robustness_overlay.layer = 4.5
		occupant_image.overlays = occupant.overlays
		add_overlay (occupant_image)
		add_overlay (robustness_overlay)
		icon_state = "robustness_base"