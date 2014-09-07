require 'rubygems'
require 'selenium-webdriver'
require 'watir-webdriver'
require 'watir-scroll'
require './rubypass.rb'
require './glauto.rb'

@bChrome = Watir::Browser.new :chrome
Watir.always_locate = false
@bChrome.add_checker do |page|
  page.iframe(:id => 'iframe_canvas').present?
end

GLAuto.loginToFacebook(@bChrome)

@bChrome.goto "http://apps.facebook.com/galaxylegion/"

Watir::Wait.until(10) {@bChrome.iframe(:id => 'iframe_canvas').present? }

Watir::Wait.until(10) { @bChrome.iframe(:id => 'iframe_canvas').link(:id => "menu_Ship").present? }

# Go to Ship screen, use ability to buff for NPC attack
GLAuto.activateModuleAbility(@bChrome, 'Cybernetic Link Interface')
GLAuto.activateModuleAbility(@bChrome, 'Dark Void Engine')
GLAuto.activateModuleAbility(@bChrome, 'Alarri Probability Core')
GLAuto.activateModuleAbility(@bChrome, 'Subquantum Tracing Console')
GLAuto.activateModuleAbility(@bChrome, 'Q-Pedd Ansible')
GLAuto.activateModuleAbility(@bChrome, 'Scruuge Charged Hypernode')
GLAuto.activateModuleAbility(@bChrome, 'Q-Pedd Assembly Line')
GLAuto.activateModuleAbility(@bChrome, 'Thraccti, Scruuge Defector')
GLAuto.activateModuleAbility(@bChrome, 'Q-Pedd Emotion Simulator')

GLAuto.activatePlayerAbility(@bChrome, 'Dark Aperture-Key','Activate')
#GLAuto.activatePlayerAbility(@b, 'Uldrinan Quota','Use')

# Collect minerals and artifacts
GLAuto.collectMinerals(@bChrome)
GLAuto.collectArtifacts(@bChrome)

GLAuto.useAllArtifact(@bChrome,'Rescued Prisoners','Use')
GLAuto.useAllArtifact(@bChrome,'Android Helmsman','Hire')
GLAuto.useAllArtifact(@bChrome,'Android Scientist','Hire')
GLAuto.useAllArtifact(@bChrome,'Rescued Specialists','Hire')
GLAuto.useAllArtifact(@bChrome,'Rescued Scientists','Hire')
GLAuto.useAllArtifact(@bChrome,'XCharge Cells','Use')
GLAuto.useAllArtifact(@bChrome,'Durtanium Brackets','Use')

GLAuto.scrapAllArtifact(@bChrome,'Dark Phase Engine')
GLAuto.scrapAllArtifact(@bChrome,'Scythe Plating')
GLAuto.scrapAllArtifact(@bChrome,"Sha'din Hypergrid Core")
GLAuto.scrapAllArtifact(@bChrome,"Sha'din Hypergrid Network")
GLAuto.scrapAllArtifact(@bChrome,"Sha'din Security Terminal")
GLAuto.scrapAllArtifact(@bChrome,'T.O. Phase Barrier')
GLAuto.scrapAllArtifact(@bChrome,'T.O. Harmonic TeraPulser')

GLAuto.useArtifact(@bChrome, 'Crimson Amplifier', 'Use')
GLAuto.useArtifact(@bChrome, 'Crux Amplifier', 'Use')
GLAuto.useArtifact(@bChrome, 'Crimson Obelisk', 'Use')
GLAuto.useArtifact(@bChrome, 'Ancient Crystal Foci', 'Use')
GLAuto.useArtifact(@bChrome, 'Shockpulse Charger', 'Use')
GLAuto.useArtifact(@bChrome, 'Grid Console', 'Use')
GLAuto.useArtifact(@bChrome, 'Nanite Swarm Capsules', 'Use')
GLAuto.useArtifact(@bChrome, 'Repair Nanodrones', 'Use') if GLAuto.hullTotal(@bFirefox) == 0
GLAuto.useArtifact(@bChrome, 'Shield Amplifier', 'Charge')
GLAuto.useArtifact(@bChrome, 'Neural Interface', 'Use')
GLAuto.useArtifact(@bChrome, 'Containment Cage', 'Use')
GLAuto.useArtifact(@bChrome, 'Krionus Virus Trap', 'Set')
GLAuto.useArtifact(@bChrome, 'Quantum Firewall Trap','Set')

GLAuto.navigateToBattle(@bChrome)
GLAuto.battleNPCs(@bChrome)

@bChrome.quit


