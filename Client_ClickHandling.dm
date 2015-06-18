


client/MouseDrop(src_object,over_object,src_location,over_location,src_control,over_control,params)
	//Make objects to store the turfs in.
	var/atom/f = src_object
	var/atom/t = over_object
	//These are debug only
	//world << "X: [t.x] Y: [t.y] Z: [t.z]"
	//world << "X: [f.x] Y: [f.y] Z: [f.z]"
	//Deselect all current troops
	for(var/mob/Troop/i in Troops) i.Deselect()
	Troops = list()
	//Adds all troops to list.
	for(var/turf/p in block(f, t))
		for(var/mob/Troop/i in p)
			if(i.Alliance == src.PlayerNumber) Troops += list(i)
	for(var/mob/Troop/i in Troops)
		if(i.Alliance == src.PlayerNumber) i.Select()


client/Click(object,location,control,params)
	//Convert parameters to list.
	var/list/clkparams = params2list(params)
	if("screen-loc" in clkparams) // Checks to make sure screen was clicked.
		var/i = 0
		i = i
	if("right" in clkparams) //Stuff done if right click anywhere
		var/atom/a = location
		a.Click(location,control,params)
		for(var/mob/Troop/i in Troops)
			i.Deselect() //Deselect all current troops
			Troops -= i //Removes troops from the list
	if("left" in clkparams) //Stuff done on left click anywhere
		var/atom/o = object
		if(o.type in typesof(/mob/Troop/))
			var/mob/Troop/m = o
			for(var/mob/Troop/tz in Troops)
				tz.Target = null
			if("shift" in clkparams)
				if(m.selected)
					m.Deselect()
					Troops -= m
				else
					if(m.Alliance != src.PlayerNumber) return
					m.Select()
					Troops += m
			else
				if(m in Troops && Troops.len < 2)
					if(m.selected)
						m.Deselect()
						Troops -= m
					else
						if(m.Alliance != src.PlayerNumber) return
						m.Select()
						Troops += m
				else
					if(m.Alliance == src.PlayerNumber)
						for(var/mob/Troop/i in Troops) i.Deselect()
						Troops = list()
						m.Select()
						Troops += list(m)
					else
						world << "clicked enemy troop!"
						for(var/mob/Troop/t in Troops)
							t.SetDestination(m)
		else
			if(Troops.len > 0)
				for(var/mob/Troop/m in Troops)
					m.SetDestination(location)

