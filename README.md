# winscp_upload.bat
This batch file uploads a file with session of winscp

## Required
- Set path to winscp.exe
- Login to target server with winscp to create a session.

## Usage and Example
### 1. Create `_winscip.json` to target folder.
```
📁 foo
 ├✨ _winscp.json
 └📁 bar
   └📄 baz.txt    
```
`_winscp.json` is like this.
```json
{
    "session": "session name of winscp",
    "remoteDir": "~/public_html"
}
```
### 2. Upload
You can 
```bat
winscp_upload.bat foo/bar/baz.txt
```
to
upload `baz.txt` to `~/public_html/bar/baz.txt` .
