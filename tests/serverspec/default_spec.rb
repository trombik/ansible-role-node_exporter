require "spec_helper"
require "serverspec"

package = "node_exporter"
service = "node_exporter"
config  = "/etc/node_exporter/node_exporter.conf"
user    = "node_exporter"
group   = "node_exporter"
ports   = [PORTS]
log_dir = "/var/log/node_exporter"
db_dir  = "/var/lib/node_exporter"

case os[:family]
when "freebsd"
  config = "/usr/local/etc/node_exporter.conf"
  db_dir = "/var/db/node_exporter"
end

describe package(package) do
  it { should be_installed }
end

describe file(config) do
  it { should be_file }
  its(:content) { should match Regexp.escape("node_exporter") }
end

describe file(log_dir) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

describe file(db_dir) do
  it { should exist }
  it { should be_mode 755 }
  it { should be_owned_by user }
  it { should be_grouped_into group }
end

case os[:family]
when "freebsd"
  describe file("/etc/rc.conf.d/node_exporter") do
    it { should be_file }
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
