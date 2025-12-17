extends Control

var lose_reason = ""

func _ready():
	if lose_reason != "":
		$Panel/lose_message.text = lose_reason

func set_lose_reason(reason: String):
	lose_reason = reason
	if is_node_ready():
		$Panel/lose_message.text = reason

func _on_restart_button_pressed():
	# Return to main game scene
	get_tree().change_scene_to_file("res://main.tscn")

func _on_quit_button_pressed():
	# Quit the game
	get_tree().quit()
