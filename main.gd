extends Node3D

var bodies_present: Array
var body_count: int
var avg_pos: Vector3
var zoom_value: float
var movingright: bool

func _ready():

	for _body in get_children():
		if _body.is_in_group("Body"):
			bodies_present.append(_body)

func _process(delta):
	cam_look(delta)
	_control()
	
	if body_count != get_children().size():
		for _body in get_children():
			if _body.is_in_group("Body"):
				bodies_present.append(_body)
	
	body_count = get_children().size()
	
	
	
func cam_look(delta):
	var sum: Vector3 = Vector3.ZERO
	
	for _body in bodies_present:
		if _body != null:
			sum += _body.global_position
	avg_pos = sum/bodies_present.size()
	
	$Camera3D.look_at(avg_pos)
	$Camera3D.global_position = lerp($Camera3D.global_position, floor(avg_pos) + Vector3(zoom_value,zoom_value,zoom_value)*$Camera3D.transform.basis.z, 0.02)
	
	#orbit camera
	
	if Input.is_action_pressed("ui_right"):
		$Camera3D.global_position += 1 * Vector3(1,1,1) * $Camera3D.transform.basis.x
	elif Input.is_action_pressed("ui_left"):
		$Camera3D.global_position -= 1 * Vector3(1,1,1) * $Camera3D.transform.basis.x
	if Input.is_action_pressed("ui_up"):
		$Camera3D.global_position += 1 * Vector3(1,1,1) * $Camera3D.transform.basis.y
	elif Input.is_action_pressed("ui_down"):
		$Camera3D.global_position -= 1 * Vector3(1,1,1) * $Camera3D.transform.basis.y
		
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom_value += 1

			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom_value -= 1
				
func _control():
	zoom_value = $distance_slider.value
