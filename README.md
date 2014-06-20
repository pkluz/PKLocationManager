PKLocationManager
====
A **Swift** based, centralized location manager, simplifying the CLLocationManager API by adding closures and automatically adjusting accuracy, based on the subscribers common needs.

## Features
- **Centralized** location manager abstraction.
- **Closure based** interface.
- **Automatic start and stop** of location retrieval, based on subscriber count.
- **Automatic accuracy adjustment**, based on subscriber needs in order to **save battery**.
- Builds as an **iOS 8 framework**

## How To
After adding the framework to your project, you need to import the module
```
import PKLocationManager
```

More detailed documentation incoming. See `PKLocationManager.swift` for comments, and the Demo project for example usage.

## Disclaimer

While basically the basic feature set is complete and stable, make sure you understand that the API **is likely to change as Swift matures** and some of the annoying compiler quirks are resolved.

## License

The MIT License (MIT)

Copyright (c) 2014 Philip Kluz (Philip.Kluz@zuui.org)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
