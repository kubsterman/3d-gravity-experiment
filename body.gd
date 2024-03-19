extends Node3D

@export var mass: float
@export var initial_velocity: Vector3

var G = 6.67430*pow(10,-11)
var g_force
var velocity: Vector3
var desired_velocity: Vector3

func _ready():
	velocity = initial_velocity
func _physics_process(delta):
	_indicator_edit()
	for body in get_parent().bodies_present:
		if body != null && body !=self:
			desired_velocity.x = (body.global_position.x-global_position.x)
			desired_velocity.y = (body.global_position.y-global_position.y)
			desired_velocity.z = (body.global_position.z-global_position.z)
			
			var distance = sqrt(pow(body.global_position.x-global_position.x,2) + pow(body.global_position.y-global_position.y,2) + pow(body.global_position.z-global_position.z,2))
			if distance !=0:
				g_force = G * ((mass * body.mass))/pow(distance,2)
			
			#print(str(velocity) + self.name)
			velocity += desired_velocity.normalized() * (g_force/mass)
			global_position += velocity * delta

func _indicator_edit():
	$x_indicator.height = velocity.x
	$x_indicator.position.x = velocity.x/4
	
	$y_indicator.height = velocity.y
	$y_indicator.position.y = velocity.y/4
	
	$z_indicator.height = velocity.z
	$z_indicator.position.z = velocity.z/4


func _on_area_3d_area_entered(area):
	if mass < area.get_parent().mass:
		area.get_parent().mass += mass
		queue_free()
	
