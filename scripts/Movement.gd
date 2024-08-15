extends Node2D

var events = {}
var last_drag_distance = 0
@onready var start: Vector2 = Vector2(position.x, position.y)

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			# This code moves the pin in the screen
			$Camera2D/Pointer.position = (event.position - start)
			start = Vector2(position.x, position.y)
			events[event.index] = event
		else:
			events.erase(event.index)
	if event is InputEventScreenDrag:
		# Leave and reset the pin's location
		$Camera2D/Pointer.position = events[event.index].position - start
		events[event.index] = event
		if events.size() == 1:
			# TODO: there is a bit of a weird behavior with the pin when reaching the borders	
			# Borders to prevent the camera going off screen
			var temp_pos = $Camera2D.position - event.relative.rotated(rotation)
			if (temp_pos.x >= 1700 || temp_pos.x <= -1700):
				return
			elif (temp_pos.y >= 4400 || temp_pos.y <= -750):
				return
			else:
				$Camera2D.position = temp_pos

# This part is reserved for pc controls, or migrate it into _input too
func _process(_delta):
	var cam_pos = $Camera2D.position
	if Input.is_action_pressed("ui_right"):
		cam_pos.x += 20
	if Input.is_action_pressed("ui_left"):
		cam_pos.x -= 20
	if Input.is_action_pressed("ui_down"):
		cam_pos.y += 20
	if Input.is_action_pressed("ui_up"):
		cam_pos.y -= 20
	$Camera2D.position = cam_pos



