extends RigidBody2D

@export var speed = 4

var targetPosition = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = position.angle_to_point(targetPosition)
	# On choisi la vélocité pour le mob
	var velocity = Vector2(randf_range(50.0,50.0),0.0) * speed
	self.linear_velocity = velocity.rotated(direction)
	self.rotation = direction
	
func start(pos):
	position = pos
	show()
