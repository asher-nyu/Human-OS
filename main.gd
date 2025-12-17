extends Node2D

var money = 100
var happiness = 100
var social = 100
var energy = 100

var current_stage = 1
var cards_played_this_stage = 0
var cards_per_stage = 6

var typing_text = ""
var typing_index = 0
var typing_card_data = null

func _ready():
	draw_cards()
	update_labels()

func update_labels():
	$StatsPanel/money_container/money_text.text = "Money: %d" % money
	$StatsPanel/happiness_container/happiness_text.text = "Happiness: %d" % happiness
	$StatsPanel/social_container/social_text.text = "Social: %d" % social
	$StatsPanel/energy_container/energy_text.text = "Energy: %d" % energy
	
	# Get stage name
	var stage_names = {
		1: "Young Adult",
		2: "Career Building",
		3: "Life Changes",
		4: "Mature Life"
	}
	var stage_name = stage_names.get(current_stage, "Unknown")
	$StatsPanel/stage.text = "Stage: %d (%d/%d cards)\n%s" % [current_stage, cards_played_this_stage, cards_per_stage, stage_name]


var cards = [
	# Stage 1: Young Adult (Early 20s) - Basic life skills, exploration, early career
	{"name": "Attend a Weekend Festival", "description": "You join friends for a music festival. Great vibes but exhausting!", "money": 0, "happiness": 10, "social": 15, "energy": -30, "stage": 1},
	{"name": "Take a Spontaneous Road Trip", "description": "You pack up and hit the road with friends. Adventure awaits but it costs money!", "money": -35, "happiness": 20, "social": 15, "energy": 0, "stage": 1},
	{"name": "Win a Local Sports Competition", "description": "You train hard and win your local tournament. Victory feels amazing and you get prize money!", "money": 35, "happiness": 25, "social": 15, "energy": -20, "stage": 1},
	{"name": "Buy a New Gadget", "description": "You splurge on the latest tech. It's exciting but expensive.", "money": -50, "happiness": 10, "social": 0, "energy": 0, "stage": 1},
	{"name": "Visit Family for a Holiday", "description": "You travel home to spend time with loved ones. Heartwarming but tiring.", "money": 0, "happiness": 10, "social": 20, "energy": -10, "stage": 1},
	{"name": "Start a New Fitness Routine", "description": "You commit to getting in shape. It's challenging but rewarding.", "money": 0, "happiness": 15, "social": 0, "energy": -10, "stage": 1},
	{"name": "Sign up for an Online Course", "description": "You enroll in a class to learn something new. Educational but time-consuming.", "money": -20, "happiness": 5, "social": 0, "energy": -10, "stage": 1},
	{"name": "Throw a Party for Friends", "description": "You host a gathering at your place. Everyone has fun but it's expensive and tiring.", "money": -25, "happiness": -5, "social": 35, "energy": -20, "stage": 1},
	{"name": "Get Stuck in Traffic for Hours", "description": "You're trapped in a massive traffic jam. Frustrating and draining.", "money": 0, "happiness": -10, "social": 0, "energy": -20, "stage": 1},
	{"name": "Upgrade Your Wardrobe", "description": "You go shopping for new clothes. You look great but it costs money.", "money": -40, "happiness": 15, "social": 0, "energy": 0, "stage": 1},
	{"name": "Take a Week Off Work for Personal Time", "description": "You use vacation days to focus on yourself. Relaxing but expensive and isolating.", "money": -50, "happiness": 25, "social": -10, "energy": 0, "stage": 1},
	{"name": "Help a Friend Move", "description": "You spend the day helping a friend relocate. Good deed but physically demanding.", "money": 0, "happiness": 0, "social": 15, "energy": -10, "stage": 1},
	{"name": "Go to Starbucks", "description": "You treat yourself to a coffee. Small pleasure with a small cost.", "money": -5, "happiness": 0, "social": 0, "energy": 10, "stage": 1},
	{"name": "Take a Sick Day to Rest", "description": "You call in sick and spend the day recovering at home. Sleep is healing.", "money": 0, "happiness": -5, "social": -10, "energy": 30, "stage": 1},
	{"name": "Go Axe Throwing with Friends", "description": "You try a new activity with friends. Fun but expensive and tiring.", "money": -10, "happiness": 15, "social": 25, "energy": -20, "stage": 1},
	{"name": "Do a New Hobby", "description": "You pick up a new creative hobby. Fulfilling but takes time and money.", "money": -10, "happiness": 15, "social": 0, "energy": -10, "stage": 1},
	{"name": "Pick Up Freelance Gig", "description": "You take on a small project for extra cash. Good money but stressful and isolating.", "money": 45, "happiness": -5, "social": -10, "energy": -15, "stage": 1},
	
	# Stage 2: Career Building (Mid-20s to 30s) - Work advancement, relationships, major decisions
	{"name": "Lose Job to AI", "description": "Your position gets automated away. It's tough, but you'll find something new.", "money": -40, "happiness": -20, "social": 0, "energy": 0, "stage": 2},
	{"name": "Start a Side Hustle", "description": "You take on extra work to earn more money. It's tiring but pays well.", "money": 50, "happiness": -20, "social": -10, "energy": -30, "stage": 2},
	{"name": "Volunteer for a Charity Event", "description": "You spend the day helping at a local charity. It feels good but takes effort.", "money": 0, "happiness": 10, "social": 25, "energy": -20, "stage": 2},
	{"name": "Go on a Dating Spree", "description": "You go on multiple dates to meet new people. Exciting but costly and draining.", "money": -30, "happiness": 15, "social": 25, "energy": -20, "stage": 2},
	{"name": "Unexpected Bill", "description": "An unexpected expense hits your budget. Just part of adult life.", "money": -15, "happiness": -10, "social": 0, "energy": 0, "stage": 2},
	{"name": "Get a Promotion at Work", "description": "You're promoted to a higher position. More money but more stress and less social time.", "money": 30, "happiness": -20, "social": -10, "energy": 0, "stage": 2},
	{"name": "Work Overtime", "description": "You put in extra hours at work. Good money but exhausting and stressful.", "money": 60, "happiness": -15, "social": -10, "energy": -30, "stage": 2},
	{"name": "Get a Demotion at Work", "description": "You're moved to a lower position. It's disappointing and affects your income.", "money": -30, "happiness": -10, "social": 0, "energy": 0, "stage": 2},
	{"name": "Quit Your Job", "description": "You leave your current job to pursue something better. Risky but liberating.", "money": -40, "happiness": 25, "social": 0, "energy": 20, "stage": 2},
	{"name": "Move to a New City", "description": "You relocate for a fresh start. Expensive but exciting and energizing.", "money": -40, "happiness": 25, "social": -20, "energy": 20, "stage": 2},
	{"name": "Divorce / Break Up", "description": "A major relationship ends. It's painful but you'll heal.", "money": -15, "happiness": -15, "social": -15, "energy": 0, "stage": 2},
	{"name": "Have a Child", "description": "You become a parent. It's joyful but expensive and exhausting.", "money": -20, "happiness": 15, "social": 10, "energy": -30, "stage": 2},
	{"name": "Join the Choir", "description": "You join a local singing group. It's uplifting and social but takes energy.", "money": 0, "happiness": 15, "social": 10, "energy": -10, "stage": 2},
	{"name": "Create Something You Want", "description": "You work on a personal creative project. Rewarding and potentially profitable.", "money": 40, "happiness": 5, "social": -5, "energy": -20, "stage": 2},
	{"name": "Meditation Retreat", "description": "You attend a peaceful retreat to recharge. More affordable than you thought!", "money": -40, "happiness": 25, "social": 0, "energy": 30, "stage": 2},
	{"name": "Get a Really Nice Gift", "description": "Someone gives you an expensive present. It's thoughtful and valuable.", "money": 35, "happiness": 5, "social": 5, "energy": 0, "stage": 2},
	{"name": "Call Off Work", "description": "You take an unplanned day off to rest. You feel better but lose some pay.", "money": -10, "happiness": 0, "social": -10, "energy": 30, "stage": 2},
	
	# Stage 3: Life Changes (30s-40s) - Established life, creative pursuits, community involvement
	{"name": "Have a Midlife Crisis", "description": "You question your life choices and feel lost about the future.", "money": 0, "happiness": -30, "social": 0, "energy": 0, "stage": 3},
	{"name": "Win City Scavenger Hunt Prize", "description": "You join a city-wide scavenger hunt, solve clues first, and win cash and a trophy!", "money": 40, "happiness": 15, "social": 10, "energy": -30, "stage": 3},
	{"name": "Rooftop Concert You Host", "description": "You rent sound gear and host a concert on your building roof. Everyone has fun!", "money": -30, "happiness": 20, "social": 20, "energy": -25, "stage": 3},
	{"name": "Weekend Freelance Rush Job", "description": "You get a big project that needs to be done fast. Good money but exhausting.", "money": 60, "happiness": -5, "social": -10, "energy": -35, "stage": 3},
	{"name": "Quiet Mountain Cabin Reset", "description": "You rent a cabin in the woods for a peaceful weekend. Calming and restorative.", "money": -50, "happiness": 15, "social": 0, "energy": 40, "stage": 3},
	{"name": "Backstage Pass and Afterparty", "description": "A friend gives you backstage access to a concert. Amazing but you get home late.", "money": -20, "happiness": 10, "social": 20, "energy": -30, "stage": 3},
	{"name": "Open Storm Shelter for Neighbors", "description": "A storm hits and you help neighbors find shelter. Heartwarming but tiring.", "money": -15, "happiness": 10, "social": 30, "energy": -30, "stage": 3},
	{"name": "Viral Sponsor Deal Lands", "description": "Something you post goes viral and a brand pays you for a sponsor deal!", "money": 50, "happiness": 5, "social": 25, "energy": -20, "stage": 3},
	{"name": "Midnight Train to Nearby Town", "description": "You take a late train to explore a nearby town. Quiet adventure and local food.", "money": -25, "happiness": 15, "social": 5, "energy": 10, "stage": 3},
	{"name": "Indie Film Extra for a Day", "description": "You volunteer to be an extra in a local movie. Fun and creative but tiring.", "money": 25, "happiness": 10, "social": 10, "energy": -10, "stage": 3},
	{"name": "Company Hackathon Win", "description": "You join a work coding contest and your team wins first place!", "money": 50, "happiness": 5, "social": 10, "energy": -35, "stage": 3},
	{"name": "Art Pop-up Booth Sells Out", "description": "You set up at an art fair and sell all your pieces. Great sales but exhausting.", "money": 60, "happiness": 10, "social": 10, "energy": -30, "stage": 3},
	{"name": "Sunrise Hot Spring Visit", "description": "You wake early and watch sunrise in a hot spring. Peaceful and restorative.", "money": -20, "happiness": 15, "social": 0, "energy": 25, "stage": 3},
	{"name": "Silent Retreat Day Pass", "description": "You spend a day at a silent retreat with no phones or talking. Mind-clearing.", "money": -40, "happiness": 15, "social": -15, "energy": 40, "stage": 3},
	{"name": "Rescue Stray Dog and Vet Check", "description": "You find a lost dog, take it to the vet, and help find its owner. Heartwarming.", "money": -20, "happiness": 15, "social": 10, "energy": -15, "stage": 3},
	{"name": "Host a Street Market on Your Block", "description": "You organize a market on your street. Great community event but tiring.", "money": 0, "happiness": 10, "social": 25, "energy": -10, "stage": 3},
	{"name": "Crowded City Weekend, No Rest", "description": "You skip your quiet plans for a busy city weekend. Overstimulating and draining.", "money": 30, "happiness": -35, "social": -10, "energy": -40, "stage": 3},
	
	# Stage 4: Mature Life (40s+) - Dealing with setbacks, different priorities, life complications
	{"name": "Rainout Fees and Plans Canceled", "description": "Your outdoor event gets rained out. You lose money but get unexpected rest.", "money": -40, "happiness": -30, "social": -20, "energy": 30, "stage": 4},
	{"name": "Noise Complaint Shuts Down Rooftop", "description": "Your rooftop show gets shut down early. A bummer, but you get home and actually sleep well.", "money": 30, "happiness": -15, "social": -10, "energy": 25, "stage": 4},
	{"name": "Client Cancels and You Refund", "description": "A client cancels your project and asks for a refund. Frustrating but you stay professional.", "money": -60, "happiness": -10, "social": 10, "energy": 35, "stage": 4},
	{"name": "VIP Event Canceled; Cozy Night In", "description": "A fancy event gets canceled. You embrace the quiet night, order takeout, and relax.", "money": 20, "happiness": 10, "social": -20, "energy": 30, "stage": 4},
	{"name": "Shelter Duties Passed to Others; You Rest Alone", "description": "You were going to help at a shelter but others take over. You rest at home.", "money": 15, "happiness": -20, "social": -40, "energy": 30, "stage": 4},
	{"name": "Sponsorship Pulled After Backlash", "description": "A company backs out of your deal after online drama. Disappointing but relieving.", "money": -70, "happiness": -20, "social": -40, "energy": 20, "stage": 4},
	{"name": "Last Train Canceled; Plans Fall Apart", "description": "You miss the last train home and your plans fall apart. Annoying but manageable.", "money": 25, "happiness": -25, "social": -10, "energy": -10, "stage": 4},
	{"name": "Film Day Cut; Self-Care Day", "description": "Your film shoot gets canceled. You turn it into a spa day at home - face masks and movies.", "money": -10, "happiness": 15, "social": -10, "energy": 20, "stage": 4},
	{"name": "Project Loss and Overtime Cut", "description": "Your work team loses a project and overtime stops. Less money but more sleep.", "money": -50, "happiness": -20, "social": -20, "energy": 35, "stage": 4},
	{"name": "Rain Ruins Your Booth Day", "description": "Heavy rain floods your market booth. You lose money but get rest.", "money": -60, "happiness": -25, "social": -20, "energy": 30, "stage": 4},
	{"name": "Mud Bath Mishap on Trip", "description": "Your spa trip goes wrong and you lose something valuable. Not what you planned.", "money": -20, "happiness": -15, "social": -5, "energy": 0, "stage": 4},
	{"name": "Noise-Filled Day, No Quiet Time", "description": "Your day is full of noise - sirens, drills, traffic. You can't rest or focus.", "money": 40, "happiness": -25, "social": 15, "energy": -40, "stage": 4},
	{"name": "Dog Adoption Falls Through; Peace and Quiet", "description": "Your dog adoption doesn't work out. Disappointing, but you appreciate the quiet time you have.", "money": 20, "happiness": -15, "social": -10, "energy": 20, "stage": 4},
	{"name": "Market Permit Denied; Catch Up on Sleep", "description": "The city denies your market permit. You use the free weekend to finally catch up on rest.", "money": 10, "happiness": -10, "social": -20, "energy": 20, "stage": 4},
	{"name": "Reconnect with Old Friend", "description": "You reach out to a friend you haven't seen in years. Meeting up brings back great memories!", "money": 0, "happiness": 25, "social": 25, "energy": -10, "stage": 4},
	{"name": "Finish Passion Project", "description": "You finally complete that project you've been working on for months. It feels amazing!", "money": 25, "happiness": 25, "social": 10, "energy": -20, "stage": 4},
	{"name": "Mentor a Young Person", "description": "You help guide someone starting their career. Giving back feels meaningful and rewarding.", "money": 0, "happiness": 20, "social": 20, "energy": -15, "stage": 4},
	{"name": "Home Improvement Success", "description": "You tackle that home project you've been putting off. Your space looks great now!", "money": -30, "happiness": 25, "social": 5, "energy": -10, "stage": 4}
]

