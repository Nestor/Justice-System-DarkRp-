# Justice-System-DarkRp-
A shit system for a gamemode for a shit game
Bascially, an Arma 3 Altis Life remake for Gmod

Justice System:


Contents:

I. How it works

II. Using it

III. Crime Docs

Chapters:

I. 

	The way this system works is by recording crimes people have committed.
	There are 8 different types of crimes you can commit.

		-The first crime is Mugging. The way this charge gets on your list is by you typing "!mug ####". You can't mug below 10$, and the highest is set in the config.

		-The second crime is Burglary. The way this charge gets on your list is by a person(you)
		lockpicking a door. After you start lockpicking a door, you have a set amount of time you can lock pick other doors before another burglary charge gets applied. (Fading doors do not count, because why?)

		-The third crime is CarJacking. This is more of a grand theft auto charge (but that name is too long). The way this works is that a charge gets applied to you when a person(you) starts lockpicking a car. After you lockpick that car, lockpicking that same car ever again won't give you the charge again.

		-The fourth crime is Murder. This charge gets added to the person whenever they kill someone. That's it. (Killing someone with a prop also gives you a charge)

		-The fifth crime is Hit n Run. This charge gets added to the person whenever they kill someone with a car. (Driving it)

		-The sixth crime is Terrorism Charge. This charge gets applied to a person if they shoot/plant/use a weapon that is defined as a terrorist weapon.

		-The seventh crime is Illegal Weapons. This charge gets applied when a person equips a weapon in their hotbar (weapon can be in your hotbar, but you need to take it out for the charge to take effect) that is listed in the config as illegal. If you take out a weapon, you will not get another charge for taking out that same weapon again.
		A side note for more advanced users, by default, it is enabled that if you go to jail, and you take out the weapon after your released, you will get another charge.

		-The eight and last crime is the contraband charge. This charge gets applied to a person if they buy or pick up (with a grav gun) an entity that is classified as contraband in the config. Doing it again to the same entity won't give you another charge.

	With all these charges, people can get tickted for them (price of ticket varies based
	on which crimes were committed and the amount of times they were committed).
	They can also get sent to jail for them (time is based on the amount of crimes and
	which crimes were committed).

	The jail also saves the time of however much time you have left, so if you leave while jailed, you will become arrested again for your remaining time.

	If you leave while restrained or being escorted, you automatically get sent to jail (as if a cop would send you to jail).

	If a cop unarrests you from jail, then the time remaining will be set to nil, the file that saves the time deletes itself.

	The cuffs that a person get put on them when they become restrained are scaled to a persons hitboxes of their forearms.

	A person automatically gets unrestrained if a cop doesn't interact with them after a set amount of time.

	A person will get automatically unescorted and unrestrained if a cop doesn't interact with them after a set amount of time.

	A person will automatically become unrestrained and unescorted if a cop gets demoted (while escorting them), otherwise, they person will stay restrained if they are just restrained.

	A person can lockpick someone out of restraints by lockpicking the body.

	If a person gets demoted (or switches jobs) while restrained, they will become that job after being unrestrained.

	A person cannot kill themselves while restrained.

	A person can only look around while restrained.

	The escort system cannot be abused by dropping people off buildings or sticking the person inside a while and unescorting them (it won't let them do that).

	A person cannot be arrested while they are being escorted.

	The charges of a person are cleared when they are ticketed, sent to jail, or are pardoned.

	Cops can get a precentage of a ticket if defined in the config.

	Cops can't use the menu on other cops.

	For the terrorism charge, the person only gets one charge per life, once a person gets a terrorism charge while they're alive, they have to die to get another one.
	(This might change in the future, because now that I think about it, this is a pretty dumb concept)

II.


	To use the justice system, police have to press "F2" (Or whatever the key you set it to.) while looking at a person. (Can't be another cop)

	You must first restrain the perp before doing anything else.

	Using escort whill move the perp where you want, they will stay in front of you whereever you look and you can move them whereever you want (maybe to PD to deal with them).

	You can ticket them, which will tell you if they paid the ticket or not. This may give you a precentage if it's set by the owner.

	You can pardon them, which will just clear all their charges.

	You can search them which will show you everything in their pocket and in their hotbar
	(if it's illegal).

	You can also seize their illegal items (this may either drop the items in front of
	them, or just get rid of them alltogther, depending on how it's set in the config).

	You can send them to jail, which will automatically, calculate the time and just send them away.


Functions explained (If anyone wants to make some shit)

	- Side note, if you don't want the netstring to send, just make it "" (Might cause errors, just google what to set a netstring too so it doesn't send).

---------------------------------------------------------
Function name: PolSys.isJob(obj ply, string netstring)

	Description: Checks if a player is the job that is listed in "PoliceSystem.AllowedJobsPoliceMenu".

	Realm: Server

	Returns: Returns True if player is the correct job, returns false if not.

	Function Parameters:

		ply(object):
			The player object
		netstring(string): (Only sends if function returns false)
			The string to send the fail messege
			The netstring writes a bool, then an int. The bool is false, and the int is 1 at 32 bits. (The string by default should be "JSDenyMsgCL")
---------------------------------------------------------

---------------------------------------------------------
Function name: PolSys.isPlyNear(obj cri, obj ply, string netstring)

	Description: Checks to make sure the ent(perp) is a player, the cop is close enough and the perp isn't another cop.

	Realm: Server

	Returns: True is passes all the checks, false otherwise.

	Function Parameters:

		cri(object):
			The perp, or the 'criminal' player object
		ply(object):
			The cop (sends the netstring to this person)
		netstring(string):
			The string to send the fail messege (if the function returns false). Should be "JSDenyMsgCL". 
			(If the ent is a cop, it writes true and then an int 3 at 32 bits)
			(If the distance is too low, it writes false, and then an int 2 at 32 bits)
			(If the ent isn't a player, it writes false, and then an int 2 at 32 bits)
---------------------------------------------------------

---------------------------------------------------------
Function name: PolSys.isEscorted(obj cri, obj ply, netstring)

	Description: Checks if the ent(perp) is being escorted.

	Realm: Server

	Returns: True if being escorted, false if not.

	Function Parameters:

		cri(object):
			The perp, or the 'criminal' player object
		ply(object):
			The cop (sends the netstring to this person)
		netstring(string):
			The string to send the fail messege (if the function returns true). Should be "JSDenyMsgCL". 
			(Writes a true bool, then a 1 int at 32 bits)
---------------------------------------------------------

---------------------------------------------------------
Function name: PolSys.isRestrained(cri, ply, netstring)

	Description: Checks if the cri(perp) is restrained.

	Realm: Server

	Returns: True if the ent(perp) is restrained, false otherwise.

	Function Parameters:

		cri(object):
			The perp, or the 'criminal' player object
		ply(object):
			The cop (sends the netstring to this person)
		netstring(string):
			The string to send the fail messege (if the function returns false). Should be "JSDenyMsgCL".
			(Writes a true bool, then a 2 int at 32 bits)
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.isWanted(obj ply, string netstring, table charges)

	Description: Checks if the person is wanted (adds all the charges togther and see's if it is over 0).

	Realm: Server

	Returns: True if person is wanted, false if not.

	Function Parameters:

		ply(object):
			The cop to send the netstring too.
		netstring(string):
			The string to send the fail messege (if the function returns false). Should be "JSDenyMsgCL".
			(Writes a false bool, then a 3 int at 32 bits)
		charges(table):
			The table of charges to pass through.
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.crimeFine(obj ply)

	Description: Returns the total fine number for the amount of crimes the ply(perp) has committed.

	Realm: Server

	Returns: Number(Total Fine Number (assumingly to charge as DarkRp cash)) Returns 0 if no crimes are committed.

	Function Parameters:
		
		ply(object):
			The criminal
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.clearCrimes(obj ply)

	Description: Clears the crimes of the player object passed through.

	Realm: Server

	Returns: Nothing.

	Function Parameters:

		ply(object):
			The criminal to clear the crimes of
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.jailTime(ply)

	Description: Gets the total amount of time the person will be jailed for, for their crimes.

	Realm: Server

	Returns: Number(Total Amount of Time).

	Function Parameters:

		ply(object):
			The criminal
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.getCrimes(obj ply)

	Description: Gets and returns the crimes of a player.

	Realm: Server

	Returns: Table(crimes)
		
		The format of the table is as follows: (The 0 will be the amount of times the player has committed the crime).

		{Mug = 0,
	     Mur = 0,
	     Car = 0,
	     Con = 0,
	     IWep = 0,
	     Bur = 0,
	     Ter = 0,
	     Hnr = 0}

	Function Parameters:

		ply(object):
			The criminal
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.searchSeize(ply)

	Description: Gets and returns a table of the players weapons that are classfied as illegal (used for searching and seizing).

	Realm: Server

	Returns: Table(Filled with weapons)
		
		The table formats are as follows:
		tablereturned.wep - The weapons in the persons hotbar
		tablereturned.pock
		tablereturned.pock.wep - The weapons in a pocker
		tablereturned.pock.ship - The shipments in a pocket
		tablereturned.poc.misc - Everything else in the pocket (like drugs)

	Function Parameters:

		ply(object):
			The criminal
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.jailTimeLeft(obj ply)

	Description: Gets the amount of jailtime the player still has (currently). (Didn't seem that darkrp had this function, so I made it myself).

	Realm: Server

	Returns: Number(Amount of Time Left).

	Function Parameters:

		ply(object):
			The inmate
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.removeWeps(obj ply)

	Description: Removes the weapons in the hotbar of a player. (Saves them in a table)
	Puts the weapons in the table ply.JSWepTable (Contains all the weapons) and ply.JSAmmoTable (the primary ammo amount of the weapons) and ply.JSAmmoTable2 (the amount of reserve/secondry ammo of the weapons). (This removes all the weapons).

	Realm: Server

	Returns: Nothing.

	Function Parameters:

		ply(object):
			The player to strip the weapons off of
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.restrainPly(obj ply)

	Description: Restrains and cuffs the player. Prevents them from moving.

	Realm: Server

	Returns: Nothing.

	Function Parameters:

		ply(object):
			The player to restrain
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.returnWeps(obj ply)

	Description: Returns the weapons that were taken with 'PolSys.removeWeps()'.

	Realm: Server

	Returns: Nothing

	Function Parameters:

		ply(object):
			The player to return the weapons to
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.unrestrainPly(obj ply, bool returnweps)

	Description: Unrestrains and returns weapons (if defined) to a player.

	Realm: Server

	Returns: Nothing.

	Function Parameters:

		ply(object):
			The player to unrestrain
		weps(bool):
			If not defined, or defined as true, the weapons will be returned.
			Otherwise, define it to false to not return the weapons
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.resetEscort(obj ply)

	Description: Resets the vars and hooks of the cop escorting someone (This needs to be called if you create your own functions which escort). (Basically stops escorting)

	Realm: Server

	Returns: Nothing.

	Function Parameters:

		ply(object):
			The cop to make them stop escorting whatever.
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.resetColls(obj ply)

	Description: Resets the collisions and vars of the player being escorted. (This needs to be called whenever the player is not being escorted anymore.)

	Realm: Server

	Returns: Nothing.

	Function Parameters:

		ply(object):
			The player that's being escorted
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.timerRS(obj cri, obj ply, bool start)

	Description: Starts or resets the timer for the player to be unrestrained/unescorted. (If a cop goes afk or some shit, this is what unrestrains/unescorts the player).

	Realm: Server

	Returns: Nothing.

	Function Parameters:

		cri(object):
			The criminal to unrestrain/unescort after the timer ends
		ply(object):
			The cop
		start(bool):
			True if we are starting the timer, false if we are just restarting it.
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.canStopEscort(obj ply, obj cri)

	Description: Checks if the ply(cop) can stop escorting the cri(perp) based on location.

	Realm: Server

	Returns: True if they can stop escorting, false if they can't. (Also sends a netstring if it's false) (Netstring name is "JSEscortPlyCL", that writes a true bool and a 105 int at 32 bits.)

	Function Parameters:

		ply(object):
			The cop escorting
		cri(object):
			The criminal being escorted
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.countSeizeWeps(table weapons)

	Description: This returns the total amount of things in the weapons table that is gotten with 'PolSys.removeWeps()'. The table is all of tables (.pock.ship, .misc, .wep (in both pock and for hotbar)).

	Realm: Server

	Returns: Number(Total amount of things in the weapons table)

	Function Parameters:

		weapons(table):
			The table gotten with 'PolSys.removeWeps()'
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.addMurder(ply)

	Description: Adds the murder charge to the player.

	Realm: Server

	Returns: Nothing.

	Function Parameters:

		ply(object):
			The player to add the charge to
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.addCarJack(ply)

	Description: Adds the car jacking charge to the player.

	Realm: Server

	Returns: Nothing.

	Function Parameters:

		ply(object):
			The player to add the charge to
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.addHitRun(ply)

	Description: Adds the hit and run charge to the player.

	Realm: Server

	Returns: Nothing.

	Function Parameters:

		ply(object):
			The player to add the charge to
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.addTerror(ply)

	Description: Adds the terrorism charge to the player.

	Realm: Server

	Returns: Nothing.

	Function Parameters:

		ply(object):
			The player to add the charge to
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.addContraband(ply)

	Description: Adds the contrabnd charge to the player.

	Realm: Server

	Returns: Nothing.

	Function Parameters:

		ply(object):
			The player to add the charge to
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.addMug(ply)

	Description: Adds the mugging charge to the player.

	Realm: Server

	Returns: Nothing.

	Function Parameters:

		ply(object):
			The player to add the charge to
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.addIllWep(ply)

	Description: Adds the illegal weapons charge to the player.

	Realm: Server

	Returns: Nothing.

	Function Parameters:

		ply(object):
			The player to add the charge to
---------------------------------------------------------


---------------------------------------------------------
Function name: PolSys.addBurglary(ply)

	Description: Adds the burglary charge to the player.

	Realm: Server

	Returns: Nothing.

	Function Parameters:

		ply(object):
			The player to add the charge to
---------------------------------------------------------
