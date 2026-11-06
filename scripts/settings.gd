extends Window

@onready var disable_splash_checkbox = $"Disable Splash"

var config_data = Save.read("settings_config")

var settings_config: Dictionary = {
	"Disable Splash": false
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
