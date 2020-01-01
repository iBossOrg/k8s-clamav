require "docker_helper"

### DOCKER_IMAGE ###############################################################

describe "Docker image", :test => :docker_image do
  # Default Serverspec backend
  before(:each) { set :backend, :docker }

  ### DOCKER_IMAGE #############################################################

  describe docker_image(ENV["DOCKER_IMAGE"]) do
    # Execute Serverspec commands locally
    before(:each) { set :backend, :exec }
    it { is_expected.to exist }
  end

  ### PACKAGES #################################################################

  describe "Packages" do

    # package
    packages = [
      # [package,           version]
      ["clamav-daemon",     ENV["DOCKER_IMAGE_TAG"]],
      ["clamav-db",         ENV["DOCKER_IMAGE_TAG"]],
      ["clamav-libunrar",   ENV["DOCKER_IMAGE_TAG"]],
      ["freshclam",         ENV["DOCKER_IMAGE_TAG"]],
    ]

    packages.each do |package, version|
      describe package(package) do
        it { is_expected.to be_installed }                        if version.nil?
        it { is_expected.to be_installed.with_version(version) }  if ! version.nil?
      end
    end
  end

  ### FILES ####################################################################

  describe "Files" do

    # [file,                                            mode, user,   group,  [expectations]]
    files = [
      ["/service/health",                  755,  "root", "root", [:be_file, :eq_sha256sum]],
      ["/entrypoint/10.default-config.sh", 644,  "root", "root", [:be_file, :eq_sha256sum]],
      ["/entrypoint/50.clamav-config.sh",  644,  "root", "root", [:be_file, :eq_sha256sum]],
      ["/entrypoint/90.clamav-update.sh",  644,  "root", "root", [:be_file, :eq_sha256sum]],
    ]

    files.each do |file, mode, user, group, expectations|
      expectations ||= []
      context file(file) do
        it { is_expected.to exist }
        it { is_expected.to be_file }       if expectations.include?(:be_file)
        it { is_expected.to be_pipe }       if expectations.include?(:be_pipe)
        it { is_expected.to be_directory }  if expectations.include?(:be_directory)
        it { is_expected.to be_mode(mode) } unless mode.nil?
        it { is_expected.to be_owned_by(user) } unless user.nil?
        it { is_expected.to be_grouped_into(group) } unless group.nil?
        its(:sha256sum) do
          is_expected.to eq(
              Digest::SHA256.file("rootfs/#{subject.name}").to_s
          )
        end if expectations.include?(:eq_sha256sum)
      end
    end
  end

  ##############################################################################

end

################################################################################
