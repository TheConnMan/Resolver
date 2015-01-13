Resolver
=========

Bash script for HTML dependency resolution within server-less applications.

## Description

**Resolver** is especially helpful for developers used to having a main header or footer file which is included on all pages, but are developing a server-less application. **Resolver** allows web developers to have abstracted out portions of pages which occur on multiple pages, but only have to be maintained in a single location. These HTML snippets are then injected into the HTML pages, creating a set of full HTML pages without the maintenance nightmare of normal HTML apps.

## Requirements

- Bash

## Installing

To install download the [latest version](https://github.com/TheConnMan/Resolver/archive/master.zip) and extract `resolver` into a permanant location. You can also move `resolver` to a location in your path for convenience.

## Use

### HTML Resolution

**Resolver** uses a conventional tag to denote injected files shown below:

```
<% resolver src="relative/path/to/my/file.html" %>
```

These file locations are all relative to the **root** (see options below) of the app, so even if a file references another file within its same subfolder the relative path will still include the subfolder of both files. An example of this can be found in the [example menu layout](https://github.com/TheConnMan/Resolver/blob/master/example/layouts/menu.html) which includes the [example submenu layout](https://github.com/TheConnMan/Resolver/blob/master/example/layouts/submenu.html) which is in the same folder.

Files are recursively resolved, so if an injected file also contains dependencies they will be resolved before injection.

There is a set of example pages under the **example** folder to help with the HTML syntax. It can also be used to try out **Resolver** before full use.

## Dependency Resolution

To compile the finished HTML run the `resolver` command. Below is a list of the command options.

Usage: `resolver [-r root] [-d dist] [-kwv]`
- -r: root HTML directory to be crawled recursively
- -d: distribution directory
- -k: keep injected files
- -w: watch root directory for changes
- -v: verbose
- -h: help

## Support

Please use [GitHub Issues](https://github.com/TheConnMan/Resolver/issues) to recommend additions or report bugs.

## License

MIT