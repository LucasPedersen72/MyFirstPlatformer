extends Control

@export_file("*.json") var dialogue_file

signal dialogue_finished

var dialogue = []
var current_dialogue_id = 0
var dialogue_active: bool = false

func _ready():
	$DialogueBackground.visible = false

func start():
	if dialogue_active:
		return

	$DialogueBackground.visible = true
	dialogue_active = true
	dialogue = load_dialogue()
	print("Loaded dialogue: ", dialogue)
	current_dialogue_id = -1
	next_script()

func load_dialogue():
	var npc = GameManager.talking_npc
	var file_path = "res://dialogue/%s_npc_dialogue.json" % npc
	print("Loading dialogue from: ", file_path)
	var content = read_json(file_path)
	
	if content.error != OK:
		print("Error loading dialogue: ", content.error)
		return []

	print("Loaded dialogue content: ", content.result)
	return content.result

func read_json(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	if file.error != OK:
		print("Failed to open file: ", file_path)
		return { "error": file.error, "result": [] }

	var content_text = file.get_as_text()
	file.close()
	print("Content text: ", content_text)

	var json = JSON.new()
	var content = json.parse(content_text)

	if content.error != OK:
		print("Failed to parse JSON: ", content.error)
		return { "error": content.error, "result": [] }

	print("Parsed content: ", content.result)
	return { "error": OK, "result": content.result }

func _input(event):
	if not dialogue_active:
		return
	if event.is_action_pressed("interact"):
		next_script()

func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		dialogue_active = false
		$DialogueBackground.visible = false
		emit_signal("dialogue_finished")
		return

	var name_label = $DialogueBackground.get_node("NameLabel")
	var text_label = $DialogueBackground.get_node("TextLabel")

	if name_label and text_label:
		var current_dialogue = dialogue[current_dialogue_id]
		print("Current dialogue: ", current_dialogue)
		if current_dialogue.has("name") and current_dialogue.has("text"):
			name_label.text = current_dialogue['name']
			text_label.text = current_dialogue['text']
		else:
			print("Dialogue entry missing 'name' or 'text': ", current_dialogue)
	else:
		print("NameLabel or TextLabel node not found")
