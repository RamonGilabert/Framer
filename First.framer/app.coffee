# First exercise

# Constants

screenWidth = Screen.width
screenHeight = Screen.height
firstButtonSize = 400
firstButtonX = (screenWidth - firstButtonSize) / 2
firstButtonY = (screenHeight - firstButtonSize) / 2 - 50

# Colors

Screen.backgroundColor = "white"

# Layers

firstButton = new Layer(
	width: firstButtonSize
	height: firstButtonSize
	x: firstButtonX
	y: firstButtonY
	borderRadius: 10
	backgroundColor: "#EC7261"
)

firstButton.draggable.enabled = true

# Animations

snapAnimation = (layer, y) ->
	layer.animate
		properties:
			y: y
		curve: "spring(200, 10, 10)"
		
peekAnimation = (layer, scale) ->
	layer.animate
		properties:
			scale: scale
		curve: "spring(200, 10, 10)"
		
levitateAnimation = (layer) ->
	layer.animate
		properties:
			z: 10
		curve: "bezier-curve(0.25, 0.1, 0.25, 1)"
		
# Functions



# Events

firstButton.on Events.DragEnd, () ->
	snapAnimation(firstButton, firstButtonY)

firstButton.on Events.Move, () ->
	if firstButton.x != firstButtonX
		firstButton.x = firstButtonX
		
firstButton.on Events.Click, () ->
	peekAnimation(firstButton, if firstButton.scale < 1.3 then 1.5 else 1)
	
firstButton.on Events.LongPress, (event) ->
	
