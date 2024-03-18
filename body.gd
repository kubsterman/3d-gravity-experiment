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
	
	for body in get_parent().bodies_present:
		if body && body !=self:
			desired_velocity.x = (body.global_position.x-global_position.x)
			desired_velocity.y = (body.global_position.y-global_position.y)
			desired_velocity.z = (body.global_position.z-global_position.z)
			
			var distance = sqrt(pow(body.global_position.x-global_position.x,2) + pow(body.global_position.y-global_position.y,2) + pow(body.global_position.z-global_position.z,2))
			
			g_force = (G * (mass * body.mass) * 10000 )/pow(distance,2)
			
	
	velocity += desired_velocity * g_force
	global_position += velocity * delta
