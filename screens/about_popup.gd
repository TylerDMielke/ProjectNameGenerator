extends Popup

@onready var ok_button: Button = $PanelContainer/CenterContainer/VBoxContainer/CenterContainer2/Button


func _ready():
	ok_button.button_down.connect(hide)


func _process(_delta):
	pass
