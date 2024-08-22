extends Control
@onready var path = get_path_to(get_parent().find_child("Timer"))

func _on_pause_btn_pressed():
	get_node(path).set_paused(1)
	get_tree().current_scene.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	process_mode = Node.PROCESS_MODE_ALWAYS
	$PauseElements.visible = true
	$PauseBtn.visible = false
