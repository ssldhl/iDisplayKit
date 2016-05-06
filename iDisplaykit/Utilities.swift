//
//  Utilities.swift
//  iDisplaykit
//
//  Created by Sushil Dahal on 5/6/16.
//  Copyright © 2016 TechGuthi. All rights reserved.
//

import Foundation
import UIKit

let StrokeRoundedImages: Bool = false

extension UIColor{
    class func darkBlueColor()->UIColor{
        return UIColor(red: 70.0/255.0, green:102.0/255.0, blue:118.0/255.0, alpha:1.0)
    }
    
    class func lightBlueColor()->UIColor{
        return UIColor(red: 70.0/255.0, green:165.0/255.0, blue:196.0/255.0, alpha:1.0)
    }
}

extension UIImage {
    class func followingButtonStretchableImageForCornerRadius(cornerRadius: CGFloat, following followingEnabled: Bool) -> UIImage {
        let unstretchedSize: CGSize = CGSizeMake(2 * cornerRadius + 1, 2 * cornerRadius + 1)
        let rect: CGRect = CGRect(origin: CGPointZero, size: unstretchedSize)
        let path: UIBezierPath = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        
//        create a graphics context for the following status button
        UIGraphicsBeginImageContextWithOptions(unstretchedSize, false, 0)
        
        path.addClip()
        
        if followingEnabled{
            UIColor.whiteColor().setFill()
            path.fill()
            
            path.lineWidth = 3
            UIColor.lightBlueColor().setStroke()
            path.stroke()
        }else{
            UIColor.lightBlueColor().setFill()
            path.fill()
        }
        
        let followingBtnImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let followingBtnImageStretchable: UIImage = followingBtnImage.stretchableImageWithLeftCapWidth(Int(cornerRadius), topCapHeight: Int(cornerRadius))
        return followingBtnImageStretchable
        
    }
    
    class func downloadImageForURL(url: NSURL, completion block: ((image: UIImage?) -> Void)?) {
        var simpleImageCache: NSCache? = nil
        var onceToken: Int = dispatch_once_t()
        dispatch_once(&onceToken) { 
            simpleImageCache = NSCache()
            simpleImageCache?.countLimit = 10
        }
        
        if(block != nil){
//            check if image is cached
            let image: UIImage? = simpleImageCache?.objectForKey(url) as? UIImage
            
            if(image != nil){
                dispatch_async(dispatch_get_main_queue(), { 
                    block!(image: image)
                })
            }else{
//                else download image
                let session: NSURLSession = NSURLSession(configuration: NSURLSessionConfiguration.ephemeralSessionConfiguration())
                let task: NSURLSessionDataTask = session.dataTaskWithURL(url, completionHandler: { (data: NSData?, response: NSURLResponse?, error: NSError?) in
                    if(data != nil){
                        let image: UIImage? = UIImage(data: data!)
                        dispatch_async(dispatch_get_main_queue(), { 
                            block!(image: image)
                        })
                    }
                })
                task.resume()
            }
        }
    }
    
    func makeCircularImageWithSize(size: CGSize) -> UIImage {
//        make a CGRect with the image's size
        let circleRect: CGRect = CGRect(origin: CGPointZero, size: size)
        
//        begin the image context since we're not in a drawRect:
        UIGraphicsBeginImageContextWithOptions(circleRect.size, false, 0)
        
//        create a UIBezierPath circle
        let circle: UIBezierPath = UIBezierPath(roundedRect: circleRect, cornerRadius: circleRect.size.width / 2)
        
//        clip to the circle
        circle.addClip()
        
//        draw the image in the circleRect *AFTER* the context is clipped
        drawInRect(circleRect)
        
//        create a border (for white background pictures)
        if StrokeRoundedImages{
            circle.lineWidth = 1
            UIColor.darkGrayColor().set()
            circle.stroke()
        }
        
//        get an image from the image context
        let roundedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
//        end the image context since we're not in a drawRect:
        UIGraphicsEndImageContext()
        
        return roundedImage
        
    }
}

extension NSString {
    // Returns a user-visible date time string that corresponds to the
    // specified RFC 3339 date time string. Note that this does not handle
    // all possible RFC 3339 date time strings, just one of the most common
    // styles.
    class func userVisibleDateTimeStringForRFC3339DateTimeString(rfc3339DateTimeString: String)->NSDate?{
        var rfc3339DateFormatter: NSDateFormatter
        var enUSPOSIXLocale: NSLocale
        
        // Convert the RFC 3339 date time string to an NSDate.
        rfc3339DateFormatter = NSDateFormatter()
        enUSPOSIXLocale = NSLocale(localeIdentifier: "en_US_POSIX")
        rfc3339DateFormatter.locale = enUSPOSIXLocale
        rfc3339DateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZ'"
        rfc3339DateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        return rfc3339DateFormatter.dateFromString(rfc3339DateTimeString)
    }
    
    // returns a user friendly elapsed time such as '50s', '6m' or '3w'
    class func elapsedTimeStringSinceDate(uploadDateString: String) -> String {
        var elapsedTime: String = "ERROR"
        let postDate: NSDate? = userVisibleDateTimeStringForRFC3339DateTimeString(uploadDateString)
        if(postDate != nil){
            let currentDate: NSDate = NSDate()
            
            let calendar: NSCalendar = NSCalendar.currentCalendar()
            
            let seconds: Int = calendar.components(NSCalendarUnit.Second, fromDate: postDate!, toDate: currentDate, options: NSCalendarOptions(rawValue: 0)).second
            let minutes: Int = calendar.components(NSCalendarUnit.Second, fromDate: postDate!, toDate: currentDate, options: NSCalendarOptions(rawValue: 0)).minute
            let hours: Int = calendar.components(NSCalendarUnit.Second, fromDate: postDate!, toDate: currentDate, options: NSCalendarOptions(rawValue: 0)).hour
            let days: Int = calendar.components(NSCalendarUnit.Second, fromDate: postDate!, toDate: currentDate, options: NSCalendarOptions(rawValue: 0)).day
            
            if(days > 7){
                elapsedTime = "\(Int(days/7))"
            }else if(days > 0){
                elapsedTime = "\(days)"
            }else if(hours > 0){
                elapsedTime = "\(hours)"
            }else if(minutes > 0){
                elapsedTime = "\(minutes)"
            }else if(seconds > 0){
                elapsedTime = "\(seconds)"
            }else if(seconds == 0){
                elapsedTime = "1s"
            }
        }
        
        return elapsedTime
    }
}

extension NSAttributedString {
    class func attributedStringWithString(string: String, fontSize size: CGFloat, color: UIColor?, firstWordColor: UIColor?) -> NSAttributedString {
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: string)
        
        let attributes: [String: AnyObject] = [NSForegroundColorAttributeName: color ?? UIColor.blackColor(), NSFontAttributeName: UIFont.systemFontOfSize(size)]
        attributedString.addAttributes(attributes, range: NSMakeRange(0, string.characters.count))
        
        if(firstWordColor != nil){
            let newString: NSString = string
            let firstSpaceRange: NSRange = newString.rangeOfCharacterFromSet(NSCharacterSet.whitespaceCharacterSet())
            let firstWordRange: NSRange = NSMakeRange(0, firstSpaceRange.location)
            attributedString.addAttribute(NSForegroundColorAttributeName, value: firstWordColor!, range: firstWordRange)
        }
        
        return attributedString
    }
}