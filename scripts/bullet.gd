extends RigidBody2D

func destroy() -> void:
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	destroy()

func _on_killzone_body_entered(body: Node2D) -> void:
	#print_debug(body.name)
	if body.name == "Hero": body.destroy()
