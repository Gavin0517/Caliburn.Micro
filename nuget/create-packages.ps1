function Get-ScriptDirectory {
  $Invoc = (Get-Variable MyInvocation -Scope 1).Value
  Split-Path $Invoc.MyCommand.Path 
}

# Hang on to current location
pushd . 

# Move to the Package working directory
$pkgroot = (Get-ScriptDirectory) + "\package"
cd $pkgroot

# Clear out the lib which are the references that will be added.
ls -Filter lib | del -recurse
mkdir lib

# Move the built binaries (release) into their respective convention folders
copy ..\..\bin\WPF\Release .\lib\net40 -Recurse
copy ..\..\bin\Silverlight\Release .\lib\sl4 -Recurse
copy ..\..\bin\WP7\Release .\lib\sl3-wp -Recurse
copy ..\..\bin\WP71\Release .\lib\sl4-windowsphone71 -Recurse

..\nuget.exe pack caliburn.micro.nuspec

popd