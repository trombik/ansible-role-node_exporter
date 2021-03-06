require "spec_helper"
require "serverspec"

package = "prometheus-node-exporter"
service = "prometheus-node-exporter"
ports   = [9100]
default_user = "root"
default_group = "root"
flags = ""

case os[:family]
when "freebsd"
  default_group = "wheel"
  package = "node_exporter"
  service = "node_exporter"
  flags = "node_exporter_args='--log.format=\"logger:stderr\"'"
end

describe package(package) do
  it { should be_installed }
end

case os[:family]
when "freebsd"
  describe file("/etc/rc.conf.d/node_exporter") do
    it { should exist }
    it { should be_file }
    it { should be_owned_by default_user }
    it { should be_grouped_into default_group }
    it { should be_mode 644 }
    its(:content) { should match(/^# Managed by ansible$/) }
    its(:content) { should match(/^#{flags}$/) }
  end
end

describe service(service) do
  it { should be_running }
  it { should be_enabled }
end

ports.each do |p|
  describe port(p) do
    it { should be_listening }
  end
end

describe command "curl -s http://localhost:9100/metrics" do
  its(:exit_status) { should eq 0 }
  its(:stderr) { should eq "" }
  its(:stdout) { should match(/^node_load1\s+\d+\.\d+$/) }
end
