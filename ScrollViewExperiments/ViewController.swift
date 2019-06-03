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
        UIColor.brown,
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

    private let targetFraction: CGFloat = 0.5
    private let targetRow = 8
    private static let defaultRowHeight: CGFloat = 120

    private var targetRowHeight: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
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
        if (indexPath.row == targetRow) {
            return targetRowHeight
        }

        return type(of: self).defaultRowHeight // This is going to change for target cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return type(of: self).defaultRowHeight
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let targetCell = tableView.cellForRow(at: IndexPath(row: targetRow, section: 0))
        guard let targetCellY = targetCell?.frame.minY else {
            return
        }

        NSLog("ContentOffset Y : \(tableView.contentOffset.y)")

        let lastTargetRowHeight = targetRowHeight
        if (tableView.contentOffset.y > targetCellY - targetFraction * tableView.frame.height) {
            // ContentOffset is already big.
            targetRowHeight = type(of: self).defaultRowHeight
        } else if (tableView.contentOffset.y < targetCellY - targetFraction * tableView.frame.height - type(of: self).defaultRowHeight) {
            // ContentOffset is small yet.
            targetRowHeight = 0
        } else {
            let baseY = targetCellY - targetFraction * tableView.frame.height - type(of: self).defaultRowHeight
            let diffY = tableView.contentOffset.y - baseY

            targetRowHeight = min(diffY, type(of: self).defaultRowHeight)
        }

        if (lastTargetRowHeight != targetRowHeight) {
            self.tableView.reloadRows(at: [IndexPath(row: self.targetRow, section: 0)], with: .none)
        }
    }
}

