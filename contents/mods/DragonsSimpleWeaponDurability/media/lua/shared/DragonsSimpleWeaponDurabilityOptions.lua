local SETTINGS;
	SETTINGS = {					
		options = {
			box0 = SandboxVars.DRASWD.BoolIncludeMelee,
			box1 = SandboxVars.DRASWD.BoolIncludeRanged,
			box2 = SandboxVars.DRASWD.BoolIncludeModded,
			dropdown3 = SandboxVars.DRASWD.EnumConditionLowerChanceMultiplier,
			dropdown4 = SandboxVars.DRASWD.EnumConditionMaxMultiplier,
			dropdown5 = SandboxVars.DRASWD.EnumConditionLowerChanceFlatIncrease,
			dropdown6 = SandboxVars.DRASWD.EnumConditionMaxFlatIncrease,
			box7 = SandboxVars.DRASWD.BoolIncludeSmallBlunt,
			box8 = SandboxVars.DRASWD.BoolIncludeBlunt,
			box9 = SandboxVars.DRASWD.BoolIncludeSmallBlade,
			box10 = SandboxVars.DRASWD.BoolIncludeLongBlade,
			box11 = SandboxVars.DRASWD.BoolIncludeAxe,
			box12 = SandboxVars.DRASWD.BoolIncludeSpear,
		},

		names = {						
			box0 = "Modify Melee Weapon Durability",
			box1 = "Modify Ranged Weapon Durability",
			box2 = "Modify Modded Weapon Durability",
			dropdown3 = "Durability Reduction Chance Multiplier",
			dropdown4 = "Durability Max Multiplier",
			dropdown5 = "Durability Reduction Chance Flat Increase",
			dropdown6 = "Durability Max Flat Increase",
			box7 = "Modify SmallBlunt Category Weapon Durability",
			box8 = "Modify Blunt Category Weapon Durability",
			box9 = "Modify SmallBlade Category Weapon Durability",
			box10 = "Modify LongBlade Category Weapon Durability",
			box11 = "Modify Axe Category Weapon Durability",
			box12 = "Modify Spear Category Weapon Durability",
		
		},						
		mod_id = "dragons_simple_weapon_durability",
		mod_shortname= "Dragons Simple Weapon Durability (Single-Player) Options",
	}
	
