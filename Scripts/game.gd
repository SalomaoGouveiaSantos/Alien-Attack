extends Node2D

@onready var player_scene = $Player
@onready var hud_scene = $UI/HUD
@onready var ui_scene = $UI

@onready var player_hit_sound = $PlayerHitSound
@onready var enemy_hit_sound = $EnemyHitSound

var game_over_scene = preload("res://Scenes/game_over_screen.tscn")

var lives = 3
var score = 0

func _ready():
	hud_scene.set_score_label(score)
	hud_scene.set_lives(lives)
	pass
func _on_death_zone_area_entered(area):
	area.queue_free()
	pass 


func _on_player_took_damage():
	lives -= 1
	player_hit_sound.play()
	hud_scene.set_lives(lives)
	if(lives == 0):
		print("game over")
		player_scene.die()
		
		await get_tree().create_timer(1.5).timeout
		
		var game_over_instance = game_over_scene.instantiate()
		game_over_instance.set_score(score)
		ui_scene.add_child(game_over_instance)
	pass 


func _on_enemy_spawner_enemy_spawned(enemy_instance):
	enemy_instance.connect("died", _on_enemy_died)
	add_child(enemy_instance)
	pass 

func _on_enemy_died():
	score += 100
	hud_scene.set_score_label(score)
	enemy_hit_sound.play()
	pass


func _on_enemy_spawner_path_enemy_spawned(path_enemy_instance):
	add_child(path_enemy_instance)
	path_enemy_instance.enemy.connect("died", _on_enemy_died)
	pass
