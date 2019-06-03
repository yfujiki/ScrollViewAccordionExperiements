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
    private let targetRows = [8, 10]
    private static let defaultRowHeight: CGFloat = 120

    private var targetRowsHeight: [CGFloat] = [0, 0]

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
        for (index, targetRow) in targetRows.enumerated() {
            if (targetRow == indexPath.row) {
                return targetRowsHeight[index]
            }
        }

        return type(of: self).defaultRowHeight // This is going to change for target cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return type(of: self).defaultRowHeight
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let targetCells = targetRows.compactMap { (targetRow) -> UITableViewCell? in
            return tableView.cellForRow(at: IndexPath(row: targetRow, section: 0))
        }

        for (index, targetCell) in targetCells.enumerated() {
            let targetCellY = targetCell.frame.minY

            NSLog("ContentOffset Y : \(tableView.contentOffset.y)")

            let lastTargetRowHeight = targetRowsHeight[index]
            if (tableView.contentOffset.y > targetCellY - targetFraction * tableView.frame.height) {
                // ContentOffset is already big.
                targetRowsHeight[index] = type(of: self).defaultRowHeight
            } else if (tableView.contentOffset.y < targetCellY - targetFraction * tableView.frame.height - type(of: self).defaultRowHeight) {
                // ContentOffset is small yet.
                targetRowsHeight[index] = 0
            } else {
                let baseY = targetCellY - targetFraction * tableView.frame.height - type(of: self).defaultRowHeight
                let diffY = tableView.contentOffset.y - baseY

                targetRowsHeight[index] = min(diffY, type(of: self).defaultRowHeight)
            }

            if (lastTargetRowHeight != targetRowsHeight[index]) {
                self.tableView.reloadRows(at: [IndexPath(row: self.targetRows[index], section: 0)], with: .none)
            }
        }
    }
}

