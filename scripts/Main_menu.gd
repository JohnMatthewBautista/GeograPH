extends Control

func _ready():
	print("App Running")

func visible(a, b):
	a.visible = not a.visible
	b.visible = not b.visible

func _on_new_game_pressed():
	visible($"NewGameSection", $"StartScreen")

func _on_settings_pressed():
	visible($"SettingsSection", $"StartScreen")

func _on_about_pressed():
	visible($"AboutSection", $"StartScreen")

func _on_back_btn_pressed():
	for i in get_children():
		i.visible = false
	$StartScreen.visible = true
	$Background.visible = true

func apply_difficulty():
	print($NewGameSection/DifficultySelection.current_tab)
	match ($NewGameSection/DifficultySelection.current_tab):
		0:
			Main.settings.timer_max = 60
			Main.settings.question_mode = "regions"
		1:
			Main.settings.timer_max = 60
			Main.settings.question_mode = "random"
		2:
			Main.settings.timer_max = 30
			Main.settings.question_mode = "random"
		_:
			Main.settings.timer_max = 60
			Main.settings.question_mode = "regions"

func _on_flashcards_pressed():
	apply_difficulty()
	get_tree().change_scene_to_file("res://scenes/FlashCards.tscn")

func _on_locate_pressed():
	apply_difficulty()
	get_tree().change_scene_to_file("res://scenes/Locate.tscn")

func _on_enumeration_pressed():
	pass # Replace with function body.

# Helper function for easier increment and decrement of tabs in a tabcontainer
# Takes a parameter of 1 for increment and 0 for decrement
func change_tabs(node: TabContainer, change: int):
	var tab
	if (change <= 0):
		tab = node.get_tab_count() - 1 if node.current_tab <= 0 else node.current_tab - 1
	elif (change >= 1):
		tab = 0 if node.current_tab >= node.get_tab_count() - 1 else node.current_tab + 1
	node.current_tab = tab

func _on_prev_pressed():
	change_tabs($NewGameSection/LevelSelection, 0)

func _on_next_pressed():
	change_tabs($NewGameSection/LevelSelection, 1)

func _on_prev_2_pressed():
	change_tabs($NewGameSection/DifficultySelection, 0)

func _on_next_2_pressed():
	change_tabs($NewGameSection/DifficultySelection, 1)



