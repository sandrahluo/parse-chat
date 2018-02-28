//
//  ChatViewController.swift
//  parse-chat
//
//  Created by Sandra Luo on 2/22/18.
//  Copyright © 2018 Sandra Luo. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var chatTable: UITableView!
    @IBOutlet weak var messageField: UITextField!
    
    var messages:[PFObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTable.delegate = self as? UITableViewDelegate
        chatTable.dataSource = self
        fetchMessages()
        
        chatTable.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height for calculating scroll indicator height
        chatTable.estimatedRowHeight = 50
    }
    
    // Action to take when the send button is pressed
    @IBAction func sendPressed(_ sender: Any) {
        
        let chatMessage = PFObject(className: "Message")
        chatMessage["user"] = PFUser.current()
        // store the text message content, or empty string if the field is blank
        chatMessage["text"] = messageField.text ?? ""
        chatMessage.saveInBackground{ (success, error) in
            if success {
                print("the message was saved!")
                // fetch messages to display the message that was just sent
                self.fetchMessages()
                self.messageField.text = ""
            }
            else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    // required function for UITableViewDelegate protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count;
    }
    
    // required function for UITableViewDelegate protocol
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTable.dequeueReusableCell(withIdentifier: "chatCell", for : indexPath) as! chatCell
        let chatMessage = messages[indexPath.row]
        cell.messageLabel.text = chatMessage["text"] as? String
        
        if let user = chatMessage["user"] as? PFUser {
            // update username label if user found
            cell.usernameLabel.text = user.username
        } else {
            // set default username if no user found
            cell.usernameLabel.text = "🤖"
        }
        
        return cell
    }
    
    // set timer to fetch chats from Parse every second
    @objc func onTimer() {
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
    }
    
    // get messages from Parse
    @objc func fetchMessages() {
        let query = PFQuery(className: "Message")
        query.includeKey("user")
        query.addDescendingOrder("createdAt")
        
        query.findObjectsInBackground { (response, error) in
            if let messages = response {
                // save the message in array and reload chat table accordingly
                self.messages = messages
                self.chatTable.reloadData()
            } else {
                print("Error with fetching messages")
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
