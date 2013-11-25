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
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').div(:id => 'tab5').present? }
# Collect minerals
if b.frame(:id => 'iframe_canvas').button(:id => 'traderms').present? then
  b.frame(:id => 'iframe_canvas').button(:id => 'traderms').click
  Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').button(:id => 'tradesellallm').present? }
  b.frame(:id => 'iframe_canvas').button(:id => 'tradesellallm').click
end
# Collect artifacts
if b.frame(:id => 'iframe_canvas').checkbox(:id => 'getallartifact').present? then
  b.frame(:id => 'iframe_canvas').checkbox(:id => 'getallartifact').set
  b.inspect
  b.frame(:id => 'iframe_canvas').button(:id => 'traderas').click
  Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').button(:class => 'red').present? }
  b.frame(:id => 'iframe_canvas').button(:class => 'red').click
end
# Stack Artifacts
b.frame(:id => 'iframe_canvas').link(:text => "Artifacts").click
if b.frame(:id => 'iframe_canvas').button(:id => 'tradestack').present? then
  b.frame(:id => 'iframe_canvas').button(:id => 'tradestack').click
end
# Start with weapons buffs
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
b.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set 'wea'
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
artifacttable = b.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
ARTIFACT = 1
BTNARRAY = 3
artifacttable.rows.each do |row|
  if artifacttable.rows[ARTIFACT].text.include? 'Crimson Amplifier' then
    artifacttable.rows[BTNARRAY].button(:text => 'Use').click
  elsif artifacttable.rows[ARTIFACT].text.include? 'Crux Amplifier' then
    artifacttable.rows[BTNARRAY].button(:text => 'Use').click
  elsif artifacttable.rows[ARTIFACT].text.include? 'Crimson Obelisk' then
    artifacttable.rows[BTNARRAY].button(:text => 'Use').click
  elsif artifacttable.rows[ARTIFACT].text.include? 'Ancient Crystal Foci' then
    artifacttable.rows[BTNARRAY].button(:text => 'Use').click
  elsif artifacttable.rows[ARTIFACT].text.include? 'Shockpulse Charger' then
    artifacttable.rows[BTNARRAY].button(:text => 'Use').click
  end
end
# Next defense and hull buff and possibly repair ship
b.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set 'gri'
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
hulltotal = b.frame(:id => 'iframe_canvas').span(:id => 's-Hull-l').text.to_i
artifacttable = b.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
artifacttable.rows.each do |row|
  if artifacttable.rows[ARTIFACT].text.include? 'Durtanium Brackets' then
    artifacttable.rows[BTNARRAY].button(:text => 'Use').click
  elsif artifacttable.rows[ARTIFACT].text.include? 'Grid Console' then
    artifacttable.rows[BTNARRAY].button(:text => 'Use').click
  elsif hulltotal == 0
    if artifacttable.rows[ARTIFACT].text.include? 'Repair Nanodrones' then
      artifacttable.rows[BTNARRAY].button(:text => 'Use').click
    end
  elsif artifacttable.rows[ARTIFACT].text.include? 'Nanite Swarm Capsules' then
    artifacttable.rows[BTNARRAY].button(:text => 'Use').click
  end
end
# Shield buff
b.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set 'hie'
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
artifacttable = b.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
artifacttable.rows.each do |row|
  if artifacttable.rows[ARTIFACT].text.include? 'XCharge Cells' then
    artifacttable.rows[BTNARRAY].button(:text => 'Use').click
  elsif artifacttable.rows[ARTIFACT].text.include? 'Shield Amplifier' then
    artifacttable.rows[BTNARRAY].button(:text => 'Use').click
  end
end


# Go to Ship screen, use ability to buff for NPC attack
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').link(:id => "menu_Ship").visible? }
b.frame(:id => 'iframe_canvas').link(:id => "menu_Ship").click
b.frame(:id => 'iframe_canvas').button(:text => 'Use an Ability').click
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').link(:text => "Module Abilities").present? }
b.frame(:id => 'iframe_canvas').link(:text => "Module Abilities").click
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => "items").present? }
abilitytable = b.frame(:id => 'iframe_canvas').table(:id => "items")
ABILITY = 1
USEBUTTON = 3
dve_ab = false
qpa_ab = false
shn_ab = false
abilitytable.rows.each do |row|
  if abililtytable.rows[ABILITY].text.include? 'Dark Void Engine' and dve_ab == false then
    abililtytable.rows[USEBUTTON].button(:text => 'Use').click if abililtytable.rows[USEBUTTON].button(:text => 'Use').enabled?
    dve_ab = true
  elsif abililtytable.rows[ABILITY].text.include? 'Alarri Probability Core' then
    abililtytable.rows[USEBUTTON].button(:text => 'Use').click if abililtytable.rows[USEBUTTON].button(:text => 'Use').enabled?
  elsif abililtytable.rows[ABILITY].text.include? 'Subquantum Tracing Console' then
    abililtytable.rows[USEBUTTON].button(:text => 'Use').click if abililtytable.rows[USEBUTTON].button(:text => 'Use').enabled?
  elsif abililtytable.rows[ABILITY].text.include? 'Q-Pedd Ansible' and qpa_ab == false then
    abililtytable.rows[USEBUTTON].button(:text => 'Use').click if abililtytable.rows[USEBUTTON].button(:text => 'Use').enabled?
    qpa_ab = true
  elsif abililtytable.rows[ABILITY].text.include? 'Scruuge Hypernode' and shn_ab == false then
    abililtytable.rows[USEBUTTON].button(:text => 'Use').click if abililtytable.rows[USEBUTTON].button(:text => 'Use').enabled?
    shn_ab = true
  elsif abililtytable.rows[ABILITY].text.include? 'Q-Pedd Assembly Line' then
    abililtytable.rows[USEBUTTON].button(:text => 'Use').click if abililtytable.rows[USEBUTTON].button(:text => 'Use').enabled?
  end
end
b.frame(:id => 'iframe_canvas').div(:class => 'dialog-close').click

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
