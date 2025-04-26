extends Node2D

@onready var bullet_scene = preload("res://scenes/bullet.tscn")

func _on_bullet_timer_timeout() -> void:
	spawn_bullet()

func spawn_bullet() -> void:
	var bullet = bullet_scene.instantiate()
	
	var bullet_spawn_point = %BulletPath/BulletPathSpawn
	bullet_spawn_point.progress_ratio = randf()
	
	bullet.position = bullet_spawn_point.position
	var direction = bullet_spawn_point.rotation + PI/2
	
	direction += randf_range(-PI / 4, PI / 4)
	bullet.rotation = direction
	
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	bullet.linear_velocity = velocity.rotated(direction)
	
	add_child(bullet)
	
func game_over() -> void:
	%GUI.game_over()
	%BulletTimer.stop()
	
func start_game() -> void:
	%Hero.spawn()
	%BulletTimer.start()
	
func _on_hero_hit() -> void:
	game_over()

func _on_gui_start() -> void:
	start_game()