-- Connecting the options to the menu, so user can change and save them.							
if ModOptions and ModOptions.getInstance then				
	ModOptions:getInstance(SETTINGS)

	local opt0 = SETTINGS.options_data.box0						
	opt0.tooltip = "IGUI_tooltip_DragonsSimpleWeaponDurability_option0"						
	local opt1 = SETTINGS.options_data.box1						
	opt1.tooltip = "IGUI_tooltip_DragonsSimpleWeaponDurability_option1"						
	local opt2 = SETTINGS.options_data.box2						
	opt2.tooltip = "IGUI_tooltip_DragonsSimpleWeaponDurability_option2"
	
	local drop3 = SETTINGS.options_data.dropdown3						
	drop3.tooltip = "IGUI_tooltip_DragonsSimpleWeaponDurability_option3"						
	drop3[1]	= ("1x")
	drop3[2]	= ("2x")
	drop3[3]	= ("3x")
	drop3[4]	= ("4x")
	drop3[5]	= ("5x")
	drop3[6]	= ("6x")
	drop3[7]	= ("7x")
	drop3[8]	= ("8x")
	drop3[9]	= ("9x")
	drop3[10]	= ("10x")
	drop3[11]	= ("100x")
	
	local drop4 = SETTINGS.options_data.dropdown4				
	drop4.tooltip = "IGUI_tooltip_DragonsSimpleWeaponDurability_option4"						
	drop4[1]	= ("1x")
	drop4[2]	= ("2x")
	drop4[3]	= ("3x")
	drop4[4]	= ("4x")
	drop4[5]	= ("5x")
	drop4[6]	= ("6x")
	drop4[7]	= ("7x")
	drop4[8]	= ("8x")
	drop4[9]	= ("9x")
	drop4[10]	= ("10x")
	drop4[11]	= ("100x")	
	
	local drop5 = SETTINGS.options_data.dropdown5						
	drop5.tooltip = "IGUI_tooltip_DragonsSimpleWeaponDurability_option5"						
	drop5[1]	= ("0")
	drop5[2]	= ("1")
	drop5[3]	= ("2")
	drop5[4]	= ("3")
	drop5[5]	= ("4")
	drop5[6]	= ("5")
	drop5[7]	= ("6")
	drop5[8]	= ("7")
	drop5[9]	= ("8")
	drop5[10]	= ("9")
	drop5[11]	= ("10")
	drop5[12]	= ("11")	
	
	local drop6 = SETTINGS.options_data.dropdown6						
	drop6.tooltip = "IGUI_tooltip_DragonsSimpleWeaponDurability_option6"						
	drop6[1]	= ("0")
	drop6[2]	= ("5")
	drop6[3]	= ("10")
	drop6[4]	= ("15")
	drop6[5]	= ("20")
	drop6[6]	= ("25")
	drop6[7]	= ("30")
	drop6[8]	= ("35")
	drop6[9]	= ("40")
	drop6[10]	= ("45")
	drop6[11]	= ("50")
	drop6[12]	= ("100")	

	local opt7 = SETTINGS.options_data.box7						
	opt7.tooltip = "IGUI_tooltip_DragonsSimpleWeaponDurability_option7"
	
	local opt8 = SETTINGS.options_data.box8						
	opt8.tooltip = "IGUI_tooltip_DragonsSimpleWeaponDurability_option8"
	
	local opt9 = SETTINGS.options_data.box9						
	opt9.tooltip = "IGUI_tooltip_DragonsSimpleWeaponDurability_option9"
	
	local opt10 = SETTINGS.options_data.box10						
	opt10.tooltip = "IGUI_tooltip_DragonsSimpleWeaponDurability_option10"
	
	local opt11 = SETTINGS.options_data.box11						
	opt11.tooltip = "IGUI_tooltip_DragonsSimpleWeaponDurability_option11"
	
	local opt12 = SETTINGS.options_data.box12
	opt12.tooltip = "IGUI_tooltip_DragonsSimpleWeaponDurability_option12"
	
	if isClient() then
	opt0.sandbox_path = "HIDE FROM CLIENT"
	opt1.sandbox_path = "HIDE FROM CLIENT"
	opt2.sandbox_path = "HIDE FROM CLIENT"
	drop3.sandbox_path = "HIDE FROM CLIENT"
	drop4.sandbox_path = "HIDE FROM CLIENT"
	drop5.sandbox_path = "HIDE FROM CLIENT"
	drop6.sandbox_path = "HIDE FROM CLIENT"
	opt7.sandbox_path = "HIDE FROM CLIENT"
	opt8.sandbox_path = "HIDE FROM CLIENT"	
	opt9.sandbox_path = "HIDE FROM CLIENT"	
	opt10.sandbox_path = "HIDE FROM CLIENT"	
	opt11.sandbox_path = "HIDE FROM CLIENT"
	opt12.sandbox_path = "HIDE FROM CLIENT"
	end

	function opt0:OnApplyInGame(val)						
		print('Option is updated!', self.id, val)					
	end						
	function opt1:OnApplyInGame(val)						
		print('Option is updated!', self.id, val)					
	end						
	function opt2:OnApplyInGame(val)						
		print('Option is updated!', self.id, val)					
	end		
	function drop3:OnApplyInGame(val)						
		print('Option is updated!', self.id, val)					
	end
	function drop4:OnApplyInGame(val)						
		print('Option is updated!', self.id, val)					
	end	
	function drop5:OnApplyInGame(val)						
		print('Option is updated!', self.id, val)					
	end	
	function drop6:OnApplyInGame(val)						
		print('Option is updated!', self.id, val)					
	end	
	function opt7:OnApplyInGame(val)						
		print('Option is updated!', self.id, val)					
	end	
	function opt8:OnApplyInGame(val)						
		print('Option is updated!', self.id, val)					
	end	
	function opt9:OnApplyInGame(val)						
		print('Option is updated!', self.id, val)					
	end	
	function opt10:OnApplyInGame(val)						
		print('Option is updated!', self.id, val)					
	end	
	function opt11:OnApplyInGame(val)						
		print('Option is updated!', self.id, val)					
	end
	function opt12:OnApplyInGame(val)						
		print('Option is updated!', self.id, val)					
	end
							
	DRASWD = {}
	DRASWD.OPTIONS = SETTINGS
end

