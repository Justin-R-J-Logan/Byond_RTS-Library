turf
	icon = 'Turf32x.dmi'
	icon_state = "Grass"
	Click(location,control,params)
		var/list/clkparams = params2list(params)
		var/client/client = usr.client
		if("left" in clkparams && !density)
			for(var/mob/Troop/t in client.Troops)
				t.SetTarget(src)
		else if("middle" in clkparams)
			if("ctrl" in clkparams)
				var/mob/Troop/t = new /mob/Troop/(src)
				t.pid = usr.client.pid+50
				t.icon_state = "Enemy"
			else
				var/mob/Troop/t = new /mob/Troop/(src)
				t.pid = usr.client.pid
		else if("right" in clkparams)
			for(var/mob/Troop/t in client.Troops) t.Deselect()
			client.Troops = list()
			client.Selecting = 0