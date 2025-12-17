extends Panel

var card_data

func set_data(data):
	card_data = data
	$CardContent/title.text = data.name
	$CardContent/description.text = data.description
	
	# Update effects with separate emoji and value labels
	$CardContent/effects_container/money_effect/money_value.text = "%+d" % data.money
	$CardContent/effects_container/happiness_effect/happiness_value.text = "%+d" % data.happiness
	$CardContent/effects_container/social_effect/social_value.text = "%+d" % data.social
	$CardContent/effects_container/energy_effect/energy_value.text = "%+d" % data.energy
	
	# Apply blur effect if card is blurred
	if data.has("blur_type"):
		apply_blur(data.blur_type)

func apply_blur(blur_type = "both"):
	# Create blur effect
	var blur_material = ShaderMaterial.new()
	var blur_shader = preload("res://blur_effect.gdshader")
	blur_material.shader = blur_shader
	
	# Apply blur based on type
	if blur_type == "both":
		# Blur both description and effects
		$CardContent/description.material = blur_material
		# Blur all effect value labels
		$CardContent/effects_container/money_effect/money_value.material = blur_material
		$CardContent/effects_container/happiness_effect/happiness_value.material = blur_material
		$CardContent/effects_container/social_effect/social_value.material = blur_material
		$CardContent/effects_container/energy_effect/energy_value.material = blur_material
	elif blur_type == "effects":
		# Blur only effects, keep description clear
		$CardContent/effects_container/money_effect/money_value.material = blur_material
		$CardContent/effects_container/happiness_effect/happiness_value.material = blur_material
		$CardContent/effects_container/social_effect/social_value.material = blur_material
		$CardContent/effects_container/energy_effect/energy_value.material = blur_material
		$CardContent/description.material = null

func _on_choose_pressed():
	get_parent().get_parent().apply_card(card_data)
	queue_free()
