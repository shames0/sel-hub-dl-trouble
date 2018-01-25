require 'selenium-webdriver'
require 'securerandom'

$download_subfolder = SecureRandom.uuid.split(pattern="-")[4]

def test_driver(type)
    puts " ==== Testing with #{type[:name]} driver: ==== "
    driver = type[:driver]

    # Download the file
    driver.get('https://www.intogeek.com/test-download.html')
    driver.find_element(:link_text => 'Download me!').click()

    sleep 5 # wait for the file to download -- NOTE: race condition

    # Read the default downloads folder contents for debugging
    dentry_list     = ''
    tmp_dir = Dir.new('/tmp')
    tmp_dir.each { |dentry|
        dentry_list = dentry_list + "#{dentry}\n"
    }
    puts "Files found in tmp dir:\n#{dentry_list}"


    # Locate downloaded file
    downloads_path = "/tmp/#{$download_subfolder}" # see docker-compose file
    begin
        downloads_dir = Dir.new(downloads_path)
    rescue Errno::ENOENT => e
        puts 'ERROR: Download directory was not created automatically by chrome'
        return
    end

    # Read the passed in downloads folder contents
    dentry_list     = ''
    downloaded_file = ''
    downloads_dir.each { |dentry|
        dentry_list = dentry_list + "#{dentry}\n"

        if dentry.match(/^[^.]+/)
            downloaded_file = dentry if downloaded_file.empty?
        end
    }

    puts "Files found in the download directory:\n#{dentry_list}"

    if (downloaded_file.empty?)
        puts 'ERROR: failed to find downloaded file'
        return
    end

    file_contents   = ''
    downloaded_path = "#{downloads_path}/#{downloaded_file}"
    # Read downloaded file
    File.open(downloaded_path) do |f|
        f.each_line do |line|
            file_contents = file_contents + "#{line}\n"
        end
    end

    puts ">>>>>>>>>>>\nDOWNLOADED FILE CONTENTS:\n #{file_contents}\n<<<<<<<<<<<"


    driver.quit
end


# Configure remote selenium chrome instance
capabilities       = Selenium::WebDriver::Remote::Capabilities.chrome(
    'chromeOptions' => {
        'prefs' => {
            'download.default_directory'   => "/home/seluser/Downloads/#{$download_subfolder}",
            'download.prompt_for_download' => false,
            'plugins.plugins_disabled'     => ['Chrome PDF Viewer']
        }
    }
)

# wait for node to register with hub
sleep 3

# Set up our test drivers
grid_driver = Selenium::WebDriver.for(
    :remote,
    :desired_capabilities => capabilities,
    :url                  => 'http://selenium_hub:4444/wd/hub'
)

standalone_driver = Selenium::WebDriver.for(
    :remote,
    :desired_capabilities => capabilities,
    :url                  => 'http://selenium_standalone:4444/wd/hub'
)

# Run the tests
[
    {
        name: 'GRID',
        driver: grid_driver
    },
    {
        name: 'STANDALONE',
        driver: standalone_driver
    }
].each { |type|
    begin
        test_driver(type)
    ensure
        puts "================== END =================="
    end
}
