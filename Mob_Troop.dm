
mob/Troop
	icon = 'Mobs16x.dmi'
	icon_state = "Troop"
	Is_Troop = 1
	var
		Alliance = null
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
		Mov_Speed = 0 //Moves every 6 ticks, and checks for
	New()
		..()
		Check_Actions()
	proc
		Select()
			selected = 1
			overlays += selview
		Deselect()
			selected = 0
			overlays -= selview
		SetDestination(var/atom/m)
			if(Target == m) return
			else world << "Not Equal"
			Target = m
			if(Target.type in typesof(/mob/Troop/))
				var/mob/Troop/t = Target
				if(t.Alliance != src.Alliance)
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
					walk_to(src, Target)
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
	icon = 'Mobs16x.dmi'
	icon_state = "Selected_1x1"
	layer = MOB_LAYER+1