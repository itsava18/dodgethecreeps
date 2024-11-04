extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game
var gameScore

func show_message(text):
	$Message.text = text
	$Message.show()
	$HighScore.show()
	$MessageTimer.start()
	
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Dodge the Creeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
	
func update_score(score):
	$ScoreLabel.text = str(score)
	gameScore = score

	
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$Message.hide()

func _process(_delta):
	if Globals.highScore > gameScore:
		$HighScore.text = "High Score: " + str(Globals.highScore)
