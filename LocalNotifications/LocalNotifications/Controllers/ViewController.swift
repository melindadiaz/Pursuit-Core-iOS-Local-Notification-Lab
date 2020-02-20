//
//  ViewController.swift
//  LocalNotifications
//
//  Created by Melinda Diaz on 2/20/20.
//  Copyright © 2020 Melinda Diaz. All rights reserved.
//

import UIKit
//step1
protocol CreateNotificationControllerDelegate: AnyObject {
    func didCreateNotification(_ NotificationViewController: ViewController)
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var timeDatePickerView: UIDatePicker!
    @IBOutlet weak var timeProgressBar: UIProgressView!
    //step2
    weak var delegate: CreateNotificationControllerDelegate?
    private var timeInterval: TimeInterval = Date().timeIntervalSinceNow + 5
    private var hours = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
    //A range is already considered an array
    private var minutes = 0...60
    private var seconds = 0...60
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    func todaysDate() {
        let _ = Date()
        let instance = DateFormatter()
        instance.dateFormat = "HH:mm:ss"
        
        
    }
    
    private func createLocalNotification() {
        //THISFUNCstep1: create the content WHat is the content of theta notificatiom
        //mutable you can change that content therer is mutable and immutable so this is how we change the content TIME 12pm
        let content = UNMutableNotificationContent()
        content.title = textField.text ?? "No title"
        content.body = "Local Notifications is awesome when used appropriately"
        content.subtitle = "Learning Local Notifications"
        content.sound = .default //only works in the background and the app is not on silent - pleae test on devise
        //TODO: you can also import your own sound file similar to adding the file for the leo.
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "yourfile.mp3"))
        let identifier = UUID().uuidString
        if let imageURL = Bundle.main.url(forResource: "hourglass", withExtension: "jpeg"){
            do {
                //we use a bundle file in order to attach it but right now we are getting an errror that UNNOtifications THROWS so we have to take it an put it in a doCatch
                let attachment = try UNNotificationAttachment(identifier: identifier , url: imageURL, options: nil)
                content.attachments = [attachment]
            } catch {
                print("error with attachment: \(error)")
            }
        } else {
            print("image resources ")
        }
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("error adding request: \(error)")
            } else {
                print("request was successfully added")
            }
        }
    }
    
    @IBAction func activateButtonPressed(_ sender: UIButton) {
    }
    @IBAction func timePickerChange(_ sender: UIPickerView){
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        createLocalNotification()
        //step 3 custom delegate
        delegate?.didCreateNotification(self)
        dismiss(animated: true)
    }
}

