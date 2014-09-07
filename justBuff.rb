require 'rubygems'
require 'selenium-webdriver'
require 'watir-webdriver'
require 'watir-scroll'
require './rubypass.rb'
require './glauto.rb'

@bFirefox = Watir::Browser.new :firefox
Watir.always_locate = false
@bFirefox.add_checker do |page|
  page.frame(:id => 'iframe_canvas').present?
end

GLAuto.loginToFacebook(@bFirefox)

@bFirefox.goto "http://apps.facebook.com/galaxylegion/"

# Go to Ship screen, use ability to buff for NPC attack
GLAuto.activateModuleAbility(@bFirefox, 'Dark Void Engine')
GLAuto.activateModuleAbility(@bFirefox, 'Alarri Probability Core')
GLAuto.activateModuleAbility(@bFirefox, 'Subquantum Tracing Console')
GLAuto.activateModuleAbility(@bFirefox, 'Q-Pedd Ansible')
GLAuto.activateModuleAbility(@bFirefox, 'Scruuge Charged Hypernode')
GLAuto.activateModuleAbility(@bFirefox, 'Q-Pedd Assembly Line')
GLAuto.activateModuleAbility(@bFirefox, 'Thraccti, Scruuge Defector')

GLAuto.activatePlayerAbility(@bFirefox, 'Dark Aperture-Key','Activate')
GLAuto.activatePlayerAbility(@bFirefox, 'Uldrinan Quota','Use')

# Collect minerals and artifacts
GLAuto.collectMinerals(@bFirefox)
#TODO: Go to Legion Base and Collect Production
GLAuto.collectArtifacts(@bFirefox)

# Start with weapons buffs
begin
  tries ||= 3
  Watir::Wait.until(10) { @bFirefox.frame(:id => 'iframe_canvas').present? }
  @bFirefox.scroll.to    @bFirefox.frame(:id => 'iframe_canvas').span(:id => 's-Hull-l')
  hulltotal = @bFirefox.frame(:id => 'iframe_canvas').span(:id => 's-Hull-l').text.to_i
rescue Watir::Exception::UnknownObjectException, Selenium::WebDriver::Error::StaleElementReferenceError, Net::ReadTimeout, Watir::Wait::TimeoutError => e
  puts "#{ e } (#{ e.class })!"
  retry unless (tries -= 1).zero?
end
GLAuto.useAllArtifact(@bFirefox,'Rescued Prisoners','Use')
GLAuto.useAllArtifact(@bFirefox,'Android Helmsman','Hire')
GLAuto.useAllArtifact(@bFirefox,'Android Scientist','Hire')
GLAuto.useAllArtifact(@bFirefox,'Rescued Specialists','Hire')
GLAuto.useAllArtifact(@bFirefox,'Rescued Scientists','Hire')
GLAuto.useAllArtifact(@bFirefox,'XCharge Cells','Use')
GLAuto.useAllArtifact(@bFirefox,'Durtanium Brackets','Use')
GLAuto.useAllArtifact(@bFirefox,'Alien Data Disc','Analyze')
GLAuto.useAllArtifact(@bFirefox,'Mass Storage Pod','Use')

GLAuto.scrapAllArtifact(@bFirefox,'Dark Phase Engine')
GLAuto.scrapAllArtifact(@bFirefox,'Scythe Plating')
GLAuto.scrapAllArtifact(@bFirefox,"Sha'din Hypergrid Core")
GLAuto.scrapAllArtifact(@bFirefox,"Sha'din Hypergrid Network")
GLAuto.scrapAllArtifact(@bFirefox,"Sha'din Security Terminal")
GLAuto.scrapAllArtifact(@bFirefox,'T.O. Phase Barrier')
GLAuto.scrapAllArtifact(@bFirefox,'T.O. Harmonic TeraPulser')

GLAuto.useArtifact(@bFirefox, 'Crimson Amplifier', 'Use')
GLAuto.useArtifact(@bFirefox, 'Crimson Amplifier', 'Use')
GLAuto.useArtifact(@bFirefox, 'Crux Amplifier', 'Use')
GLAuto.useArtifact(@bFirefox, 'Crimson Obelisk', 'Use')
GLAuto.useArtifact(@bFirefox, 'Ancient Crystal Foci', 'Use')
GLAuto.useArtifact(@bFirefox, 'Shockpulse Charger', 'Use')
GLAuto.useArtifact(@bFirefox, 'Grid Console', 'Use')
GLAuto.useArtifact(@bFirefox, 'Nanite Swarm Capsules', 'Use')
GLAuto.useArtifact(@bFirefox, 'Repair Nanodrones', 'Use') if hulltotal == 0
GLAuto.useArtifact(@bFirefox, 'Shield Amplifier', 'Charge')
GLAuto.useArtifact(@bFirefox, 'Neural Interface', 'Use')
GLAuto.useArtifact(@bFirefox, 'Containment Cage', 'Use')
GLAuto.useArtifact(@bFirefox, 'Krionus Virus Trap', 'Set')
GLAuto.useArtifact(@bFirefox, 'Quantum Firewall Trap','Set')



@bFirefox.quit


