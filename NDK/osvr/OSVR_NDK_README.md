# OSVR Android NDK Modules

This `osvr` directory contains the native code binaries built for Android of the OSVR-Core. It's designed for use with the `ndk-build` build system, specifically the exported modules feature.


## Using OSVR in your NDK project
The primary way to use these libraries is via [import-module][]. The example given is for using ClientKit, but you could replace `ClientKit` in the following instructions with `PluginKit` or any other module that has a subdirectory of this `osvr` directory.

[import-module]: https://developer.android.com/ndk/guides/android_mk.html#npfm

- In your `Android.mk`:
	- In your module definition, between `include $(CLEAR_VARS)` and `include $(BUILD_???)`, insert this line:
		- `LOCAL_SHARED_LIBRARIES := osvrClientKit`
		- Or, add `osvrClientKit` to your existing `LOCAL_SHARED_LIBRARIES` line if you already have one.
	- At the bottom of the file, add this line:
		- `$(call import-module,osvr/ClientKit)`

For it to be useful, the build system needs to be able to find the `osvr` directory. There are three basic ways, each with pros and cons:

1. Place the whole `osvr` directory in the `sources` directory of your NDK. That location is automatically added to the module search path.
2. On your development machine, specify `NDK_MODULE_PATH` to include the parent directory of the `osvr` directory (either as an environment variable or as an argument passed to `ndk-build`
3. If your build can rely on these modules always being in the same location (for instance, if they're checked into a repository or on a shared drive), you can add a line like the following directly above the `import-module` line: `$(call import-add-path, /my/path/to/modules)`