//
// Created by Chelsea Troy on 5/10/16.
// Copyright (c) 2016 ChelseaTroy. All rights reserved.
//

import Foundation

class ApiClient {
    func getProjects() {
        let url: NSURL = NSURL(string: "https://panoptes-staging.zooniverse.org/api/projects")!
        let session = NSURLSession.sharedSession()

        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        request.addValue("application/vnd.api+json; version=1", forHTTPHeaderField: "Accept")

        //this is how you would add query params or request body to your request
        //let paramString = "data=Hello"
        //request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        var projects = [Project]()

        let task = session.dataTaskWithRequest(request) {
            (let data, let response, let error) in

            if let json: NSDictionary = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary {
                if let items = json["projects"] as? NSArray {

                    for item in items {
                        // construct your model objects here
                        print(item["description"])
                        let project = Project(json: item as! NSDictionary)

                        projects.append(project)
                    }
                }
            }

            let nc = NSNotificationCenter.defaultCenter()
            nc.postNotificationName("didFetchProjects", object: projects)

        }
    }
}