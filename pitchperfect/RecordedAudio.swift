//
//  RecordedAudio.swift
//  pitchperfect
//
//  Created by John David Stroud on 6/27/15.
//  Copyright (c) 2015 John David Stroud. All rights reserved.
//

import Foundation


class RecordedAudio: NSObject {
    
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}