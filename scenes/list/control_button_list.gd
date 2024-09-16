extends Control

@export var button_count: int = 6

@onready var vboxContainerButton := $VBoxContainerButton
@onready var normal_style := load("res://art/styling/button.tres")
@onready var pressed_style := load("res://art/styling/buttonPressed.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(1,button_count):
		var button = Button.new()
		button.text = "Niveau %d" % i
		button.name = "Button_%d" % i
		button.add_theme_stylebox_override("normal",normal_style)
		button.add_theme_stylebox_override("hover",normal_style)
		button.add_theme_stylebox_override("pressed",pressed_style)
		# button.disabled = true
		button.set_meta("index",i)
		button.connect("pressed",Callable(self,"_on_button_pressed").bind(i))
		vboxContainerButton.add_child(button)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_button_pressed(index):
	var levelName = "res://levels//level_" + str(index) + ".tscn"
	if (ResourceLoader.exists(levelName)):
		get_tree().change_scene_to_file(levelName)
	else:
		print("Resource not exist")
