timer = 0
menuTimer = 0
exitTimer = 0
leaveTimer = 0
spawnTrigger = true

exiting = false

uibase = new UiBase()

window_set_caption("AOLIM2")

display_reset(8,true)

signinFrame = new Frame(300,400,10)
signinFrame.moving = false
signinFrame.displacing = false

//e = new TextElement("username")

signinFrame.pop_element_scope()

