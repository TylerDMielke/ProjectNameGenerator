extends Node2D
class_name NameGeneratorService

signal name_generated

@export var name_file_location: String
@export var prefix_file_location: String
@export var postfix_file_location: String

var names: PackedStringArray
var prefixes: PackedStringArray
var postfixes: PackedStringArray


func _ready():
	pass 


func _process(_delta):
	pass


func generate_name(use_prefix: bool = false, use_postfix: bool = false, append_number: bool = false):
	var generated_name: String = ""

	if use_prefix:
		prefixes = _load_file_contents(Constants.PREFIX_FILE_PATH)
	if use_postfix:
		postfixes = _load_file_contents(Constants.POSTFIX_FILE_PATH)

	names = _load_file_contents(Constants.NAME_FILE_PATH)
	if names.size() < 1:
		return  # Do nothing if we don't have any names.
	
	var selected_prefix: String = ""
	if use_prefix and prefixes.size() > 0:
		var random_prefix_index: int = randi() % prefixes.size()
		selected_prefix = prefixes[random_prefix_index]
		selected_prefix = selected_prefix + "-"

	var selected_postfix: String = ""
	if use_postfix and postfixes.size() > 0:
		var random_postfix_index: int = randi() % postfixes.size()
		selected_postfix = postfixes[random_postfix_index]
		selected_postfix = "-" + selected_postfix

	var selected_name: String = ""
	var random_name_index: int = randi() % names.size()
	selected_name = names[random_name_index]

	var selected_number: String = ""
	if append_number:
		selected_number = str(randi())
		selected_number = "-" + selected_number
	
	generated_name = selected_prefix + selected_name + selected_postfix + selected_number
	
	name_generated.emit(generated_name)


func _load_file_contents(file_path: String) -> PackedStringArray:
	if not FileAccess.file_exists(file_path):
		return PackedStringArray([])

	var file_string = FileAccess.get_file_as_string(file_path)
	if file_string.length() < 1:
		return PackedStringArray([])

	return _process_csv_string(file_string)


func _process_csv_string(csv_string: String) -> PackedStringArray:
	var result_strings: PackedStringArray = PackedStringArray([])
	var split_strings: PackedStringArray = csv_string.split(",")
	for string in split_strings:
		var stripped_string = string.strip_edges()
		result_strings.append(stripped_string)
	return result_strings


# func generate_name():
# 	var possible_words: PackedStringArray = name_file_contents.split(",")

# 	if name_file_location.length() > 0:
# 		var error: Error = _get_name_file_contents(name_file_location)
# 		if error != Error.OK:
# 			return 
# 	else:
# 		possible_words = PackedStringArray(["new", "game", "project", "godot", "test"])
	
# 	var chosen_words: PackedStringArray = PackedStringArray([])
# 	for i in range(word_count):
# 		var random_index = randi() % possible_words.size()
# 		var random_string = possible_words[random_index]
# 		chosen_words.append(random_string)

# 	var generated_name: String =  "-".join(chosen_words) 

# 	name_generated.emit(generated_name)


# func _get_name_file_contents(name_file_location: String):
# 	if not FileAccess.file_exists(name_file_location):
# 		print("File: %s does not exist." % name_file_location)
# 		return Error.ERR_FILE_NOT_FOUND

# 	name_file_contents = FileAccess.get_file_as_string(name_file_location)

# 	var name_file_error: Error = FileAccess.get_open_error()
# 	if name_file_error != Error.OK:
# 		print("Failed to read file contents from %s" % name_file_location)
# 		return name_file_error
		
# 	return Error.OK