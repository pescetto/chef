#
# Author:: Adam Edwards (<adamed@chef.io>)
# Copyright:: Copyright 2013-2016, Chef Software Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require "chef/resource/windows_script"

class Chef
  class Resource
    class PowershellScript < Chef::Resource::WindowsScript
      provides :powershell_script, os: "windows"

      description "Use the powershell_script resource to execute a script using the Windows PowerShell"\
                  " interpreter, much like how the script and script-based resources—bash, csh, perl, python,"\
                  " and ruby—are used. The powershell_script is specific to the Microsoft Windows platform"\
                  " and the Windows PowerShell interpreter.\n\n The powershell_script resource creates and"\
                  " executes a temporary file (similar to how the script resource behaves), rather than running"\
                  " the command inline. Commands that are executed with this resource are (by their nature) not"\
                  " idempotent, as they are typically unique to the environment in which they are run. Use not_if"\
                  " and only_if to guard this resource for idempotence."

      def initialize(name, run_context = nil)
        super(name, run_context, :powershell_script, "powershell.exe")
        @convert_boolean_return = false
      end

      def convert_boolean_return(arg = nil)
        set_or_return(
          :convert_boolean_return,
          arg,
          kind_of: [ FalseClass, TrueClass ]
        )
      end

      # Allow callers evaluating guards to request default
      # attribute values. This is needed to allow
      # convert_boolean_return to be true in guard context by default,
      # and false by default otherwise. When this mode becomes the
      # default for this resource, this method can be removed since
      # guard context and recipe resource context will have the
      # same behavior.
      def self.get_default_attributes(opts)
        { convert_boolean_return: true }
      end
    end
  end
end
