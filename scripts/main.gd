extends Control

var poppy_config: Dictionary = {
	"Chapter 1": "C:/Program Files (x86)/Steam/steamapps/common/Poppy Playtime/WindowsNoEditor/Poppy_Playtime/Binaries/Win64/Poppy_Playtime-Win64-Shipping.exe",
	"Chapter 2": "C:/Program Files (x86)/Steam/steamapps/common/Poppy Playtime/WindowsNoEditor/Playtime_Prototype4/Binaries/Win64/Playtime_Prototype4-Win64-Shipping.exe",
	"Chapter 3": "C:/Program Files (x86)/Steam/steamapps/common/Poppy Playtime/PoppyPlaytime_Chapter3/Playtime_Chapter3/Binaries/Win64/Playtime_Chapter3-Win64-Shipping.exe",
	"Chapter 4": "C:/Program Files (x86)/Steam/steamapps/common/Poppy Playtime/Playtime_Chapter4/ch4_pro/Binaries/Win64/ch4_pro-Win64-Shipping.exe",
	"Chapter 5": "C:/Program Files (x86)/Steam/steamapps/common/Poppy Playtime/Chapter5/ch5_pro/Binaries/Win64/ch5_pro-Win64-Shipping.exe",
	"PROJECT: PLAYTIME": "C:/Program Files (x86)/Steam/steamapps/common/PROJECT PLAYTIME/ProjectPlaytime.exe",
	"Escape from Playtime": "C:/Program Files (x86)/Steam/steamapps/common/Escape from Playtime/EscapeFromPlaytime.exe"
}

var config_data = Save.read("poppy_playtime_config")

var in_chapters_section

var transition_tween: Tween

func _ready() -> void:
	const POPPY_SLOT_NAME = "poppy_playtime_config"
	
	if Save.has(POPPY_SLOT_NAME):
		var saved_data = Save.read(POPPY_SLOT_NAME)
		
		if saved_data is Dictionary:
			for game_key in saved_data:
				if poppy_config.has(game_key):
					poppy_config[game_key] = saved_data[game_key]
			print("Existing configuration found and loaded safely.")
	else:
		var success = Save.write(POPPY_SLOT_NAME, poppy_config)
		if success:
			print("First-time setup complete: Default Steam paths written to disk.")
		else:
			print("Warning: Could not create the initial default save file.")
	
	if config_data != null:
		Global.ch1_path = config_data.get("Chapter 1", "")
		Global.ch2_path = config_data.get("Chapter 2", "")
		Global.ch3_path = config_data.get("Chapter 3", "")
		Global.ch4_path = config_data.get("Chapter 4", "")
		Global.ch5_path = config_data.get("Chapter 5", "")
		
		Global.escape_path = config_data.get("Escape from Playtime", "")
		Global.project_path = config_data.get("PROJECT: PLAYTIME", "")
		
		print("/n--- Individual Configurations Loaded ---")
		if Global.ch1_path != "": print("Ch 1: ", Global.ch1_path, check_executable(Global.ch1_path))
		if Global.ch2_path != "": print("Ch 2: ", Global.ch2_path, check_executable(Global.ch2_path))
		if Global.ch3_path != "": print("Ch 3: ", Global.ch3_path, check_executable(Global.ch3_path))
		if Global.ch4_path != "": print("Ch 4: ", Global.ch4_path, check_executable(Global.ch4_path))
		if Global.ch5_path != "": print("Ch 5: ", Global.ch5_path, check_executable(Global.ch5_path))
		if Global.escape_path != "": print("Escape from Playtime: ", Global.escape_path, check_executable(Global.escape_path))
		if Global.project_path != "": print("Project - Playtime: ", Global.project_path, check_executable(Global.project_path))

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
			if !in_chapters_section:
				transition_texture(load("res://assets/backgrounds/main.webp"), 0.2)
			else:
				return
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


func _on_chapters_mouse_entered() -> void:
	in_chapters_section = true


func _on_chapters_mouse_exited() -> void:
	in_chapters_section = false
