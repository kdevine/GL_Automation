require 'rubygems'
require 'selenium-webdriver'
require 'watir-webdriver'
require '../rubypass.rb'
require './glauto.rb'

@b = Watir::Browser.new :firefox
@b.goto "http://facebook.com"

@b.text_field(:id => "email").set Authentication.username
@b.text_field(:id => "pass").set Authentication.password
@b.form(:id => 'login_form').submit

@b.button(:name => "submit[Continue]").when_present.click
if @b.button(:name => "submit[This is Okay]").exists? then
  @b.button(:name => "submit[This is Okay]").click
end
if @b.button(:name => "submit[Continue]").exists? then
  @b.button(:name => "submit[Continue]").click
end
if @b.button(:name => "submit[Continue]").exists? then
  @b.button(:name => "submit[Continue]").click
end

IMAGE = 0
TARGET = 1
RANK = 2
TYPE = 3
STATUS = 4
ATK_BTN = 5

begin
@b.goto "http://apps.facebook.com/galaxylegion/"

@b.add_checker do |page|
  page.frame(:id => 'iframe_canvas').present?
end

# Go to Ship screen, use ability to buff for NPC attack
#GLAuto.navigateToModuleAbilities(@b)

#GLAuto.activateAbility(@b,'Dark Void Engine')
#GLAuto.activateAbility(@b,'Alarri Probability Core')
#GLAuto.activateAbility(@b,'Subquantum Tracing Console')
#GLAuto.activateAbility(@b,'Q-Pedd Ansible')
#GLAuto.activateAbility(@b,'Scruuge Hypernode')
#GLAuto.activateAbility(@b,'Q-Pedd Assembly Line')

#@b.frame(:id => 'iframe_canvas').div(:class => 'dialog-close').click

# Go to trade screen, get all minerals, get all artifacts, sell all minerals, then buff for NPC hunting
Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').visible? }
Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").visible? }
@b.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").click
Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').div(:id => 'tab5').present? }
# Collect minerals
if @b.frame(:id => 'iframe_canvas').button(:id => 'traderms').present? then
  @b.frame(:id => 'iframe_canvas').button(:id => 'traderms').click
  Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').button(:id => 'tradesellallm').present? }
  @b.frame(:id => 'iframe_canvas').button(:id => 'tradesellallm').click
end
# Collect artifacts
if @b.frame(:id => 'iframe_canvas').checkbox(:id => 'getallartifact').present? then
  @b.frame(:id => 'iframe_canvas').checkbox(:id => 'getallartifact').set
  @b.frame(:id => 'iframe_canvas').button(:id => 'traderas').click
  Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').button(:class => 'red').present? }
  @b.frame(:id => 'iframe_canvas').button(:class => 'red').click
end
# Stack Artifacts
@b.frame(:id => 'iframe_canvas').link(:text => "Artifacts").click
if @b.frame(:id => 'iframe_canvas').button(:id => 'tradestack').present? then
  @b.frame(:id => 'iframe_canvas').button(:id => 'tradestack').click
end
# Start with weapons buffs
Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
hulltotal = @b.frame(:id => 'iframe_canvas').span(:id => 's-Hull-l').text.to_i

GLAuto.useArtifact(@b,'Crimson Amplifier','Use')
GLAuto.useArtifact(@b,'Crux Amplifier','Use')
GLAuto.useArtifact(@b,'Crimson Obelisk','Use')
GLAuto.useArtifact(@b,'Ancient Crystal Foci','Use')
GLAuto.useArtifact(@b,'Shockpulse Charger','Use')
GLAuto.useArtifact(@b,'Durtanium Brackets','Use')
GLAuto.useArtifact(@b,'Grid Console','Use')
GLAuto.useArtifact(@b,'Nanite Swarm Capsules','Use')
GLAuto.useArtifact(@b,'Repair Nanodrones','Use') if hulltotal == 0
GLAuto.useArtifact(@b,'XCharge Cells','Use')
GLAuto.useArtifact(@b,'Shield Amplifier','Charge')
GLAuto.useArtifact(@b,'Neural Interface','Use')
GLAuto.useArtifact(@b,'Containment Cage','Use')



# Go to Legion screen, legion base, UDT for buffing

Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
@b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
@b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
@b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
@b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
@b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
@b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
@b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
@b.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click



Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').table(:id => 'npcbattle').visible? }
energytotal = @b.frame(:id => 'iframe_canvas').span(:id => 's-Energy-l').text.to_i
hulltotal   = @b.frame(:id => 'iframe_canvas').span(:id => 's-Hull-l').text.to_i
npctable    = @b.frame(:id => 'iframe_canvas').table(:id => "npcbattle")
while energytotal > 5 and hulltotal > 20000 do
  npctable.rows.each do |row|
    if row[TYPE].text.include? 'Standard' then
      if !row[TARGET].text.include? 'Xathe' then
        row[ATK_BTN].button(:tag_name => "button").click
        Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').button(:id => 'npcattack').visible? }
        atkbtn = @b.frame(:id => 'iframe_canvas').button(:id => 'npcattack')
        until @b.frame(:id => 'iframe_canvas').button(:class => 'grey').present? do
          atkbtn.click if atkbtn.enabled?
        end
        @b.frame(:id => 'iframe_canvas').div(:class => 'dialog-close').click
        break;
      end
    end
  end
  Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').table(:id => 'npcbattle').visible? }
  npctable = @b.frame(:id => 'iframe_canvas').table(:id => "npcbattle")
  Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').table(:id => 'npcbattle').visible? }
  energytotal = @b.frame(:id => 'iframe_canvas').span(:id => 's-Energy-l').text.to_i
  hulltotal   = @b.frame(:id => 'iframe_canvas').span(:id => 's-Hull-l').text.to_i
  puts "Current energy: #{energytotal}, Hull: #{hulltotal}"
end

rescue Exception => e
  puts "#{ e } (#{ e.class })!"
  puts "Error occured, restarting..."
  retry
end
#b.quit


