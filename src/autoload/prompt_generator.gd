extends Node

var global_seed = 0

var prompts = []
var rng = RandomNumberGenerator.new()


func get_prompt_set(quantity, seed) -> Array:
	rng.seed = hash(seed) + hash(global_seed)
	if quantity >= len(prompts):
		return prompts
	
	var selected_prompts = []
	while len(selected_prompts) < quantity:
		var next_prompt = prompts[rng.randi_range(0,len(prompts)-1)]
		if not next_prompt in selected_prompts:
			selected_prompts.append(next_prompt)
	return selected_prompts

func remove_empty_elements() -> void:
	prompts = Array(prompts)
	var pre_len = len(prompts) + 1
	while pre_len != len(prompts):
		pre_len = len(prompts)
		prompts.erase("")
