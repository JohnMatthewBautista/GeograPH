extends Control

# Functions for gameover and pause
func _on_retry_pressed():
	get_tree().reload_current_scene()

func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_continue_button_pressed():
	var pause_scrn = $PlayerPerspective/Camera2D/HUD/PauseScreen
	#if ($GameOverScreen.visible == true): 
	#	$GameOverScreen.visible = false
	if (pause_scrn.get_node("PauseElements").visible == true): 
		pause_scrn.get_node("PauseElements").visible = false
		pause_scrn.get_node("PauseBtn").visible = true
	$PlayerPerspective/Camera2D/HUD/TimerContainer/Timer.set_paused(0)
