//
// Add any Xibs you want to convert during the build process.
// These are automagically converted to CIBs, suitable to be used
// with Cappuccino. No prefix or extension is required, e.g.
//   'Fubar' will convert Resources/Fubar.xib to Resources/Fubar.cib
//
var XibsToConvert = ["FirstWindow", "SecondWindow"];

var ENV = require("system").env,
    FILE = require("file"),
    JAKE = require("jake"),
    task = JAKE.task,
    FileList = JAKE.FileList,
    app = require("cappuccino/jake").app,
    configuration = ENV["CONFIG"] || ENV["CONFIGURATION"] || ENV["c"] || "Debug",
    OS = require("os");

app ("CibCaching", function(task)
{
    task.setBuildIntermediatesPath(FILE.join("Build", "CibCaching.build", configuration));
    task.setBuildPath(FILE.join("Build", configuration));

    task.setProductName("CibCaching");
    task.setIdentifier(".com.cib.Caching");
    task.setVersion("1.0");
    task.setAuthor("Two Monkeys");
    task.setEmail("feedback @nospam@ 2monki.es");
    task.setSummary("CibCaching");
    task.setSources((new FileList("**/*.j")).exclude(FILE.join("Build", "**")));
    task.setResources(new FileList("Resources/**"));
    task.setIndexFilePath("index.html");
    task.setInfoPlistPath("Info.plist");
    task.setNib2CibFlags("-R Resources/");

    if (configuration === "Debug")
        task.setCompilerFlags("-DDEBUG -g");
    else
        task.setCompilerFlags("-O");
});

function printResults(configuration)
{
    print("----------------------------");
    print(configuration+" app built at path: "+FILE.join("Build", configuration, "CibCaching"));
    print("----------------------------");
}

task ("default", ["nibs", "CibCaching"], function()
{
    printResults(configuration);
});

task( "cloc", function()
{
  OS.system(["ohcount", "app/", "AppController.j"]);
});

task( "nibs", function()
{
  // Tried using JAKE.file but that didn't not want to work with subdirectories, 
  // i.e. Resources/
  for ( var idx = 0; idx < XibsToConvert.length; idx++ ) {
    var filenameXib = "Resources/../Xibs/" + XibsToConvert[idx] + ".xib";
    var filenameCib = "Resources/" + XibsToConvert[idx] + ".cib";
    if ( !FILE.exists(filenameCib) || FILE.mtime(filenameXib) > FILE.mtime(filenameCib) ) {
      print("Converting to cib: " + filenameXib);
      OS.system(["nib2cib", filenameXib, filenameCib]);
    } else {
      print("Ignoring " + filenameXib + " -> has been converted");
    }
  }
});

task ("build", ["nibs", "default"]);

task ("debug", function()
{
    ENV["CONFIGURATION"] = "Debug";
    JAKE.subjake(["."], "build", ENV);
});

task ("release", function()
{
    ENV["CONFIGURATION"] = "Release";
    JAKE.subjake(["."], "build", ENV);
});

task ("run", ["debug"], function()
{
    OS.system(["open", FILE.join("Build", "Debug", "CibCaching", "index.html")]);
});

task ("run-release", ["release"], function()
{
    OS.system(["open", FILE.join("Build", "Release", "CibCaching", "index.html")]);
});

task ("press", ["release"], function()
{
  FILE.mkdirs(FILE.join("Build", "Press", "CibCaching"));
  OS.system(["press", "-f", FILE.join("Build", "Release", "CibCaching"), 
             FILE.join("Build", "Press", "CibCaching")]);
});

task ("deploy", ["release"], function()
{
    FILE.mkdirs(FILE.join("Build", "Deployment", "CibCaching"));
    OS.system(["press", "-f", FILE.join("Build", "Release", "CibCaching"), 
               FILE.join("Build", "Deployment", "CibCaching")]);
    printResults("Deployment");
});

task ("flatten", ["press"], function()
{
  FILE.mkdirs(FILE.join("Build", "Flatten", "CibCaching"));
  var args = ["flatten", "-f", "--verbose", "--split", "2", 
              "-c", "closure-compiler", "-F", "Frameworks"];
  for ( var idx = 0; idx < XibsToConvert.length; idx++ ) {
    args.push("-P");
    args.push(FILE.join("Resources", XibsToConvert[idx] + ".cib"));
  }
  args.push(FILE.join("Build", "Press", "CibCaching"));
  args.push(FILE.join("Build", "Flatten", "CibCaching"));
  OS.system(args);
});

task( "documentation", [], function()
{
  OS.system("doxygen");
});

task("test", function()
{
    print("============> WARNING");
    print("Ensure that test filenames are the same as the class that is defined");
    print("E.g. TweetTest.j for TweetTest and not tweet_test.j (i.e. rails style)");
    print("Otherwise you'll get a strange error: >>objj [warn]: unable to get tests<<");
    print("============> END WARNING");

    var tests = new FileList('Test/**/*Test.j');
    var moretests = new FileList('Test/**/*_test.j');
    var cmd = ["ojtest"].concat(tests.items()).concat(moretests.items());
    //print( cmd.map(OS.enquote).join(" ") );
    var cmdString = cmd.map(OS.enquote).join(" ");

    var code = OS.system(cmdString);
    if (code !== 0)
        OS.exit(code);
});
