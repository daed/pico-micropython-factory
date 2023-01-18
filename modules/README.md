# modules

Any python files you would like added as frozen modules to your firmware build should be placed in this directory.

esp32test.py is in this directory as a demonstration of the frozen module capability.  To test it for yourself, you may do the following from the REPL:

import esp32test
esp32test.add(2, 2)
esp32test.testFunction()

