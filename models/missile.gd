extends RigidBody2D

@export var speed = 350

@onready var collision = $CollisionShape2D

var degat
var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision.disabled = false
	degat = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if direction != Vector2.ZERO:
		position += direction * speed * delta
		rotation = direction.angle()

func set_direction(newDirection):
	direction = newDirection

func set_degat(Newdegat):
	degat = Newdegat

func _on_body_entered(body: Node2D) -> void:
	explode()
	
func explode():
	#set_physics_process(false)
	queue_free()
