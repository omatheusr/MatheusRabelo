//
//  InterfaceController.swift
//  MatheusRabelo WatchKit Extension
//
//  Created by Matheus Oliveira Rabelo on 20/04/15.
//  Copyright (c) 2015 Matheus. All rights reserved.
//

import WatchKit
import Foundation


class REMainInterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @IBAction func openConfig() {
        self.pushControllerWithName("interfaceConfig", context: nil)
    }
    
}
