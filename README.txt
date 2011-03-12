Cib Caching
-----------

Demostration of cib caching.

The 'Multiple Window' button opens the same window multiple times, the 'Single Window' 
button only opens the single instance of the window, i.e. if the window is closed 
it's reopend. If the window is open, a second window is not opened.

The point is that both buttons initially retrieve the cib from the server. However the
'Multiple Window' button will retrieve the cib for each window that it opens. The cib
data itself should be cached and reused.

However, this is actually the case if you flatten the project and provide a '-P' option
for each cib file.

Flatten
-------

Using '-P <path to cib>' to flatten inlines the cib data and removes the need for any
request to obtain the Cib. This works however in this demo, this causes JS errors in the 
application and allows the single window button to open multiple windows.

>>>
CPInternalInconsistencyException: Window for <FirstWindowController 0x004ad7> could not 
be loaded from Cib or no window specified.
Override loadWindow to load the window manually.
<<<
the same happened for the SecondWindowController.

In both cases the windows, can not be closed (other than with the 'X' in the top-left) 
using the 'Cancel' and 'Accept' buttons -- these aren't connected to the corresponding 
actions of the controller (apparently).

These errors weren't produced when using the application without flatten.

Reproducing
-----------

# jake flatten

Will build the flatten version of the project

# cd Build/Flatten/CibCaching
# open index.html

Will open the flatten version of the application.

Versions
--------

# capp --version
cappuccino 0.9.0 (2011-02-23 8c1a3a)

# Safari --version
Version 5.0.3 (5533.19.4)
