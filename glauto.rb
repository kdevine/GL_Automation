module GLAuto
  ABILITY = 1
  USEBUTTON = 3
  
  ARTIFACT = 1
  BTNARRAY = 3

  def GLAuto.useArtifact(browser,artifact,useText)
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
  end

  def GLAuto.navigateToModuleAbilities(browser)
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:id => "menu_Ship").visible? }
    browser.frame(:id => 'iframe_canvas').link(:id => "menu_Ship").click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').button(:text => 'Use an Ability').present? }
    browser.frame(:id => 'iframe_canvas').button(:text => 'Use an Ability').click
    Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:text => "Module Abilities").present? }
    browser.frame(:id => 'iframe_canvas').link(:text => "Module Abilities").click
  end

  def GLAuto.activateAbility(browser,abilityname) 
    puts "Activate #{abilityname}"
    Watir::Wait.until(20) { browser.frame(:id => 'iframe_canvas').div(:id => 'tabmods').table.present? }
    
    div_with_scroll = browser.frame(:id => 'iframe_canvas').div(:id => 'tabmods')
    scroll_bottom_script = 'arguments[0].scrollTop = arguments[0].scrollHeight'
    div_with_scroll.browser.execute_script(scroll_bottom_script, div_with_scroll)
    
    abilitytable = browser.frame(:id => 'iframe_canvas').div(:id => 'tabmods').table
    abilitytable.rows.each do |row|
      puts "#{row[ABILITY].text}, Visible? #{row.visible?}"
      while !row.visible?
        # scroll
        Watir::Wait.until(10) { browser.frame(:id => 'iframe_canvas').link(:class => 'jspArrowDown').exists? }
        browser.frame(:id => 'iframe_canvas').link(:class => 'jspArrowDown').click
      end
      if row[ABILITY].span.exists? then
        puts "#{row[ABILITY].span.text} == #{abilityname}?"
        if row[ABILITY].span.text.include? abilityname then
          if !row[USEBUTTON].button(:class => 'grey').present? then
            row[USEBUTTON].button(:text => 'Use').click 
            break
          end
        end
      end
    end
  end
end
