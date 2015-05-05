Pod::Spec.new do |s|
s.name         = "CVCalendarKit"
s.version      = "0.1.1"
s.summary      = "A wrapper around NSDate which provides a convenience way for dealing with dates and NSCalendar."
s.homepage     = "https://github.com/Mozharovsky/CVCalendarKit"
s.license      = { :type => 'MIT' }
s.author       = { "Eugene Mozharovsky" => "mozharovsky@live.com" }
s.platform     = :ios, '7.0'
s.source       = { :git => "https://github.com/Mozharovsky/CVCalendarKit.git", :tag => s.version.to_s }
s.source_files  = 'CVCalendarKit/*'
s.requires_arc = true
end