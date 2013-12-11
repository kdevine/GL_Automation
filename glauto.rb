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
  #      GLAuto.allocateRankPoints(browser,attribute,number)
  #      GLAuto.allocateAllRankPoints(browser,attribute)
  #      GLAuto.collectFromBase(browser)
  #      GLAuto.UDTBuff(browser,buffname)
  #      GLAuto.createFromCTL(browser,itemname,number)
  #      GLAuto.convertResearchToCredits(browser)
  #      GLAuto.attemptExperiment(browser)

  def GLAuto.scrapAllArtifact(browser, artifact)
    GLAuto.scrapArtifact(browser, artifact, 999999)
  end

  def GLAuto.scrapArtifact(browser, artifact, number)
    tries ||= 0
    if !browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? then
      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').visible? }
      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").present? }
      browser.scroll.to browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade")
      browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").click
      browser.frame(:id => 'iframe_canvas').link(:text => "Artifacts").click
    end
    puts "Scrap #{artifact}"
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
    browser.scroll.to browser.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter')
    browser.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set artifact
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
    artifacttable = browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
    if !artifacttable.td(:class => 'dataTables_empty').exists? then
      artifacttable.rows.each do |row|
        browser.scroll.to row
        if row[ARTIFACT].text.include? artifact then
          # If number > uses left, set to uses left
          if row[ARTIFACT].text.include? "Uses Left" then
            usesLeft = row[ARTIFACT].span(:class => 'info').span.text.delete "(Uses Left: "
            usesLeft = usesLeft.delete ")"
            puts usesLeft
            if number > usesLeft.to_i then
              number = usesLeft.to_i
            end
          else
            number = 1
          end

          artifacttable.text_field(:id => 'sellart').set number
          row[BTNARRAY].button(:text => 'Scrap').click
          Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').div(:class => 'error_msg_lg').present? }
          browser.frame(:id => 'iframe_canvas').div(:class => 'error_msg_lg').button(:class => 'red').when_present.click
          break
        end
      end
    end
  rescue Watir::Exception::UnknownObjectException, Selenium::WebDriver::Error::StaleElementReferenceError => e
    puts "#{ e } (#{ e.class })!"
    retry unless (tries -= 1).zero?
  end

  def GLAuto.useAllArtifact(browser, artifact, useText)
    tries ||= 0
    if !browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? then
      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').visible? }
      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").present? }
      browser.scroll.to browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade")
      browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").click
      browser.frame(:id => 'iframe_canvas').link(:text => "Artifacts").click
    end
    puts "Use #{artifact}"
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
    browser.scroll.to browser.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter')
    browser.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set artifact
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
    artifacttable = browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
    until artifacttable.td(:class => 'dataTables_empty').exists? do
      artifacttable.rows.each do |row|
        browser.scroll.to row
        if row[ARTIFACT].text.include? artifact then
          row[BTNARRAY].button(:text => useText).click
          break
        end
      end
      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
      artifacttable = browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
    end
  rescue Watir::Exception::UnknownObjectException, Selenium::WebDriver::Error::StaleElementReferenceError => e
    puts "#{ e } (#{ e.class })!"
    retry unless (tries -= 1).zero?
  end

  def GLAuto.useArtifact(browser, artifact, useText)
    tries ||= 0
    if !browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? then
      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').visible? }
      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").present? }
      browser.scroll.to browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade")
      browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").click
      browser.frame(:id => 'iframe_canvas').link(:text => "Artifacts").click
    end
    puts "Use #{artifact}"
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
    browser.scroll.to browser.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter')
    browser.frame(:id => 'iframe_canvas').div(:id => 'artifacts_filter').text_field(:type => 'text').set artifact
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts').present? }
    artifacttable = browser.frame(:id => 'iframe_canvas').table(:id => 'artifacts')
    if !artifacttable.td(:class => 'dataTables_empty').exists? then
      artifacttable.rows.each do |row|
        browser.scroll.to row
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
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").present? }
    browser.scroll.to browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle")
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").present? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").present? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").present? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").present? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").present? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").present? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").present? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
  end

  def GLAuto.collectArtifacts(browser)
    tries ||= 3
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').visible? }
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").visible? }
    browser.scroll.to browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade")
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").click
    if browser.frame(:id => 'iframe_canvas').checkbox(:id => 'getallartifact').present? then
      browser.scroll.to browser.frame(:id => 'iframe_canvas').checkbox(:id => 'getallartifact')
      browser.frame(:id => 'iframe_canvas').checkbox(:id => 'getallartifact').set
      browser.frame(:id => 'iframe_canvas').button(:id => 'traderas').click
      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').button(:class => 'red').present? }
      browser.scroll.to browser.frame(:id => 'iframe_canvas').button(:class => 'red')
      browser.frame(:id => 'iframe_canvas').button(:class => 'red').click
    end
    browser.scroll.to browser.frame(:id => 'iframe_canvas').link(:text => "Artifacts")
    browser.frame(:id => 'iframe_canvas').link(:text => "Artifacts").click
    if browser.frame(:id => 'iframe_canvas').button(:id => 'tradestack').present? then
      browser.scroll.to browser.frame(:id => 'iframe_canvas').button(:id => 'tradestack')
      browser.frame(:id => 'iframe_canvas').button(:id => 'tradestack').click
    end
  rescue Watir::Exception::UnknownObjectException, Selenium::WebDriver::Error::StaleElementReferenceError => e
    puts "#{ e } (#{ e.class })!"
    retry unless (tries -= 1).zero?
  end

  def GLAuto.collectMinerals(browser)
    tries ||= 3
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').visible? }
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").present? }
    browser.scroll.to browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade")
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Trade").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').div(:id => 'tab5').present? }
    if browser.frame(:id => 'iframe_canvas').button(:id => 'traderms').present? then
      browser.scroll.to browser.frame(:id => 'iframe_canvas').button(:id => 'traderms')
      browser.frame(:id => 'iframe_canvas').button(:id => 'traderms').click
      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').button(:id => 'tradesellallm').present? }
      browser.scroll.to browser.frame(:id => 'iframe_canvas').button(:id => 'tradesellallm')
      browser.frame(:id => 'iframe_canvas').button(:id => 'tradesellallm').click
    end
  rescue Watir::Exception::UnknownObjectException, Selenium::WebDriver::Error::StaleElementReferenceError => e
    puts "#{ e } (#{ e.class })!"
    retry unless (tries -= 1).zero?
  end

  def GLAuto.activateModuleAbility(browser, abilityname)
    tries ||= 3
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Ship").present? }
    browser.scroll.to browser.frame(:id => 'iframe_canvas').link(:id => "menu_Ship")
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Ship").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').button(:text => 'Use an Ability').present? }
    browser.scroll.to browser.frame(:id => 'iframe_canvas').button(:text => 'Use an Ability')
    browser.frame(:id => 'iframe_canvas').button(:text => 'Use an Ability').click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:text => "Module Abilities").present? }
    browser.scroll.to browser.frame(:id => 'iframe_canvas').link(:text => "Module Abilities")
    browser.frame(:id => 'iframe_canvas').link(:text => "Module Abilities").click
    puts "Activate #{abilityname}"
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
    browser.scroll.to browser.frame(:id => 'iframe_canvas').div(:class => 'dialog-close')
    browser.frame(:id => 'iframe_canvas').div(:class => 'dialog-close').click
  rescue Watir::Exception::UnknownObjectException, Selenium::WebDriver::Error::StaleElementReferenceError => e
    puts "#{ e } (#{ e.class })!"
    retry unless (tries -= 1).zero?
  end

  def GLAuto.activatePlayerAbility(browser, abilityname, useText)
    tries ||= 3
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Ship").present? }
    browser.scroll.to browser.frame(:id => 'iframe_canvas').link(:id => "menu_Ship")
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Ship").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').button(:text => 'Use an Ability').present? }
    browser.scroll.to browser.frame(:id => 'iframe_canvas').button(:text => 'Use an Ability')
    browser.frame(:id => 'iframe_canvas').button(:text => 'Use an Ability').click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:text => "Player Abilities").present? }
    browser.scroll.to browser.frame(:id => 'iframe_canvas').link(:text => "Player Abilities")
    browser.frame(:id => 'iframe_canvas').link(:text => "Player Abilities").click
    puts "Activate #{abilityname}"
    Watir::Wait.until(20) { browser.frame(:id => 'iframe_canvas').div(:id => 'tababil').table.present? }
    abilitytable = browser.frame(:id => 'iframe_canvas').div(:id => 'tababil').table
    abilitytable.rows.each do |row|
      browser.scroll.to row
      if row[ABILITY].span.exists? then
        #puts "#{row[ABILITY].span.text} == #{abilityname}?"
        if row[ABILITY].span.text.include? abilityname then
          if !row[USEBUTTON].button(:class => 'grey').present? then
            row[USEBUTTON].button(:text => useText).click
            #puts "Activated #{abilityname}"
            break
          end
        end
      end
    end
    browser.scroll.to browser.frame(:id => 'iframe_canvas').div(:class => 'dialog-close')
    browser.frame(:id => 'iframe_canvas').div(:class => 'dialog-close').click
  rescue Watir::Exception::UnknownObjectException, Selenium::WebDriver::Error::StaleElementReferenceError => e
    puts "#{ e } (#{ e.class })!"
    retry unless (tries -= 1).zero?
  end

  def GLAuto.battleNPCs(browser)
    browser.scroll.to browser.frame(:id => 'iframe_canvas').span(:id => 's-Energy-l')
    energytotal = browser.frame(:id => 'iframe_canvas').span(:id => 's-Energy-l').text.to_i
    hulltotal = browser.frame(:id => 'iframe_canvas').span(:id => 's-Hull-l').text.to_i
    if hulltotal < 20000 then
      GLAuto.useArtifact(browser, 'Repair Nanodrones', 'Use')
      GLAuto.useArtifact(browser, 'Shield Restorer', 'Use')
      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").present? }
      browser.scroll.to browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle")
      browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    end

    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").present? }
    browser.scroll.to browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle")
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
    while energytotal > 10 and hulltotal > 20000 do
      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').table(:id => 'npcbattle').present? }
      browser.scroll.to browser.frame(:id => 'iframe_canvas').table(:id => "npcbattle")
      npctable = browser.frame(:id => 'iframe_canvas').table(:id => "npcbattle")
      npctable.rows.each do |row|
        browser.scroll.to row
        if row[TYPE].text.include? 'Standard'
          if !row[TARGET].text.include? 'Xathe' and !(row[TARGET].text.include? 'Scruuge' and row[TYPE].text.include? 'Rare') then
            until browser.frame(:id => 'iframe_canvas').button(:id => 'npcattack').present? do
              row[ATK_BTN].button(:tag_name => "button").click
            end
            Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').button(:id => 'npcattack').present? }
            atkbtn = browser.frame(:id => 'iframe_canvas').button(:id => 'npcattack')
            until browser.frame(:id => 'iframe_canvas').button(:class => 'grey').present? do
              atkbtn.when_present.click if atkbtn.when_present.enabled?
            end
            browser.scroll.to browser.frame(:id => 'iframe_canvas').div(:class => 'dialog-close')
            browser.frame(:id => 'iframe_canvas').div(:class => 'dialog-close').when_present.click
            break
          end
        end
      end

      Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').table(:id => 'npcbattle').present? }
      energytotal = browser.frame(:id => 'iframe_canvas').span(:id => 's-Energy-l').text.to_i
      hulltotal = browser.frame(:id => 'iframe_canvas').span(:id => 's-Hull-l').text.to_i
      if hulltotal < 20000 then
        browser.frame(:id => 'iframe_canvas').div(:class => 'dialog-close').click
        Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').table(:id => 'npcbattle').present? }
        GLAuto.navigateToTrade(browser)
        GLAuto.useArtifact(browser, 'Repair Nanodrones', 'Use')
        Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").present? }
        browser.frame(:id => 'iframe_canvas').link(:id => "menu_Battle").click
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
