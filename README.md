# tempail
api for tempail.top site for geting temp email address
# Example
```nim
import asyncdispatch, tempail, json, strutils

let data = waitFor create_email()
echo data
```

# Launch (your script)
```
nim c -d:ssl -r  your_app.nim
```
