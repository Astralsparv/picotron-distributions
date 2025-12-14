--[[pod_format="raw",created="2025-12-13 23:16:24",modified="2025-12-14 00:39:06",revision=111]]
window{width=450,height=200,title="Picotron Distribution Installer"}	
notify("Ensure this is loaded and you run it with CTRL+R")

cls()
if (fstat("/distributions")) then --create a distro
	name=input("Create a distribution using your current /system.\n\nName: ")
	cp("/system","/distributions/"..name)
	default=input("Set this to default? [y/n]\n"):lower()
	if (default=="y") then
		store("/distributions/active.txt",name)
	end
	exit()
else
	r=input("This will convert Picotron to be distribution-based.\nThis is experimental.\n\nYour active /system folder will be used as the Picotron Distribution\n\n\nAre you ready? [y/n]\n"):lower()
	
	if (r=="y") then
		local startms=stat(987)
		print(stat(987)-startms.."ms creating distribution folder at /distributions")
		mkdir("/distributions")
		
		print(stat(987)-startms.."ms setting default distribution")
		store("/distributions/active.txt","picotron")
		
		print(stat(987)-startms.."ms installing bios")
		cp("bios","/distributions/bios")
		
		print(stat(987)-startms.."ms saving the picotron distribution")
		cp("/system","/distributions/picotron")
		
		print(stat(987)-startms.."ms adding the bios utility (terminal command)")
		cp("bios.lua","/distributions/picotron/util/bios.lua")
		
		print(stat(987)-startms.."ms patching your picotron distro's boot.lua")
		mv("/distributions/picotron/boot.lua","/distributions/picotron/custom_boot.lua")
		
		print(stat(987)-startms.."ms persisting your system")
		cp("/system","/system.")
		
		print(stat(987)-startms.."ms deleting your system")
		rm("/system")
		
		print(stat(987)-startms.."ms rebuilding your system")
		mkdir("/system")
		
		print(stat(987)-startms.."ms installing boot.lua")
		cp("boot.lua","/system/boot.lua")
		
		print(stat(987)-startms.."ms done! restarting to bios")
		store("/distributions/bootinto.txt","bios")
		
		--delay so that the user has time to process
		for i=1, 500 do flip() end
		
		send_message(2,{event="reboot"})
	else
		exit()
	end
end