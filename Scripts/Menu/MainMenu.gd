extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_NewGame_pressed():
	get_tree().change_scene("res://Scenes/Levels/Level0.tscn")


func _on_OptionsButton_pressed():
	get_tree().change_scene("res://Scenes/Menu/Options.tscn")


func _on_QuitButton_pressed():
	get_tree().exit()


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu/MainMenu.tscn")
