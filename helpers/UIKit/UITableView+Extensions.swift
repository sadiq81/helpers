//
// Created by Tommy Hinrichsen on 22/02/2018.
// Copyright (c) 2018 Parkzone. All rights reserved.
//

import Foundation
import UIKit


extension UITableView {

    public func addCorners(cell: UITableViewCell, tableView: UITableView, indexPath: IndexPath) {
        
        let rows: Int = tableView.numberOfRows(inSection: indexPath.section) - 1
        let layer = CAShapeLayer()
        var addSeparator = false
        if indexPath.row == 0 && indexPath.row == rows {
            layer.path = UIBezierPath(roundedRect: cell.bounds, cornerRadius: 12).cgPath
        } else if indexPath.row == 0 {
            layer.path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 12.0, height: 12.0)).cgPath
            addSeparator = true
        } else if indexPath.row == rows {
            layer.path = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 12.0, height: 12.0)).cgPath
        } else {
            layer.path = UIBezierPath(rect: cell.bounds).cgPath
            addSeparator = true
        }

        cell.mask = UIView(frame: cell.bounds)
        cell.mask?.layer.insertSublayer(layer, at: 0)
        if addSeparator == true {
            let separator: CGFloat = 1.0 / UIScreen.main.scale
            let cellSeparator = CALayer()
            cellSeparator.frame = CGRect(x: 0, y: cell.bounds.size.height - separator, width: cell.bounds.size.width - 15.0, height: separator)
            cellSeparator.backgroundColor = tableView.separatorColor?.cgColor
            cell.layer.addSublayer(cellSeparator)
        }
        cell.mask?.layer.masksToBounds = true
        cell.clipsToBounds = true
    }
}

