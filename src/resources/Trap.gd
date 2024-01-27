class_name Trap
extends Resource

enum Kind {
	STATIC,
	MOVABLE,
	HOLE,
	SPIKE
}

@export var icon: Texture2D
@export var scene: PackedScene
@export var floating := false
@export var kind: Kind = Kind.STATIC
@export var custom_y: int
