/
	desc = "An aging combat sarcophagus, designed to sustain mortally-wounded Astartes, while allowing them to continue their service."
	name = "Dreadnaught"
	icon_state = "durand"
	initial_icon = "durand"
	step_in = 4
	health = 600
	deflect_chance = 30
	damage_absorption = list("brute"=0.5,"fire"=1,"bullet"=0.5,"laser"=0.7,"energy"=0.9,"bomb"=0.75)
	max_temperature = 30000
	infra_luminosity = 8
	force = 40
	var/defence = 0
	var/def_boost = 15
	wreckage = /obj/effect/decal/mecha_wreckage/durand

/*
/obj/mecha/combat/durand/New()
	..()
	weapons += new /datum/mecha_weapon/ballistic/autocannon(src)
	weapons += new /datum/mecha_equipment/tool/hydraulic_clamp(src)
	selected_weapon = weapons[1]
	return
*/

/obj/mecha/combat/durand/relaymove(mob/user,direction)
	if(defence)
		if(world.time - last_message > 20)
			src.occupant_message("<font color='red'>Unable to move while in defence mode</font>")
			last_message = world.time
		return 0
	. = ..()
	return


/obj/mecha/combat/durand/verb/defence_mode()
	set category = "Exosuit Interface"
	set name = "Toggle defence mode"
	set src = usr.loc
	set popup_menu = 0
	if(usr!=src.occupant)
		return
	defence = !defence
	if(defence)
		deflect_chance += def_boost
		src.occupant_message("<font color='blue'>You enable [src] defence mode.</font>")
	else
		deflect_chance -= def_boost
		src.occupant_message("<font color='red'>You disable [src] defence mode.</font>")
	src.log_message("Toggled defence mode.")
	return


/obj/mecha/combat/durand/get_stats_part()
	var/output = ..()
	output += "<b>Defence mode: [defence?"on":"off"]</b>"
	return output

/obj/mecha/combat/durand/get_commands()
	var/output = {"<div class='wr'>
						<div class='header'>Special</div>
						<div class='links'>
						<a href='?src=\ref[src];toggle_defence_mode=1'>Toggle defence mode</a>
						</div>
						</div>
						"}
	output += ..()
	return output

/obj/mecha/combat/durand/Topic(href, href_list)
	..()
	if (href_list["toggle_defence_mode"])
		src.defence_mode()
	return
