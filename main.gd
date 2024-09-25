extends Node2D

@onready var name_generator_screen = $CanvasLayer/GenerateNameScreen
@onready var name_generator = $NameGeneratorService


func _ready():
	name_generator.name_generated.connect(_on_name_generated)
	name_generator_screen.generate_name.connect(_on_generate_name)


func _process(_delta):
	pass


func _on_generate_name(use_prefix: bool = false, use_postfix: bool = false, append_number: bool = false):
	name_generator.generate_name(use_prefix, use_postfix, append_number)


func _on_name_generated(generated_name: String):
	name_generator_screen.update_generator_output_edit(generated_name)
