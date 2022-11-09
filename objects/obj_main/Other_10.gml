
// Feather disable GM2016
// Feather disable GM2017
// Feather disable GM1041
// Feather disable GM1058
// Feather disable GM1064
// Feather disable GM1033
;

// Create our Parent Frame
masterFrame = new Frame(window_width,window_height,0,10)
masterFrame.elementStartDirection = horizontal
masterFrame.margin = [10, 10]
masterFrame.drawSelf = function() {}
masterFrame.movable = false
masterFrame.displacing = false
masterFrame.winX = 15
masterFrame.winY = 15

	// Create our Left Frame
	leftFrameWidth = 350
	leftFrame = new Frame(leftFrameWidth,window_height,0,10)
	leftFrame.margin = [0,0]
	leftFrame.drawSelf = function() {}
	leftFrame.elementStartDirection = vertical
	
		topicBrowser = new Frame(infinity,400,5)
		topicBrowser.elementStartDirection = horizontal
		
			e = new TextElement("aolim2   //   topic browser")
			
			e = new LayoutSwitch(true)
			
			scrubwareText = new TextElement("[c_white][fa_right][rainbow][wave]scrubware")
			scrubwareText.alpha = 0
			
			with scrubwareText {
				move = function(x,y) {
					return [parentFrame.frameAnchor[X2] * 0.95, y]
				}
				step = function() {
					if parentFrame.frameAnchor[X2] < 320 {
						alpha = max(alpha - 0.08,0)
					} else {
						alpha = min(alpha + 0.08,1)
					}
					
					scribbleText.blend(c_white,alpha)	
				}
			}
		
			
			e = new Divider()
			
			phillyTestChannel = new Channel("philly cheesesteaks")
			generalChannel = new Channel("general")
			
			generalChannel.addNotification(34,99)
			generalChannel.addNotification(34,99)
			
		topicBrowser.pop_element_scope()
	
		
	
		// Resize Dragger
		leftFrameDragger = new Dragger(5,30,10)
		leftFrameDragger.step = function() {
			topicBrowser.idealHeight = leftFrameDragger.run(topicBrowser.idealHeight)
		}

		// Extra Browser
		extraBrowser = new Frame(infinity,infinity,5)
		extraBrowser.margin = [0,0]
		extraBrowser.elementStartDirection = horizontal
		
			// Extra Browser Elements
			serverListWidth = 55

			serverList = new Frame(serverListWidth,infinity,0)
			serverList.drawSelf = function() {}
			
				iconTest = new Icon(infinity,c_black,5,spr_boif,4,0.9); serverList.addElement(iconTest); serverList.addElement(iconTest);
				iconTest.outline = false
				
				settingsButton = new Button()
				
			serverList.pop_element_scope()

			e = new Padding(2,0)
			e = new Divider(5,0,0)
			
			userList = new Frame(infinity,infinity,0)
			userList.elementPadding = 5
			userList.drawSelf = function() {}
			
				memberListTitle = new TextElement("member list   //   [[server name]")
			
				e = new Divider()
				
			userList.pop_element_scope()
				
		extraBrowser.pop_element_scope()
		
	leftFrame.pop_element_scope()
		
	betweenFrameDragger = new Dragger(5,80,10)
	betweenFrameDragger.step = function() {
		leftFrame.idealWidth = betweenFrameDragger.run(leftFrame.idealWidth)	
	}
	
	rightFrame = new Frame(infinity, infinity, 0, 10)
	rightFrame.drawSelf = function() {}
	rightFrame.margin = [0,0]
	rightFrame.elementStartDirection = horizontal
	
		// Right Frame Elements
		chatNumber = 3
		chats = array_create(chatNumber)
	
		for (var i = 0; i < chatNumber; i ++) {
			chats[i] = new ChatWindow()
		
			chats[i].chatIndex = i
			chats[i].chatNumber = chatNumber
			chats[i].colorFrame.color = uibase.colorSettings.chatWindow[i % (array_length(uibase.colorSettings.chatWindow)) ]
		
			with chats[i] {
				updateIdealSize = function() {
					//idealWidth = (parentFrame.width / chatNumber) -  (chatNumber = 1 ? 0 : (parentFrame.elementPadding * 2) + chatNumber )
					idealWidth = (parentFrame.width - (chatNumber - 1) * parentFrame.elementPadding * 2) / chatNumber
				}
			}
		
			e = new Padding()
		}
		
	rightFrame.pop_element_scope()
masterFrame.pop_element_scope()


stockUserJimmy = new User("jimmy",0,#85fcc9)
stockUserQuentin = new User("Quentin",4,#ff2d79)
stockUserBigShot = new User("[[[[BIG SHOT]]",9,#8be0ff)

stockTime = new Time()

chats[0].add_to_element_scope(chats[0])
	stockMessage = new ChatMessage(stockUserJimmy,"[c_red]among us!",stockTime)
	stockMessage = new ChatMessage(stockUserQuentin,"[spr_emoji] you did not just say [c_red]among us [/color]!",stockTime)
	stockMessage = new ChatMessage(stockUserBigShot,"[c_dkgray]...",stockTime)
	stockMessage = new ChatMessage(stockUserBigShot,"neither of you",stockTime)
	stockMessage = new ChatMessage(stockUserBigShot,"neither of you will ever be",stockTime)
	stockMessage = new ChatMessage(stockUserBigShot,"[c_dkgray][[[[BIG SHOTS]] [/color][spr_emoji]",stockTime)
chats[0].pop_element_scope()


popupFrame = new Frame(400,300,5)
popupFrame.winX = 100
popupFrame.winY = 100

	// Popup Frame Elements
	
	e = new TextElement("[c_dkgray]Wow! It's a popup!")

popupFrame.pop_element_scope()