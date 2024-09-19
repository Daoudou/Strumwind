extends RigidBody2D

@onready var collision = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	$AnimatedSprite2D.play("frame")
	collision.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
