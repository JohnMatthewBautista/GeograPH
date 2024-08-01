extends Control
var path

func _ready():
	var node = get_parent().find_child("Timer")
	path = get_path_to(node)

func _on_pause_btn_pressed():
	get_node(path).set_paused(1)
	$PauseElements.visible = true
	$PauseBtn.visible = false
