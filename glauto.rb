module GLAuto
  ABILITY = 1
  USEBUTTON = 3

  ARTIFACT = 1
  BTNARRAY = 3

  IMAGE = 0
  TARGET = 1
  RANK = 2
  TYPE = 3
  STATUS = 4
  ATK_BTN = 5

  #TODO: Functions still needed:
  #      GLAuto.scrapArtifact(browser,artifact,number)
  #      GLAuto.scrapAllArtifact(browser,artifact)
  #      GLAuto.useAllArtifact(browser,artifact,useText)
  #      GLAuto.allocateRankPoints(browser,attribute,number)
  #      GLAuto.allocateAllRankPoints(browser,attribute)
  #      GLAuto.collectFromBase(browser)
  #      GLAuto.UDTBuff(browser,buffname)
  #      GLAuto.createFromCTL(browser,itemname,number)
  #      GLAuto.convertResearchToCredits(browser)
  #      GLAuto.attemptExperiment(browser)


  def GLAuto.useArtifact(browser, artifact, useText)
    tries ||= 0
    if !browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? then
      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').visible? }
      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").visible? }
      browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").click
      browser.frame(:id => 'iframe_canvas').link(:text => "Artifacts").click
    end
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
    browser.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set artifact
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
    artifacttable = browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
    if !artifacttable.td(:class => 'dataTables_empty').exists? then
      artifacttable.rows.each do |row|
        if row[ARTIFACT].text.include? artifact then
          row[BTNARRAY].button(:text => useText).click
          break
        end
      end
    end
  rescue Watir::Exception::UnknownObjectException, Selenium::WebDriver::Error::StaleElementReferenceError => e
    puts "#{ e } (#{ e.class })!"
    retry unless (tries -= 1).zero?
  end

  def GLAuto.navigateToBattle(browser)
    #Repeated 8 times to get new NPCs
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
  end

  def GLAuto.collectArtifacts(browser)
    tries ||= 3
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').visible? }
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").visible? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").click
    if browser.frame(:id => 'iframe_canvas').checkbox(:id => 'getallartifact').present? then
      browser.frame(:id => 'iframe_canvas').checkbox(:id => 'getallartifact').set
      browser.frame(:id => 'iframe_canvas').button(:id => 'traderas').click
      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').button(:class => 'red').present? }
      browser.frame(:id => 'iframe_canvas').button(:class => 'red').click
    end
    browser.frame(:id => 'iframe_canvas').link(:text => "Artifacts").click
    if browser.frame(:id => 'iframe_canvas').button(:id => 'tradestack').present? then
      browser.frame(:id => 'iframe_canvas').button(:id => 'tradestack').click
    end
  rescue Watir::Exception::UnknownObjectException, Selenium::WebDriver::Error::StaleElementReferenceError => e
    puts "#{ e } (#{ e.class })!"
    retry unless (tries -= 1).zero?
  end


  def GLAuto.collectMinerals(browser)
    tries ||= 3
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').visible? }
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").visible? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').div(:id => 'tab5').present? }
    if browser.frame(:id => 'iframe_canvas').button(:id => 'traderms').present? then
      browser.frame(:id => 'iframe_canvas').button(:id => 'traderms').click
      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').button(:id => 'tradesellallm').present? }
      browser.frame(:id => 'iframe_canvas').button(:id => 'tradesellallm').click
    end
  rescue Watir::Exception::UnknownObjectException, Selenium::WebDriver::Error::StaleElementReferenceError => e
    puts "#{ e } (#{ e.class })!"
    retry unless (tries -= 1).zero?
  end

  def GLAuto.activateModuleAbility(browser, abilityname)
    tries ||= 3

    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Ship").visible? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Ship").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').button(:text => 'Use an Ability').present? }
    browser.frame(:id => 'iframe_canvas').button(:text => 'Use an Ability').click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:text => "Module Abilities").present? }
    browser.frame(:id => 'iframe_canvas').link(:text => "Module Abilities").click
    #puts "Activate #{abilityname}"
    Watir::Wait.until(20) { browser.frame(:id => 'iframe_canvas').div(:id => 'tabmods').table.present? }
    abilitytable = browser.frame(:id => 'iframe_canvas').div(:id => 'tabmods').table
    abilitytable.rows.each do |row|
      browser.scroll.to row
      if row[ABILITY].span.exists? then
        #puts "#{row[ABILITY].span.text} == #{abilityname}?"
        if row[ABILITY].span.text.include? abilityname then
          if !row[USEBUTTON].button(:class => 'grey').present? then
            row[USEBUTTON].button(:text => 'Use').click
            #puts "Activated #{abilityname}"
            break
          end
        end
      end
    end
    browser.frame(:id => 'iframe_canvas').div(:class => 'dialog-close').click
  rescue Watir::Exception::UnknownObjectException, Selenium::WebDriver::Error::StaleElementReferenceError => e
    puts "#{ e } (#{ e.class })!"
    retry unless (tries -= 1).zero?
  end


  def GLAuto.activatePlayerAbility(browser, abilityname)
    tries ||= 3
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Ship").visible? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Ship").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').button(:text => 'Use an Ability').present? }
    browser.frame(:id => 'iframe_canvas').button(:text => 'Use an Ability').click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:text => "Player Abilities").present? }
    browser.frame(:id => 'iframe_canvas').link(:text => "Player Abilities").click
    #puts "Activate #{abilityname}"
    Watir::Wait.until(20) { browser.frame(:id => 'iframe_canvas').div(:id => 'tababil').table.present? }
    abilitytable = browser.frame(:id => 'iframe_canvas').div(:id => 'tababil').table
    abilitytable.rows.each do |row|
      browser.scroll.to row
      if row[ABILITY].span.exists? then
        #puts "#{row[ABILITY].span.text} == #{abilityname}?"
        if row[ABILITY].span.text.include? abilityname then
          if !row[USEBUTTON].button(:class => 'grey').present? then
            row[USEBUTTON].button(:text => 'Use').click
            #puts "Activated #{abilityname}"
            break
          end
        end
      end
    end
    browser.frame(:id => 'iframe_canvas').div(:class => 'dialog-close').click
  rescue Watir::Exception::UnknownObjectException, Selenium::WebDriver::Error::StaleElementReferenceError => e
    puts "#{ e } (#{ e.class })!"
    retry unless (tries -= 1).zero?
  end

  def GLAuto.battleNPCs(browser)
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').table(:id => 'npcbattle').visible? }
    energytotal = browser.frame(:id => 'iframe_canvas').span(:id => 's-Energy-l').text.to_i
    hulltotal = browser.frame(:id => 'iframe_canvas').span(:id => 's-Hull-l').text.to_i
    if hulltotal < 20000 then
      GLAuto.useArtifact(browser, 'Repair Nanodrones', 'Use')
      GLAuto.useArtifact(browser, 'Shield Restorer', 'Use')
      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
      browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    end
    browser.add_checker do |page|
      page.frame(:id => 'iframe_canvas').present?
    end
    Watir.always_locate = false

    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    while energytotal > 10 and hulltotal > 20000 do
      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').table(:id => 'npcbattle').visible? }
      npctable = browser.frame(:id => 'iframe_canvas').table(:id => "npcbattle")
      npctable.rows.each do |row|
        browser.scroll.to row
        if row[TYPE].text.include? 'Standard'
          if !row[TARGET].text.include? 'Xathe' and !(row[TARGET].text.include? 'Scruuge' and row[TYPE].text.include? 'Rare') then
            row[ATK_BTN].button(:tag_name => "button").click
            Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').button(:id => 'npcattack').visible? }
            atkbtn = browser.frame(:id => 'iframe_canvas').button(:id => 'npcattack')
            until browser.frame(:id => 'iframe_canvas').button(:class => 'grey').present? or energytotal < 10 or hulltotal < 20000 do
              atkbtn.when_present.click if atkbtn.when_present.enabled?
              Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').table(:id => 'npcbattle').visible? }
              energytotal -= 5
              hulltotal = browser.frame(:id => 'iframe_canvas').span(:id => 's-Hull-l').text.to_i
            end
            browser.frame(:id => 'iframe_canvas').div(:class => 'dialog-close').click
            break
          end
        end
      end

      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').table(:id => 'npcbattle').visible? }
      energytotal = browser.frame(:id => 'iframe_canvas').span(:id => 's-Energy-l').text.to_i
      hulltotal = browser.frame(:id => 'iframe_canvas').span(:id => 's-Hull-l').text.to_i
      if hulltotal < 20000 then
        browser.frame(:id => 'iframe_canvas').div(:class => 'dialog-close').click
        Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').table(:id => 'npcbattle').visible? }
        GLAuto.navigateToTrade(browser)
        GLAuto.useArtifact(browser, 'Repair Nanodrones', 'Use')
        Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").visible? }
        browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
        break
      end
      puts "Current energy: #{energytotal}, Hull: #{hulltotal}"
    end
  rescue Watir::Exception::UnknownObjectException, Selenium::WebDriver::Error::StaleElementReferenceError, Net::ReadTimeout, Watir::Wait::TimeoutError => e
    p "#{e}"
    retry
  end


  def GLAuto.loginToFacebook(browser)
    browser.goto "http://facebook.com"

    browser.text_field(:id => "email").set Authentication.username
    browser.text_field(:id => "pass").set Authentication.password
    browser.form(:id => 'login_form').submit

    browser.button(:name => "submit[Continue]").when_present.click
    if browser.button(:name => "submit[This is Okay]").exists? then
      browser.button(:name => "submit[This is Okay]").click
    end
    if browser.button(:name => "submit[Continue]").exists? then
      browser.button(:name => "submit[Continue]").click
    end
    if browser.button(:name => "submit[Continue]").exists? then
      browser.button(:name => "submit[Continue]").click
    end

  end

end