# First exercise

# Constants

screenWidth = Screen.width
screenHeight = Screen.height

firstButtonSize = 300
firstButtonX = (screenWidth - firstButtonSize) / 2
firstButtonY = (screenHeight - firstButtonSize) / 2 - 50
firstButtonZ = 200

shadowSize = firstButtonSize - 20
shadowZ = 100

# Layers

backgroundLayer = new Layer(
	width: screenWidth
	height: screenHeight
	backgroundColor: "#CECECE"
)

firstButton = new Layer(
	width: firstButtonSize
	height: firstButtonSize
	x: firstButtonX
	y: firstButtonY
	z: firstButtonZ
	borderRadius: 10
	backgroundColor: "#EC7261"
	superLayer: backgroundLayer
	clip: true
)

reflectionLayer = new Layer(
	width: 1300
	height: 1300
	opacity: 0.4
	superLayer: firstButton
)

shadowLayer = new Layer(
	width: shadowSize
	height: shadowSize
	z: shadowZ
	opacity: 0.15
	backgroundColor: "black"
	blur: 10
	superLayer: backgroundLayer
)

textLayer = new Layer(
	width: firstButtonSize
	z: 50
	html: "Framer"
	backgroundColor: "transparent"
)

textLayer.midX = firstButton.midX
textLayer.minY = firstButton.maxY + 40
textLayer.style = 
	"color": "white"
	"font-family" : "Helvetica"
	"font-size" : "40px"
	"text-align" : "center"
	"text-shadow": "2px 3px 2px #A9A9A9"
	
reflectionLayer.style =
	"background": "radial-gradient( rgba(255,255,255,1) 0%, rgba(255,255,255,0) 60%)"

shadowLayer.y = firstButton.maxY - shadowSize + 20
shadowLayer.midX = firstButton.midX

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

# Events

backgroundLayer.on Events.MouseMove, (event) ->
	divider = 20
	layerRotationX = (firstButton.midY - event.y) / divider
	layerRotationY = (event.x - firstButton.midX) / divider
	firstButton.rotationX = layerRotationX
	firstButton.rotationY = layerRotationY
	shadowLayer.rotationX = layerRotationX / 2
	shadowLayer.rotationY = layerRotationY / 2
	reflectionLayer.y = -(400 - event.y + firstButton.minY)
	reflectionLayer.x =  -(400 - event.x + firstButton.minX)

firstButton.on Events.DragEnd, () ->
	snapAnimation(firstButton, firstButtonY)

firstButton.on Events.Move, () ->
	if firstButton.x != firstButtonX
		firstButton.x = firstButtonX
		
firstButton.on Events.Click, () ->
	scale = if firstButton.scale < 1.3 then 1.5 else 1
	peekAnimation(firstButton, scale)
	peekAnimation(shadowLayer, scale)