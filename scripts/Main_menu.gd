extends Control

func visible(a, b):
	a.visible = not a.visible
	b.visible = not b.visible

func _ready():
	pass # Replace with function body.

func _process(_delta):
	pass

func _on_new_game_pressed():
	visible($"NewGameSection", $"StartScreen")

func _on_settings_pressed():
	visible($"SettingsSection", $"StartScreen")

func _on_about_pressed():
	visible($"AboutSection", $"StartScreen")

func _on_back_btn_pressed():
	for i in get_children():
		i.visible = false
	$"StartScreen".visible = true
	$Background.visible = true

func _on_flashcards_pressed():
	get_tree().change_scene_to_file("res://scenes/FlashCards.tscn")
