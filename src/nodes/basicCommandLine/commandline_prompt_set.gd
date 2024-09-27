extends Control

#const possible_commands = [
#	[">>> PromptGenerator.generatePromptSet(\'","\')"],
#	[">>> PromptGenerator.generatePromptSet(\'","\')"],
#	[">>> generatePromptSet(\'","\')"],
#	[">>> generatePromptSet(\'","\')"],
#	[">>> print(generatePromptSet(\'","\')"],
#	[">>> ",".prompts"],
#	[">>> ",".prompts"]
#]

var SEED = "NYAH NYAH MOTHERFUCKER"
var PROMPTS = []
var prompt_lables = []


@export var prompt_node_tcsn_adress = "res://src/nodes/basic/BasicPompt.tscn"

@export var prompt_container_node :Node

@export var seed_node :Label

@export var animation_player :AnimationPlayer


func refresh(seed, prompts) -> void:
	PROMPTS = prompts
	
	_instantiate_prompt_lables()
	_update_prompt_text()
	
	#var command_id = randi_range(0,len(possible_commands)-1)
	#seed_node.text = possible_commands[command_id][0] + seed + possible_commands[command_id][1]
	seed_node.text = ">>> " + seed

func _instantiate_prompt_lables() -> void:
	for i in range(0, len(PROMPTS)):
		var prompt_node = load(prompt_node_tcsn_adress)
		prompt_lables.append(prompt_node.instantiate())
		prompt_container_node.add_child(prompt_lables[-1])

func _update_prompt_text() -> void:
	prompt_lables = prompt_container_node.get_children()
	for i in range(0, len(PROMPTS)):
		prompt_lables[i].text = PROMPTS[i]
		prompt_lables[i].get_children()[0].play("on load")
		await prompt_lables[i].get_children()[0].animation_finished

func dim() -> void:
	animation_player.play("dim")
