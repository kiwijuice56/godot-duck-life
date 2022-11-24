class_name ScreenShakeCamera
extends Camera2D

# Screen shake code from kidscancode.org 

@export var decay = 0.8  # How quickly the shaking stops [0, 1].
@export var max_offset = Vector2(100, 75)  # Maximum hor/ver shake in pixels.
@export var max_roll = 0.1  # Maximum rotation in radians (use sparingly).

var trauma = 0.0  # Current shake strength.
var trauma_power = 2  # Trauma exponent. Use [2, 3].
@onready var noise = FastNoiseLite.new()
var noise_y := 0.0

func _ready() -> void:
	randomize()
	noise.seed = 2
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.fractal_octaves = 2
	noise.frequency = 0.12

func add_trauma(amount: float):
	trauma = min(trauma + amount, 1.0)

func _process(delta: float) -> void:
	if trauma:
		trauma = max(trauma - decay * delta, 0)
		shake(delta)

func shake(delta: float) -> void:
	var amount = pow(trauma, trauma_power)
	noise_y += 60 * delta
	rotation = max_roll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = max_offset.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.y = max_offset.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)
