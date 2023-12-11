//
//  SearchHistory.swift
//  RafFinder
//
//  Created by iosdev on 12/10/23.
//

import Foundation

import CoreData

@objc(SearchHistory)
public class SearchHistory: NSManagedObject {
    @NSManaged public var searchText: String?
}

