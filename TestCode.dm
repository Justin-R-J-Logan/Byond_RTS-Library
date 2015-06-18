/*

mob/Troop
	proc
		SetDestination(var/atom/m)
			//TODO Check for enemies, and try to kill them.
			Destination = m
			if(Destination.type in typesof(/turf/))
				Moving=1
				while(1)
					step_towards(src, Destination)
					world << src.x
					world << src.y
					world << Destination.x
					world << Destination.y
					world << "------------"
					sleep(1)
					if(src.x == Destination.x && src.y == Destination.y)
						break
				world << "Finished!"

*/