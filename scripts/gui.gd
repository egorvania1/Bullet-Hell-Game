extends CanvasLayer

signal start

func update_score(score: int) -> void:
	%ScoreLabel.text = str(score)
	
func start_game() -> void:
	%ScoreLabel.text = "0"
	%StartButton.visible = false
	start.emit()
	
func game_over() -> void:
	%StartButton.visible = true

func _on_start_button_pressed() -> void:
	start_game()
