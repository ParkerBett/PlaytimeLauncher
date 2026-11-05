extends Control

#@export var texture: Texture2D
@export_range(-1, 5) var game: int = 1

var black_white = load("res://materials/black_white.tres")
var pressed = load("res://materials/pressed.tres")

func _ready() -> void:
	$Button.material = black_white
	
	match game:
		-1:
			print("Project Playtime")
			$Button.texture_normal = load("res://assets/banners/multiplayer/project_playtime.jpg")
		0:
			print("Escape from Playtime")
			$Button.texture_normal = load("res://assets/banners/multiplayer/escape_from_playtime.jpg")
		1:
			print("Chapter 1")
			$Button.texture_normal = load("res://assets/banners/chapter_1.jpg")
		2:
			print("Chapter 2")
			$Button.texture_normal = load("res://assets/banners/chapter_2.jpg")
		3:
			print("Chapter 3")
			$Button.texture_normal = load("res://assets/banners/chapter_3.jpg")
		4:
			print("Chapter 4")
			$Button.texture_normal = load("res://assets/banners/chapter_4.jpg")
		5:
			print("Chapter 5")
			$Button.texture_normal = load("res://assets/banners/chapter_5.jpg")

func _on_button_mouse_entered() -> void:
	$Button.material = null

func _on_button_mouse_exited() -> void:
	$Button.material = black_white

func _on_button_button_up() -> void:
	$Button.material = null

func _on_button_button_down() -> void:
	$Button.material = pressed
