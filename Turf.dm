turf
	icon = 'Turf16x.dmi'
	icon_state = "Grass"
	DblClick()
		var/mob/Troop/t = new /mob/Troop/(src)
		t.pid = usr.client.pid
	Click(location,control,params)
		var/list/clkparams = params2list(params)
		if("right" in clkparams)
			var/mob/Troop/t = new /mob/Troop/(src)
			t.pid = usr.client.pid+50
			t.icon_state = "Enemy"