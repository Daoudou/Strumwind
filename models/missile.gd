extends Area2D

@export var speed = 250

@onready var collision = $CollisionShape2D

var degat
var direction: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
var has_entered = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	collision.disabled = false

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
	if not has_entered:
		has_entered = true;
		if body.is_in_group("playerGame"):
			body.take_damage(degat)
		elif body.is_in_group("enemies"):
			body.take_damage(degat)
		if body.is_in_group("missileGroup"):
			collision.disabled = true
	
	set_deferred("monitoring", false)
	queue_free()
	
func explode():
	#set_physics_process(false)
	queue_free()
