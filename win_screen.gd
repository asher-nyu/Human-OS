extends Control

var final_stats = {"money": 0, "happiness": 0, "social": 0, "energy": 0}

func _ready():
	if final_stats:
		update_stats_display()

func set_final_stats(stats: Dictionary):
	final_stats = stats
	if is_node_ready():
		update_stats_display()

func update_stats_display():
	$Panel/stats_container/money_stat/money_text.text = "Money: %d" % final_stats.money
	$Panel/stats_container/happiness_stat/happiness_text.text = "Happiness: %d" % final_stats.happiness
	$Panel/stats_container/social_stat/social_text.text = "Social: %d" % final_stats.social
	$Panel/stats_container/energy_stat/energy_text.text = "Energy: %d" % final_stats.energy

func _on_restart_button_pressed():
	# Return to main game scene
	get_tree().change_scene_to_file("res://main.tscn")

func _on_quit_button_pressed():
	# Quit the game
	get_tree().quit()
