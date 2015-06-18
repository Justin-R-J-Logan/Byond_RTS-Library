mob/Troop
	icon = 'Mobs32x.dmi'
	icon_state = "Troop"
	Is_Troop = 1
	var
		pid = null
		Action = 0
		Checking = 0
		//Action enum: Standstill = 0, 1 = Movement, 2 = Attacking Troop, 4 = Attacking other, 5 = Dead / dying
		atom/Target      //Move to and attack
		selected = 0
		obj/Selected/selview = new
		//Combat and movement
		Attack_Range = 1
		Attacking = 0
		Damage    = 4  //4 damage per swing
		Hitpoints = 25 //Life Total
		Atk_Speed = 4 //swings every 4 world ticks
		Mov_Speed = 1 //Moves every 3 ticks, and checks for
	New()
		..()
		Check_Actions()
	Click(location,control,params)

		var/mob/user = usr
		var/client/client = user.client
		var/list/para = params2list(params)
		var/mouse_button = 0 //0 = left, 1 = right, 2 = middle
		var/shift = 0; var/ctrl = 0; var/alt = 0

		for(var/i in para)
			if(i == "left") mouse_button = 0
			if(i == "right") mouse_button = 1
			if(i == "middle") mouse_button = 2
			if(i == "shift") shift = 1
			if(i == "ctrl") ctrl = 1
			if(i == "alt") alt = 1

		world << "Mouse: [mouse_button==0?"left":""][mouse_button==1?"right":""][mouse_button==2?"middle":""] buttons:[shift?"shift,":""][ctrl?"control,":""][alt?"alt":""]"

		if(mouse_button == 0) // Left
			if(client.pid == src.pid && shift && ctrl) //Shift & control does nothing
				//Do nothing
			else if(client.pid == src.pid && shift && !ctrl) //shift click adds the unit to your selected units.
				client.Troops += list(src)
				client.Selecting = 1
				src.Select()
				world << "shift selected"
			else if(client.pid == src.pid && !shift && ctrl) //Control click makes you attack your own unit
				for(var/mob/Troop/t in client.Troops) t.SetTarget(src)
				world << "control selected"
			else if(client.pid == src.pid && !shift && !ctrl) //single click forces selection of only that unit.
				for(var/mob/Troop/t in client.Troops) t.Deselect()
				client.Troops = list(src)
				client.Selecting = 1
				src.Select()
				world << "selected"
	proc
		Select()
			selected = 1
			overlays += selview
		Deselect()
			selected = 0
			overlays -= selview
		SetTarget(var/atom/m)
			if(Target == m) return
			else world << "Not Equal"
			Target = m
			if(Target.type in typesof(/mob/Troop/))
				var/mob/Troop/t = Target
				if(t.pid != src.pid)
					world << "Target Aquired."
					Action = 2
			else if(Target.type in typesof(/turf/))
				world << "Walking!"
				Action = 1
			Check_Actions()
		Walk_Towards()
		Check_Actions()
			Checking = 1
			while(Checking)
				if(Action == 0) break
				else if(Action == 1)
					walk_to(src, Target, 0, Mov_Speed, 32)
					break
				else
					sleep(5)
					world << "Bua haha"
					break
			Checking = 0
		Strike(var/mob/Troop/Enemy)
			Enemy.Hitpoints -= Damage
			if(Enemy.Hitpoints < 0)
				del(Enemy)
				Attacking = 0



obj/Selected
	icon = 'Mobs32x.dmi'
	icon_state = "Selected_1x1"
	layer = MOB_LAYER+1