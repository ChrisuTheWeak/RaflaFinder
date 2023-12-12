//
//  SearchHistory.swift
//  RafFinder
//
//  Created by iosdev on 12/10/23.
//

import Foundation
import CoreData
//This attribute exposes the Swift class to Objective-C and names the entity as 'SearchHistory'
@objc(SearchHistory)
// It allows Core Data to track changes, manage object graphs and persist data.
public class SearchHistory: NSManagedObject {
    @NSManaged public var searchText: String?
}
