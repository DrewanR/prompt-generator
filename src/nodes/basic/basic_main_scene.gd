extends Control

var prompt_set_nodes = []
var bottom_sticky = true

@export var prompt_set_adress :String = "res://src/nodes/basic/BasicPromptSet.tscn"
@export var prompt_container_node :Node
@export var seed_text_box :Node
@export var quantity_selecter :Node
@export var quantity_readout :Node
@export var global_seed_readout :Node
@export var scroll_container :Node
@export var dim_previous_promptsets := false

func _ready() -> void:
	if quantity_selecter != null:
		quantity_selecter.max_value = len(PromptGenerator.prompts)
		quantity_selecter.value = 3
	global_seed_readout.text = "Global seed: " + str(PromptGenerator.global_seed)

func _process(delta: float) -> void:
	if bottom_sticky:
		scroll_container.scroll_vertical = 1000000
	
	if Input.is_action_just_pressed("ui_accept"):
		_on_enter_pressed()

func spawn_prompt_Set(seed, prompts) -> void:
	if len(prompt_container_node.get_children()) > 0 and dim_previous_promptsets:
		prompt_container_node.get_children()[-1].dim()
	
	var prompt_set_node = load(prompt_set_adress)
	prompt_set_nodes.append(prompt_set_node.instantiate())
	prompt_container_node.add_child(prompt_set_nodes[-1])

	prompt_set_nodes[-1].refresh(seed, prompts)

func generate_prompts() -> Array:
	return PromptGenerator.get_prompt_set(quantity_selecter.value, seed_text_box.text)

func _on_enter_pressed() -> void:
	spawn_prompt_Set(seed_text_box.text, generate_prompts())
	seed_text_box.text = ""

func _on_h_slider_value_changed(value: float) -> void:
	quantity_readout.text = str(value)
