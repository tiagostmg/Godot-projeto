extends Node2D


func _on_botao_reiniciar_button_down():
	get_tree().change_scene_to_file("res://cenas/main.tscn")
