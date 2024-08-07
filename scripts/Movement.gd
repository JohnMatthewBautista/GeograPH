extends Node2D

@export var speed = 1000 # How fast the player will move (pixels/sec).
@onready var screen_size = get_viewport_rect().size
var events = {}
var last_drag_distance = 0

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			events[event.index] = event
		else:
			events.erase(event.index)
	if event is InputEventScreenDrag:
		events[event.index] = event
		if events.size() == 1:
			var temp_pos = $Camera2D.position - event.relative.rotated(rotation)
			if (temp_pos.x >= 1730 || temp_pos.x <= -1730):
				return
			elif (temp_pos.y >= 4000 || temp_pos.y <= -750):
				return
			else:
				$Camera2D.position = temp_pos

# This part is reserved for pc controls
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func selected_region(reg: String):
	$Camera2D/HUD/Question.parse_bbcode("[center]" + reg)

func _on_character_body_2d_area_entered(area):
	print(area)
	selected_region(area.name)

func _on_character_body_2d_area_exited(area):
	print("Changing: ", area)
