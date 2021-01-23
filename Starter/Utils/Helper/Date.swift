//
//  Date.swift
//  Starter
//
//  Created by Nizzammuddin on 22/01/2021.
//

import Foundation

struct DateHelper {
    
    enum DateFormatterEnum: String {
        /// DateTime Format
        case dd_MM_yyyy__HH_mm_ss = "dd-MM-yyyy HH:mm:ss" /// 21-07-1999 19:20:00
        case dd__MMM__yyyy__h_mm_a = "dd/MM/yyyy h:mm a" /// 21/07/1999 7:20 PM
        case dd_MMM_yyyy__h_mm_ss_a = "dd-MMMM-yyyy h:mm:ss a" /// 21-July-1999 7:20:00 PM
        case dd_MM_yyyy = "dd-MM-yyyy" ///  28-07-1999
        case dd_MMM_yyyy = "dd-MMM-yyyy" /// 28-July-1999
        case dd_MMM_h_mm_a = "dd MMM, hh:mm" /// 04 Oct, 10:13 AM
        case dd__MM__yyyy = "dd MM yyyy" /// 04 05 2019
        case dd__MMM__yyyy = "dd MMM yyyy" /// 04 May 2019
        case dd_MMM = "dd MMM" /// 01 May
        case EE_dd_MMM = "EE, dd MMM" /// Wed, 01 May
        case EEEE_dd_MMM = "EEEE, dd MMM" /// Wednesday, 01 May
        case h_mm_a = "h:mm a" ///  7:20 PM
        case hh_mm_a = "hh:mm a" ///  07:20 PM
        case HH_mm_a = "HH:mm" /// 19:20
        case HH_mm_ss = "HH:mm:ss" ///  19:20:00
        case HHmm = "HHmm" ///  1920
        case MMM_yyyy = "MMM yyyy" /// Oct 2019
        case MMMM_yyyy = "MMMM yyyy" /// October 2019
        case yyMMdd = "yyMMdd" /// 191001
        case yyyy_MM_dd_HH_mm_ss_Z = "yyyy-MM-dd HH:mm:ss Z" /// 2019-05-01 08:00:00 +0000
        case yyyy_MM_dd_HH_mm_ss = "yyyy-MM-dd HH:mm:ss" /// 2019-05-01 08:00:00
        case yyyy_MM_dd__HH_mm = "yyyy-MM-dd HH:mm" /// 1999-07-21 19:20
        case yyyy_MM_dd = "yyyy-MM-dd" /// 2019-05-01
        case yyyy = "yyyy" /// 2019
        case yyyyMMdd_HHmmss = "yyyyMMdd HHmmss" /// 20191004 101329
        case yyyyMMdd = "yyyyMMdd" /// 19560812
        case yyyy__MM__dd = "yyyy/MM/dd" /// 1956/08/12
        case dd___MM___yyyy = "dd/MM/yyyy" /// 12/08/1956
    }
    
    static func returnString(inputFormat: DateFormatterEnum,
                             outputFormat: DateFormatterEnum,
                             dateTime: String) -> String? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = inputFormat.rawValue
        inputDateFormatter.timeZone = TimeZone.current
        let inputDate = inputDateFormatter.date(from: dateTime) ?? Date()
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat.rawValue
        outputFormatter.timeZone = TimeZone.current
        let op = outputFormatter.string(from: inputDate)
        return op
    }
    
    static func returnDate(inputFormat: DateFormatterEnum,
                           outputFormat: DateFormatterEnum,
                           dateTime: String) -> Date {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = inputFormat.rawValue
        inputDateFormatter.timeZone = TimeZone.current
        let inputDate = inputDateFormatter.date(from: dateTime) ?? Date()
        let inputString = inputDateFormatter.string(from: inputDate)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat.rawValue
        outputFormatter.timeZone = TimeZone.current
        return outputFormatter.date(from: inputString) ?? Date()
    }
    
    static func fromDateReturnString(inputFormat: DateFormatterEnum,
                                     outputFormat: DateFormatterEnum,
                                     dateTime: Date) -> String? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = inputFormat.rawValue
        inputDateFormatter.timeZone = TimeZone.current
        let inputDateStr = inputDateFormatter.string(from: dateTime)
        let inputDate = inputDateFormatter.date(from: inputDateStr) ?? Date()
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat.rawValue
        inputDateFormatter.timeZone = TimeZone.current
        return outputFormatter.string(from: inputDate)
    }
    
    static func fromDateReturnDate(inputFormat: DateFormatterEnum,
                                   outputFormat: DateFormatterEnum,
                                   dateTime: Date) -> Date? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = inputFormat.rawValue
        inputDateFormatter.timeZone = TimeZone.current
        let inputDateStr = inputDateFormatter.string(from: dateTime)
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = outputFormat.rawValue
        outputFormatter.timeZone = TimeZone.current
        return outputFormatter.date(from: inputDateStr)
    }
    
    static func getCurrentDateTimeReturnString(format: DateFormatterEnum) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = format.rawValue
        dateFormatterGet.timeZone = TimeZone.current
        return dateFormatterGet.string(from: Date())
    }
}
