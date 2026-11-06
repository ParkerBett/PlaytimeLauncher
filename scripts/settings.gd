extends Window

@onready var disable_splash_checkbox = $"Disable Splash"

@onready var chapter_1 = $"Chapters/Chapter 1"
@onready var chapter_2 = $"Chapters/Chapter 2"
@onready var chapter_3 = $"Chapters/Chapter 3"
@onready var chapter_4 = $"Chapters/Chapter 4"
@onready var chapter_5 = $"Chapters/Chapter 5"

@onready var chapter_1_file = $"Files/Chapter 1"
@onready var chapter_2_file = $"Files/Chapter 2"
@onready var chapter_3_file = $"Files/Chapter 3"
@onready var chapter_4_file = $"Files/Chapter 4"
@onready var chapter_5_file = $"Files/Chapter 5"

var config_data = Save.read("settings_config")

var settings_config: Dictionary = {
	"Disable Splash": false
}

var poppy_config: Dictionary = {
	"Chapter 1": "C:/Program Files (x86)/Steam/steamapps/common/Poppy Playtime/WindowsNoEditor/Poppy_Playtime/Binaries/Win64/Poppy_Playtime-Win64-Shipping.exe",
	"Chapter 2": "C:/Program Files (x86)/Steam/steamapps/common/Poppy Playtime/WindowsNoEditor/Playtime_Prototype4/Binaries/Win64/Playtime_Prototype4-Win64-Shipping.exe",
	"Chapter 3": "C:/Program Files (x86)/Steam/steamapps/common/Poppy Playtime/PoppyPlaytime_Chapter3/Playtime_Chapter3/Binaries/Win64/Playtime_Chapter3-Win64-Shipping.exe",
	"Chapter 4": "C:/Program Files (x86)/Steam/steamapps/common/Poppy Playtime/Playtime_Chapter4/ch4_pro/Binaries/Win64/ch4_pro-Win64-Shipping.exe",
	"Chapter 5": "C:/Program Files (x86)/Steam/steamapps/common/Poppy Playtime/Chapter5/ch5_pro/Binaries/Win64/ch5_pro-Win64-Shipping.exe",
	"PROJECT: PLAYTIME": "C:/Program Files (x86)/Steam/steamapps/common/PROJECT PLAYTIME/ProjectPlaytime.exe",
	"Escape from Playtime": "C:/Program Files (x86)/Steam/steamapps/common/Escape from Playtime/EscapeFromPlaytime.exe"
}

var disable_splash

func _ready() -> void:
	const SETTINGS_SLOT_NAME = "settings_config"
	
	if Save.has(SETTINGS_SLOT_NAME):
		var saved_data = Save.read(SETTINGS_SLOT_NAME)
		
		if saved_data is Dictionary:
			for key in saved_data:
				if settings_config.has(key):
					settings_config[key] = saved_data[key]
			print("Existing configuration found and loaded safely.")
	else:
		var success = Save.write(SETTINGS_SLOT_NAME, settings_config)
		if success:
			print("First-time setup complete: Default Settings written to disk.")
		else:
			print("Warning: Could not create the initial default save file.")
	
	if config_data != null:
		disable_splash = config_data.get("Disable Splash", false)
		
		print("\n--- Settings Configurations Loaded ---")
		if disable_splash != null: 
			print("Splash Disabled: ", disable_splash)
			disable_splash_checkbox.button_pressed = disable_splash

	else:
		print("Config save slot not found.")

func _on_close_requested() -> void:
	hide()

func _on_disable_splash_toggled(toggled_on: bool) -> void:
	const SETTINGS_SLOT_NAME = "settings_config"
	
	Global.disable_splash = toggled_on
	
	settings_config = {
		"Disable Splash": toggled_on
	}
	
	var success = Save.write(SETTINGS_SLOT_NAME, settings_config)
	if success:
		print("Save complete: Settings written to disk.")
	else:
		print("Warning: Could not create the save file.")


func _on_chapter_1_pressed() -> void:
	chapter_1_file.show()

func _on_chapter_1_file_selected(path: String) -> void:
	chapter_1_file.hide()

	var save_data = Save.read("poppy_playtime_config")

	if save_data == null:
		save_data = {}

	save_data["Chapter 1"] = path
	Save.write("poppy_playtime_config", save_data)
	
	Global.ch1_path = path
	
	
func _on_chapter_2_pressed() -> void:
	chapter_2_file.show()

func _on_chapter_2_file_selected(path: String) -> void:
	chapter_2_file.hide()

	var save_data = Save.read("poppy_playtime_config")

	if save_data == null:
		save_data = {}

	save_data["Chapter 3"] = path
	Save.write("poppy_playtime_config", save_data)
	
	Global.ch2_path = path


func _on_chapter_3_pressed() -> void:
	chapter_3_file.show()

func _on_chapter_3_file_selected(path: String) -> void:
	chapter_3_file.hide()

	var save_data = Save.read("poppy_playtime_config")

	if save_data == null:
		save_data = {}

	save_data["Chapter 3"] = path
	Save.write("poppy_playtime_config", save_data)
	
	Global.ch3_path = path
	
	
func _on_chapter_4_pressed() -> void:
	chapter_4_file.show()

func _on_chapter_4_file_selected(path: String) -> void:
	chapter_4_file.hide()

	var save_data = Save.read("poppy_playtime_config")

	if save_data == null:
		save_data = {}

	save_data["Chapter 4"] = path
	Save.write("poppy_playtime_config", save_data)
	
	Global.ch4_path = path


func _on_chapter_5_pressed() -> void:
	chapter_5_file.show()

func _on_chapter_5_file_selected(path: String) -> void:
	chapter_5_file.hide()

	var save_data = Save.read("poppy_playtime_config")

	if save_data == null:
		save_data = {}

	save_data["Chapter 5"] = path
	Save.write("poppy_playtime_config", save_data)
	
	Global.ch5_path = path
