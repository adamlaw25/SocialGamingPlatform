//
//  MessageViewController.swift
//  SocialGamingPlatform
//
//  Created by Adam Law on 10/28/18.
//  Copyright © 2018 Jiahao Luo. All rights reserved.
//

import UIKit
import Firebase
import MessageKit
import MessageInputBar
import FirebaseFirestore

class MessageViewController: MessagesViewController {

    private let db = Firestore.firestore()
    private var reference: CollectionReference?
    private let storage = Storage.storage().reference()
    private let message_limit = 20
    
    private var messages: [Message] = []
    
    func getMessages() -> [Message] {
        return messages
    }
    
    private var messageListener: ListenerRegistration?
    
    deinit {
        messageListener?.remove()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        title = "Message Board"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // the database reference on Firebase
        reference = db.collection(["messages"].joined(separator: "/"))
        
        // set a listener for real-time updating
        messageListener = reference?.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error listening for channel updates: \(error?.localizedDescription ?? "No error")")
                return
            }
            
            snapshot.documentChanges.forEach { change in
                self.handleDocumentChange(change)
            }
        }
        
        // UI settings for the chat room
        self.navigationItem.title = "Chat room"
        
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.inputTextView.tintColor = UIColor.black
        messageInputBar.sendButton.setTitleColor(UIColor.black, for: .normal)
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.incomingMessageTopLabelAlignment = .init(textAlignment: .left, textInsets: .zero)
            layout.textMessageSizeCalculator.outgoingMessageTopLabelAlignment = .init(textAlignment: .right, textInsets: .zero)
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }
    }
    
    // method to handle the displaying of the messages
    private func handleDocumentChange(_ change: DocumentChange) {
        guard let message = Message(document: change.document) else {
            return
        }
        
        switch change.type {
        case .added:
            insertNewMessage(message)
        default:
            break
        }
    }
    
    // method to save new user outgoing message
    private func save(_ message: Message) {
        reference?.addDocument(data: message.representation) { error in
            if let e = error {
                print("Error sending message: \(e.localizedDescription)")
                return
            }
            
            self.messagesCollectionView.scrollToBottom()
        }
    }
    
    // method to insert a message to the message board
    private func insertNewMessage(_ message: Message) {
        guard !messages.contains(message) else {
            return
        }
        
        messages.append(message)
        messages.sort()
        
        let isLatestMessage = messages.index(of: message) == (messages.count - 1)
        let shouldScrollToBottom = isLatestMessage
        
        //added a check method to check if the no of messages exceed 20
        let msgCtr = messages.count
        print(msgCtr)
        if msgCtr > message_limit {
           self.messages = Array(messages[msgCtr-message_limit...msgCtr-1])
        }
        
        messagesCollectionView.reloadData()
        
        if shouldScrollToBottom {
            DispatchQueue.main.async {
                self.messagesCollectionView.scrollToBottom(animated: true)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// delegate for displaying the chat room
extension MessageViewController: MessagesDisplayDelegate {
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? UIColor.blue : UIColor.green
    }
    
    func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> Bool {
        return false
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
    
    // sender name label
    func messageTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let name = message.sender.displayName
        return NSAttributedString(
            string: name,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor(white: 0.3, alpha: 1)
            ]
        )
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 20
    }
    
    // sent date label
    func cellTopLabelAttributedText(for message: MessageType,
                                    at indexPath: IndexPath) -> NSAttributedString? {
        
        return NSAttributedString(string: MessageKitDateFormatter.shared.string(from: message.sentDate), attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 10), NSAttributedString.Key.foregroundColor: UIColor.darkGray])
    }
    
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 12
    }
}

// the layout delegate for the chat room
extension MessageViewController: MessagesLayoutDelegate {
    
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    func footerViewSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 8)
    }
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 0
    }
    
}

// the data source delegate for returning the messages
extension MessageViewController: MessagesDataSource {
    // return the number of sections
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    // return the current sender
    func currentSender() -> Sender {
        return Sender(id: Constants.refs.getCurrentUserID(), displayName: Constants.refs.getCurrentUserEmail())
    }
    
    // return the number of messages
    func numberOfMessages(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    // return the sepecific message
    func messageForItem(at indexPath: IndexPath,
                        in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        return messages[indexPath.section]
    }
}

// the user input set-up
extension MessageViewController: MessageInputBarDelegate {
    
    // save the input as content message
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let message = Message(content: text)
        save(message)
        inputBar.inputTextView.text = ""
    }
    
}
