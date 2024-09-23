extends Node

var Alien = preload("res://cenas/alien.tscn")
var Bonus = preload("res://cenas/bonus.tscn")

@onready var timer_disparar = $TimerDisparar

var lista_aliens = []
var linhas = 4
var colunas = 8

var total_aliens = linhas * colunas
var contador_aliens = 0

func _ready():
	$TimerBonus.wait_time = randf_range(3.0, 20.0)
	$TimerBonus.start()
	for j in range(linhas):
		lista_aliens.append([])
		for i in range(colunas):
			var alien = Alien.instantiate()
			alien.global_position = Vector2(57+25*i,55+25*j)
			self.add_child(alien)
			lista_aliens[j].append(alien)
			alien.connect("alien_eliminado",Callable(self, "_on_alien_eliminado"))
			var parent_node = get_parent()
			alien.connect("alien_eliminado", Callable(parent_node, "_on_somar_pontos_alien"))


func _on_alien_eliminado(a):
	print("alien eliminado")
	for fila in lista_aliens:
		if a in fila:
			fila.erase(a)
			a.queue_free()
			contador_aliens += 1
			if contador_aliens == total_aliens:
				get_tree().change_scene_to_file("res://cenas/vitoria.tscn")
			break  

func _on_timer_descida_timeout():
	print("Descendo...")
	for fila in lista_aliens:
		for a in fila:
			if is_instance_valid(a):
				a.position.y +=17


func _on_timer_disparar_timeout() :
	var lista_aliens_vivos = []
	for fila in lista_aliens:
		for a in fila:
			if is_instance_valid(a) and !a.is_queued_for_deletion():
				lista_aliens_vivos.append(a)
				
	if lista_aliens_vivos:
		var indice = int(floor(randf_range(0,len(lista_aliens_vivos)-1)))
		lista_aliens_vivos[indice].disparar()
		timer_disparar.wait_time = randf_range(2,5)


func _on_timer_bonus_timeout():
	var bonus = Bonus.instantiate()
	self.add_child(bonus)
	bonus.connect("bonus_eliminado", Callable(get_parent(), "somar_bonus"))
