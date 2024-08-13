extends Control

@onready var game_over_scrn = $PlayerPerspective/Camera2D/HUD/GameOverScreen
@onready var timer_cntr = $PlayerPerspective/Camera2D/HUD/TimerContainer

var questions_array = []
var chosen : Area2D
var curr
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
	create_question()
	set_question()

func _process(_delta):
	if (timer_cntr.get_node("Timer").is_stopped()):
		game_over_scrn.get_node("GameOverTxt").parse_bbcode("[center] GAME OVER \n Final Score: " + str(counters.score))
		game_over_scrn.visible = true
	else:
		var percent = (timer_cntr.get_node("Timer").time_left / counters["timer_max"])
		timer_cntr.get_node("TimerBar").set_value_no_signal(100 * percent)

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
		gamemode = 0
		results.append(main_region.rand_lgu())
	elif (Main.settings.question_mode == "random"):
		gamemode = randi_range(0,2)
		if (gamemode == 0):
			results.append(main_region.rand_lgu())
		elif (gamemode == 1):
			results.append(main_region.center)
		else:
			results.append(main_region.number)
	results.append(gamemode)
	questions_array.append(results)

func set_question():
	curr = questions_array.pick_random()
	$PlayerPerspective/Camera2D/HUD/Question.parse_bbcode("[center]" + curr[0])

# Functions for gameover and pause
func _on_retry_pressed():
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_continue_button_pressed():
	var pause_scrn = $PlayerPerspective/Camera2D/HUD/PauseScreen
	if (game_over_scrn.visible == true): 
		game_over_scrn.visible = false
	if (pause_scrn.get_node("PauseElements").visible == true): 
		pause_scrn.get_node("PauseElements").visible = false
		pause_scrn.get_node("PauseBtn").visible = true
	$PlayerPerspective/Camera2D/Pointer.position = Vector2(0,0)
	timer_cntr.get_node("Timer").set_paused(0)

func _on_character_body_2d_area_entered(area):
	print("Enters: ", area)
	$PlayerPerspective/Camera2D/HUD/PassAnswer.visible = not $PlayerPerspective/Camera2D/HUD/PassAnswer.visible
	chosen = area

func _on_character_body_2d_area_exited(area):
	print("\nChanging: ", area)
	$PlayerPerspective/Camera2D/HUD/PassAnswer.visible = false

func _on_pass_answer_pressed():
	print("Your Answer: ", chosen.name)
	if (curr[0] == chosen.name):
		print("Correct")
	else:
		print("Wrong")
	
