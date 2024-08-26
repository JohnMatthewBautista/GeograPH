extends Control
# The timercontainer needs to be a sibling of this node
@onready var path = get_path_to(get_parent().find_child("TimerContainer"))

# Independent script connected to PauseScreen
# Stops the processes and reveals the pause screen
func _on_pause_btn_pressed():
	# Pause timer node
	get_node(path).process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	# Takes the root node and disable process there except this one
	get_tree().current_scene.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	process_mode = Node.PROCESS_MODE_ALWAYS
	$PauseElements.visible = true
	$PauseBtn.visible = false
	$PauseElements/AudioStreamPlayer2D.play()
