require 'spec_helper'

require 'rugsweep'

require 'yaml'
require 'tmpdir'
require 'stringio'

describe Rugsweep do
  it 'has a version number' do
    expect(Rugsweep::VERSION).not_to be nil
  end

  def prepare_test_dir(dir, config, files)
    Dir.chdir(dir) do
      files.each do |file|
        IO.write file, ""
      end
      File.open(".rugsweep.yml", "w") { |f| YAML.dump(config, f) }
    end
  end

  let!(:dir) { Dir.mktmpdir }

  after(:each) do
    FileUtils.remove_entry_secure dir
  end

  def assert_file_present(filename)
    path = Pathname.new(filename)
    expect(path).to exist
  end

  def assert_file_absent(filename)
    path = Pathname.new(filename)
    expect(path).to_not exist
  end

  let(:log) { StringIO.new }

  it "should clean a directory" do
    config = {
      "keep" => %w(
        Good
        Good2
      ),
      "rug" => "tmp",
    }
    files = %w( Good Good2 Bad Bad2 .Other )

    prepare_test_dir(dir, config, files)

    Dir.chdir(dir) do
      files.each do |file|
        assert_file_present(file)
      end
      Rugsweep::Sweeper.new(log).sweep
      assert_file_present("Good")
      assert_file_present("Good2")
      assert_file_absent("Bad")
      assert_file_absent("Bad2")
      assert_file_present("tmp/Bad")
      assert_file_present("tmp/Bad2")
      expect(log.string).to include("Bad")
      expect(log.string).to include("Bad2")
      expect(log.string).to_not include("Good")
      expect(log.string).to_not include("Good2")
    end
  end

  it "should raise when no config file" do
    Dir.chdir(dir) do
      expect do
        Rugsweep::Sweeper.new(log).sweep
      end.to raise_error
    end
  end
end