func draw_cards():
	var stage_cards = []
	# Filter cards by current stage
	for card in cards:
		if card.stage == current_stage:
			stage_cards.append(card)
	
	var chosen = []
	while chosen.size() < 3 and stage_cards.size() > 0:
		var pick = stage_cards[randi() % stage_cards.size()]
		if pick not in chosen:
			chosen.append(pick)
	
	for card_data in chosen:
		var card = preload("res://card.tscn").instantiate()
		
		# Progressive blur system based on stage progress
		if cards_played_this_stage >= 4:
			# Choices 5-6: Both description and effects blurred
			card_data.blur_type = "both"
		elif cards_played_this_stage >= 2:
			# Choices 3-4: Only effects blurred
			card_data.blur_type = "effects"
		# Choices 1-2: No blur (normal cards)
		
		card.set_data(card_data)
		$card_container.add_child(card)
		
func apply_card(card):
	money += card.money
	happiness += card.happiness
	social += card.social
	energy += card.energy
	cards_played_this_stage += 1
	
	# Check for lose condition
	if check_lose_condition():
		clear_cards()
		show_lose_screen()
		return
	
	# Check if we should advance to next stage
	if cards_played_this_stage >= cards_per_stage:
		if current_stage < 4:
			current_stage += 1
			cards_played_this_stage = 0
			print("Advanced to Stage ", current_stage)
		else:
			# Completed all 4 stages - WIN!
			clear_cards()
			show_win_screen()
			return
	
	# Handle different blur types
	if card.has("blur_type"):
		if card.blur_type == "effects":
			clear_cards()
			show_reveal_screen(card)
			return
		elif card.blur_type == "both":
			clear_cards()
			start_typing_animation(card)
			return
	
	# Normal flow for unblurred cards
	update_labels()
	clear_cards()
	draw_cards()


