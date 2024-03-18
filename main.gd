extends Node3D

@export var bodies_present: Array
@export var body_count: int

func _ready():
	bodies_present.resize(1)
	for _body in get_children():
		if _body.is_in_group("Body"):
			bodies_present.append(_body)

func _process(delta):

	
	if body_count != get_children().size():
		for _body in get_children():
			if _body.is_in_group("Body"):
				bodies_present.append(_body)
	
	body_count = get_children().size()

