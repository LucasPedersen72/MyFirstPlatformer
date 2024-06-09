extends Node

var dialogue_data = {}
var current_dialogue = {}

func _ready():
	load_dialogue_data()
	start_dialogue("Girl_NPC")

func load_dialogue_data():
	var dialogue_files = Directory.new()
	var dialogues_dir = "res://dialogue/DialogueManager/"
	if dialogue_files.open(dialogues_dir) == OK:
		dialogue_files.list_dir_begin(true, true)
		var filename = dialogue_files.get_next()
		while filename != "":
			if filename.ends_with(".dialogue"):
				var file = File.new()
				if file.open(dialogues_dir + filename, File.READ) == OK:
					var dialogue_text = file.get_as_text()
					parse_dialogue_file(dialogue_text)
					file.close()
			filename = dialogue_files.get_next()

func parse_dialogue_file(dialogue_text: String):
	# Implement your custom parsing logic here.
	# This will depend on the structure of your .dialogue files.
	# Parse the dialogue text and populate the dialogue_data dictionary.
	pass

func start_dialogue(dialogue_id):
	current_dialogue = dialogue_data[dialogue_id]
	show_dialogue()

func show_dialogue():
	$DialogueLabel.text = current_dialogue["text"]
	$ChoicesContainer.clear()  # Clear previous choices
	for choice_idx in range(current_dialogue["choices"].size()):
		var button = Button.new()
		var choice = current_dialogue["choices"][choice_idx]
		button.text = choice["text"]
		button.connect("pressed", self, "_on_choice_selected", [choice_idx])
		$ChoicesContainer.add_child(button)

func _on_choice_selected(choice_idx):
	var next_dialogue_id = current_dialogue["choices"][choice_idx]["next"]
	start_dialogue(next_dialogue_id)
