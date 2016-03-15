require 'rubygems'
require 'selenium-webdriver'
require 'watir-webdriver'
require 'watir-scroll'
require './rubypass.rb'
require './glauto.rb'
require 'csv'
require 'stringio'

def silent_warnings
  old_stderr = $stderr
  $stderr = StringIO.new
  yield
ensure
  $stderr = old_stderr
end


@bFirefox = Watir::Browser.new :firefox
Watir.always_locate = false

GLAuto.loginToFacebook(@bFirefox)

@bFirefox.goto "http://pucatrade.com"
Watir::Wait.until(10) { @bFirefox.elements(:css => '#home-login > form:nth-child(2) > div:nth-child(8) > a:nth-child(1)')[0].present? }
@bFirefox.elements(:css => '#home-login > form:nth-child(2) > div:nth-child(8) > a:nth-child(1)')[0].click
Watir::Wait.until(20) { @bFirefox.elements(:css => '.profile-link')[0].present? }

body = File.read("C:\\Users\\kdevine\\Downloads\\Wishlist_Toonela_2016.March.13(1).csv")
csv=CSV.new(body, :headers => true, :header_converters => :symbol, :converters => :all)
rows = csv.to_a.map { |row| row.to_hash }
i=0

rows.each do |row|
  unless row[:name].nil?
    @bFirefox.goto "https://pucatrade.com/cards/want"
    qa = @bFirefox.text_field(:css => '#quickAdder')
    qa.set row[:name]
    Watir::Wait.until(20) { @bFirefox.elements(:css => '#ui-id-1')[0].present? }
    searchtext = Regexp.new("#{row[:edition]}")
    silent_warnings do
      MyList = @bFirefox.execute_script("return $('.autofill').autocomplete('widget').get();").first
    end
    found = false
    MyList.lis.each do |li|
      li.links.each do |link|
        if row[:edition] == ''
          link.click
          found = true
        elsif link.text.match(searchtext)
          link.click
          found = true
        end
        break if found
      end
      break if found
    end
    sleep 2
    p "Could not find #{row[:name]} from #{row[:edition]}" unless found
    p "Added #{row[:name]} from #{row[:edition]}" if found
  end
end

@bFirefox.quit


