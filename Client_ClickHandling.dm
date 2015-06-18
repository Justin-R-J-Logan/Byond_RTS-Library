


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
			if(i.pid == src.pid) Troops += list(i)
	for(var/mob/Troop/i in Troops)
		if(i.pid == src.pid) i.Select()