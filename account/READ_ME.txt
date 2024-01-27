--------------------------------
Talonheim Online - talonheim.com
--------------------------------

1. I beleive you now in account folder. If you are not, please to account folder.

2. Fix all the shortcut location error for account_01, 02, 03. (Right click -> Properties -> Shortcut location )

	Example:

	Location Target : C:\Talonheim_Openkore\wxstart.exe -control="account/account_01"
	Start in : C:\Talonheim_Openkore
	
	*p/s : change to where you locate your Talonheim_openkore folder
	
3. Run account_01 and enjoy botting!

4. You can duplicate the folder if you want to add more account.

----------------------------------------------------
Check openkore.com for botting configuration support
----------------------------------------------------

Important setting

1. Change botting location

Example:

	Open C:\Talonheim_Openkore\account\account_01\config.txt
	Find lockMap at line 202
	Change the map location
	
2. Don't attack specific monster

Example:

	Open C:\Talonheim_Openkore\account\account_01\mon_control.txt
	
	Will attack sample:
	
	Poring 1 0 0
	Fabre 1 0 0
	Pupa 1 0 0
	Lunatic 1 0 0
	
	Will not attack sample:
	
	Poporing 0 0 0
	Spore 0 0 0
	Ant's Egg 0 0 0
	PecoPeco's Egg 0 0 0
	Pupa 0 0 0
	Thief Bug's Egg 0 0 0
	
3. Auto storage specific item

Example:

	Open C:\Talonheim_Openkore\account\account_01\config.txt
	Find storageAuto_npc at line 910
	Change the npc Kafra coordinate location ( use /where in game )
	
	Open C:\Talonheim_Openkore\account\account_01\items_control.txt
	
	Will auto storage knife only:
	
	Knife 0 1 0

4. Auto pickup specific item

	Open C:\Talonheim_Openkore\account\account_01\pickupitems.txt
	
	Will not pickup knife:
	
	Knife 0
	
	Will pickup knife:
	
	Knife 1
	
5. Attack monster using skills setting? Visit our discord to view configuration shared by communities or you can visit openkore.com forum