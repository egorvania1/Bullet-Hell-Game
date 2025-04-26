extends CharacterBody2D

const SPEED = 5000.0
const JUMP_VELOCITY = -400.0
signal hit

var start_pos: Vector2

func _ready() -> void:
	start_pos = position

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	velocity = direction * SPEED * delta
	move_and_slide()

func spawn() -> void:
	position = start_pos
	show()
	$CollisionShape2D.set_deferred("disabled", false)

func destroy() -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)
