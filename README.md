DevCook Cookbook
================
When making changes to POSHChef it is desirable to be able to run a benign runlist to check the logic and everything is working, but nothing is changed locally, e.g. on a local workstation.

This cookbook provides some recipes and attributes that can be used locally to ensure that the run completes as expected.  No permenant system changes are made, and any files that are creatd are removed at the end of the run.

Requirements
------------
The following cookbooks are required for a successful run:

 * Pester - contains the recipes to install and run tests using Pester

Attributes
----------
The following attributes are for the DevCook cookbook.

+ node["DevCook"]["animal"] - Name of an animal to be overridden in a role or an environment.  Default: **fox**
+ node["DevCook"]["files"] - Number of text files to create in the ```remotefile``` recipe. Default: **10**
+ node["DevCook"]["path"] - Path to create in the ```remotefile``` recipe.  This will be where the text files are created.  Default: **c:\temp\remotefile**
+ node["DevCook"]["target"] - Path where the created text files are to be copied.  Default: **c:\temp\remotefile_copy**

So that the tests in the cookbook will be run by POSHChef, it needs to be enabled in the main run.  The following attribute does this:

+ node["Tests"]["enabled"] - Turn on POSHChef tests.  Default: **true**

NOTE:  This can be overridden by a role and / or an environment.

Usage
-----
#### DevCook::default
Empty cookbook which can be used to add cookbook to run without using cookbook dependencies.

#### DevCook::cookbookfile
Copy the file in the cookbook to a location on disk.

#### DevCook::folders
This recipe uses the POSHChef 'Folder' DSC Resource to create specified directories on the machine.  It expects the folders to be defined in a role as part of the 'Base' attributes.  So by including the following in a role:

```json
{
  "name": "DevCook_Folders",
  "default_attributes": {
    "Base": {
      "Folders": {
        "c:\\windows\\temp\\devcook": {

        }
      }
    }
  },
  "run_list": [
    "recipe[DevCook::Folders]"
  ]
}
```

This will ensure that the directory ```c:\\windows\\temp\\devcook``` is created by the recipe.

NOTE:  The recipe uses the keys of the ```Folders``` hash table to determine the folders to create.  In a more advanced configuration the members of the key can contain permissions, share name and share acl.

#### DevCook::log
Simple recipe that will output a message, using the Verbose stream in DSC.  The default output is a new GUID.

#### DevCook::remotefile
Uses the POSHChef 'RemoteFile' DSC resource to create a number of files that are to be copied to a target location.

The resource is intended to copy files from remote locations to a local destination, but to simulate this in this cookbook it creates several files in one directory and then copies them to a target directory.

Please refer to the ['Remote File Resource'](https://github.com/POSHChef.wiki/resources/Remote File Resource) page for more information about how to use the remote file resource.

#### DevCook::template
Uses the POSHChef 'Template' DSC Resource to write out a file that has specific keywords in it that need to be replaced.  These keywords or tokens can come from variables that are passed to the resource or from the node attributes.

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like add_component_x)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Russell Seymour (<russell.seymour@turtlesystemsconsulting.co.uk>)

```text
Copyright:: 2010-2014, Turtlesystems Consulting, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
