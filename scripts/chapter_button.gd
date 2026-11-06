extends Control

#@export var texture: Texture2D
@export_range(-1, 5) var game: int = 1

var app_pid: int = -1

var config_data = Save.read("poppy_playtime_config")

var black_white = load("res://materials/black_white.tres")
var pressed = load("res://materials/pressed.tres")

func _ready() -> void:
	$Button.material = black_white
	
	match game:
		-1:
			#$Button.texture_normal = load("res://assets/banners/multiplayer/project_playtime.jpg")
			return
		0:
			#$Button.texture_normal = load("res://assets/banners/multiplayer/escape_from_playtime.jpg")
			return
		1:
			$Button.texture_normal = load("res://assets/banners/chapter_1.jpg")
		2:
			$Button.texture_normal = load("res://assets/banners/chapter_2.jpg")
		3:
			$Button.texture_normal = load("res://assets/banners/chapter_3.png")
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
			if Global.project_path:
				open_application(Global.project_path)
		0:
			if Global.escape_path:
				open_application(Global.escape_path)
		1:
			if Global.ch1_path:
				open_application(Global.ch1_path)
		2:
			if Global.ch2_path:
				open_application(Global.ch2_path)
		3:
			if Global.ch3_path:
				open_application(Global.ch3_path)
		4:
			if Global.ch4_path:
				open_application(Global.ch4_path)
		5:
			if Global.ch5_path:
				open_application(Global.ch5_path)

func open_application(executable_path, arguments: PackedStringArray = []):
	var absolute_path = ProjectSettings.globalize_path(executable_path)

	app_pid = OS.create_process(absolute_path, arguments)
	
	if app_pid > 0:
		print("Application successfully opened. Process ID: ", app_pid)
		#get_tree().quit()
	else:
		print("Failed to open application. Check your file path.")

func _process(_delta: float):
	if app_pid > 0:
		if OS.is_process_running(app_pid):
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MINIMIZED)
		else:
			print("The Application has been Closed.")
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			app_pid = -1 
