extends Node

var pontos = 0
@onready var label_pontos = $VBoxContainer/LabelPontos

func _on_somar_pontos_alien():
	pontos += 100
	label_pontos.text = str(pontos)    
	print("Sinal alien_eliminado recebido!")	


func somar_bonus():
	pontos += 500
	label_pontos.text = str(pontos)



func _on_loop_1_sec_timeout():
	$Loop1sec.start()
	var time_left = $TempoJogo.time_left
	if time_left:
		$Tempo.text = str(int(time_left))
	#$Tempo.text = $TempoJogo.time_left.as_string() 	
	
func _on_tempo_jogo_timeout():
	get_tree().change_scene_to_file("res://cenas/game_over.tscn")
