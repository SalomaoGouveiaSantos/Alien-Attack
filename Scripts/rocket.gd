extends Area2D

@export var speed:int = 500
@onready var visible_notifier = $VisibleNotifier

func _ready():
	visible_notifier.connect("screen_exited", _on_screen_exited)
	pass
func _physics_process(delta):
	global_position.x += speed * delta
	pass
	
func _on_screen_exited():
	queue_free()
	pass

func _on_area_entered(area):
	
	queue_free()
	area.die()
	pass 
