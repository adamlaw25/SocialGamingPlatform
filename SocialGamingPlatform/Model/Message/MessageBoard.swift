//
//  MessageBoard.swift
//  SocialGamingPlatform
//
//  Created by Adam Law on 10/28/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import Foundation

//a class that represents the message board
class MessageBoard {
	var maxShownMessages = 10
	var latestMessages: [Message]
	var editingMessage: Message?

    //contructor
	init() {
		self.latestMessages = []
	}
}
