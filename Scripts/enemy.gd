extends Area2D

@export var speed:int = 300

signal died

func _physics_process(delta):
	global_position.x -= speed * delta
	pass

func die():
	queue_free()
	emit_signal("died")
	pass


func _on_body_entered(body):
	body.take_damage()
	die()
	pass 
