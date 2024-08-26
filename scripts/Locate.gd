extends Control

@onready var game_over_scrn = $PlayerPerspective/Camera2D/HUD/GameOverScreen
@onready var timer_cntr = $PlayerPerspective/Camera2D/HUD/TimerContainer

var questions_array = []
var chosen : Area2D
var arr_size : int
var qnum : int
var counters = {
	"score" : 0,
	"timer_max" : 60,
}

func _ready():
# Setup the timer 
	counters["score"] = 0
	counters["timer_max"] = Main.settings.timer_max
	timer_cntr.get_node("Timer").wait_time = counters.timer_max
	timer_cntr.get_node("Timer").start()
# Prepare the question
	for i in range(10):
		create_question()
	arr_size = questions_array.size() - 1
#Random number generator
	qnum = randi_range(0, arr_size)
	set_question(qnum)

func _input(event):
# Desktop controls for confirm and pause buttons
	if ($PlayerPerspective/Camera2D/HUD/PassAnswer.visible):
		if InputMap.event_is_action(event, "ui_accept"):
			_on_pass_answer_pressed()
	if InputMap.event_is_action(event, "ui_cancel"):
		$PlayerPerspective/Camera2D/HUD/PauseScreen._on_pause_btn_pressed()

func _process(_delta):
# Gameover condition if the timer stops
	if (timer_cntr.get_node("Timer").is_stopped()):
		game_over_scrn.get_node("VBoxContainer/CenterContainer/Label/FinalScore").parse_bbcode("[center]Final Score: " + str(counters.score))
		game_over_scrn.visible = true
		game_over_scrn.visible = true
	# Prevent other user input
		process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		game_over_scrn.process_mode = Node.PROCESS_MODE_ALWAYS
	else:
	# Updates the timer bar
		var percent = (timer_cntr.get_node("Timer").time_left / counters["timer_max"])
		timer_cntr.get_node("TimerBar").set_value_no_signal(100 * percent)

# Creates an array that contains the correct String answer, hint, question phrase
func create_question():
# The array is setup as "Answer", "Question/Hint", GameMode
# GameMode -> An int to setup the added phrase or instruction
	var results = []
# Set the answer
	var main_region = Main.regions.pick_random()
	results.append(main_region.fullname)
# Set the question
	var gamemode = 0
	if (Main.settings.question_mode == "regions") : 
		results.append(main_region.fullname)
	elif (Main.settings.question_mode == "random"):
		gamemode = randi_range(0,2)
		if (gamemode == 0):
			results.append(main_region.fullname)
		elif (gamemode == 1):
			results.append(main_region.center)
		else:
			results.append(main_region.number)
	results.append(gamemode)
	questions_array.append(results)

# Sets the question in the text nodes or prepares the question
func set_question(question_number):
	# Check if the questions are too few and load new ones
	if questions_array.size() <= 3:
		for i in range(10):
			create_question()
		arr_size = questions_array.size() - 1
	var instructions = $PlayerPerspective/Camera2D/HUD/TextContainer/Instructions
	var curr = questions_array[question_number]
	if (curr[2] == 0):
		instructions.parse_bbcode("[center] Where can you find this region : ")
	elif (curr[2] == 1):
		instructions.parse_bbcode("[center] Choose the region that has the regional center: ")
	elif (curr[2] == 2):
		instructions.parse_bbcode("[center] Which region is also known as : ")
	$PlayerPerspective/Camera2D/HUD/TextContainer/MainQuestion.parse_bbcode("[center]" + curr[1])

# Functions for gameover and pause
func _on_retry_button_pressed():
# Call deferred is necessary due to connection to "released" signal
	get_tree().call_deferred("reload_current_scene")

func _on_main_menu_button_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://scenes/MainMenu.tscn")

# Hides the pause menu and enables the root node process (allow inputs)
func _on_continue_button_pressed():
	var pause_scrn = $PlayerPerspective/Camera2D/HUD/PauseScreen
	if (pause_scrn.get_node("PauseElements").visible == true): 
		pause_scrn.get_node("PauseElements").visible = false
		pause_scrn.get_node("PauseBtn").visible = true
		process_mode = Node.PROCESS_MODE_ALWAYS
		pause_scrn.get_node("PauseElements/AudioStreamPlayer2D").stop()
	$PlayerPerspective/Camera2D/Pointer.position = Vector2(0,0)
	timer_cntr.process_mode = Node.PROCESS_MODE_INHERIT

# Sets the global variable "chosen" when the player moves the pinned location
func _on_character_body_2d_area_entered(area):
	$PlayerPerspective/Camera2D/HUD/PassAnswer.visible = not $PlayerPerspective/Camera2D/HUD/PassAnswer.visible
	chosen = area

# Remove the confirmation button when no area chosen
func _on_character_body_2d_area_exited(_area):
	$PlayerPerspective/Camera2D/HUD/PassAnswer.visible = false

# Checks if the selected area is the correct answeer
func _on_pass_answer_pressed():
#Variables used inside this function
	var question = $PlayerPerspective/Camera2D/HUD/TextContainer/MainQuestion
	var player_answer = chosen.name
	var correct_answer = questions_array[qnum][0]
#This is when the answer is correct
	if correct_answer == player_answer:
		question.parse_bbcode("[center] Correct")
		counters["score"] += 100
		$PlayerPerspective/Camera2D/HUD/TextContainer/Score.parse_bbcode("[center] Score: " + str(counters["score"]))
#This section is when it is wrong
	elif correct_answer != player_answer:
		question.parse_bbcode("[center] Wrong ")
		question.append_text("\n[b] You Chose: " + player_answer)
	else:
		print("Error input was not string")
# Restrict the player from moving while the answer is being checked
	var pointer = $PlayerPerspective/Camera2D/Pointer
	pointer.process_mode = Node.PROCESS_MODE_DISABLED
	$PlayerPerspective/Camera2D/HUD/PassAnswer.visible = false
	await get_tree().create_timer(1.0).timeout
	pointer.process_mode = Node.PROCESS_MODE_INHERIT
# Removes the question from the array to avoid repetition
	questions_array.pop_at(qnum)
	arr_size -= 1
#Randomises question
	qnum = randi_range(0, arr_size)
	set_question(qnum)
	
	

