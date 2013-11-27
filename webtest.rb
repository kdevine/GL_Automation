require 'rubygems'
require 'selenium-webdriver'
require 'watir-webdriver'

b = Watir::Browser.new :firefox
b.goto "http://facebook.com"

b.text_field(:id => "email").set 'kdevine@yahoo.com'
b.text_field(:id => "pass").set '<password>'
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

# Go to Ship screen, use ability to buff for NPC attack
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').link(:id => "menu_Ship").visible? }
b.frame(:id => 'iframe_canvas').link(:id => "menu_Ship").click
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').button(:text => 'Use an Ability').present? }
b.frame(:id => 'iframe_canvas').button(:text => 'Use an Ability').click
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').link(:text => "Module Abilities").present? }
b.frame(:id => 'iframe_canvas').link(:text => "Module Abilities").click
Watir::Wait.until(20) { b.frame(:id => 'iframe_canvas').div(:id => 'tabmods').table.present? }
abilitytable = b.frame(:id => 'iframe_canvas').div(:id => 'tabmods').table
ABILITY = 1
USEBUTTON = 3
dve_ab = false
qpa_ab = false
shn_ab = false
abilitytable.rows.each do |row|
  if row[ABILITY].text.include? 'Dark Void Engine' and dve_ab == false then
    row[USEBUTTON].button(:text => 'Use').click if !row[USEBUTTON].button(:class => 'grey').present?
    dve_ab = true
    break
  end
end
Watir::Wait.until(20) { b.frame(:id => 'iframe_canvas').div(:id => 'tabmods').table.present? }
abilitytable = b.frame(:id => 'iframe_canvas').div(:id => 'tabmods').table
abilitytable.rows.each do |row|
  if row[ABILITY].text.include? 'Alarri Probability Core' then
    row[USEBUTTON].button(:text => 'Use').click if !row[USEBUTTON].button(:class => 'grey').present?
    break
  end
end
Watir::Wait.until(20) { b.frame(:id => 'iframe_canvas').div(:id => 'tabmods').table.present? }
abilitytable = b.frame(:id => 'iframe_canvas').div(:id => 'tabmods').table
abilitytable.rows.each do |row|
  if row[ABILITY].text.include? 'Subquantum Tracing Console' then
    row[USEBUTTON].button(:text => 'Use').click if !row[USEBUTTON].button(:class => 'grey').present?
    break
  end
end
Watir::Wait.until(20) { b.frame(:id => 'iframe_canvas').div(:id => 'tabmods').table.present? }
abilitytable = b.frame(:id => 'iframe_canvas').div(:id => 'tabmods').table
abilitytable.rows.each do |row|
  if row[ABILITY].text.include? 'Q-Pedd Ansible' and qpa_ab == false then
    row[USEBUTTON].button(:text => 'Use').click if !row[USEBUTTON].button(:class => 'grey').present?
    qpa_ab = true
    break
  end
end
Watir::Wait.until(20) { b.frame(:id => 'iframe_canvas').div(:id => 'tabmods').table.present? }
abilitytable = b.frame(:id => 'iframe_canvas').div(:id => 'tabmods').table
abilitytable.rows.each do |row|
  if row[ABILITY].text.include? 'Scruuge Hypernode' and shn_ab == false then
    row[USEBUTTON].button(:text => 'Use').click if !row[USEBUTTON].button(:class => 'grey').present?
    shn_ab = true
    break
  end
end
Watir::Wait.until(20) { b.frame(:id => 'iframe_canvas').div(:id => 'tabmods').table.present? }
abilitytable = b.frame(:id => 'iframe_canvas').div(:id => 'tabmods').table
abilitytable.rows.each do |row|
  if row[ABILITY].text.include? 'Q-Pedd Assembly Line' then
    row[USEBUTTON].button(:text => 'Use').click if !row[USEBUTTON].button(:class => 'grey').present?
    break
  end
end

