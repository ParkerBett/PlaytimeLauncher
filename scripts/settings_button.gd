extends Control


var black_white = load("res://materials/black_white.tres")
var pressed = load("res://materials/pressed.tres")

func _ready() -> void:
	$Button.material = black_white


func _on_button_mouse_entered() -> void:
	$Button.material = null

func _on_button_mouse_exited() -> void:
	$Button.material = black_white
	Global.selected = 0

func _on_button_button_up() -> void:
	$Button.material = null

func _on_button_button_down() -> void:
	$Button.material = pressed
	$Settings.visible = !$Settings.visible
