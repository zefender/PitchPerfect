//
//  RecorderedAudio.swift
//  PitchPerfect
//
//  Created by Кузяев Максим on 28.06.15.
//  Copyright (c) 2015 zefender. All rights reserved.
//

import UIKit

class RecorderedAudio {
    var title: NSString!
    var filePathUrl: NSURL!
    
    init(url: NSURL, title:String) {
        self.filePathUrl = url
        self.title = title
    }
}
