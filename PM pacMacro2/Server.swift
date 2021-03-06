//
//  Server.swift
//  PM pacMacro2
//
//  Created by Josh Wu on 2016-08-03.
//  Copyright © 2016 Josh Wu. All rights reserved.
//

import Foundation

public class Server : NSObject {
    static let sharedInstance = Server()
    
    private var serverip : String = "http://pacmacro.herokuapp.com/"
    private var lastConnectionTime : NSDate = NSDate()

    public func getAllPlayerDetails() -> [Player] {
        var playerList : [Player] = []
        do{
            
            let requestPlayerDetails : String = "/player/details"
            
            let data = NSData(contentsOfURL: NSURL(string: serverip + requestPlayerDetails)!)
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
            
            for player in jsonResult as! [Dictionary <String, AnyObject>] {
                playerList.append(
                    Player(playerID: "", playerName: "", playerType: player["name"] as! String,latitude: player["latitude"] as! Double, longitude: player["longitude"] as! Double)
                )
            }
        } catch let error as NSError {
            print(error)
        }
        
        return playerList
    }
    
    public func getDots() -> [Dot] {
        var dotList : [Dot] = []
        do {
            let requestDotLocations = "/pacdots"
            
            let data = NSData(contentsOfURL: NSURL(string: serverip + requestDotLocations)!)
            
            let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)
            
            for dot in jsonResult as! [Dictionary <String, AnyObject>] {
                dotList.append(
                    Dot(id: "", latitude: dot["latitude"] as! Double, longitude: dot["longitude"] as! Double, isCollectedBool: (dot["eaten"] as! String).toBool(), isPowerDot: (dot["powerdot"] as! String).toBool())
                )
            }
        } catch let error as NSError {
            print(error)
        }
        
        return dotList
    }
    
}

extension String {
    public func toBool() -> Bool {
        if self == "false" {
            return false
        }
        else {
            return true
        }
    }
    
}