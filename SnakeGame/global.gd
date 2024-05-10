extends Node

# 割り算に使われることが多い値をintで定義すると整数除算Warningが出てうざいかも
# int型はあんまり使わなくていいかな？
var CELL_SIZE:float = 32.0
var CELLS_X:float
var CELLS_Y:float


func _ready():

	var extent = DisplayServer.window_get_size()
	CELLS_X = int(extent.x / CELL_SIZE)
	CELLS_Y = int(extent.y / CELL_SIZE)


# pythonのzipのような？？
func zip(a:Array, b:Array) -> Array:
	var ret:Array = []
	
	var length:int = min(a.size(), b.size())
	
	for i in range(length):
		ret.append([a[i], b[i]])
	
	return ret
