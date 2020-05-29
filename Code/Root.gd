extends Node

var current_level
export var start_level = "Level0"

###############################################################
# Nodeprozesse 

func _ready():
	current_level = $LevelContainerL1/LevelRoot
	load_level(start_level)
		
###############################################################
# Signale
	
func _on_change_level(next_scene):
	load_level(next_scene)
	
###############################################################
# Funktionen

func load_level(level):
	var scene_string = "res://Scenes/Levels/" + level + ".tscn"
	var new_level_scene = load(scene_string)
	var new_level_node = new_level_scene.instance()
		
	# Alte Scene mit Verbindung raus
	if current_level.is_connected("change_level", self, "_on_change_level"):
		current_level.disconnect("change_level", self, "_on_change_level")
		
	if $Player.is_connected("talk_to_npc", current_level, "_on_talk_to_npc"):
		$Player.disconnect("talk_to_npc", current_level, "_on_talk_to_npc")
		
	if $LevelContainerL1.get_child_count() != 0:
		$LevelContainerL1.get_child(0).queue_free()
	
	# Neue Szene rein
	$LevelContainerL1.call_deferred("add_child", new_level_node)
	if new_level_node.connect("change_level", self, "_on_change_level") != OK:
		print("--E-- Fehler beim Connecten des neuen Levels")
	if $Player.connect("talk_to_npc", new_level_node, "_on_talk_to_npc") != OK:
		print("--E-- Fehler beim Connecten des neuen Levels")
	current_level = new_level_node

