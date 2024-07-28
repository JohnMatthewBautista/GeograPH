extends Control

var qnum = 0
var arr_size = 0
var questions_array = []
var counters = {
	"score" : 0
}
# Paths used to iterate over the options much easier
var options_paths = ["OptionsButtons/OptionA/ButtonText","OptionsButtons/OptionB/ButtonText","OptionsButtons/OptionC/ButtonText","OptionsButtons/OptionD/ButtonText"]

func create_question():
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
	results.shuffle()
	# Set the question
	var main_lgu = main_region.rand_lgu()
	results.push_front(main_lgu)
	# Set the answer
	results.append(main_region.fullname)
	results.append(results.find(main_region.fullname, 1))
	questions_array.append(results)

func _ready():
	counters["score"] = 0
	# Creates the question at startup 
	for i in range(10):
		create_question()
	arr_size = questions_array.size() - 1
	#Random number generator
	qnum = randi_range(0, arr_size)
	set_question(qnum)

func _process(_delta):
	if ($Timer.time_left <= 0):
		print("Times up")
		$OptionsButtons.visible = false
	else:
		print($Timer.time_left)

#Function that changes the label to start the question
func set_question(question_number):
	# Check if the questions are too few
	if questions_array.size() <= 3:
		for i in range(10):
			create_question()
		arr_size = questions_array.size() - 1
	var chosen = questions_array[question_number]
	var question = $TextContainer/Main_Question
#Sets the main question
	question.parse_bbcode("[center]" + chosen[0])
#Iterates over the array and sets the options 
	var iter1 = 1
	for i in options_paths:
		var option = get_node(i)
		option.parse_bbcode("[center]" + chosen[iter1])
		if iter1 < 6: iter1 += 1

#Checks the last letter on the questions_array (which is the correct answer) and changes the question text to "Correct" or "Wrong"
func check_answer(answer_number,question_number):
# Prevent wrong index
	if question_number >= questions_array.size():
		print("Error Exceed Array Index")
#Variables used inside this function
	var question = $TextContainer/Main_Question
	question.clear()
	var options_buttons = get_node("OptionsButtons")
	#This is for easier access of the variable
	var correct_answer = questions_array[question_number][5]
#This is when the answer is correct
	if  correct_answer == answer_number:
		question.clear()
		question.append_text("[center] Correct")
		counters["score"]  += 100
#This section is when it is wrong
	elif correct_answer != answer_number:
		question.clear()
		question.append_text("[center] Wrong")
		counters["score"]  -= 50
	else:
		print("Error input was not string")
	# Hide the buttons
	options_buttons.visible = not options_buttons.visible
	# Pause for 1 second before executing the next line of code
	await get_tree().create_timer(1.0).timeout
	# Removes the question from the array to avoid repetition
	questions_array.pop_at(question_number)
	arr_size -= 1
	#Randomises question
	qnum = randi_range(0,arr_size) 
	set_question(qnum)
	options_buttons.visible = not options_buttons.visible

func _on_OptionA_pressed():
	check_answer(1,qnum)

func _on_OptionB_pressed():
	check_answer(2,qnum)

func _on_OptionC_pressed():
	check_answer(3,qnum)

func _on_OptionD_pressed():
	check_answer(4,qnum)
