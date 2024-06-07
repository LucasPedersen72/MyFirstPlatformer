extends Control

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
	current_dialogue_id = -1
	next_script()

func load_dialogue():
	var content = {}

	match GameManager.talking_npc:
		"girl":
			content = read_json("res://dialogue/girl_npc_dialogue.json")
		"floating_wizard":
			content = read_json("res://dialogue/floating_wizard_dialogue.json")
		_:
			print("No matching NPC found.")
			return []

	if content.error != OK:
		print("Failed to load dialogue: ", content.error)
		return []

	return content.result

func read_json(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	if not file:
		print("Failed to open file: ", file_path)
		return { "error": ERR_CANT_OPEN, "result": [] }

	var content_text = file.get_as_text()
	file.close()

	var json = JSON.new()
	var result = json.parse(content_text)

	if result.error != OK:
		print("Failed to parse JSON: ", result.error)
		return { "error": result.error, "result": [] }

	return { "error": OK, "result": result.result }

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
		name_label.text = dialogue[current_dialogue_id].get('name', '')
		text_label.text = dialogue[current_dialogue_id].get('text', '')
	else:
		print("NameLabel or TextLabel node not found")
