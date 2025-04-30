extends Node2D
@onready var player = %Hero
var score = 0

@onready var bullet_scene = preload("res://scenes/bullet.tscn")

func _ready() -> void:
	player.ability_used.connect(_on_ability_used)
	player.bullet_dodged.connect(_on_bullet_dodged)

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
	
func reset_score() -> void:
	score = 0
	update_score()
	
func update_score() -> void:
	%GUI.update_score(score)
	
func _on_hero_hit() -> void:
	game_over()

func _on_gui_start() -> void:
	start_game()

func _on_ability_used() -> void:
	for bullet in get_tree().get_nodes_in_group("bullets"):
		score += 1
		bullet.destroy()
	update_score()

func _on_bullet_dodged() -> void:
	score += 1
	update_score()
