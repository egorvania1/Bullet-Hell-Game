extends CharacterBody2D

const SPEED = 5000.0
const JUMP_VELOCITY = -400.0
const MAX_CHARGE = 10

signal hit
var charge = 0
@onready var chargebar = %AbilityChargeBar
@onready var anim = %AnimationPlayer

signal bullet_dodged
signal ability_used

var start_pos: Vector2

func _ready() -> void:
	start_pos = position

func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("left", "right", "up", "down")
	if (Input.is_action_just_pressed("ability")): use_ability()
	velocity = direction * SPEED * delta
	move_and_slide()

func spawn() -> void:
	position = start_pos
	show()
	$CollisionShape2D.set_deferred("disabled", false)

func destroy() -> void:
	hide()
	hit.emit()
	reset_charge()
	$CollisionShape2D.set_deferred("disabled", true)

func reset_charge() -> void:
	charge = 0
	chargebar.value = charge

func use_ability() -> void:
	if charge == MAX_CHARGE:
		ability_used.emit()
		reset_charge()
	#destroy bullets

func _on_dodgebox_body_entered(body: Node2D) -> void:
	if charge < MAX_CHARGE: charge += 1
	anim.play("dodge")
	chargebar.value = charge
	bullet_dodged.emit()
