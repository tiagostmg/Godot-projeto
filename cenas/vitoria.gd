extends Node2D


func _on_botao_recomecar_button_down() -> void:
	get_tree().change_scene_to_file("res://cenas/main.tscn")
