extends Window

var current_path: String = '~'
@export var label_text: String = '[user@blackwall]:'
@export var root_folder: String = 'res://fs'
var current_dir: DirAccess = DirAccess.open('res://fs/home/user')
var history: Array[String]

func _ready() -> void:
	update_prefix()
	connect("close_requested", _on_close_requested)
	$VSplitContainer/terminal_line/terminal_input.text_submitted.connect(_on_text_entered)

func abs_path(target_dir) -> String: return root_folder + target_dir
func local_path(str_abs_path: String) -> String: return str_abs_path.replace('res://fs', '')

func _on_close_requested() -> void:
	self.queue_free()

func update_prefix() -> void:
	var new_path = local_path(current_dir.get_current_dir())
	if new_path == '/home/user': new_path = '~'
	if new_path == '': new_path = '/'
	$VSplitContainer/terminal_line/Label.text = label_text + new_path + '$'
	
func _on_text_entered(user_input: String) -> void:
	print(user_input)
	process_command(user_input)

func clear_screen() -> void:
	$VSplitContainer/MarginContainer/RichTextLabel.text = ''
	
func print_log(text_to_print) -> void:
	$VSplitContainer/MarginContainer/RichTextLabel.text += '\n' + str(text_to_print)
	
func change_directory(command: String) -> void:
	if command == 'cd': return
	var target_path = command.split(' ')[1]
	if target_path == '~': target_path = '/home/user'
	if target_path == '/': target_path = ''
	if current_dir.change_dir(abs_path(target_path)) == OK:
		update_prefix()
	else:
		print_log('Folder not found.')

func list_directory(command: String) -> void:
	var dir
	if command != 'ls':
		dir = get_directory(command.split(' ')[1])
		if dir == null: return
	else: dir = current_dir
	var temp: PackedStringArray = dir.get_files() + dir.get_directories()
	print_log(temp)
	
func get_directory(dir_path: String):
	print('Get directory: ', abs_path(dir_path))
	var dir = DirAccess.open(abs_path(dir_path))
	if dir != null: print(dir.get_current_dir())
	return dir

# Either fix margin and positioning in single terminal or split input and output

func process_command(command: String) -> void:
	print_log(label_text + command)
	if command == 'shutdown': get_tree().quit()
	if command == 'clear': clear_screen()
	if command == 'pwd': print_log(local_path(current_dir.get_current_dir()))
	if command == 'history': print_log(history)
	if command == 'exit': queue_free()
	if 'cd' in command: change_directory(command)
	if 'ls' in command: list_directory(command)
	$VSplitContainer/terminal_line/terminal_input.text = ''
	history.append(command)
	return
