#
# Copyright 2015, Noah Kantrowitz
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'chef/resource'
require 'poise_languages/static'

require 'poise_javascript/error'
require 'poise_javascript/javascript_providers/base'


module PoiseJavascript
  module JavascriptProviders
    class NodeJS < Base
      provides(:nodejs)
      include PoiseLanguages::Static(
#         versions: %w{
# 0.12.7 0.12.6 0.12.5 0.12.4 0.12.3 0.12.2 0.12.1 0.12.0 0.11.16 0.11.15 0.11.14
# 0.11.13 0.11.12 0.11.11 0.11.10 0.11.9 0.11.8 0.11.7 0.11.6 0.11.5 0.11.4 0.11.3
# 0.11.2 0.11.1 0.11.0 0.10.40 0.10.39 0.10.38 0.10.37 0.10.36 0.10.35 0.10.34
# 0.10.33 0.10.32 0.10.31 0.10.30 0.10.29 0.10.28 0.10.27 0.10.26 0.10.25 0.10.24
# 0.10.23 0.10.22 0.10.21 0.10.20 0.10.19 0.10.18 0.10.17 0.10.16 0.10.15 0.10.14
# 0.10.13 0.10.12 0.10.11 0.10.10 0.10.9 0.10.8 0.10.7 0.10.6 0.10.5 0.10.4 0.10.3
# 0.10.2 0.10.1 0.10.0 0.9.12 0.9.11 0.9.10 0.9.9 0.9.8 0.9.7 0.9.6 0.9.5 0.9.4
# 0.9.3 0.9.2 0.9.1 0.9.0 0.8.28 0.8.27 0.8.26 0.8.25 0.8.24 0.8.23 0.8.22 0.8.21
# 0.8.20 0.8.19 0.8.18 0.8.17 0.8.16 0.8.15 0.8.14 0.8.13 0.8.12 0.8.11 0.8.10
# 0.8.9 0.8.8 0.8.7 0.8.6 0.8.5 0.8.4 0.8.3 0.8.2 0.8.1 0.8.0 0.7.12 0.7.11 0.7.10
# 0.7.9 0.7.8 0.7.7 0.7.6 0.7.5 0.7.4 0.7.3 0.7.2 0.7.1 0.7.0 0.6.21 0.6.20 0.6.19
# 0.6.18 0.6.17 0.6.16 0.6.15 0.6.14 0.6.13 0.6.12 0.6.11 0.6.10 0.6.9 0.6.8 0.6.7
# 0.6.6 0.6.5 0.6.4 0.6.3 0.6.2 0.6.1 0.6.0 0.5.10 0.5.9 0.5.8 0.5.7 0.5.6 0.5.5
# 0.5.4 0.5.3 0.5.2 0.5.1},
        versions: %w{0.12.7 0.11.16 0.10.40 0.9.12 0.8.28 0.7.12 0.6.21 0.5.10},
        machines: %w{linux-i686 linux-x86_64 darwin-x86_64},
        url: 'https://nodejs.org/dist/v%{version}/node-v%{version}-%{kernel}-%{machine}.tar.gz',
      )

      def self.provides_auto?(node, resource)
        # Also work if we have a blank or numeric-y version. This should make
        # it the default provider on supported platforms.
        super || (resource.version.to_s =~ /^(\d|$)/ && static_machines.include?(static_machine_label(node)))
      end

      MACHINE_LABELS = {'i386' => 'x86', 'i686' => 'x86', 'x86_64' => 'x64'}

      def static_url_variables
        machine = node['kernel']['machine']
        super.merge(machine: MACHINE_LABELS[machine] || machine)
      end

      def javascript_binary
        ::File.join(static_folder, 'bin', 'node')
      end

      private

      def install_javascript
        install_static
      end

      def uninstall_javascript
        uninstall_static
      end

    end
  end
end

