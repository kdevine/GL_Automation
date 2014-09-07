require 'rubygems'
require 'selenium-webdriver'
require 'watir-webdriver'
require 'watir-scroll'
require './rubypass.rb'
require './glauto.rb'

@bFirefox = Watir::Browser.new :firefox
Watir.always_locate = false

@bFirefox.add_checker do |page|
  page.iframe(:id => 'iframe_canvas').present?
end


GLAuto.loginToFacebook(@bFirefox)


@bFirefox.goto "http://apps.facebook.com/galaxylegion/"
Watir::Wait.until(10) {@bFirefox.iframe(:id => 'iframe_canvas').present? }
Watir::Wait.until(10) { @bFirefox.iframe(:id => 'iframe_canvas').link(:id => "menu_Ship").present? }

# Go to Ship screen, use ability to buff for NPC attack
GLAuto.activateModuleAbility(@bFirefox, 'Cybernetic Link Interface')
GLAuto.activateModuleAbility(@bFirefox, 'Dark Void Engine')
GLAuto.activateModuleAbility(@bFirefox, 'Alarri Probability Core')
GLAuto.activateModuleAbility(@bFirefox, 'Subquantum Tracing Console')
GLAuto.activateModuleAbility(@bFirefox, 'Q-Pedd Ansible')
GLAuto.activateModuleAbility(@bFirefox, 'Scruuge Charged Hypernode')
GLAuto.activateModuleAbility(@bFirefox, 'Q-Pedd Assembly Line')
GLAuto.activateModuleAbility(@bFirefox, 'Thraccti, Scruuge Defector')
GLAuto.activateModuleAbility(@bFirefox, 'Q-Pedd Emotion Simulator')



GLAuto.activatePlayerAbility(@bFirefox, 'Dark Aperture-Key','Activate')
#

# Collect minerals and artifacts

GLAuto.collectMinerals(@bFirefox)
GLAuto.collectArtifacts(@bFirefox)

GLAuto.useAllArtifact(@bFirefox,'Rescued Prisoners','Use')
GLAuto.useAllArtifact(@bFirefox,'Android Helmsman','Hire')
GLAuto.useAllArtifact(@bFirefox,'Android Scientist','Hire')
GLAuto.useAllArtifact(@bFirefox,'Rescued Specialists','Hire')
GLAuto.useAllArtifact(@bFirefox,'Rescued Scientists','Hire')
GLAuto.useAllArtifact(@bFirefox,'XCharge Cells','Use')
GLAuto.useAllArtifact(@bFirefox,'Durtanium Brackets','Use')


GLAuto.scrapAllArtifact(@bFirefox,'Dark Phase Engine')
GLAuto.scrapAllArtifact(@bFirefox,'Scythe Plating')
GLAuto.scrapAllArtifact(@bFirefox,"Sha'din Hypergrid Core")
GLAuto.scrapAllArtifact(@bFirefox,"Sha'din Hypergrid Network")
GLAuto.scrapAllArtifact(@bFirefox,"Sha'din Security Terminal")
GLAuto.scrapAllArtifact(@bFirefox,'T.O. Phase Barrier')
GLAuto.scrapAllArtifact(@bFirefox,'T.O. Harmonic TeraPulser')


GLAuto.useArtifact(@bFirefox, 'Crimson Amplifier', 'Use')
GLAuto.useArtifact(@bFirefox, 'Crux Amplifier', 'Use')
GLAuto.useArtifact(@bFirefox, 'Crimson Obelisk', 'Use')
GLAuto.useArtifact(@bFirefox, 'Ancient Crystal Foci', 'Use')
GLAuto.useArtifact(@bFirefox, 'Shockpulse Charger', 'Use')
GLAuto.useArtifact(@bFirefox, 'Grid Console', 'Use')
GLAuto.useArtifact(@bFirefox, 'Nanite Swarm Capsules', 'Use')
GLAuto.useArtifact(@bFirefox, 'Repair Nanodrones', 'Use') if GLAuto.hullTotal(@bFirefox) == 0
GLAuto.useArtifact(@bFirefox, 'Shield Amplifier', 'Charge')
GLAuto.useArtifact(@bFirefox, 'Neural Interface', 'Use')
GLAuto.useArtifact(@bFirefox, 'Containment Cage', 'Use')
GLAuto.useArtifact(@bFirefox, 'Krionus Virus Trap', 'Set')
GLAuto.useArtifact(@bFirefox, 'Quantum Firewall Trap','Set')

GLAuto.navigateToBattle(@bFirefox)
GLAuto.battleNPCs(@bFirefox)


@bFirefox.quit


