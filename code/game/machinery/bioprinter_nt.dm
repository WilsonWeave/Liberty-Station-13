/obj/machinery/autolathe/bioprinter
	name = "custodian flarelathe"
	desc = "A forge design created by the Custodians that makes use of Radiance to smith their equipment."
	icon_state = "flarelathe"
	unsuitable_materials = list()
	build_type = AUTOLATHE | BIOPRINTER
	storage_capacity = 480
	speed = 11
	have_recycling = TRUE
	queue_max = 16 //Might be 8 in game do to wires
	mat_efficiency = 0.5

/obj/machinery/autolathe/bioprinter/attackby(obj/item/I, mob/user)
	//hacky way to forbid deconstruction but use ..()
	var/tool_type = I.get_tool_type(user, list(QUALITY_SCREW_DRIVING), src)
	if(tool_type == QUALITY_SCREW_DRIVING)
		return

	//it needs to have panel open, but just in case
	if(istype(I, /obj/item/storage/part_replacer))
		return

	..(I, user)

/obj/machinery/autolathe/bioprinter/RefreshParts()
	..()
	speed = initial(speed)
	mat_efficiency = initial(mat_efficiency)


/obj/machinery/autolathe/bioprinter/disk
	default_disk = /obj/item/computer_hardware/hard_drive/portable/design/nt/bioprinter

/obj/machinery/autolathe/bioprinter/public
	default_disk = /obj/item/computer_hardware/hard_drive/portable/design/nt/bioprinter/public
