extends Node3D

var bodies_present: Array
var body_count: int
var avg_pos: Vector3
var zoom_value: float
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
		sum += _body.global_position
	avg_pos = sum/bodies_present.size()
	
	$Camera3D.look_at(avg_pos)
	$Camera3D.global_position = lerp($Camera3D.global_position, floor(avg_pos) + Vector3(zoom_value,zoom_value,zoom_value)*$Camera3D.transform.basis.z, 0.02)
	


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				zoom_value += 1

			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				zoom_value -= 1
func _control():
	pass
