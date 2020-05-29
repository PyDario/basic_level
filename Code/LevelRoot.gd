extends Node2D

#Für jedes Level, müssen Script-Erweiterungen gemacht werden, indem 
#die Funktion als Haken für das Signal beschrieben wird und 
#das Signal für das nächste Level ausgegeben wird

#ToDo:	- Evtl einen NPC Container erstellen, damit sie leichter
#			gezählt werden können
#			- Alternativ könnte ich auch die Gruppenfunktion probieren

export var ausgaenge = 0

var DictLoad = load("res://Code/NPC_Conversation.gd")
var npc_dict = DictLoad.new()

signal change_level(next_scene)

func _ready():
	get_node("Hinweis").queue_free()
	$PlayerDummy.visible = false
	get_node("../../Player").position = $PlayerDummy.position
	$PlayerDummy.queue_free()

# Baut die Signale nach der Anzahl der Ausgänge auf
	if ausgaenge > 0:
		for i in range(0, ausgaenge):
			var lvl_brd_string = "LevelBorder" + String(i)
			var method_string = "_on_" + lvl_brd_string + "_body_entered"
			if get_node(lvl_brd_string).connect("body_entered", self, method_string) != OK:
				print("--E-- Fehler beim Connecten von " + get_node(lvl_brd_string).name)
		

func _on_talk_to_npc(npc):
	var dict_string = "L" + self.name.right(5) + "_" + npc.name
	var conv_size
	
	if npc_dict.conversation.has(dict_string):
		conv_size = npc_dict.conversation[dict_string].size()
	else:
		conv_size = 0
	
	if conv_size != 0:
		if npc.conv_loop:
			if npc.conv_count >= conv_size:
				npc.conv_count = 0
			npc.get_node("RichTextLabel").text = npc_dict.conversation[dict_string][npc.conv_count]
			npc.conv_count += 1
		else:
			npc.get_node("RichTextLabel").text = npc_dict.conversation[dict_string][0]
		npc.get_node("RichTextLabel").visible = true
		npc.get_node("Timer").start()
		
	
#Jedes Child-Node mit dieser Funktion erweitern, wobei "LevelBorder0" durch den 
#Namen des Area2D's ersetzt wird.
#Es sollte für jedes LevelBorder eine Funktion da sein
func _on_LevelBorder0_body_entered(_body):
	emit_signal("change_level", "Level0")
