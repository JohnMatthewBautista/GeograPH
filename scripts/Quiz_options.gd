extends Control

# Called when the node enters the scene tree for the first time.
var qnum = 0
var arr_size

var global_variables = {
	"answered" : 0,
	"score" : 0,
	"questions_array" : [
		["This essential gas is important so that we can breath.","Oxygen","Helium","Nitrogen","Carbon Dioxide","A"],
		["What is the nearest planet to the sun","Pluto","Earth","Mercury","Uranus","C"],
	]
}
# Paths used to iterate over the options much easier
var options_paths = ["OptionsButtons/OptionA/ButtonText","OptionsButtons/OptionB/ButtonText","OptionsButtons/OptionC/ButtonText","OptionsButtons/OptionD/ButtonText"]

func _ready():
	global_variables["answered"] = 0
	global_variables["score"] = 0
	#Random number generator
	arr_size = global_variables["questions_array"].size() - 1
	qnum = randi_range(0, arr_size)
	print(Main.regions["NCR"][1])
	set_question(qnum)

#Function that changes the label to start the question
func set_question(question_number):
	# Statement if the array is empty
	if global_variables["questions_array"].size() == 0:
		print("Error Array Empty")
		var scene = preload("res://scenes/MainMenu.tscn").instantiate()
		get_parent().add_child(scene)
		get_parent().remove_child(self)
		return
	var chosen = global_variables["questions_array"][question_number]
	var question = $Main_Question
#Sets the main question
	question.clear()
	question.append_text("[color=black][center]" + chosen[0])
#Iterates over the array and sets the options 
	var iter1 = 1
	for i in options_paths:
		var option = get_node(i)
		option.clear()
		option.append_text("[color=black][center]" + chosen[iter1])
		if iter1 < 6: iter1 += 1


#Checks the last letter on the questions_array (which is the correct answer) and changes the question text to "Correct" or "Wrong"
func check_answer(answer_letter,question_number):
# Prevent wrong index
	if question_number >= global_variables["questions_array"].size():
		print("Error Exceed Array Index")
		return

#Variables used inside this function
	var question = $Main_Question
	question.clear()
	var options_buttons = get_node("OptionsButtons")
	qnum = randi_range(0,global_variables["questions_array"].size() - 1) #Randomises question
	#This is for easier access of the variable
	var correct_answer = global_variables["questions_array"][question_number][5]
#This is when the answer is correct
	if  correct_answer == answer_letter:
		question.clear()
		question.append_text("[center] Correct")
		print("Correct")
		global_variables["score"]  += 100
		# Removes the question from the array to avoid repetition
		global_variables["questions_array"].pop_at(question_number)
		arr_size -= 1
		# Hide the buttons
		options_buttons.visible = not options_buttons.visible		
		# Pause for 1 second before executing the next line of code
		await get_tree().create_timer(1.0).timeout
		qnum = randi_range(0, arr_size)
		set_question(qnum)
		options_buttons.visible = not options_buttons.visible
#This section is when it is wrong
	elif correct_answer != answer_letter:
		question.clear()
		question.append_text("[center] Wrong")
		global_variables["score"]  -= 50
		print("Wrong")
		options_buttons.visible = not options_buttons.visible
		await get_tree().create_timer(1.0).timeout
		qnum = randi_range(0,arr_size)
		set_question(qnum)
		options_buttons.visible = not options_buttons.visible
	else:
		print("Error input was not string")

func _on_OptionA_pressed():
	check_answer("A",qnum)

func _on_OptionB_pressed():
	check_answer("B",qnum)

func _on_OptionC_pressed():
	check_answer("C",qnum)

func _on_OptionD_pressed():
	check_answer("D",qnum)
