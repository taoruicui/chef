#
# Author:: Cary Penniman (<cary@rightscale.com>)
# Author:: Tyler Cloke (<tyler@chef.io>)
# Copyright:: Copyright 2008-2016, Chef Software Inc.
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

require "spec_helper"

describe Chef::Resource::Log do

  let(:log_str) { "this is my string to log" }
  let(:resource) { Chef::Resource::Log.new(log_str) }

  it "supports the :write actions" do
    expect(resource.allowed_actions).to include(:write)
  end

  it "has a name of log" do
    expect(resource.resource_name).to eq(:log)
  end

  it "allows you to set a log string" do
    expect(resource.name).to eq(log_str)
  end

  it "sets the message to the first argument to new" do
    expect(resource.message).to eq(log_str)
  end

  it "accepts a string for the log message" do
    resource.message "this is different"
    expect(resource.message).to eq("this is different")
  end

  it "accepts a vaild level option" do
    resource.level :debug
    resource.level :info
    resource.level :warn
    resource.level :error
    resource.level :fatal
    expect { resource.level :unsupported }.to raise_error(ArgumentError)
  end

  describe "when the identity is defined" do
    let(:resource) { Chef::Resource::Log.new("ery day I'm loggin-in") }

    it "returns the log string as its identity" do
      expect(resource.identity).to eq("ery day I'm loggin-in")
    end
  end
end
