extends CharacterBody2D

signal bonus_eliminado
var velocidade = 50

func _process(delta):
	position.x -= velocidade * delta

#func _on_animated_sprite_2d_animation_finished(anim_name):

func explosion():
	$AnimatedSprite2D.play("morte")
	$AnimatedSprite2D.connect("animation_finished", Callable(self, "_on_AnimationFinished"))

func _on_AnimationFinished():
	if $AnimatedSprite2D.animation == "morte":
		emit_signal("bonus_eliminado")
		queue_free()
