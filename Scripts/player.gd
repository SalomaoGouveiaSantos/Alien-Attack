extends CharacterBody2D

signal took_damage 

@export var moveSpeed:float = 10
@onready var rocket_container = $RocketContainer #get_node("RocketContainer")
@onready var rocket_shoot_sound = $RocketShootSound

var rocket_scene = preload("res://Scenes/rocket.tscn")
	
func _physics_process(delta):
	
	clamp_Screen_Size()
	handleMovement()
	shoot()
	
	pass
	
func handleMovement():
	
	var input = Vector2(0, 0)
	
	if(Input.is_action_pressed("move_right")):
		input.x += moveSpeed
	elif(Input.is_action_pressed("move_left")):
		input.x -= moveSpeed
	elif(Input.is_action_pressed("move_up")):
		input.y -= moveSpeed
	elif(Input.is_action_pressed("move_down")):
		input.y += moveSpeed
	else:
		return
	move_and_collide(input)
	pass
	
func clamp_Screen_Size():
	
	var screen_size = get_viewport_rect().size
	
	global_position =  global_position.clamp(Vector2(), screen_size)
	#global_position.x = clampf(global_position.x, 0, screen_size.x)
	#global_position.y = clampf(global_position.y, 0, screen_size.y)
	pass
	
func shoot():
	if(Input.is_action_just_pressed("shoot")):
		rocket_shoot_sound.play()
		var rocket_instance = rocket_scene.instantiate()
		rocket_container.add_child(rocket_instance)
		rocket_instance.global_position = global_position
		rocket_instance.global_position.x += 25
		
	pass
	
func take_damage():
	emit_signal("took_damage")
	pass
	
func die():
	queue_free()
	pass