func show_reveal_screen(card_data):
	$reveal_overlay.visible = true
	$reveal_overlay/reveal_panel/reveal_title.text = card_data.name
	# Update effects with separate emoji and value labels
	$reveal_overlay/reveal_panel/reveal_effects_container/money_effect/money_value.text = "%+d" % card_data.money
	$reveal_overlay/reveal_panel/reveal_effects_container/happiness_effect/happiness_value.text = "%+d" % card_data.happiness
	$reveal_overlay/reveal_panel/reveal_effects_container/social_effect/social_value.text = "%+d" % card_data.social
	$reveal_overlay/reveal_panel/reveal_effects_container/energy_effect/energy_value.text = "%+d" % card_data.energy
	
	# Auto-hide after 3 seconds
	$reveal_timer.start(1.0)

func hide_reveal_screen():
	$reveal_overlay.visible = false
	update_labels()
	clear_cards()
	draw_cards()

func _on_reveal_timer_timeout():
	hide_reveal_screen()

func start_typing_animation(card_data):
	typing_card_data = card_data
	typing_text = card_data.description
	typing_index = 0
	$typing_overlay.visible = true
	$typing_overlay/typing_panel/typing_text.text = ""
	$typing_timer.start()

func _on_typing_timer_timeout():
	if typing_index < typing_text.length():
		$typing_overlay/typing_panel/typing_text.text += typing_text[typing_index]
		typing_index += 1
		# Add blinking cursor
		#$typing_overlay/typing_panel/typing_text.text += "|"
		# Play typing sound (commented out until sound file is added)
		# $typing_sound.play()
	else:
		# Typing complete, remove cursor and show effects
		$typing_timer.stop()
		await get_tree().create_timer(2.0).timeout
		$typing_overlay.visible = false
		show_reveal_screen(typing_card_data)

