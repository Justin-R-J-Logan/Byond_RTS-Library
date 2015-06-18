turf
	icon = 'Turf16x.dmi'
	icon_state = "Grass"
	DblClick()
		var/mob/Troop/t = new /mob/Troop/(src)
		t.Alliance = usr.client.PlayerNumber
	Click(location,control,params)
		var/list/clkparams = params2list(params)
		if("right" in clkparams)
			var/mob/Troop/t = new /mob/Troop/(src)
			t.Alliance = usr.client.PlayerNumber+1
			t.icon_state = "Enemy"