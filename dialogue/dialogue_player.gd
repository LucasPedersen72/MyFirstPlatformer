extends Control
@onready var dialogue_background = $DialogueBackground

@export_file("*.json") var dialogue_file

signal dialogue_finsished

var dialogue = []
var current_dialogue_id = 0
var dialogue_active : bool = false

func _ready():
	dialogue_background.visible = false

func start():
	if dialogue_active == false:
		return
	
	dialogue_background.visible = true
	dialogue_active = true
	dialogue = load_dialogue()
	current_dialogue_id = -1
	next_script()
	
func load_dialogue():
	var file = FileAccess.open("res://dialogue/girl_npc_dialogue.json", FileAccess.READ)
	var content = JSON.parse_string(file.get_as_text())
	return content
	
func _input(event):
	if !dialogue_active:
		return
	if event.is_action_pressed("interact"):
		next_script()

func next_script():
	current_dialogue_id += 1
	if current_dialogue_id >= len(dialogue):
		dialogue_active = false
		dialogue_background.visible = false
		emit_signal("dialogue_finsished")
		return
		
	$DialogueBackground/name.text = dialogue[current_dialogue_id]['name']
	$DialogueBackground/text.text = dialogue[current_dialogue_id]['text']
