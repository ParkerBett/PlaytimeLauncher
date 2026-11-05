extends Control

func _ready() -> void:
	if Global.disable_splash:
		get_tree().change_scene_to_file.call_deferred("res://scenes/main.tscn")
	else:
		$Video.autoplay = true


func _on_video_finished() -> void:
	await get_tree().create_timer(1.0).timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn")
