-- An FYI before hand, these things -- comment out the code. So if you see code in --, it means that will be ignored.

PoliceSystem = {

--[[-------------------------------------------------------------------------
-- Advanced Script Options --
---------------------------------------------------------------------------]]

    -- This option (if set to true) will delete data files in the charges/arrest after a certain amount of time that have not been touched.
    -- For those who don't know what this does, a .txt file gets saved, for every person that joins the server, in your server data folder.
    -- This will delete those .txt files after a certain amount of time. Otherwise you can turn this off but sooner or later those files will start to pile up.
    -- I would keep this on to keep your server optimized. (This doesn't delete all the files, just the ones that go over the specified amount of time.)
    -- *IMPORTENT* This doesn't delete files that are used. (This only deletes the files of people who don't log into your server after a certain amount of time.)
    DeleteDaFiles = true,

    -- Time for the charges files
    -- How long should the files be saved for? (After the time you put down, if that person which the file is assgined to does not log on, it will be delete.)
    -- Default is one week. (Put the time in minutes.)
    -- 1 Day: 1440 Minutes
    -- 1 Week: 10080 Minutes
    -- 1 Month: 43800 Minues
    TimeFileDeleteDelayCharges = 10080,

    -- Time for the arrest files
    -- How long should the files be saved for? (After the time you put down, if that person which the file is assgined to does not log on, it will be delete.)
    -- Default is one week. (Put the time in minutes.)
    -- 1 Day: 1440 Minutes
    -- 1 Week: 10080 Minutes
    -- 1 Month: 43800 Minues
    TimeFileDeleteDelayArrest = 10080,

--[[-------------------------------------------------------------------------
-- Advanced Script Options --
---------------------------------------------------------------------------]]

--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------


--[[-------------------------------------------------------------------------
-- General Config --
---------------------------------------------------------------------------]]

    -- Open Menu Buttons
        -- The menu will open by pressing button 1 and 2 in any order. (So you can press 2, then 1)
        MButton1 = KEY_F2, -- I made it F2 so it shouldn't conflict.
        -- This button can be anything you want. Make sure it doesn't conflict.
        -- Button 1 has to be from/on this list: https://wiki.garrysmod.com/page/Enums/KEY
        MButton2 = KEY_NONE,
        -- Button 2 has to be from/on this list: https://wiki.garrysmod.com/page/Enums/KEY
        -- Make this 'KEY_NONE' if you want it to just be MButton1 key to open the menu.
        -- Set this to a key if you want both keys to be pressed to open the menu


    -- Police Jobs
        -- What jobs are allowed to access the police menu?
        AllowedJobsPoliceMenu = {

        TEAM_MAYOR,
        TEAM_POLICE

        },

    -- Ticket Config

        -- Crime Fine
        -- How much should each crime be fined for?
        -- F.Y.I, There are crimes that people will have x20 or x30 (like contraband for example) so price carefully. Depends also on how your server economy is.
        -- Ex. Murder = 1000 means they will be fined 1000$ for each murder they committed

        CrimeFines = {

            MuggingFine = 250,
            MurderFine = 1000,
            CarJackingFine = 250,
            ContrabandFine = 100,
            IllWeaponsFine = 250,
            BurglaryFine = 500,
            TerrorismFine = 2000,
            HitRunFine = 500

        },

        -- Cop Percentage Ticket
        -- How much should the cop get from the ticket he gives (if the ticket is paid?)
        -- Ex. If you don't want the cop to get any money at all put 0.
        -- If you want him to get all of the ticket money put 100.
        -- If you want him to get 35 percent of the ticket put 35. Etc.
        -- If you want him to get double the ticket he gave put 200. Etc.
        -- Default is 35%

        CopPercentage = 35,

    -- Jail Config

        -- Jail Times
        -- Put in seconds how much each charge shoud get in jail time.
        -- Ex. 20 seconds for murder and 5 seconds for mugging would make it 55 seconds jail time
        -- If the perp had 3 muggging charges and 2 murders.

        JailTimeCharges = {

            MuggingTime = 5,
            MurderTime = 20,
            CarJackingTime = 10,
            ContrabandTime = 2,
            IllWeaponsTime = 5,
            BurglaryTime = 10,
            TerrorismTime = 25,
            HitRunTime = 15

        },

    -- Search/Seize Config
        -- This searches the pockets and the weapons the player currently has on them (or something else if you so desire)
        -- Put in the entites name of what can be found. For example (shipment_weed or ls_sniper or weapon_pumpshotgun2)
        -- I'll put in some as deafults.
        -- FYI, this acts as the config for both being able to search for these items and being able to seize these items.
        -- Another thing. Shipments will be searched for by the entity they hold (in pockets).
        -- Ex. A shipment of deafult darkrp five sevens will have the name "weapon_fiveseven2", makes it easier so you don't have to type it out twice.
        SearchSeizeItems = {

            "weapon_pumpshotgun2",
            "weapon_smg1",
            "weapon_frag",
            "weapon_shotgun",
            "weapon_crossbow",
            "weapon_slam",
            "weapon_ar2",
            "weapon_glock2",
            "weapon_deagle2",
            "weapon_mac102",
            "weapon_m42",
            "weapon_ak472",
            "weapon_mp52",
            "weapon_c4",
            "weapon_p2282",
            "weapon_fiveseven2",
            "weapon_rpg",
            "ls_sniper",
            "durgz_mushroom", -- These are from the drug addon
            "durgz_pcp",
            "durgz_meth",
            "durgz_weed",
            "durgz_lsd"
        },

        -- Drop or remove illegal items?
        -- When the cop clicks seize, should all the illegal items (on the person and in his pocket) drop or be removed?
        -- If it drops it means cops can pick it up, or the perp or whoever.
        -- If it gets removed then it cannot be taken back, it disappers.
        -- true to remove / false to drop
        -- Deafult is true
        DropRemoveSeize = false,

        -- How long should a person be restrained for?
        -- When a cop restrains someone and forget about them, how long until they will be automaticlly unrestrained?
        -- This is in seconds so 1 minute = 60, 3 minutes = 180, etc. Deafult is 5 minutes
        -- If the person is being escorted, they will automatically have the timer restarted (when escort starts) and be unescorted and unrestrained if still being escorted
        RestrainingTimer = 300,


--[[-------------------------------------------------------------------------
-- General Config --
---------------------------------------------------------------------------]]


--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------


--[[-------------------------------------------------------------------------
-- Enable/Disable Charges --
---------------------------------------------------------------------------]]

    --Set to false to disable people being charged with that crime. Keep it true to keep it on.

    --Murder Charge (Set to false to disable)
    MurderEnable = true,

    --Burglary Charge (Set to false to disable)
    BurglaryEnable = true,

    --CarJacking Charge (Set to false to disable)
    CarJackingEnable = true,

    --HitNRun Charge (Set to false to disable)
    HitRunEnable = true,

    --Terrorism Charge (Set to false to disable)
    TerrorismEnable = true,

    --Mugging Charge (Set to false to disable)
    MuggingEnable = true,

    --Contraband Charge (Set to false to disable)
    ContrabandEnable = true,

    --IllegalWep Charge (Set to false to disable)
    IllegalWepEnable = true,

--[[-------------------------------------------------------------------------
-- Enable/Disable Charges --
---------------------------------------------------------------------------]]


--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------


--[[-------------------------------------------------------------------------
-- MURDER CHARGE CONFIG --
---------------------------------------------------------------------------]]

    --Hit n' Run Add Murder
    --If set to true then someone who kills someone else with their car will get a Hit n' Run charge along with a Murder charge.
    --If set to false then someone who kills someone else with their car will get only a Hit n' Run charge.
    HitRunMurder = true,

    -- Murder Charge Job Ignore
    -- Put whatever teams you want in here to be ignored by the script when it adds the murder charge
    -- EX. If you put "TEAM_POLICE", then if anyone on that team kills someone, they will not have a Murder charge added
    MurderTable_1 = {

        TEAM_POLICE,
        TEAM_MAYOR -- Make sure the last team you put in here doesn't have a comma at the end.

    },

--[[-------------------------------------------------------------------------
-- MURDER CHARGE CONFIG --
---------------------------------------------------------------------------]]


--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------


--[[-------------------------------------------------------------------------
-- BURGLARY CHARGE CONFIG --
---------------------------------------------------------------------------]]

    --LockPicks
    --Right click on the weapon icon and click copy to clipboard, then paste it in here following the format.
    --You need to do this for all your lockpicks, the default lockpick is already included
    LockPickTable = {

        "lockpick",
        "pro_lockpick"
    },

    --DelayTime
    --Set (in seconds) the time for how long you want the charge to delay before charging again
    --Ex. If set to 180 that means every time the person lock picks a house they will be charged with burglary.
    --Then in the 3 minute span, anything they lockpick will be ignored and not added to the charge
    DelayBurglaryTime = 180,

    -- Burglary Charge Job Ignore
    -- Put whatever teams you want in here to be ignored by the script when it adds the Burglary charge
    -- EX. If you put "TEAM_POLICE", then if anyone on that lock picks a door, they will not have a Burglary charge added
    BurglaryTable_1 = {

        TEAM_MAYOR,
        TEAM_POLICE

    },

--[[-------------------------------------------------------------------------
-- BURGLARY CHARGE CONFIG --
---------------------------------------------------------------------------]]


--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------


--[[-------------------------------------------------------------------------
-- CARJACKING CHARGE CONFIG --
---------------------------------------------------------------------------]]

    -- Car Jacking Charge Job Ignore
    -- Put whatever teams you want in here to be ignored by the script when it adds the CarJack charge
    -- EX. If you put "TEAM_POLICE", then if anyone on that team steals a car, they will not have a CarJack charge added
    -- It is empty by default, uncomment or just add jobs for it to enable.
    CarJackTable_1 = {

        --TEAM_POLICE,
        --TEAM_MAYOR
    },

--[[-------------------------------------------------------------------------
-- CARJACKING CHARGE CONFIG --
---------------------------------------------------------------------------]]


--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------


--[[-------------------------------------------------------------------------
-- HIT N RUN CHARGE CONFIG --
---------------------------------------------------------------------------]]


    -- Jobs to be ignored when the script runs
    -- EX. TEAM_POLICE will not have a Hit N Run charge added when they kill someone with their car
    HitRunTable_1 = {

        TEAM_POLICE,
        TEAM_MAYOR

    },

--[[-------------------------------------------------------------------------
-- HIT N RUN CHARGE CONFIG --
---------------------------------------------------------------------------]]


--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------


--[[-------------------------------------------------------------------------
-- TERRORISM CHARGE CONFIG --
---------------------------------------------------------------------------]]

    -- Put the weapons in qoutation marks to add what weapons it triggers on
    -- EX. Putting "weapon_slam" will make it that everytime someone places down a slam it will add a charge to them (providing the pass the job check)
    -- To get the weapon name go to the q meun, right click the weapon in the weapons tab and click "Copy to clipboard"
    TerrorismWeapons = {

        --"weapon_c4", -- This is not an actual weapon, this is just to show were to put commas.
        "weapon_slam"

    },

    -- If you set this to true then any jobs in the TerrorismJobTable_1 who plant bombs will have a charge applied to them
    -- If you set this to false then any jobs in the TerrorismJobTable_1 will be ignored when they plant a bomb
    TerrorJobCheck = false,

    --Jobs to be checked or ignored based on what you set TerrorJobCheck to
    TerrorismJobTable_1 = {

        TEAM_POLICE,
        TEAM_MAYOR
        --If TerrorJobCheck set to true it would look like this
        --TEAM_TERRORIST,
        --TEAM_TERRORISTLEADER

    },

--[[-------------------------------------------------------------------------
-- TERRORISM CHARGE CONFIG --
---------------------------------------------------------------------------]]


--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------


--[[-------------------------------------------------------------------------
-- MUGGING CHARGE CONFIG --
---------------------------------------------------------------------------]]

    --How long should it wait before someone can mug again? (In Seconds) (Default is 180 (3 minutes))
    MugDelaying = 180,

    --How much should the mugger be able to ask for maximum?
    --Ex. 5000 means the mugger cannot ask for more than $5000
    MaxMugging = 5000,

    --Which jobs shouldn't be allowed to mug people?
    MuggerJobTable_1 = {

        TEAM_POLICE,
        TEAM_MAYOR
    },

    -- More Info: To mug, you must type in "!mug number"
    -- For example: "!mug 1000" or "!mug 2000"
    -- Mugging cannot be below 10$ and cannot be above your max that you set.

--[[-------------------------------------------------------------------------
-- MUGGING CHARGE CONFIG --
---------------------------------------------------------------------------]]


--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------


--[[-------------------------------------------------------------------------
-- CONTRABAND CHARGE CONFIG --
---------------------------------------------------------------------------]]

    --Jobs to be ignored
    --Ex. Whenever TEAM_POLICE buys contraband or picks it up, they will not have a charge added.
    ContrabandJob_1 = {

        TEAM_POLICE,
        TEAM_MAYOR

    },

    --Which Entities should be contraband?
    ---------------------------------------- Note: This doesn't work with Vehicles or Shipments
    --If you don't know how to get the entity name, I made a function for the group "superadmin".
    --Look at the entity and type in "!!GetEnt" without the "". Type it exactly. Now the name should print to your chat.
    --Take that name and go ahead and toss it in the table below in "".
    ----------------------------------------
    --Quick note: The way this works is if a player buys or picks any of these entities up with their gravity gun.

        --"printer_white",
        --"ent_c4", -- This is lets say someone plants a c4 and someone else picks it up. ent_c4 is what they would be picking up
        --"shipment_m9k_spas12", -- I don't know the actually entity name but spawn a shipment and look above
        --"weapon_m9k_spas12" -- Again don't know the actual entity name, it's just to give you an idea.

    -- This table (table is something that holds more than one value) is meant to only hold shipment names that are contraband.
    -- The name of the shipment should be put in here. To get the name it is what you type in right after 'DarkRP.createShipment("M4", {'
    -- So 'M4' would be what you put in to the table. I will put in the name of all the rifles that are default in DarkRP as an example.
    -- You can also get the name by typing in "!!GetEnt" while looking at the shipment and it will print to your chat.
    -- More Info: How this works is that once, let's say player A, player A picks this up, player A will get a charge added. 
    -- He will not get another charge however for picking up the same shipment. (same shipment means that one unique shipment, it does not mean all shipments with the same gun.)
    -- This will also give a charge to those who buy it.
    ContrabandShip_1 = {

    "AK47",
    "MP5",
    "Mac 10",
    "Pump shotgun",
    "M4",
    "Sniper rifle"

    },

    -- This table is for the actual guns. Again look at the gun and just type in '!!GetEnt' to get the name.
    -- Then toss the name in here. I will be putting the default DarkRP guns.
    -- This will also give a charge to those who buy it.

    ContrabandWep_1 = {

    "weapon_p2282",
    "weapon_fiveseven2",
    "weapon_glock2",
    "weapon_deagle2"

    },

    -- If you want to add more things to contraband then put them here. (Anything that isn't a Weapon or Shipment)
    -- There is no garuntee they will work but they most likely will. If they don't then feel free to leave a comment on my profile.
    -- I don't have any other ents so I will be putting in examples from the drug mod which can be found here
    -- https://steamcommunity.com/sharedfiles/filedetails/?id=696374067
    -- These are commeneted out so you would have to remvoe the "--" to make them work.
    -- I did however include the money printer.

    ContrabandXtra_1 = {

    --"durgz_aspirin",
    --"durgz_alcohol",
    --"durgz_cigarette",
    --"durgz_lsd",
    --"durgz_heroine",
    --"durgz_cocaine",
    --"durgz_weed",
    --"durgz_meth",
    --"durgz_mushroom",
    --"durgz_pcp",
    "money_printer",
    "drug_lab",
    "gunlab"

    },

    --Should this have DarkRp functions (Checking if they buy from the F4 menu, weapon shipments, printers etc.)
    --*ONLY WORKS WITH DARKRP*
    --Set to true to have DarkRp functions, set to false to disable it.
    -- I'm stupid and I thought I could make this addon without it relying on the Dark RP base.
    -- Just don't touch this.
    ContrabandDarkRp = true,

--[[-------------------------------------------------------------------------
-- CONTRABAND CHARGE CONFIG --
---------------------------------------------------------------------------]]

--------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------

--[[-------------------------------------------------------------------------
-- ILLEGAL WEAPON CHARGE CONFIG --
---------------------------------------------------------------------------]]

    -- What jobs should be ignored by the charge?
    --(People that have the job stated below will not get a charge with that crime.)
    IllegalWepJob_1 = {

    TEAM_MAYOR,
    TEAM_POLICE

    },

    -- What weapons should be illegal?
    -- (The way this script works is that whenever a player takes out a weapons listed below,
    --  then that player will get a charge added. It does not add a charge if they just have it on them.)
    -- (Also, until that player dies, they will not be charged with taking out that same weapon again
    --  unless they drop and pick it up again. (That will be an option for you.))
    -- To get the name of a weapon, go into your Q menu and go to the weapons tab. Find the weapon, right click on the icon and click copy to clipboard. Paste it below.
    IllegalWeapons_1 = {

    "weapon_deagle2",
    "weapon_rpg",
    "weapon_glock2",
    "weapon_slam"

    },

    --*IMPORTENT*-- (Really this whole script relies on DarkRp so you really shouldn't touch this anyways unless you know what you're doing)
    --*READ THIS BELOW*--
    -- So I have devised two ways on how people can be charged with having an illegal weapon. I didn't know which one to choose so I made both and will let you choose.
    -- So setting the below option to true will give you option 1, setting it to false will give you option 2.
    -- Option 1(true), Option 2(false) <--- This is not how you put it in, this is just to show which option you will get based on wether you put true or false.
    -- Option 1: The person will get an illegal weapons charge everytime he picks an illegal weapon. That's it.
    -- Option 2: Option 2 is a bit more advanced. In this option,
    -- everytime a player unholsters an illegal weapon (takes it out, lets say he had his gravity gun out, then he took out an AK. That would trigger the script)
    -- that player will then get an illegal weapons charge. He will not get another charge for taking out that same weapon unless he gets sent to jail or dies.
    -- By default I will set this to option 2 because I like it better. Remember, setting it to true will be picking option 1.
    ChoiceIWep = false,
    -- Set this to false if IWepDarkRp is true
    -- ChoiceIWep is option 1


    -- *This is only for option 2, if you have option 1 from above, don't bother reading this.*--
    -- You don't really have to touch this unless you are coding your own gamemode.
    -- If this is set to true then DarkRP functions will be enabled in the script.
    -- For example: People, when sent to jail, will have weapons that they have prevousily took out will be cleared.
    -- EX. Player 1 takes out an AK and gets an illegal weapons charge. He now will not get another charge for taking out the AK again unless he goes to jail (or dies).
    -- Then when he does it again, he will get another charge. Since jail is a DarkRp thing, IWepDarkRp will have to be true for it to work.
    IWepDarkRp = true,
    -- Set this to false if ChoiceIWep is true, vica versa.
    -- IWepDarkRp is option 2

--[[-------------------------------------------------------------------------
-- ILLEGAL WEAPON CHARGE CONFIG --
---------------------------------------------------------------------------]]

-- Don't touch the stuff below this line. This is for me.

    -- Lock Pickable Doors (Burglary Check)
    doorcheck = {
        "prop_door_rotating",
        "func_door_rotating",
        "func_door"
    },

    -- Escort Distance
    EscortDistance = 50,

}