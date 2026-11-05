extends Control

var poppy_config: Dictionary = {
	"Chapter 1": "C:/Program Files (x86)/Steam/steamapps/common/Poppy Playtime/WindowsNoEditor/Poppy_Playtime.exe",
	"Chapter 2": "C:/Program Files (x86)/Steam/steamapps/common/Poppy Playtime/WindowsNoEditor/Playtime_Prototype4/Binaries/Win64/Playtime_Prototype4-Win64-Shipping.exe",
	"Chapter 3": "C:/Program Files (x86)/Steam/steamapps/common/Poppy Playtime/PoppyPlaytime_Chapter3/Playtime_Chapter3/Binaries/Win64/Playtime_Chapter3-Win64-Shipping.exe",
	"Chapter 4": "C:/Program Files (x86)/Steam/steamapps/common/Poppy Playtime/Playtime_Chapter4/ch4_pro/Binaries/Win64/ch4_pro-Win64-Shipping.exe",
	"Chapter 5": "C:/Program Files (x86)/Steam/steamapps/common/Poppy Playtime/Chapter5/ch5_pro/Binaries/Win64/ch5_pro-Win64-Shipping.exe",
	"PROJECT: PLAYTIME": "C:/Program Files (x86)/Steam/steamapps/common/PROJECT PLAYTIME/ProjectPlaytime.exe",
	"Escape from Playtime": "C:/Program Files (x86)/Steam/steamapps/common/Escape from Playtime/EscapeFromPlaytime.exe"
}

func _ready() -> void:
	const SLOT_NAME = "poppy_playtime_config"
	
	if Save.has(SLOT_NAME):
		var saved_data = Save.read(SLOT_NAME)
		
		if saved_data is Dictionary:
			for game_key in saved_data:
				if poppy_config.has(game_key):
					poppy_config[game_key] = saved_data[game_key]
			print("Existing configuration found and loaded safely.")
	else:
		var success = Save.write(SLOT_NAME, poppy_config)
		if success:
			print("First-time setup complete: Default Steam paths written to disk.")
		else:
			print("Warning: Could not create the initial default save file.")
