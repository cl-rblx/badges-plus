--[[
                                         
Scripted by C_L 
- https://github.com/cl-rblx
- https://www.roblox.com/users/728575063/profile            

Made for those who want a simple way of giving badges
                                        
--]]

local badgesPlus = {}
badgesPlus.__index = badgesPlus

local this = setmetatable({}, badgesPlus)
this.Service = game:GetService("BadgeService")

badgesPlus.playerHasBadge = function(player: Player, badgeId: number, outputResult: boolean?)
	local success, returnErr = pcall(function()
		return this.Service:UserHasBadgeAsync(player.UserId, badgeId) --> Return the result
	end)

	if not success then --> Some error occured
		return warn(string.format('[Badges+] Error checking player badges: %s', returnErr))
	end

	if outputResult then
		print(string.format('[Badges+] %s has badgeId %d', tostring(player.UserId), badgeId))
	end
end

badgesPlus.awardBadge = function(player: Player, badgeId: number, outputResult: boolean?)
	local success, returnErr = pcall(function()
		local hasBadge = badgesPlus.playerHasBadge(player, badgeId) --> Does [...] have badge?
		
		if hasBadge then
			if outputResult then
				print(string.format('[Badges+] UserId %s already has BadgeId %d', tostring(player.UserId), badgeId))
			else
				return false --> Did not award;
			end
		else
			this.Service:AwardBadge(player.UserId, badgeId) --> Attempt award badge;
		end
	end)
	
	if not success then
		return warn(string.format('[Badges+] Error giving badge to UserId %d, error: %s', player.UserId, returnErr))
	end

	if outputResult then
		print(string.format('[Badges+] Success! BadgeId %s awarded to UserId %d', tostring(badgeId), player.UserId))
	end
	
	return true --> Awarded badge;
end

badgesPlus.getBadgeInfo = function(badgeId: number, outputResult: boolean?)
	local info
	
	local success, returnErr = pcall(function()
		info = this.Service:GetBadgeInfoAsync(badgeId) --> Get data
	end)
	
	if not success then
		return warn(string.format('[Badges+] Error getting info for badge %s, error: %d', tostring(badgeId), returnErr))
	end
	
	if outputResult then
		print(string.format(
			'[Badges+] %s badge info ', 
			tostring(badgeId)
			--.. " Description = "..tostring(info.Description)
			--.. " IconImageId = "..tostring(info.IconImageId)
			--.. " IsEnabled = "..tostring(info.IsEnabled)
			--.. " Name = "..tostring(info.Name)
			))
		print(info) --> Print seperate from initial output
	end
	
	return info --> Return final data
end

return badgesPlus
