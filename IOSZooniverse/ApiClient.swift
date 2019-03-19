//
// Created by Chelsea Troy on 5/10/16.
// Copyright (c) 2016 ChelseaTroy. All rights reserved.
//

import Foundation

class ApiClient {
    func getProjects() {
        let url: URL = URL(string: "https://panoptes.zooniverse.org/api/projects")!
        let session = URLSession.shared

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/vnd.api+json; version=1", forHTTPHeaderField: "Accept")

        //this is how you would add query params or request body to your request
        //let paramString = "data=Hello"
        //request.HTTPBody = paramString.dataUsingEncoding(NSUTF8StringEncoding)
        var projects = [Project]()

        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) in

            if let json: NSDictionary = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                if let items = json["projects"] as? NSArray {

                    for item in items {
                        let project = Project(json: item as! NSDictionary)

                        projects.append(project)
                    }
                }
            }

            let nc = NotificationCenter.default
            nc.post(name: Notification.Name(rawValue: "didFetchProjects"), object: projects)

        }) 
        task.resume()
    }
}
