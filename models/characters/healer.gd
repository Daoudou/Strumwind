extends RigidBody2D

var pv
var heal
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func start():
	pv = 80
	heal = 5
	show()
	
func take_damage(damage):
	pv -= damage
	if (pv <= 0):
		queue_free()
		
func give_heal(mob : Node2D, PvInit):
	if	(mob.pv < PvInit):
		mob.pv += heal
	
	