local function initDragonsSimpleWeaponDurabilitySandboxOptions()
	SETTINGS = {					
		options = {
			box0 = SandboxVars.DRASWD.BoolIncludeMelee,
			box1 = SandboxVars.DRASWD.BoolIncludeRanged,
			box2 = SandboxVars.DRASWD.BoolIncludeModded,
			dropdown3 = SandboxVars.DRASWD.EnumConditionLowerChanceMultiplier,
			dropdown4 = SandboxVars.DRASWD.EnumConditionMaxMultiplier,
			dropdown5 = SandboxVars.DRASWD.EnumConditionLowerChanceFlatIncrease,
			dropdown6 = SandboxVars.DRASWD.EnumConditionMaxFlatIncrease,
			box7 = SandboxVars.DRASWD.BoolIncludeSmallBlunt,
			box8 = SandboxVars.DRASWD.BoolIncludeBlunt,
			box9 = SandboxVars.DRASWD.BoolIncludeSmallBlade,
			box10 = SandboxVars.DRASWD.BoolIncludeLongBlade,
			box11 = SandboxVars.DRASWD.BoolIncludeAxe,
			box12 = SandboxVars.DRASWD.BoolIncludeAxe,
		},

		names = {						
			box0 = "Modify Melee Weapon Durability",
			box1 = "Modify Ranged Weapon Durability",
			box2 = "Modify Modded Weapon Durability",
			dropdown3 = "Durability Reduction Chance Multiplier",
			dropdown4 = "Durability Max Multiplier",
			dropdown5 = "Durability Reduction Chance Flat Increase",
			dropdown6 = "Durability Max Flat Increase",
			box7 = "Modify SmallBlunt Category Weapon Durability",
			box8 = "Modify Blunt Category Weapon Durability",
			box9 = "Modify SmallBlade Category Weapon Durability",
			box10 = "Modify LongBlade Category Weapon Durability",
			box11 = "Modify Axe Category Weapon Durability",
			box12 = "Modify Axe Category Weapon Durability",

		},						
		mod_id = "dragons_simple_weapon_durability",
		mod_shortname = "Dragons Simple Weapon Durability (Single-Player) Options",				
	}
	DRASWD = {}
	DRASWD.OPTIONS = SETTINGS
	
	local OPTIONS = DRASWD.OPTIONS
	
	--print("*******************************************")
	--print("** SANDBOXVARS TRANSFERED TO MOD OPTIONS **")
	--print("*******************************************")
	--print("Modify Melee Weapon Durability = ", DRASWD.OPTIONS.options.box0)	
	--print("Modify Ranged Weapon Durability = ", DRASWD.OPTIONS.options.box1)
	--print("Modify Modded Weapon Durability = ", DRASWD.OPTIONS.options.box2)
	--print("Durability Reduction Chance Multiplier = ", DRASWD.OPTIONS.options.dropdown3)
	--print("Durability Max Multiplier = ", DRASWD.OPTIONS.options.dropdown4)
	--print("Durability Reduction Chance Flat Increase = ", DRASWD.OPTIONS.options.dropdown5)
	--print("Durability Max Flat Increase = ", DRASWD.OPTIONS.options.dropdown6)
	
end

		----------------------------------
		--	MULTI-PLAYER MODE			--
		--	LOCAL HOST = CLIENT	TRUE	--
		--	DEDICATED = SERVER TRUE		--
		--	SINGLE-PLAYER BOTH false	--
		----------------------------------
if		isServer() or isClient() then
		--print("MULTI-PLAYER ADD OPTIONS ON EVENT")
		Events.OnGameStart.Add(initDragonsSimpleWeaponDurabilitySandboxOptions)
		Events.OnServerStartSaving.Add(initDragonsSimpleWeaponDurabilitySandboxOptions)
		Events.OnPreDistributionMerge.Add(initDragonsSimpleWeaponDurabilitySandboxOptions)
		Events.OnDistributionMerge.Add(initDragonsSimpleWeaponDurabilitySandboxOptions)
		Events.OnPostDistributionMerge.Add(initDragonsSimpleWeaponDurabilitySandboxOptions)
		Events.OnServerFinishSaving.Add(initDragonsSimpleWeaponDurabilitySandboxOptions)
else	--print("SINGLE-PLAYER... USING MOD OPTIONS")
end