b.frame(:id => 'iframe_canvas').div(:class => 'dialog-close').click

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
hulltotal = b.frame(:id => 'iframe_canvas').span(:id => 's-Hull-l').text.to_i
ARTIFACT = 1
BTNARRAY = 3

Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
b.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set 'crimson amplifier'
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
artifacttable = b.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
artifacttable.rows.each do |row|
  if row[ARTIFACT].text.include? 'Crimson Amplifier' then
    row[BTNARRAY].button(:text => 'Use').click
    break
  end
end
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
b.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set 'crux amplifier'
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
artifacttable = b.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
if !artifacttable.td(:class => 'dataTables_empty').exists? then
  artifacttable.rows.each do |row|
    if row[ARTIFACT].text.include? 'Crux Amplifier' then
      row[BTNARRAY].button(:text => 'Use').click
      break
    end
  end
end
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
b.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set 'crimson obelisk'
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
artifacttable = b.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
artifacttable.rows.each do |row|
  if row[ARTIFACT].text.include? 'Crimson Obelisk' then
    row[BTNARRAY].button(:text => 'Use').click
    break
  end
end
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
b.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set 'Ancient Crystal Foci'
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
artifacttable = b.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
artifacttable.rows.each do |row|
  if row[ARTIFACT].text.include? 'Ancient Crystal Foci' then
    row[BTNARRAY].button(:text => 'Use').click
    break
  end
end
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
b.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set 'Shockpulse Charger'
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
artifacttable = b.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
artifacttable.rows.each do |row|
  if row[ARTIFACT].text.include? 'Shockpulse Charger' then
    row[BTNARRAY].button(:text => 'Use').click
    break
  end
end

# Next defense and hull buff and possibly repair ship
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
b.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set 'Durtanium Brackets'
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
artifacttable = b.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
if !artifacttable.td(:class => 'dataTables_empty').exists? then
  artifacttable.rows.each do |row|
    if row[ARTIFACT].text.include? 'Durtanium Brackets' then
      row[BTNARRAY].button(:text => 'Use').click
      break
    end
  end
end
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
b.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set 'Grid Console'
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
artifacttable = b.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
artifacttable.rows.each do |row|
  if row[ARTIFACT].text.include? 'Grid Console' then
    row[BTNARRAY].button(:text => 'Use').click
    break
  end
end
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
b.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set 'Nanite Swarm Capsules'
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
artifacttable = b.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
artifacttable.rows.each do |row|
  if row[ARTIFACT].text.include? 'Nanite Swarm Capsules' then
    row[BTNARRAY].button(:text => 'Use').click
    break
  end
end
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
if hulltotal == 0 then
  b.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set 'Repair Nanodrones'
  Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
  artifacttable = b.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
  artifacttable.rows.each do |row|
    if row[ARTIFACT].text.include? 'Repair Nanodrones' then
      row[BTNARRAY].button(:text => 'Use').click
      break
    end
  end
end

# Shield buff
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
b.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set 'XCharge Cells'
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
artifacttable = b.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
if !artifacttable.td(:class => 'dataTables_empty').exists? then
  artifacttable.rows.each do |row|
    if row[ARTIFACT].text.include? 'XCharge Cells' then
      row[BTNARRAY].button(:text => 'Use').click
      break
    end
  end
end
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
b.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set 'Shield Amplifier'
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
artifacttable = b.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
artifacttable.rows.each do |row|
  if row[ARTIFACT].text.include? 'Shield Amplifier' then
    row[BTNARRAY].button(:text => 'Charge').click
    break
  end
end

# Go to Legion screen, legion base, UDT for buffing

Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
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
  npctable = b.frame(:id => 'iframe_canvas').table(:id => "npcbattle")
  Watir::Wait.until(10) { b.frame(:id => 'iframe_canvas').table(:id => 'npcbattle').visible? }
  energytotal = b.frame(:id => 'iframe_canvas').span(:id => 's-Energy-l').text.to_i
  puts "Current energy: #{energytotal}"
end
#b.quit
