//
//  Stream.swift
//  SwiftFFmpeg
//
//  Created by sunlubo on 2018/6/29.
//

import CFFmpeg

// MARK: - Discard

public typealias Discard = CFFmpeg.AVDiscard

extension Discard {
    /// discard nothing
    public static let none = AVDISCARD_NONE
    /// discard useless packets like 0 size packets in avi
    public static let `default` = AVDISCARD_DEFAULT
    /// discard all non reference
    public static let nonRef = AVDISCARD_NONREF
    /// discard all bidirectional frames
    public static let bidir = AVDISCARD_BIDIR
    /// discard all non intra frames
    public static let nonIntra = AVDISCARD_NONINTRA
    /// discard all frames except keyframes
    public static let nonKey = AVDISCARD_NONKEY
    /// discard all
    public static let all = AVDISCARD_ALL
}

// MARK: - Stream

typealias CAVStream = CFFmpeg.AVStream

/// Stream structure.
public final class Stream {
    let cStreamPtr: UnsafeMutablePointer<CAVStream>
    var cStream: CAVStream { cStreamPtr.pointee }

    init(cStreamPtr: UnsafeMutablePointer<CAVStream>) {
        self.cStreamPtr = cStreamPtr
    }

    /// Stream index in `FormatContext`.
    public var index: Int {
        Int(cStream.index)
    }

    /// Format-specific stream ID.
    ///
    /// - encoding: Set by the user, replaced by libavformat if left unset.
    /// - decoding: Set by libavformat.
    public var id: Int32 {
        get { cStream.id }
        set { cStreamPtr.pointee.id = newValue }
    }

    /// This is the fundamental unit of time (in seconds) in terms of which frame timestamps are represented.
    ///
    /// - encoding: May be set by the caller before `FormatContext.writeHeader(options:)` to provide a hint
    ///   to the muxer about the desired timebase. In `FormatContext.writeHeader(options:)`, the muxer will
    ///   overwrite this field with the timebase that will actually be used for the timestamps written into the
    ///   file (which may or may not be related to the user-provided one, depending on the format).
    /// - decoding: Set by libavformat.
    public var timebase: Rational {
        get { cStream.time_base }
        set { cStreamPtr.pointee.time_base = newValue }
    }

    /// pts of the first frame of the stream in presentation order, in stream timebase.
    public var startTime: Int64 {
        cStream.start_time
    }

    public var duration: Int64 {
        cStream.duration
    }

    /// Number of frames in this stream if known or 0.
    public var frameCount: Int {
        Int(cStream.nb_frames)
    }

    /// Selects which packets can be discarded at will and do not need to be demuxed.
    public var discard: Discard {
        get { cStream.discard }
        set { cStreamPtr.pointee.discard = newValue }
    }

    /// sample aspect ratio (0 if unknown)
    ///
    /// - encoding: Set by user.
    /// - decoding: Set by libavformat.
    public var sampleAspectRatio: Rational {
        cStream.sample_aspect_ratio
    }

    /// The metadata of the stream.
    public var metadata: [String: String] {
        get {
            var dict = [String: String]()
            var prev: UnsafeMutablePointer<AVDictionaryEntry>?
            while let tag = av_dict_get(cStream.metadata, "", prev, AV_DICT_IGNORE_SUFFIX) {
                dict[String(cString: tag.pointee.key)] = String(cString: tag.pointee.value)
                prev = tag
            }
            return dict
        }
        set { cStreamPtr.pointee.metadata = newValue.toAVDict() }
    }

    /// Average framerate.
    ///
    /// - demuxing: May be set by libavformat when creating the stream or in
    ///   `FormatContext.findStreamInfo(options:)`.
    /// - muxing: May be set by the caller before `FormatContext.writeHeader(options:)`.
    public var averageFramerate: Rational {
        get { cStream.avg_frame_rate }
        set { cStreamPtr.pointee.avg_frame_rate = newValue }
    }

    /// Real base framerate of the stream.
    /// This is the lowest framerate with which all timestamps can be represented accurately
    /// (it is the least common multiple of all framerates in the stream). Note, this value is just a guess!
    /// For example, if the timebase is 1/90000 and all frames have either approximately 3600 or 1800 timer ticks,
    /// then realFramerate will be 50/1.
    public var realFramerate: Rational {
        cStream.r_frame_rate
    }

    /// Codec parameters associated with this stream.
    ///
    /// - demuxing: Filled by libavformat on stream creation or in `FormatContext.findStreamInfo(options:)`.
    /// - muxing: Filled by the caller before `FormatContext.writeHeader(options:)`.
    public var codecParameters: CodecParameters {
        CodecParameters(cParametersPtr: cStream.codecpar)
    }

    /// The media type of the stream.
    public var mediaType: MediaType {
        codecParameters.mediaType
    }
}