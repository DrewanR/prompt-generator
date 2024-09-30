extends Node

var global_seed = 0

var prompts = []
var rng = RandomNumberGenerator.new()

var theme_parameters = {"testValue":null}

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

func set_theme_params(params :String) -> void:
	var theme_parameters_line = params.split(";")
	for parameter in theme_parameters_line:
		parameter = parameter.split("=")
		if len(parameter) >= 2:
			var key = parameter[0].strip_edges()
			var value = parameter[1].strip_edges()
			if value[0] == '"':   # String
				theme_parameters[key] = value.substr(1,len(value)-2)
			elif value[0] == '#': # Colour
				var red   = float(value.substr(1,2).hex_to_int())/256
				var green = float(value.substr(3,2).hex_to_int())/256
				var blue  = float(value.substr(5,2).hex_to_int())/256
				theme_parameters[key] = Color(red, green, blue, 1)
				print(Color(red, green, blue, 1))
