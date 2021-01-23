//
//  TableCell.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import UIKit

enum TableCell: String, CaseIterable {
    
    case title
    
//    //  Drawer
//    case drawer_header
//    case drawer_item
//
//    //  Input
//    case textfield
//    case phone_no
//    case password
//    case otp
//    case button
//    case picker_field
//
//    //  Question
//    case ques_title
//    case ques_multiple
//    case ques_dropdown
//    case ques_datetime
//    case ques_sub_answer
//
//    //  Payment
//    case payment_channel
//
//    //  Misc
//    case terms_n_privacy
//    case logo
//    case empty
//    case landing_screen
//    case header
//    case gender
//    case line
}

extension TableCell: FormCellProvider {
    
    var cellType: FormCellType {
        switch self {
        default: return .read
        }
    }
    
    var identifier: String {
        switch self {
        case .title: return UITableView.Cell.TABLE_CELL.value
        }
    }
    
    var cellForm: AnyClass {
        switch self {
        case .title: return UITableViewCell.self
        }
    }
}
