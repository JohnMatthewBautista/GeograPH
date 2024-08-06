extends Control

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

func _on_flashcards_pressed():
	get_tree().change_scene_to_file("res://scenes/FlashCards.tscn")

func _on_enumeration_pressed():
	pass # Replace with function body.

# Functions for level select
func _on_prev_pressed():
	var lvl = $NewGameSection/LevelSelection
	var tab = lvl.get_tab_count() - 1 if lvl.current_tab <= 0 else lvl.current_tab - 1
	lvl.current_tab = tab

func _on_next_pressed():
	var lvl = $NewGameSection/LevelSelection
	var tab = 0 if lvl.current_tab >= lvl.get_tab_count() - 1 else lvl.current_tab + 1
	lvl.current_tab = tab
