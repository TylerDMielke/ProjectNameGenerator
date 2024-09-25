extends Control
## User Interface for the Generate Name service.
##
## Screen for configuring and exectuting the Generate Name service.

signal generate_name

@onready var about_popup: Popup = $AboutPopup
@onready var generate_output_edit: LineEdit = %GeneratorOutputEdit
@onready var generate_button: Button = %GenerateButton
@onready var menu_bar: Control = $UIBackground/MenuBar
@onready var append_number_checkbox: CheckBox = %AppendNumberCheckBox
@onready var use_postfix_checkbox: CheckBox = %UsePostfixCheckBox
@onready var use_prefix_checkbox: CheckBox = %UsePrefixCheckBox


func _ready():
	menu_bar.add_file_menu_item("Quit", get_tree().quit)
	menu_bar.add_edit_menu_item("Edit Prefixes", _on_edit_prefixes_pressed)
	menu_bar.add_edit_menu_item("Edit Names", _on_edit_names_pressed)
	menu_bar.add_edit_menu_item("Edit Postfixes", _on_edit_postfixes_pressed)
	menu_bar.add_help_menu_item("Documentation", func(): print("Clicked Documentation"))
	menu_bar.add_help_menu_item("About", about_popup.show)
	generate_button.button_down.connect(_on_generate_button_down)


func _process(_delta):
	pass


func update_generator_output_edit(generator_output: String):
	generate_output_edit.text = generator_output


func _on_edit_prefixes_pressed():
	get_tree().change_scene_to_file("res://screens/generate_name_prefix_screen.tscn")


func _on_edit_names_pressed():
	get_tree().change_scene_to_file("res://screens/generate_name_name_screen.tscn")


func _on_edit_postfixes_pressed():
	get_tree().change_scene_to_file("res://screens/generate_name_postfix_screen.tscn")


func _on_generate_button_down():
	var use_prefix: bool = use_prefix_checkbox.button_pressed
	var use_postfix: bool = use_postfix_checkbox.button_pressed
	var append_number: bool = append_number_checkbox.button_pressed
	print_debug(use_prefix, " ", use_postfix, " ", append_number)
	generate_name.emit(use_prefix, use_postfix, append_number)