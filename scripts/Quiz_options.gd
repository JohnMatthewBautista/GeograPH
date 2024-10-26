extends Control

var qnum = 0
var arr_size = 0
var questions_array = []
var counters = {
	"score" : 0,
	"timer_max" : 60,
}
# Paths used to iterate over the options much easier
var options_paths = ["OptionsButtons/OptionA/ButtonText","OptionsButtons/OptionB/ButtonText","OptionsButtons/OptionC/ButtonText","OptionsButtons/OptionD/ButtonText"]

func _ready():
# Setup the timer 
	counters["score"] = 0
	counters["timer_max"] = Main.settings.timer_max
	$TimerContainer/Timer.wait_time = counters.timer_max
	$TimerContainer/Timer.start()
# Creates the question at startup 
	for i in range(10):
		create_question()
	arr_size = questions_array.size() - 1
#Random number generator
	qnum = randi_range(0, arr_size)
	set_question(qnum)

# Pc controls connected to keyboard keys: 1,2,3,4 / a,b,c,d
func _input(event):
	# Connect to the options
	if ($OptionsButtons.visible):
		if InputMap.event_is_action(event, "a"):
			check_answer(1)
		elif InputMap.event_is_action(event, "b"):
			check_answer(2)
		elif InputMap.event_is_action(event, "c"):
			check_answer(3)
		elif InputMap.event_is_action(event, "d"):
			check_answer(4)
	# Connect to the pause button
	if InputMap.event_is_action(event, "ui_cancel"):
		$PauseScreen._on_pause_btn_pressed()

# Contains code for the timer control and gameover condition
func _process(_delta):
	if ($TimerContainer/Timer.is_stopped()):
		$GameOverScreen/VBoxContainer/CenterContainer/Label/FinalScore.parse_bbcode("[center]Final Score: " + str(counters.score))
		$GameOverScreen.visible = true
		# Prevent other user input while the gameover screen is open
		process_mode = Node.PROCESS_MODE_WHEN_PAUSED
		$GameOverScreen.process_mode = Node.PROCESS_MODE_ALWAYS
	else:
		# Update the timerbar
		var percent = ($TimerContainer/Timer.time_left / counters["timer_max"])
		$TimerContainer/TimerBar.set_value_no_signal(100 * percent)

# Creates the array that contains the question details, options, and correct answer
func create_question():
# The array is setup as  GameMode, "Question/Hint", (4) "Region Options", AnswerIndex
# GameMode -> An int to setup the added phrase or instruction
# AnswerIndex -> Index of the correct answer from 0 - 3
	var results = []
# Choose the correct answer
	var main_region = Main.regions.pick_random()
	for i in range(3):
		var curr = Region.rand_region_name(Main.regions)
		# Reiterate when same name
		while((curr == main_region.fullname) or (results.has(curr))):
			curr = Region.rand_region_name(Main.regions)
		results.append(curr)
# Randomise the options
	results.append(main_region.fullname)
	results.shuffle()
# Set the answer
	results.append(results.find(main_region.fullname) + 1)
# Set the question
	var gamemode = 0
	if (Main.settings.question_mode == "regions") : 
		results.push_front(main_region.rand_lgu())
	elif (Main.settings.question_mode == "random"):
		gamemode = randi_range(0,2)
		if (gamemode == 0):
			results.push_front(main_region.rand_lgu())
		elif (gamemode == 1):
			results.push_front(main_region.center)
		else:
			results.push_front(main_region.number)
	results.push_front(gamemode)
	questions_array.append(results)


# Changes the text nodes to set the question and options
func set_question(question_number):
	# Check if the questions are too few
	if questions_array.size() <= 3:
		for i in range(10):
			create_question()
		arr_size = questions_array.size() - 1
	var chosen = questions_array[question_number]
	var question = $TextContainer/MainQuestion
	var instructions = $TextContainer/Instructions
#Sets the main question
	if (chosen[0] == 0):
		instructions.parse_bbcode("[center] Where does this city or province belong to: ")
	elif (chosen[0] == 1):
		instructions.parse_bbcode("[center] Choose the region that has the regional center: ")
	elif (chosen[0] == 2):
		instructions.parse_bbcode("[center] Which region is also known as : ")
	question.parse_bbcode("[center]" + chosen[1])
#Iterates over the array and sets the options 
	var iter1 = 2
	for i in options_paths:
		var option = get_node(i)
		option.parse_bbcode("[center]" + chosen[iter1])
		if iter1 < 6: iter1 += 1

# Checks if the user's answer is correct
# Compares the chosen option with the correct_answer index value
func check_answer(answer_number):
	var question_number = qnum
# Prevent wrong index
	if question_number >= questions_array.size():
		print("Error Exceed Array Index")
#Variables used inside this function
	var question = $TextContainer/MainQuestion
	var correct_answer = questions_array[question_number][6]
#This is when the answer is correct
	if correct_answer == answer_number:
		question.parse_bbcode("[center] Correct")
		counters["score"] += 100
		$TextContainer/Score.parse_bbcode("[center] Score: " + str(counters["score"]))
#This section is when it is wrong
	elif correct_answer != answer_number:
		question.parse_bbcode("[center] Wrong ")
		question.append_text("\n[b] Answer: " + questions_array[question_number][correct_answer + 1])
	else:
		print("Error input was not string")
	# Hide the buttons
	$OptionsButtons.visible = false
	# Pause for 1 second before executing the next line of code
	await get_tree().create_timer(1.0).timeout
	# Removes the question from the array to avoid repetition
	questions_array.pop_at(question_number-1)
	arr_size -= 1
	#Randomises question
	qnum = randi_range(0,arr_size) 
	set_question(qnum)
	$OptionsButtons.visible = true

# Functions for gameover and pause
func _on_retry_button_pressed():
	get_tree().call_deferred("reload_current_scene")

func _on_main_menu_button_pressed():
	get_tree().call_deferred("change_scene_to_file", "res://scenes/MainMenu.tscn")

# Returns to the game and hides the pause screen
func _on_continue_button_pressed():
	if ($PauseScreen/PauseElements.visible == true): 
		$PauseScreen/PauseElements.visible = false
		$PauseScreen/PauseBtn.visible = true
		process_mode = Node.PROCESS_MODE_ALWAYS
		# Stop the audio in the pause screen
		$PauseScreen/PauseElements/AudioStreamPlayer2D.stop()
	$TimerContainer.process_mode = Node.PROCESS_MODE_INHERIT
