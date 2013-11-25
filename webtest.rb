require 'rubygems'
require 'selenium-webdriver'
require 'watir-webdriver'

b = Watir::Browser.new :firefox
b.goto "http://facebook.com"

b.text_field(:id => "email").set 'kdevine@yahoo.com'
b.text_field(:id => "pass").set '325cf7669775b6feb4606073a9a4055adef826a2d64d227791dcd985990c406e'
b.form(:id => 'login_form').submit

b.button(:name => "submit[Continue]").when_present.click
if b.button(:name => "submit[This is Okay]").exists? then
    b.button(:name => "submit[This is Okay]").click
end
if b.button(:name => "submit[Continue]").exists? then
  b.button(:name => "submit[Continue]").click
end
if b.button(:name => "submit[Continue]").exists? then
  b.button(:name => "submit[Continue]").click
end


b.goto "http://apps.facebook.com/galaxylegion/"

b.add_checker do |page|
  page.frame(:id => 'iframe_canvas').present?
end

# Go to trade screen, get all minerals, get all artifacts, sell all minerals, then buff for NPC hunting
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').visible? }
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").visible? }
b.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").click
Watir::Wait.until(10) {b.frame(:id => 'iframe_canvas').div(:id => 'Cargo Used').present? }
if b.frame(:id => 'iframe_canvas').button(:id => 'traderms').present? then
  b.frame(:id => 'iframe_canvas').button(:id => 'traderms').click 
  Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').button(:id => 'tradesellallm').present? }
  b.frame(:id => 'iframe_canvas').button(:id => 'tradesellallm').click
end
if b.frame(:id => 'iframe_canvas').checkbox(:id => 'getallartifact').present? then
  b.frame(:id => 'iframe_canvas').checkbox(:id => 'getallartifact').set
  b.inspect
  b.frame(:id => 'iframe_canvas').button(:id => 'traderas').click
  Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').button(:class => 'red').present? }
  b.frame(:id => 'iframe_canvas').button(:class => 'red').click
end 
b.frame(:id => 'iframe_canvas').link(:text => "Artifacts").click
if b.frame(:id => 'iframe_canvas').button(:id => 'tradestack').present? then
  b.frame(:id => 'iframe_canvas').button(:id => 'tradestack').click
end
b.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set 'wea'
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
artifacttable = b.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
artifacttable.rows.each do |row|
  row.each do |col|
    puts col.text
  end
end
b.debug
# Go to Ship screen, use ability to buff for NPC attack


# Go to Legion screen, legion base, UDT for buffing


Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click

IMAGE = 0
TARGET = 1
RANK = 2
TYPE = 3
STATUS = 4
ATK_BTN = 5

Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'npcbattle').visible? }
energytotal = b.frame(:id => 'iframe_canvas').span(:id => 's-Energy-l').text.to_i
npctable = b.frame(:id => 'iframe_canvas').table(:id => "npcbattle")
while energytotal > 0 do
  npctable.rows.each do |row|
    if row[TYPE].text.include? 'Standard' then
      row[ATK_BTN].button(:tag_name => "button").click
      Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').button(:id => 'npcattack').visible? }
      atkbtn = b.frame(:id => 'iframe_canvas').button(:id => 'npcattack')
      until b.frame(:id => 'iframe_canvas').button(:class => 'grey').present? do
        atkbtn.click if atkbtn.enabled?
      end 
      b.frame(:id => 'iframe_canvas').div(:class => 'dialog-close').click
      break;
    end
  end
  Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'npcbattle').visible? }
  energytotal = b.frame(:id => 'iframe_canvas').span(:id => 's-Energy-l').text.to_i
  puts "Current energy: #{energytotal}"
end
#b.quit
