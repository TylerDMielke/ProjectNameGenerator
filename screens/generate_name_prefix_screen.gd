extends Control

@onready var confirm_button: Button = $UIBackground/ConfirmButton
@onready var cancel_button: Button = $UIBackground/CancelButton
@onready var text_edit: TextEdit = $UIBackground/CenterContainer/MarginContainer/TextEdit


func _ready():
	confirm_button.button_down.connect(_on_confirm_button_down)
	cancel_button.button_down.connect(_on_cancel_button_down)

	_load_existing_names()


func _process(_delta):
	pass


func _load_existing_names():
	# Check for names file
	if not FileAccess.file_exists(Constants.PREFIX_FILE_PATH):
		return

	# Read names file
	var file = FileAccess.open(Constants.PREFIX_FILE_PATH, FileAccess.READ)
	var file_content = file.get_as_text()

	# Load text_edit with file contents
	text_edit.text = file_content


func _on_confirm_button_down():
	# save text to file
	var file = FileAccess.open(Constants.PREFIX_FILE_PATH, FileAccess.WRITE)
	file.store_string(text_edit.text)
	file.close()

	# Change to main scene
	get_tree().change_scene_to_file("res://main.tscn")


func _on_cancel_button_down():
	get_tree().change_scene_to_file("res://main.tscn")
