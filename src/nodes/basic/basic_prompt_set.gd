extends Control

var SEED = "NYAH NYAH MOTHERFUCKER"
var PROMPTS = []
var prompt_lables = []

@export var prompt_node_tcsn_adress = "res://src/nodes/basic/BasicPompt.tscn"

@export var prompt_container_node :Node

@export var seed_node :Label

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	refresh(SEED, PromptGenerator.get_prompt_set(3,SEED))


func refresh(seed, prompts) -> void:
	PROMPTS = prompts
	
	_instantiate_prompt_lables()
	_update_prompt_text()
	
	seed_node.text = str(seed)


func _instantiate_prompt_lables() -> void:
	for i in range(0, len(PROMPTS)):
		var prompt_node = load(prompt_node_tcsn_adress)
		prompt_lables.append(prompt_node.instantiate())
		prompt_container_node.add_child(prompt_lables[-1])


func _update_prompt_text() -> void:
	prompt_lables = prompt_container_node.get_children()
	for i in range(0, len(PROMPTS)):
		prompt_lables[i].text = PROMPTS[i]
