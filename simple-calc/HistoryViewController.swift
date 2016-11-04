//
//  HistoryViewController.swift
//  simple-calc
//
//  Created by Andrew Kan on 11/2/16.
//  Copyright © 2016 Andrew Kan. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var calcHistory: [String] = []

    @IBOutlet weak var scrollView: UIScrollView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        var interval = 0
        for calc in calcHistory {
            let label = UILabel(frame: CGRect(x: 50, y: interval * 30, width: Int(self.view.frame.size.width), height: 100))
            label.text = calc
            interval += 1
            self.scrollView?.addSubview(label)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "toCalculatorView" {
            let viewController = segue.destination as! ViewController
            viewController.history = calcHistory
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
