extends Control
## A generalized menu bar.
##
## A menu bar that can be configured for different screens.

@export var screen_name: String = "{Screen Name}"

var file_item_id_map: Dictionary = {}
var file_item_callable_map: Dictionary = {}
var edit_item_id_map: Dictionary = {}
var edit_item_callable_map: Dictionary = {}
var help_item_id_map: Dictionary = {}
var help_item_callable_map: Dictionary = {}

@onready var screen_label: Label = %ScreenLabel
@onready var menu_bar: MenuBar = $ButtonContainer/MenuBar
@onready var file_popup_menu: PopupMenu = $ButtonContainer/MenuBar/File
@onready var edit_popup_menu: PopupMenu = $ButtonContainer/MenuBar/Edit
@onready var help_popup_menu: PopupMenu = $ButtonContainer/MenuBar/Help


func _ready():
	screen_label.text = screen_name

	file_popup_menu.id_pressed.connect(_on_file_menu_id_pressed)
	edit_popup_menu.id_pressed.connect(_on_edit_menu_id_pressed)
	help_popup_menu.id_pressed.connect(_on_help_menu_id_pressed)


func _process(_delta):
	if file_popup_menu.item_count < 1:
		menu_bar.set_menu_hidden(0, true)
	if edit_popup_menu.item_count < 1:
		menu_bar.set_menu_hidden(1, true)
	if help_popup_menu.item_count < 1:
		menu_bar.set_menu_hidden(2, true)


func add_file_menu_item(menu_item_title: String, menu_item_action: Callable):
	var menu_item_id: int = _create_file_item_id()
	file_popup_menu.add_item(menu_item_title, menu_item_id)
	file_item_id_map[menu_item_id] = menu_item_title
	file_item_callable_map[menu_item_id]= menu_item_action


func add_edit_menu_item(menu_item_title: String, menu_item_action: Callable):
	var menu_item_id: int = _create_edit_item_id()
	edit_popup_menu.add_item(menu_item_title, menu_item_id)
	edit_item_id_map[menu_item_id] = menu_item_title
	edit_item_callable_map[menu_item_id]= menu_item_action


func add_help_menu_item(menu_item_title: String, menu_item_action: Callable):
	var menu_item_id: int = _create_help_item_id()
	help_popup_menu.add_item(menu_item_title, menu_item_id)
	help_item_id_map[menu_item_id] = menu_item_title
	help_item_callable_map[menu_item_id]= menu_item_action


func _create_file_item_id() -> int:
	var existing_ids: Array = file_item_id_map.keys()
	if existing_ids.size() < 1:
		return 0 
	return existing_ids.back() + 1


func _create_edit_item_id() -> int:
	var existing_ids: Array = edit_item_id_map.keys()
	if existing_ids.size() < 1:
		return 0 
	return existing_ids.back() + 1


func _create_help_item_id() -> int:
	var existing_ids: Array = help_item_id_map.keys()
	if existing_ids.size() < 1:
		return 0 
	return existing_ids.back() + 1


func _on_file_menu_id_pressed(id: int):
	var file_item_callable: Callable = file_item_callable_map[id]
	file_item_callable.call()


func _on_edit_menu_id_pressed(id: int):
	var edit_item_callable: Callable = edit_item_callable_map[id]
	edit_item_callable.call()


func _on_help_menu_id_pressed(id: int):
	var help_item_callable: Callable = help_item_callable_map[id]
	help_item_callable.call()
