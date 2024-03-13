class_name TooltipHUD
extends PanelContainer

@export var fade_seconds := 0.2

@onready var tooltip_icon: TextureRect = %TooltipIcon
@onready var tooltip_text_label: RichTextLabel = %TooltipText

var tween: Tween
var shown: bool = false

func _ready() -> void:
	modulate = Color.TRANSPARENT
	hide()
	
#TEST FUNCTION, REMOVE LATER
func _unhandled_input(event):
	if event.is_action_pressed("space"):
		shown = !shown
		if shown:
			show_tooltip(load("res://assets/icon.svg"),"This is a test description.")
		else: 
			hide_tooltip()
			
func show_tooltip(icon: Texture, text: String) -> void:
	if tween:
		tween.kill()
		
	tooltip_icon.texture = icon
	tooltip_text_label.text = text
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(show)
	tween.tween_property(self, "modulate", Color.WHITE, fade_seconds)
	
func hide_tooltip() -> void:
	if tween:
		tween.kill()
	
	hide_animation()
	
func hide_animation() -> void:
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "modulate", Color.TRANSPARENT, fade_seconds)
	tween.tween_callback(hide)
