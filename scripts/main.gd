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

var config_data = Save.read("poppy_playtime_config")

var transition_tween: Tween

var ch1_path
var ch2_path
var ch3_path
var ch4_path
var ch5_path
var escape_path
var project_path

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
	
	if config_data != null:
		ch1_path = config_data.get("Chapter 1", "")
		ch2_path = config_data.get("Chapter 2", "")
		ch3_path = config_data.get("Chapter 3", "")
		ch4_path = config_data.get("Chapter 4", "")
		ch5_path = config_data.get("Chapter 5", "")
		
		escape_path = config_data.get("Escape from Playtime", "")
		project_path = config_data.get("PROJECT: PLAYTIME", "")
		
		print("\n--- Individual Configurations Loaded ---")
		if ch1_path != "": print("Ch 1: ", ch1_path, check_executable(ch1_path))
		if ch2_path != "": print("Ch 2: ", ch2_path, check_executable(ch2_path))
		if ch3_path != "": print("Ch 3: ", ch3_path, check_executable(ch3_path))
		if ch4_path != "": print("Ch 4: ", ch4_path, check_executable(ch4_path))
		if ch5_path != "": print("Ch 5: ", ch5_path, check_executable(ch5_path))
		if escape_path != "": print("Escape from Playtime: ", escape_path, check_executable(escape_path))
		if project_path != "": print("Project - Playtime: ", project_path, check_executable(project_path))

	else:
		print("Config save slot not found.")


func check_executable(path):	
	if FileAccess.file_exists(path):
		return " Valid"
	else:
		return " Invalid"

func _process(_delta: float) -> void:
	match Global.selected:
		0:
			transition_texture(load("res://assets/backgrounds/main.webp"), 0.2)
		1:
			transition_texture(load("res://assets/backgrounds/chapter_1.png"), 0.2)
		2:
			transition_texture(load("res://assets/backgrounds/chapter_2.png"), 0.2)
		3:
			transition_texture(load("res://assets/backgrounds/chapter_3.png"), 0.2)
		4:
			transition_texture(load("res://assets/backgrounds/chapter_4.png"), 0.2)
		5:
			transition_texture(load("res://assets/backgrounds/chapter_5.png"), 0.2)


func transition_texture(new_texture: Texture2D, duration: float = 0.4):
	if $Background.texture == new_texture:
		return

	if transition_tween and transition_tween.is_valid():
		transition_tween.kill()

	for child in get_children():
		if child.name.begins_with("TempFadeClone_"):
			child.queue_free()

	var old_clone = TextureRect.new()
	old_clone.name = "TempFadeClone_" + str(Time.get_ticks_msec())
	old_clone.texture = $Background.texture

	old_clone.expand_mode = $Background.expand_mode
	old_clone.stretch_mode = $Background.stretch_mode
	old_clone.size = $Background.size
	old_clone.position = $Background.position
	
	add_child(old_clone)
	move_child(old_clone, $Background.get_index())

	$Background.texture = new_texture
	$Background.modulate.a = 0.0

	transition_tween = create_tween()
	transition_tween.set_parallel(true) 

	transition_tween.tween_property($Background, "modulate:a", 1.0, duration)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	transition_tween.tween_property(old_clone, "modulate:a", 0.0, duration)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)

	transition_tween.set_parallel(false)
	transition_tween.tween_callback(old_clone.queue_free)
