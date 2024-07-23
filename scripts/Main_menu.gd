extends Control

func visible(a, b):
	a.visible = not a.visible
	b.visible = not b.visible

func _ready():
	pass # Replace with function body.

func _process(delta):
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

func _on_flashcards_pressed():
	# This method allows the main control node and other children to remain while switching to a new scene
	var scene = preload("res://scenes/FlashCards.tscn").instantiate()
	get_parent().add_child(scene)
	get_parent().remove_child(self)
