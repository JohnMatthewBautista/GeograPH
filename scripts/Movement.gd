extends Node2D

# Script based from https://kidscancode.org/godot_recipes/3.x/2d/touchscreen_camera/index.html
var events = {}
var last_drag_distance = 0
@onready var start: Vector2 = Vector2(position.x, position.y)

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			# This code moves the pin in the screen
			$Camera2D/Pointer.position = (event.position - start)
			# Make it adjust with screen size
			$Camera2D/Pointer.position -= get_tree().current_scene.position
			start = Vector2(position.x, position.y)
			events[event.index] = event
		else:
			events.erase(event.index)
	if event is InputEventScreenDrag:
		# Leave and reset the pin's location
		$Camera2D/Pointer.position = events[event.index].position - start
		$Camera2D/Pointer.position -= get_tree().current_scene.position
		events[event.index] = event
		if events.size() == 1:
			# Borders to prevent the camera going off screen
			var temp_pos = $Camera2D.position - event.relative.rotated(rotation)
			if (temp_pos.x >= 1700 || temp_pos.x <= -1700):
				return
			elif (temp_pos.y >= 4400 || temp_pos.y <= -750):
				return
			else:
				$Camera2D.position = temp_pos

# This part is reserved for pc controls
func _process(_delta):
	var cam_pos = $Camera2D.position
	if Input.is_action_pressed("ui_right"):
		$Camera2D/Pointer.position = Vector2(0,0)
		cam_pos.x += 20
	if Input.is_action_pressed("ui_left"):
		$Camera2D/Pointer.position = Vector2(0,0)
		cam_pos.x -= 20
	if Input.is_action_pressed("ui_down"):
		$Camera2D/Pointer.position = Vector2(0,0)
		cam_pos.y += 20
	if Input.is_action_pressed("ui_up"):
		$Camera2D/Pointer.position = Vector2(0,0)
		cam_pos.y -= 20
	# Same borders to prevent off bounds
	if (cam_pos.x >= 1700 || cam_pos.x <= -1700):
		return
	elif (cam_pos.y >= 4400 || cam_pos.y <= -750):
		return
	else:
		$Camera2D.position = cam_pos



