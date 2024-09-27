extends Control

const prompt_file_info_labels = """File Name: 
Prompt Count: 
Average Prompt Length: 
Last Modified:"""
const begin_texts = ["Begin","Begin","Activate","Accept","Activate","Start","Start","Nyah","Press to begin","Except","Get to the hecking prompts","trats","CLICK ME!","Meow","Begin²"]

@export var theme_scenes :Array[Array]=[
	["Test Theme", "res://src/nodes/basic/basic_main_scene.tscn"],
	["Basic Commandlike", "res://src/nodes/basicCommandLine/commandline_main_scene.tscn"]
]

@onready var global_seed_box := $MarginContainer/VBoxContainer/GlobalSeed/SpinBox

@onready var theme_dropdown  := $MarginContainer/VBoxContainer/Theme/OptionButton

@onready var prompt_file_adress_line_edit     := $MarginContainer/VBoxContainer/PromptFileAdress/LineEdit
@onready var prompt_file_adress_filedialogue  := $MarginContainer/VBoxContainer/PromptFileAdress/FileDialog
@onready var prompt_file_adress_search_button := $MarginContainer/VBoxContainer/PromptFileAdress/Button
@onready var prompt_file_adress_info          := $MarginContainer/VBoxContainer/PromptFileAdress/Info
@onready var prompt_file_adress_label         := $MarginContainer/VBoxContainer/PromptFileAdress/InfoLabels

@onready var accept_button := $MarginContainer/Button

var prompt_file_adress = "nyah"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prompt_file_adress = prompt_file_adress_line_edit.text
	accept_button.text = begin_texts[randi_range(0,len(begin_texts)-1)]
	
	update_theme_select()
	update_prompt_info()

func start() -> void:
	PromptGenerator.global_seed = global_seed_box.value
	var file_content = load_file()
	PromptGenerator.prompts = file_content.split("\n")
	PromptGenerator.remove_empty_elements()
	get_tree().change_scene_to_file(theme_scenes[theme_dropdown.selected][1])

func update_theme_select() -> void:
	for i in range(0,len(theme_scenes)):
		theme_dropdown.add_item(theme_scenes[i][0],i)

func update_prompt_info() -> void:
	var file_content = load_file()
	if file_content == null:
		prompt_file_adress_info.visible = false
		prompt_file_adress_label.text = "File Not Found\n\n\n\n"
		accept_button.visible = false
	else:
		var number_of_lines = len(file_content.split("\n"))
		prompt_file_adress_label.text = prompt_file_info_labels
		prompt_file_adress_info.visible = true
		prompt_file_adress_info.text  = " " + prompt_file_adress.split("/")[-1]
		prompt_file_adress_info.text += "\n " + str(number_of_lines) + " L"
		prompt_file_adress_info.text += "\n " + str(len(file_content.split(" "))/number_of_lines) + " W"
		
		var time_dict = Time.get_datetime_dict_from_unix_time(FileAccess.get_modified_time(prompt_file_adress))
		prompt_file_adress_info.text += "\n " + str(time_dict["day"]) + "/" + str(time_dict["month"]) + "/" + str(time_dict["year"])
		accept_button.visible = true

func load_file():
	var file = FileAccess.open(prompt_file_adress, FileAccess.READ)
	if file != null:
		var content = file.get_as_text()
		return content
	else:
		return null

func _on_file_dialog_confirmed() -> void:
	pass # Replace with function body.

func _on_line_edit_text_changed(new_text: String) -> void:
	prompt_file_adress = new_text
	update_prompt_info()

func _on_button_pressed() -> void:
	start()
