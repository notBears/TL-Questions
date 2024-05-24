Jump = {}

jumpminigameWindow       = nil
jumpminigameButton       = nil

--Variables for dealing with moving the button on the x-axis
local xMovement = nil
xStartPosition = 500
xPosition = xStartPosition

local states = {
	jumping       = false
}

--Initalizes the module following outlined pattern from module tutorial on otclient github
function init()
  connect(g_game, { onGameEnd   = Jump.destroy })

  jumpminigameButton = modules.client_topmenu.addRightGameToggleButton('jumpminigameButton', tr('Jump Mini Game'), '/images/topbuttons/spelllist', toggle)
  jumpminigameButton:setOn(false)
  
  jumpminigameWindow = g_ui.displayUI('jumpminigame', modules.game_interface.getRightPanel())
  jumpminigameWindow:hide()
  
  cycleEvent(leftShift, 100)
end

--Terminates the module following the outline pattern from module tutorial on otclient github
function terminate()
  disconnect(g_game, { onGameEnd   = Jump.destroy })
  
  stopEvent()
  
  Jump.destroy()

  jumpminigameButton:destroy()
  
end

--I added my module to the topmenu and gave it toggle ability like other modules in the menu.
function toggle()
  if jumpminigameButton:isOn() then
    jumpminigameButton:setOn(false)
    jumpminigameWindow:hide()
  else
    jumpminigameButton:setOn(true)
    jumpminigameWindow:show()
    jumpminigameWindow:raise()
    jumpminigameWindow:focus()
  end
end


function Jump.destroy()
  if jumpminigameWindow then
    jumpminigameWindow:destroy()
	jumpminigameWindow = nil
  end
end

--Moves the buttons x position to the left and resets it to the right if it reaches the edge of the window.
function leftShift()
  widget = jumpminigameWindow:getChildById('jumpButton')
  xPosition = xPosition - 10
  if xPosition < 50 then
    xPosition = xStartPosition
	widget:setY(math.random(75, 350))
  end
  widget:setX(xPosition)
end

--Moves the button when clicked to a random y location and the right side of the window.
function moveButton(widget)
  widget:setY(math.random(75, 350))
  widget:setX(xStartPosition)
  xPosition = xStartPosition
end


function Jump.resetWindow()
  jumpminigameWindow:hide()
  jumpminigameButton:setOn(false)
end
