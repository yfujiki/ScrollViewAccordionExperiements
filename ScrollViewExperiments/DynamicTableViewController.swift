//
//  ViewController.swift
//  ScrollViewExperiments
//
//  Created by Yuichi Fujiki on 6/2/19.
//  Copyright © 2019 Yuichi Fujiki. All rights reserved.
//

import UIKit


class DynamicTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var texts = [
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        "",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    ]

    private let targetFraction: CGFloat = 0.5
    private var defaultRowsHeight = [IndexPath: CGFloat]()

    private let targetRows = [8, 10]
    private let targetRowsDefaultHeight: [CGFloat] = [120, 120]
    private var targetRowsHeight: [CGFloat] = [0, 0]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension DynamicTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (targetRows.contains(indexPath.row)) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell")!
            cell.backgroundColor = UIColor.yellow
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell") as! LabelTableViewCell
            cell.contentTextLabel.text = texts[indexPath.row]
            return cell
        }
    }
}

extension DynamicTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        defaultRowsHeight[indexPath] = cell.frame.height
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        for (index, targetRow) in targetRows.enumerated() {
            if indexPath.row == targetRow {
                return targetRowsHeight[index]
            }
        }

        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return defaultRowsHeight[indexPath] ?? 44
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let targetCells = targetRows.compactMap { (targetRow) -> UITableViewCell? in
            return tableView.cellForRow(at: IndexPath(row: targetRow, section: 0))
        }

        var indexPathsToReload = [IndexPath]()
        for (index, targetCell) in targetCells.enumerated() {
            let targetCellY = targetCell.frame.minY

            NSLog("ContentOffset Y : \(tableView.contentOffset.y)")

            let lastTargetRowHeight = targetRowsHeight[index]
            let defaultHeight = targetRowsDefaultHeight[index]
            if (tableView.contentOffset.y > targetCellY - targetFraction * tableView.frame.height) {
                // ContentOffset is already big.
                targetRowsHeight[index] = defaultHeight
            } else if (tableView.contentOffset.y < targetCellY - targetFraction * tableView.frame.height - defaultHeight) {
                // ContentOffset is small yet.
                targetRowsHeight[index] = 0
            } else {
                let baseY = targetCellY - targetFraction * tableView.frame.height - defaultHeight
                let diffY = tableView.contentOffset.y - baseY

                targetRowsHeight[index] = min(diffY, defaultHeight)
            }

            if (lastTargetRowHeight != targetRowsHeight[index]) {
                indexPathsToReload.append(IndexPath(row: self.targetRows[index], section: 0))
            }
        }
        if (!indexPathsToReload.isEmpty) {
            tableView.reloadRows(at: indexPathsToReload, with: .none)
        }
    }
}

