extends Control

#@export var texture: Texture2D
@export_range(-1, 5) var game: int = 1

var app_pid: int = -1

var config_data = Save.read("poppy_playtime_config")

var black_white = load("res://materials/black_white.tres")
var pressed = load("res://materials/pressed.tres")

var ch1_path
var ch2_path
var ch3_path
var ch4_path
var ch5_path
		
var escape_path
var project_path

func _ready() -> void:
	if config_data != null:
		ch1_path = config_data.get("Chapter 1", "")
		ch2_path = config_data.get("Chapter 2", "")
		ch3_path = config_data.get("Chapter 3", "")
		ch4_path = config_data.get("Chapter 4", "")
		ch5_path = config_data.get("Chapter 5", "")
		
		escape_path = config_data.get("Escape from Playtime", "")
		project_path = config_data.get("PROJECT: PLAYTIME", "")

		print("--- Individual Configurations Loaded ---")
		if ch1_path != "": print("Ch 1: ", ch1_path)
		if ch2_path != "": print("Ch 2: ", ch2_path)
		if ch3_path != "": print("Ch 3: ", ch3_path)
		if ch4_path != "": print("Ch 4: ", ch4_path)
		if ch5_path != "": print("Ch 5: ", ch5_path)
		if escape_path != "": print("Escape from Playtime: ", escape_path)
		if project_path != "": print("Project - Playtime: ", project_path)

	else:
		print("Config save slot not found.")
	
	$Button.material = black_white
	
	match game:
		-1:
			$Button.texture_normal = load("res://assets/banners/multiplayer/project_playtime.jpg")
		0:
			$Button.texture_normal = load("res://assets/banners/multiplayer/escape_from_playtime.jpg")
		1:
			$Button.texture_normal = load("res://assets/banners/chapter_1.jpg")
		2:
			$Button.texture_normal = load("res://assets/banners/chapter_2.png")
		3:
			$Button.texture_normal = load("res://assets/banners/chapter_3.jpg")
		4:
			$Button.texture_normal = load("res://assets/banners/chapter_4.jpg")
		5:
			$Button.texture_normal = load("res://assets/banners/chapter_5.jpg")

func _on_button_mouse_entered() -> void:
	$Button.material = null
	Global.selected = game

func _on_button_mouse_exited() -> void:
	$Button.material = black_white
	Global.selected = 0

func _on_button_button_up() -> void:
	$Button.material = null

func _on_button_button_down() -> void:
	$Button.material = pressed
	
	match game:
		-1:
			if project_path:
				open_application(project_path)
		0:
			if escape_path:
				open_application(escape_path)
		1:
			if ch1_path:
				open_application(ch1_path)
		2:
			if ch2_path:
				open_application(ch2_path)
		3:
			if ch3_path:
				open_application(ch3_path)
		4:
			if ch4_path:
				open_application(ch4_path)
		5:
			if ch5_path:
				open_application(ch5_path)

func open_application(executable_path, arguments: PackedStringArray = []):
	var absolute_path = ProjectSettings.globalize_path(executable_path)

	app_pid = OS.create_process(absolute_path, arguments)
	
	if app_pid > 0:
		print("Application successfully opened. Process ID: ", app_pid)
		get_tree().quit()
	else:
		print("Failed to open application. Check your file path.")


func _process(_delta: float):
	if app_pid > 0:
		if OS.is_process_running(app_pid):
			pass
		else:
			print("The Application has been Closed.")
			app_pid = -1 
