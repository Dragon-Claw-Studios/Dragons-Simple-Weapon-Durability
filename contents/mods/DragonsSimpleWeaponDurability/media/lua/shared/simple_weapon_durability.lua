-- Item Types: (Right now the script only includes "Weapon" types. Other types can be manually added.
-- Clothing
-- Container
-- Drainable
-- Food
-- Key
-- KeyRing
-- Literature
-- Normal
-- Weapon
-- WeaponPart

-- Weapon categories:
-- "SmallBlunt", "Blunt", "SmallBlade", "LongBlade", "Axe" or "Spear"

function ModifyALLItemCondition()
	
	-- Some simple flags to filter what items will be adjusted
	local bIncludeMelee = DRASWD.OPTIONS.options.box0
	local bIncludeRanged = DRASWD.OPTIONS.options.box1
	local bIncludeModded = DRASWD.OPTIONS.options.box2

	-- The various durability modifiers
	local iConditionLowerChanceMultiplier = DRASWD.OPTIONS.options.dropdown3
	local iConditionMaxMultiplier = DRASWD.OPTIONS.options.dropdown4
	local iConditionLowerChanceFlatIncrease = DRASWD.OPTIONS.options.dropdown5
	local iConditionMaxFlatIncrease = DRASWD.OPTIONS.options.dropdown6

	-- Extended filters for what melee weapon categories will be adjusted
	local bIncludeSmallBlunt = DRASWD.OPTIONS.options.box7
	local bIncludeBlunt = DRASWD.OPTIONS.options.box8
	local bIncludeSmallBlade = DRASWD.OPTIONS.options.box9
	local bIncludeLongBlade = DRASWD.OPTIONS.options.box10
	local bIncludeAxe = DRASWD.OPTIONS.options.box11
	local bIncludeSpear = DRASWD.OPTIONS.options.box12	
	
	local oValidCategories = java.util.ArrayList:new()
	
	if bIncludeSmallBlunt then
		oValidCategories:add("SmallBlunt")
	end
	
	if bIncludeBlunt then
		oValidCategories:add("Blunt")
	end
	
	if bIncludeSmallBlade then
		oValidCategories:add("SmallBlade")
	end
	
	if bIncludeLongBlade then
		oValidCategories:add("LongBlade")
	end
	
	if bIncludeAxe then
		oValidCategories:add("Axe")
	end

	if bIncludeSpear then
		oValidCategories:add("Spear")
	end	
	
	-- Copy the list of unmodified items into one we can change	
	local oAllItems = DRAALLITEMS

	--print("bIncludeMelee set to: "..tostring(bIncludeMelee))
	--print("bIncludeRanged set to: "..tostring(bIncludeRanged))
	--print("bIncludeModded set to: "..tostring(bIncludeModded))
	
	--print("iConditionLowerChanceMultiplier set to: "..tostring(iConditionLowerChanceMultiplier))
	--print("iConditionMaxMultiplier set to: "..tostring(iConditionMaxMultiplier))
	--print("iConditionLowerChanceFlatIncrease set to: "..tostring(iConditionLowerChanceFlatIncrease))	
	--print("iConditionMaxFlatIncrease set to: "..tostring(iConditionMaxFlatIncrease))	
	
	for iItemsCount=oAllItems:size()-1, 0, -1 do
		ModifyItemCondition(oAllItems:get(iItemsCount), bIncludeMelee, bIncludeRanged, bIncludeModded, iConditionLowerChanceMultiplier, iConditionMaxMultiplier, iConditionLowerChanceFlatIncrease, iConditionMaxFlatIncrease, oValidCategories)
	end

end

function ModifyItemCondition(oItem, bIncludeMelee, bIncludeRanged, bIncludeModded, iConditionLowerChanceMultiplier, iConditionMaxMultiplier, iConditionLowerChanceFlatIncrease, iConditionMaxFlatIncrease, oValidCategories)

	if oItem ~= nil then

		-- These variables are all the information you would need to include or exclude specific items, mods, etc.
		--ModuleName is kinda useless, because some mods derive from "Base", such as Brita's Weapon Pack. ModID is much better suited for this task.
		--local sModuleName = oItem:getModuleName()		
		local sItemType = oItem:getTypeString()
		local sModID = oItem:getModID()
		local sItemName = oItem:getName()
		local bIsRanged = oItem:isRanged()

		local oCategories = java.util.ArrayList:new()
		local sCategoryMatch = ""
		
		if oItem:getCategories() then
			oCategories = oItem:getCategories()
			--print ("Categories")
			--print (oCategories)
		end
			
		local iItemCurrentConditionMax = oItem:getConditionMax()
		local iItemCurrentConditionLowerChance = oItem:getConditionLowerChance()

		-- Uncomment the below line in order to see what items' durability is being updated in the logs. Logs are located at C:\Users\{username}\Zomboid\Logs on windows. Unsure on Linux or other OS.
		--print("Item Name: "..sModID.."."..sItemName)
		
		-- Uncomment the below lines in order to see the condition lower chances before and after values in the logs. Logs are located at C:\Users\{username}\Zomboid\Logs on windows. Unsure on Linux or other OS.
		--print("Original Max Condition: "..tostring(oItem:getConditionMax()))
		--print("Original Lower Chance: "..tostring(oItem:getConditionLowerChance()))

		-- Check if item actually has any categories. Ranged weapons have none, for instance.
		if oCategories:size() ~= 0 then
			-- Comparing the list of this weapon's categories, if any exist to a list of all valid categories set by bools earlier.
			for iCategoriesCount=oCategories:size()-1, 0, -1 do
				for iValidCategoriesCount=oValidCategories:size()-1, 0, -1 do
				
					-- If any valid category is found, we store it temporarily and stop the loop
					if oCategories:get(iCategoriesCount) == oValidCategories:get(iValidCategoriesCount) then
						sCategoryMatch = oCategories:get(iCategoriesCount)
					break end
				end
				-- If any valid category is found, we dont care about further checking
				if sCategoryMatch ~= "" then
				break end
			end
		-- To insure that we still modify any item that does not have a category, we set a failsafe string. As long as this string is not empty, we assume a valid category
		else
			sCategoryMatch = "NoCategoryFound"
		end



		-- We ignore "iConditionLowerChanceMultiplier = 1" because that is just default item value, in order to speed up the process
		if (iConditionMaxMultiplier ~= 1) and (iItemCurrentConditionMax ~= nil) and (iItemCurrentConditionMax ~= 1000000) and (sItemType == "Weapon") and sCategoryMatch ~= "" then
			
			-- Logical expressions to determine if item is included and should be adjusted or not
			-- By checking if the ModID is "pz-vanilla", we can exclude any modded items			
			if (bIsRanged == true and bIncludeRanged == true) or (bIsRanged ~= true and bIncludeMelee == true) and ((sModID == "pz-vanilla") or (sModID ~= "pz-vanilla" and bIncludeModded == true)) then

				if iConditionLowerChanceFlatIncrease < 11 then
					oItem:setConditionMax(iItemCurrentConditionMax * iConditionMaxMultiplier)
				elseif iConditionLowerChanceFlatIncrease == 11 then
					oItem:setConditionMax(iItemCurrentConditionMax + 100)
				end

				--we update the currently selected item stats in case we need to modify them further later				
				iItemCurrentConditionMax = iItemCurrentConditionMax * iConditionMaxMultiplier
			end
		end
		
		
		if (iConditionLowerChanceMultiplier ~= 1) and (iItemCurrentConditionLowerChance ~= nil) and (iItemCurrentConditionLowerChance ~= 1000000) and (sItemType == "Weapon") and sCategoryMatch ~= "" then
			
			-- Logical expressions to determine if item is included and should be adjusted or not

			if (bIsRanged == true and bIncludeRanged == true) or (bIsRanged ~= true and bIncludeMelee == true) and ((sModID == "pz-vanilla") or (sModID ~= "pz-vanilla" and bIncludeModded == true)) then
								
				-- Since the value from the mod options is just the index, we need a few extra conditions to set the value.
				if iConditionLowerChanceMultiplier < 11 then
					oItem:setConditionLowerChance(iItemCurrentConditionLowerChance * iConditionLowerChanceMultiplier)
				elseif iConditionLowerChanceMultiplier == 11 then
					oItem:setConditionLowerChance(iItemCurrentConditionLowerChance + 100)
				end
				iItemCurrentConditionLowerChance = iItemCurrentConditionLowerChance * iConditionLowerChanceMultiplier
			end
		end

		
		
		-- ==========FLAT INCREASES========== 
		-- We ignore "iConditionLowerChanceFlatIncrease = 1" because that is the default setting of adding 0, which would be pointless. It only exists in order to disable modification by a flat value
		if (iConditionMaxFlatIncrease ~= 1) and (iItemCurrentConditionMax ~= nil) and (iItemCurrentConditionMax ~= 1000000) and (sItemType == "Weapon") and sCategoryMatch ~= "" then
			
			-- Logical expressions to determine if item is included and should be adjusted or not
			if (bIsRanged == true and bIncludeRanged == true) or (bIsRanged ~= true and bIncludeMelee == true) and ((sModID == "pz-vanilla") or (sModID ~= "pz-vanilla" and bIncludeModded == true)) then

				if iConditionMaxFlatIncrease < 12 then
					oItem:setConditionMax(iItemCurrentConditionMax + iConditionMaxFlatIncrease*5)
				elseif iConditionMaxFlatIncrease == 12 then
					oItem:setConditionMax(iItemCurrentConditionMax + 100)
				end
			end
		end
		
		if (iConditionLowerChanceFlatIncrease ~= 1) and (iItemCurrentConditionLowerChance ~= nil) and (iItemCurrentConditionLowerChance ~= 1000000) and (sItemType == "Weapon") and sCategoryMatch ~= "" then
			
			-- Logical expressions to determine if item is included and should be adjusted or not
			if (bIsRanged == true and bIncludeRanged == true) or (bIsRanged ~= true and bIncludeMelee == true) and ((sModID == "pz-vanilla") or (sModID ~= "pz-vanilla" and bIncludeModded == true)) then

				if iConditionLowerChanceFlatIncrease < 12 then
				--We have to reduce by 1, because the options array is 1-indexed
					oItem:setConditionLowerChance(iItemCurrentConditionLowerChance + iConditionLowerChanceFlatIncrease-1)
				elseif iConditionLowerChanceFlatIncrease == 12 then
					oItem:setConditionLowerChance(iItemCurrentConditionLowerChance + 15)
				elseif iConditionLowerChanceFlatIncrease == 13 then
					oItem:setConditionLowerChance(iItemCurrentConditionLowerChance + 20)
				elseif iConditionLowerChanceFlatIncrease == 14 then
					oItem:setConditionLowerChance(iItemCurrentConditionLowerChance + 25)
				end
			end
		end

		--print("Modified Max Condition: "..tostring(oItem:getConditionMax()))	
		--print("Modified Lower Chance: "..tostring(oItem:getConditionLowerChance()))

	else
		--print("Item is nil")
	end
end

function initDragonsSimpleWeaponDurabilityVariables()
	
	local tempAllItems = {}
	tempAllItems = ScriptManager.instance:getAllItems()
	
	--Go through list backwards from end to start, Java list is 0-indexed
	for iItemsCount=tempAllItems:size()-1, 0, -1 do
		--All items technically have durability stats, so we need to filter out all non-breakable items that by default have 1000000 ConditionLowerChance
		if tempAllItems:get(iItemsCount):getConditionLowerChance() ~= 1000000 then
			
			--print("iItemsCount"..tostring(iItemsCount))
			DRAALLITEMS:add(tempAllItems:get(iItemsCount))

		end	
	end
	
	--This debug can tell you how many items you save iterating over by doing this pre-filter on startup :D
	--print("Durability items list was reduced from: "..tostring(tempAllItems:size()).." -> "..tostring(DRAALLITEMS:size()))

end

	--DRAALLITEMS contains a globally available filtered list of items that we can use to reference the original values of each item, regardless of how many times we perform modification of the durabilities. This ensures that we never stack any durability additions. Pre-filtering the list of objects should also make it faster to iterate over.
	DRAALLITEMS = java.util.ArrayList:new()
	Events.OnGameBoot.Add(initDragonsSimpleWeaponDurabilityVariables)
	
	--We need to modify all items before the world is loaded, so we cannot use "OnGameStart", as that triggers after the world is loaded if continuing a saved game.
	Events.OnInitWorld.Add(ModifyALLItemCondition)	

		----------------------------------
		--	MULTI-PLAYER MODE			--
		--	LOCAL HOST = CLIENT	TRUE	--
		--	DEDICATED = SERVER TRUE		--
		--	SINGLE-PLAYER BOTH false	--
		----------------------------------
--if isServer() or isClient() then
--	print("MULTI-PLAYER ADD OPTIONS ON EVENT")
--else
--	print("SINGLE-PLAYER... USING MOD OPTIONS")
--end


