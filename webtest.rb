require 'rubygems'
require 'selenium-webdriver'
require 'watir-webdriver'
require 'watir-scroll'
require './rubypass.rb'
require './glauto.rb'

@b = Watir::Browser.new :firefox
Watir.always_locate = false
@b.add_checker do |page|
  page.frame(:id => 'iframe_canvas').present?
end

GLAuto.loginToFacebook(@b)

@b.goto "http://apps.facebook.com/galaxylegion/"

# Go to Ship screen, use ability to buff for NPC attack
GLAuto.activateModuleAbility(@b, 'Dark Void Engine')
GLAuto.activateModuleAbility(@b, 'Alarri Probability Core')
GLAuto.activateModuleAbility(@b, 'Subquantum Tracing Console')
GLAuto.activateModuleAbility(@b, 'Q-Pedd Ansible')
GLAuto.activateModuleAbility(@b, 'Scruuge Charged Hypernode')
GLAuto.activateModuleAbility(@b, 'Q-Pedd Assembly Line')
GLAuto.activateModuleAbility(@b, 'Thraccti, Scruuge Defector')

GLAuto.activatePlayerAbility(@b, 'Dark Aperture-Key')
GLAuto.activatePlayerAbility(@b, 'Uldrinan Quota')

# Collect minerals and artifacts
GLAuto.collectMinerals(@b)
#TODO: Go to Legion Base and Collect Production
GLAuto.collectArtifacts(@b)

# Start with weapons buffs
Watir::Wait.until(10) { @b.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
hulltotal = @b.frame(:id => 'iframe_canvas').span(:id => 's-Hull-l').text.to_i

GLAuto.useArtifact(@b, 'Crimson Amplifier', 'Use')
GLAuto.useArtifact(@b, 'Crux Amplifier', 'Use')
GLAuto.useArtifact(@b, 'Crimson Obelisk', 'Use')
GLAuto.useArtifact(@b, 'Ancient Crystal Foci', 'Use')
GLAuto.useArtifact(@b, 'Shockpulse Charger', 'Use')
GLAuto.useArtifact(@b, 'Durtanium Brackets', 'Use')
GLAuto.useArtifact(@b, 'Grid Console', 'Use')
GLAuto.useArtifact(@b, 'Nanite Swarm Capsules', 'Use')
GLAuto.useArtifact(@b, 'Repair Nanodrones', 'Use') if hulltotal == 0
GLAuto.useArtifact(@b, 'XCharge Cells', 'Use')
GLAuto.useArtifact(@b, 'Shield Amplifier', 'Charge')
GLAuto.useArtifact(@b, 'Neural Interface', 'Use')
GLAuto.useArtifact(@b, 'Containment Cage', 'Use')

#TODO: Go to Legion screen, legion base, UDT for buffing

GLAuto.navigateToBattle(@b)
GLAuto.battleNPCs(@b)

#b.quit


