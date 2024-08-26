extends Control

# Local function to efficiently switch visibility
func visible(a, b):
	a.visible = not a.visible
	b.visible = not b.visible

# Navigation buttons
func _on_new_game_pressed():
	visible($"NewGameSection", $"StartScreen")

func _on_credits_pressed():
	visible($CreditsSection, $"StartScreen")

# Activates the camera2d on MapSection to allow roaming around
func _on_map_pressed():
	$MapSection/Movement/Camera2D.position = Vector2(0,0)
	$MapSection/Movement/Camera2D.enabled = true
	$MapSection/Movement.process_mode = Node.PROCESS_MODE_INHERIT
	$AudioStreamPlayer2D.stop()
	visible($"MapSection", $"StartScreen")

# Universal back button to return to the StartScreen
func _on_back_btn_pressed():
	for i in get_children():
		i.visible = false
	$StartScreen.visible = true
	$Background.visible = true
	$MapSection/Movement.process_mode = Node.PROCESS_MODE_WHEN_PAUSED

# Sets the global variables according to the difficulty
func apply_difficulty():
	match ($NewGameSection/DifficultySelection.current_tab):
		0:
			Main.settings.timer_max = 60
			Main.settings.question_mode = "regions"
		1:
			Main.settings.timer_max = 60
			Main.settings.question_mode = "random"
		_:
			Main.settings.timer_max = 60
			Main.settings.question_mode = "regions"

# Changes the scene and starts the game
func _on_start_pressed():
	apply_difficulty()
	if ($NewGameSection/LevelSelection.current_tab == 0):
		get_tree().change_scene_to_file("res://scenes/FlashCards.tscn")
	elif ($NewGameSection/LevelSelection.current_tab == 1):
		get_tree().change_scene_to_file("res://scenes/Locate.tscn")

# Helper function for easier increment and decrement of tabs in a tabcontainer
# Takes a parameter of 1 for increment and 0 for decrement
func change_tabs(node_path: String, change: int):
	var node = get_node("NewGameSection/" + node_path)
	var tab
	if (change <= 0):
		tab = node.get_tab_count() - 1 if node.current_tab <= 0 else node.current_tab - 1
	elif (change >= 1):
		tab = 0 if node.current_tab >= node.get_tab_count() - 1 else node.current_tab + 1
	node.current_tab = tab

# Custom backbutton that disables the camera2d in the MapSection
func _on_map_back_pressed():
	_on_back_btn_pressed()
	$MapSection/Movement/Camera2D/AudioStreamPlayer2D.stop()
	$AudioStreamPlayer2D.play()
	$MapSection/Movement/Camera2D.enabled = false

 # Changes the texture to create a checkbox effect and toggle parts of the map
func click_check(map_name):
	var btn_texture = preload("res://resources/icons/check-icon.svg")
	var map_part = get_node("MapSection/Map/" + map_name)
	var button_part = get_node("MapSection/Movement/Camera2D/CheckBoxes/" + map_name)
	if (map_part.visible):
		btn_texture = preload("res://resources/icons/unchecked-icon.svg")
	map_part.visible = not map_part.visible
	button_part.texture_normal = btn_texture