func clear_cards():
	for card in $card_container.get_children():
		card.queue_free()


func check_lose_condition():
	# Check if any stat has gone negative
	if money < 0 or happiness < 0 or social < 0 or energy < 0:
		return true
	return false

func show_lose_screen():
	# Customize the lose message based on which stat(s) went negative
	var negative_stats = []
	if money < 0:
		negative_stats.append("Money")
	if happiness < 0:
		negative_stats.append("Happiness")
	if social < 0:
		negative_stats.append("Social")
	if energy < 0:
		negative_stats.append("Energy")
	
	var message = ""
	if negative_stats.size() > 1:
		message = negative_stats[0]
		for i in range(1, negative_stats.size()):
			if i == negative_stats.size() - 1:
				message += " and " + negative_stats[i]
			else:
				message += ", " + negative_stats[i]
		message += " dropped below zero!\nLife balance is everything."
	else:
		message = negative_stats[0] + " dropped below zero!\nLife balance is everything."
	
	# Load the lose screen scene
	var lose_scene = load("res://lose_screen.tscn").instantiate()
	lose_scene.set_lose_reason(message)
	get_tree().root.add_child(lose_scene)
	get_tree().current_scene = lose_scene
	queue_free()

func show_win_screen():
	# Update labels one final time to show the winning stats
	update_labels()
	
	# Load the win screen scene
	var win_scene = load("res://win_screen.tscn").instantiate()
	win_scene.set_final_stats({
		"money": money,
		"happiness": happiness,
		"social": social,
		"energy": energy
	})
	get_tree().root.add_child(win_scene)
	get_tree().current_scene = win_scene
	queue_free()
