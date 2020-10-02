//
//  File.swift
//  
//
//  Created by Greg Cotten on 10/2/20.
//

import Foundation
import CFFmpeg

public extension AVCodec {
    static var version: UInt32 {
        avcodec_version()
    }
}

public extension AVDevice {
    static var version: UInt32 {
        avdevice_version()
    }
}

public extension AVFilter {
    static var version: UInt32 {
        avfilter_version()
    }
}

public struct AVFormat {
    public static var version: UInt32 {
        avformat_version()
    }
}

public struct AVUtil {
    public static var version: UInt32 {
        avutil_version()
    }
    
    public static var avVersionInfo: String {
        String(cString: av_version_info())
    }
}

public struct SwResample {
    public static var version: UInt32 {
        swresample_version()
    }
}

public struct SwScale {
    public static var version: UInt32 {
        swscale_version()
    }
}
