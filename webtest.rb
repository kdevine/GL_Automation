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
GLAuto.activateModuleAbility(@b, 'Q-Pedd Emotion Simulator')

GLAuto.activatePlayerAbility(@b, 'Dark Aperture-Key','Activate')
#GLAuto.activatePlayerAbility(@b, 'Uldrinan Quota','Use')

# Collect minerals and artifacts
GLAuto.collectMinerals(@b)
GLAuto.collectArtifacts(@b)

GLAuto.useAllArtifact(@b,'Rescued Prisoners','Use')
GLAuto.useAllArtifact(@b,'Android Helmsman','Hire')
GLAuto.useAllArtifact(@b,'Android Scientist','Hire')
GLAuto.useAllArtifact(@b,'Rescued Specialists','Hire')
GLAuto.useAllArtifact(@b,'Rescued Scientists','Hire')
GLAuto.useAllArtifact(@b,'XCharge Cells','Use')
GLAuto.useAllArtifact(@b,'Durtanium Brackets','Use')

GLAuto.scrapAllArtifact(@b,'Dark Phase Engine')
GLAuto.scrapAllArtifact(@b,'Scythe Plating')
GLAuto.scrapAllArtifact(@b,"Sha'din Hypergrid Core")
GLAuto.scrapAllArtifact(@b,"Sha'din Hypergrid Network")
GLAuto.scrapAllArtifact(@b,"Sha'din Security Terminal")
GLAuto.scrapAllArtifact(@b,'T.O. Phase Barrier')
GLAuto.scrapAllArtifact(@b,'T.O. Harmonic TeraPulser')

GLAuto.useArtifact(@b, 'Crimson Amplifier', 'Use')
GLAuto.useArtifact(@b, 'Crux Amplifier', 'Use')
GLAuto.useArtifact(@b, 'Crimson Obelisk', 'Use')
GLAuto.useArtifact(@b, 'Ancient Crystal Foci', 'Use')
GLAuto.useArtifact(@b, 'Shockpulse Charger', 'Use')
GLAuto.useArtifact(@b, 'Grid Console', 'Use')
GLAuto.useArtifact(@b, 'Nanite Swarm Capsules', 'Use')
GLAuto.useArtifact(@b, 'Repair Nanodrones', 'Use') if GLAuto.hullTotal(@b) == 0
GLAuto.useArtifact(@b, 'Shield Amplifier', 'Charge')
GLAuto.useArtifact(@b, 'Neural Interface', 'Use')
GLAuto.useArtifact(@b, 'Containment Cage', 'Use')
GLAuto.useArtifact(@b, 'Krionus Virus Trap', 'Set')
GLAuto.useArtifact(@b, 'Quantum Firewall Trap','Set')

GLAuto.navigateToBattle(@b)
GLAuto.battleNPCs(@b)

@b.quit


