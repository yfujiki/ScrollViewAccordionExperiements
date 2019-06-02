//
//  ViewController.swift
//  ScrollViewExperiments
//
//  Created by Yuichi Fujiki on 6/2/19.
//  Copyright © 2019 Yuichi Fujiki. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var colors = [
        UIColor.red,
        UIColor.blue,
        UIColor.yellow,
        UIColor.black,
        UIColor.green,
        UIColor.gray,
        UIColor.purple,
        UIColor.orange,
        UIColor.cyan,
        UIColor.brown
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }


//    @objc func panGestureDetected(gestureRecognizer: UIPanGestureRecognizer) {
//        let translation = gestureRecognizer.translation(in: scrollView)
//        let velocity = gestureRecognizer.velocity(in: scrollView)
//        NSLog("Pan gesture detected. Translation : \(translation), Velocity : \(velocity)")
//    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.backgroundColor = colors[indexPath.row]
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88 // This is going to change for target cell
    }
}

