require 'rails_helper'

RSpec.feature "Users kunnen nieuwe opdrachten versturen" do
  before do
    visit "users/1"
  end

  # before do
  #   visit "/"

  #   fill_in "Gebruikersnaam", with: "Katarina"
  #   fill_in "Password", with: "12345"

  #   click_button "Meld mij aan"
  # end


  # scenario "maar allereerst moet de toegang verleent worden" do
  #   user = User.find_by(name: "Katarina")
  #   expect(page.current_url).to eq user_url(user)
  #   expect(page).to have_content "U bent ingelogd bij De Ruby Bank."
  # end

  scenario "met valide gegevens" do
    fill_in "Transferbedrag", with: "233.28"
    fill_in "Naam van ontvanger", with: "Karel"
    
    click_button "Ja."
    expect(page).to have_content "Uw opdracht is verzonden."
  end

  scenario "maar hun saldo is ontoereikend" do
    fill_in "Transferbedrag", with: "100000.00"
    fill_in "Naam van ontvanger", with: "Esmeralda"
    
    click_button "Ja."
    expect(page).to have_content "U beschikt niet over voldoende saldo om uw opdracht te doen slagen."
  end

  scenario "maar ze laten de velden blank" do
    fill_in "Transferbedrag", with: ""
    fill_in "Naam van ontvanger", with: ""
    
    click_button "Ja."
    expect(page).to have_content "U dient een juist bedrag in te vullen."
    expect(page).to have_content "U dient een naam op te geven welke aanwezig is in het banksysteem."
  end

  scenario "maar niet naar zichzelf " do
    fill_in "Transferbedrag", with: "233.28"
    fill_in "Naam van ontvanger", with: "Katarina"
    
    click_button "Ja."
    expect(page).to have_content "U kunt vanuit uw account geen opdracht versturen naar deze zelfde account."
  end

  scenario "en uitloggen op elk moment" do
    click_link "Afmelden"
    expect(page).to have_content "U bent succesvol afgemeld."
  end
end