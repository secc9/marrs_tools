Font.availableFonts()
Font.

(
    var availableFonts = Font.availableFonts();
    for (var fontName, 1, availableFonts.length()) {
        << fontName >>.postln;
    }
)

Font.availableFonts.keys.do(_.postln)

Font.availableFonts.do { |f| f.postln };



