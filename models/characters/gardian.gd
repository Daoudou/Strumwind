extends RigidBody2D

var pv
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start(pos):
	position = pos
	pv = 150
	show()

func take_damage(damage):
	pv -= damage
	if (pv <= 0):
		queue_free()
