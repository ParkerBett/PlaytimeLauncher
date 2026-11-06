extends Control

func _ready() -> void:
	const SETTINGS_SLOT_NAME = "settings_config"
	var saved_data = Save.read(SETTINGS_SLOT_NAME)
	
	Global.disable_splash = saved_data.get("Disable Splash", false)
	
	if Global.disable_splash:
		get_tree().change_scene_to_file.call_deferred("res://scenes/main.tscn")
	else:
		$Video.paused = false


func _on_video_finished() -> void:
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn")
