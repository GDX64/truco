using Glob

##
cd("src/assets/cards")
svgFiles = glob("*.svg")
##
svgContents(fileName) = read(`cat $fileName`, String)
fileContents = svgContents.(svgFiles)
##
function lineGenerate(svgName, svgContent)
    return "c$(svgName[1:2]):`$svgContent`,\n" 
end
##
open("svgs.ts", "w+") do io
    lines = lineGenerate.(svgFiles, fileContents)
    write(io, "const svgDict: { [id: string]: string }={")
    for line in lines
        write(io, line)
    end
    write(io, "}\n export default svgDict")
end
