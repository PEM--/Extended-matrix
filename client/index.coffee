Transform = famous.core.Transform
View = famous.core.View
StateModifier = famous.modifiers.StateModifier
Surface = famous.core.Surface

class Slide extends View
  constructor: (options) ->
    super()
    @mod = new StateModifier
      size: [400, 300]
      origin: [.5, .5]
      align: [.5, .5]
      transform: options.transform
    surf = new Surface
      content: options.content
      classes: ['slide']
      properties: backgroundColor: options.color
    (@add @mod).add surf
    options.renderNode.add @
  getTransform: -> @mod.getFinalTransform()

Template.index.rendered = ->
  Engine = famous.core.Engine
  Easing = famous.transitions.Easing

  mainCtx = Engine.createContext()
  mainCtx.setPerspective 1000

  @deckMod = new StateModifier
  renderNode = mainCtx.add @deckMod

  @slideDeck = [
    new Slide
      content: 'Slide1'
      color: CSSC.red
      renderNode: renderNode
      transform: Transform.rotateY Math.PI/4
    new Slide
      content: 'Slide2'
      color: CSSC.green
      renderNode: renderNode
      transform: Transform.translate 0, 300, 0
    new Slide
      content: 'Slide3'
      color: CSSC.navy
      renderNode: renderNode
      transform: Transform.multiply \
        (Transform.translate 0, 650, 0), (Transform.rotateZ Math.PI/2)
    new Slide
      content: 'Slide4'
      color: CSSC.maroon
      renderNode: renderNode
      transform: Transform.multiply \
        (Transform.translate 300, 650, 0), (Transform.rotateZ 3*Math.PI/2)
  ]
  @currentSlide = 0
  @deckMod.setTransform (Transform.inverse \
    @slideDeck[@currentSlide].getTransform())

  Engine.on 'click', =>
    @currentSlide = if @currentSlide is @slideDeck.length - 1 \
      then 0 else @currentSlide + 1
    @deckMod.setTransform (Transform.inverse \
      @slideDeck[@currentSlide].getTransform()),
      duration: 1000
      curve: Easing.inOutQuart
