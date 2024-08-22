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
	$AboutSection/Movement/Camera2D.position = Vector2(0,0)
	$AboutSection/Movement/Camera2D.enabled = true
	visible($"AboutSection", $"StartScreen")

func _on_back_btn_pressed():
	for i in get_children():
		i.visible = false
	$StartScreen.visible = true
	$Background.visible = true

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

func _on_info_pressed():
	$AboutSection/Movement/Camera2D/HUD/Panel.visible = not $AboutSection/Movement/Camera2D/HUD/Panel.visible

func _on_about_back_pressed():
	_on_back_btn_pressed()
	$AboutSection/Movement/Camera2D.enabled = false

func _on_check_released():
	$AboutSection/Map/RegionNames.visible = not $AboutSection/Map/RegionNames.visible

func click_check(map_name):
	var btn_texture = preload("res://resources/icons/check-icon.svg")
	var map_part = get_node("AboutSection/Map/" + map_name)
	var button_part = get_node("AboutSection/Movement/Camera2D/CheckBoxes/" + map_name)
	if (map_part.visible):
		btn_texture = preload("res://resources/icons/unchecked-icon.svg")
	map_part.visible = not map_part.visible
	button_part.texture_normal = btn_texture
