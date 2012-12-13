--resource
local function AddDir(dir) --copypasta from gmod wiki.
	local list = file.FindDir("../"..dir.."/*")
	for _, fdir in pairs(list) do
		if fdir ~= ".svn" then
			AddDir(dir.."/"..fdir)
		end
	end
 
	for k,v in pairs(file.Find("../"..dir.."/*")) do
		if v and  v ~= "" then 
			local d = string.gsub(dir,"gamemodes/JailBreak/content/","");
			resource.AddSingleFile(d.."/"..v)
		end
	end
end
 
AddDir("gamemodes/JailBreak/content")
