energy_whitelist = {"mult", "mult1", "mult2", "chips", "chips1", "chips2", "chips3", "Xmult", "money", "money_mod", "mult_mod", "mult_mod2", "s_mult", "chip_mod", "Xmult_mod", 
                    "Xmult_multi",  "Xmult_multi2"}
energy_values = {
  mult = .2, mult1 = .2, mult2 = .2, chips = .2, chips1 = .2, chips2 = .2, chips3 = .2, Xmult = .2, money = .1, money_mod = .1, mult_mod = .2, mult_mod2 = .2, s_mult = .2, chip_mod = .2, 
  Xmult_mod = .2, Xmult_multi = .1, Xmult_multi2 = .1
}

energy_max = 3

scaled_evos = {"seadra", "golbat", "magmar", "scyther", "sentret"}

family = {
    {"bulbasaur","ivysaur","venusaur"},
    {"charmander","charmeleon","charizard"},
    {"squirtle","wartortle","blastoise"},
    {"caterpie","metapod","butterfree"},
    {"weedle","kakuna","beedrill"},
    {"pidgey","pidgeotto","pidgeot"},
    {"rattata","raticate"},
    {"spearow","fearow"},
    {"ekans","arbok"},
    {"pichu", "pikachu","raichu"},
    {"sandshrew","sandslash"},
    {"nidoranf","nidorina","nidoqueen"},
    {"nidoranm","nidorino","nidoking"},
    {"cleffa", "clefairy","clefable"},
    {"vulpix","ninetales"},
    {"igglybuff", "jigglypuff","wigglytuff"},
    {"zubat","golbat", "crobat"},
    {"oddish","gloom","vileplume", "bellossom"},
    {"paras","parasect"},
    {"venonat","venomoth"},
    {"diglett","dugtrio"},
    {"meowth","persian"},
    {"psyduck","golduck"},
    {"mankey","primeape", "annihilape"},
    {"growlithe","arcanine"},
    {"poliwag","poliwhirl","poliwrath", "politoed"},
    {"abra","kadabra","alakazam"},
    {"machop","machoke","machamp"},
    {"bellsprout","weepinbell","victreebel"},
    {"tentacool","tentacruel"},
    {"geodude","graveler","golem"},
    {"ponyta","rapidash"},
    {"slowpoke","slowbro", "slowking"},
    {"magnemite","magneton", "magnezone"},
    {"doduo","dodrio"},
    {"seel","dewgong"},
    {"grimer","muk"},
    {"shellder","cloyster"},
    {"gastly","haunter","gengar"},
    {"onix","steelix"},
    {"drowzee","hypno"},
    {"krabby","kingler"},
    {"voltorb","electrode"},
    {"exeggcute","exeggutor"},
    {"cubone","marowak"},
    {"koffing","weezing"},
    {"rhyhorn","rhydon", "rhyperior"},
    {"horsea","seadra", "kingdra"},
    {"goldeen","seaking"},
    {"staryu","starmie"},
    {"scyther", "scizor"},
    {"mimejr", "mrmime"},
    {"elekid", "electabuzz", "electivire"},
    {"magby", "magmar", "magmortar"},
    {"tangela", "tangrowth"},
    {"smoochum", "jynx"},
    {"magikarp","gyarados"},
    {"munchlax", "snorlax"},
    {"happiny", "chansey", "blissey"},
    {"lickitung", "lickilicky"},
    {"porygon", "porygon2", "porygonz"},
    {"eevee", "vaporeon", "jolteon", "flareon", "espeon", "umbreon", "glaceon", "leafeon", "sylveon"},
    {"omanyte","omastar"},
    {"kabuto","kabutops"},
    {"dratini","dragonair","dragonite"},
    {"tyrogue", "hitmonlee", "hitmonchan", "hitmontop"},
    {"beldum", "metang", "metagross"},
    {"sentret", "furret"},
    {"buizel", "floatzel"},
    {"grubbin", "charjabug", "vikavolt"},
    {"yamper","boltund"}
}

type_sticker_applied = function(card)
  if not card then return false end
  if card.ability.grass_sticker then
    return "Grass"
  elseif card.ability.fire_sticker then
    return "Fire"
  elseif card.ability.water_sticker then
    return "Water"
  elseif card.ability.lightning_sticker then
    return "Lightning"
  elseif card.ability.psychic_sticker then
    return "Psychic"
  elseif card.ability.fighting_sticker then
    return "Water"
  elseif card.ability.colorless_sticker then
    return "Colorless"
  elseif card.ability.dark_sticker then
    return "Dark"
  elseif card.ability.metal_sticker then
    return "Metal"
  elseif card.ability.fairy_sticker then
    return "Fairy"
  elseif card.ability.dragon_sticker then
    return "Dragon"
  elseif card.ability.earth_sticker then
    return "Earth"
  else
    return false
  end
  
end

find_pokemon_type = function(target_type)
  local found = {}
  if G.jokers and G.jokers.cards then
    for k, v in pairs(G.jokers.cards) do
      if v.ability and ((v.ability.extra and type(v.ability.extra) == "table" and target_type == v.ability.extra.ptype) or v.ability[string.lower(target_type).."_sticker"]) then
        table.insert(found, v)
      end
    end
  end
  return found
end

is_type = function(card, target_type)
  if card.ability and ((card.ability.extra and type(card.ability.extra) == "table" and target_type == card.ability.extra.ptype) or card.ability[string.lower(target_type).."_sticker"]) then
    return true
  else
    return false
  end
end

energy_matches = function(card, etype, include_colorless)
  if card.ability and card.ability.extra and type(card.ability.extra) == "table" then
    if (card.ability.extra.ptype and etype and card.ability.extra.ptype == etype) or (card.ability[string.lower(etype).."_sticker"]) then
      return true
    elseif etype == "Colorless" and (card.ability.extra.ptype or type_sticker_applied(card)) and include_colorless then
      return true
    end
  elseif card.ability and (card.ability.extra and type(card.ability.extra) == "number") or (card.ability.mult and card.ability.mult > 0) or (card.ability.t_mult and card.ability.t_mult > 0) or 
      (card.ability.t_chips and card.ability.t_chips > 0) then
    if card.ability[string.lower(etype).."_sticker"] then
      return true
    elseif etype == "Colorless" and type_sticker_applied(card) and include_colorless then
      return true
    end
  end
  return false
end

energize = function(card, etype, evolving)
  if type(card.ability.extra) == "table" then
    for l, data in pairs(card.ability.extra) do
      if type(data) == "number" then
        for m, name in ipairs(energy_whitelist) do
          if l == name then
            local addition = energy_values[name]
            if evolving then
              if card.ability.extra.ptype ~= "Colorless" and not card.ability.colorless_sticker then
                addition = (addition * (card.ability.extra.energy_count or 0)) + (addition/2 * (card.ability.extra.c_energy_count or 0))
              else
                addition = (addition * ((card.ability.extra.energy_count or 0) + (card.ability.extra.c_energy_count or 0)))
              end
              card.ability.extra[l] =  data + (card.config.center.config.extra[l] * addition) * (card.ability.extra.escale or 1)
            else
              if (card.ability.extra.ptype ~= "Colorless" and not card.ability.colorless_sticker) and etype == "Colorless" then
                card.ability.extra[l] = data + (card.config.center.config.extra[l] * addition/2) * (card.ability.extra.escale or 1)
              else
                card.ability.extra[l] = data + (card.config.center.config.extra[l] * addition) * (card.ability.extra.escale or 1)
              end
            end
          end
        end
      end
    end
  elseif type(card.ability.extra) == "number" then
    local increase = nil
    local mult = nil
    local mult_mod = nil
    local chip = nil
    local chip_mod = nil
    local Xmult = nil
    local Xmult_mod = nil
    local money = nil
    local mults = {"Joker" , "Jolly Joker", "Zany Joker", "Mad Joker", "Crazy Joker", "Droll Joker", "Half Joker", "Mystic Summit", "Gros Michel", "Popcorn"}
    local mult_mods = {"Greedy Joker", "Lusty Joker", "Wrathful Joker", "Gluttonous Joker", "Fibonacci", "Abstract Joker", "Even Steven", "Ride the Bus", "Green Joker", "Red Card", "Erosion",
                       "Fortune Teller", "Pokedex", "Flash Card", "Spare Trousers", "Smiley Face", "Onyx Agate", "Shoot the Moon", "Bootstraps"}
    local chips = {"Sly Joker", "Wily Joker", "Clever Joker", "Devious Joker", "Crafty Joker", "Stuntman"}
    local chip_mods = {"Banner", "Scary Face", "Odd Todd", "Runner", "Blue Joker", "Hiker", "Square Joker", "Stone Joker", "Bull", "Castle", "Arrowhead", "Wee Joker"}
    local Xmults = {"Loyalty Card", "Blackboard", "Cavendish", "Card Sharp", "Ramen", "Acrobat", "Flower Pot", "Seeing Double", "The Duo", "The Trio", "The Family", "The Order", "The Tribe", 
                    "Driver's License"}
    local Xmult_mods = {"Joker Stencil", "Steel Joker", "Constellation", "Madness", "Vampire", "Hologram", "Baron", "Obelisk", "Photograph", "Lucky Cat", "Baseball Card", "Everstone", "Ancient Joker",
                        "Campfire", "Throwback", "Bloodstone", "Glass Joker", "The Idol", "Hit the Road", "Canio", "Triboulet", "Yorick"}
    local monies = {"Delayed Gratification", "Egg", "Cloud 9", "Rocket", "Gift Card", "Reserved Parking", "Mail-In Rebate", "To the Moon", "Golden Joker", "Trading Card", "Golden Ticket", "Rough Gem",
                    "Satellite", "Matador"}
    
    for k, v in pairs(mults) do
      if card.ability.name == v then
        mult = true
      end
    end
    
    for k, v in pairs(mult_mods) do
      if card.ability.name == v then
        mult_mod = true
      end
    end
    
    for k, v in pairs(chips) do
      if card.ability.name == v then
        chip = true
      end
    end
    
    for k, v in pairs(chip_mods) do
      if card.ability.name == v then
        chip_mod = true
      end
    end
    
    for k, v in pairs(Xmults) do
      if card.ability.name == v then
        Xmult = true
      end
    end
    
    for k, v in pairs(Xmult_mods) do
      if card.ability.name == v then
        money = true
      end
    end
    
    for k, v in pairs(monies) do
      if card.ability.name == v then
        money = true
      end
    end
    
    if mult then
      increase = energy_values.mult
    elseif mult_mod then
      increase = energy_values.mult_mod
    elseif chip then
      increase = energy_values.chips
    elseif chip_mod then
      increase = energy_values.chip_mod
    elseif Xmult then
      increase = energy_values.Xmult
    elseif Xmult_mod then
      increase = energy_values.Xmult_mod
    elseif money then
      increase = energy_values.money
    end
    if increase then
      if not card.ability.colorless_sticker and etype == "Colorless" then
        card.ability.extra = card.ability.extra + (card.config.center.config.extra * increase/2)
      else
        card.ability.extra = card.ability.extra + (card.config.center.config.extra * increase)
      end
    end
  else
    local increase = nil
    if (card.ability.mult and card.ability.mult > 0) or (card.ability.t_mult and card.ability.t_mult > 0) then
      increase = energy_values.mult
    elseif (card.ability.t_chips and card.ability.t_chips > 0) then
      increase = energy_values.chips
    end
    if increase then
      if not card.ability.colorless_sticker and etype == "Colorless" then
        increase = increase/2
      end
      if (card.ability.mult and card.ability.mult > 0) then
        card.ability.mult = card.ability.mult + (card.config.center.config.mult * increase)
      end
      if (card.ability.t_mult and card.ability.t_mult > 0) then
        card.ability.t_mult = card.ability.t_mult + (card.config.center.config.t_mult * increase)
      end
      if (card.ability.t_chips and card.ability.t_chips > 0) then
        card.ability.t_chips = card.ability.t_chips + (card.config.center.config.t_chips * increase)
      end
    end
  end
  card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize("poke_energized_ex"), colour = G.ARGS.LOC_COLOURS.pink})
end

copy_scaled_values = function(card)
  local values = {mult = 0, chips = 0, Xmult = 0, money = 0}
  if card.ability and card.ability.extra and type(card.ability.extra) == "table" then
    for l, v in pairs(values) do
      if card.ability.extra[l] and (card.ability.extra[l.."_mod"] or card.ability.extra[string.sub(l, 1, -2).."_mod"]) then
        values[l] = card.ability.extra[l]
      end
    end
  end
  return values
end

remove = function(self, card, context)
  play_sound('tarot1')
  card.T.r = -0.2
  card:juice_up(0.3, 0.4)
  card.states.drag.is = true
  card.children.center.pinch.x = true
  G.E_MANAGER:add_event(Event({
      trigger = 'after', delay = 0.3, blockable = false,
      func = function()
          G.jokers:remove_card(self)
          card:remove()
          card = nil
          return true
      end
  }))
  return true
end

evolve = function(self, card, context, forced_key)
  if not pokermon_config.no_evos and not next(find_joker("everstone")) and not context.retrigger_joker then
    local poketype_list = nil
    local previous_edition = nil
    local previous_perishable = nil
    local previous_eternal = nil
    local previous_rental = nil
    local previous_energy_count = nil
    local previous_c_energy_count = nil
    local shiny = nil
    local type_sticker = nil
    local scaled = nil
    local scaled_values = nil
    local reset_apply_type = nil
    local previous_extra_value = nil
    
    if card.edition then
      previous_edition = card.edition
      if card.edition.poke_shiny then
        shiny = true
      end
    end
    
    if card.ability.perishable then
      previous_perishable = card.ability.perishable
    end
      
    if card.ability.eternal then
      previous_eternal = card.ability.eternal
    end

    if card.ability.rental then
      previous_rental = card.ability.rental
    end
    
    if card.ability.extra and card.ability.extra.energy_count then
      previous_energy_count  = card.ability.extra.energy_count
    end
      
    if card.ability.extra and card.ability.extra.c_energy_count then
      previous_c_energy_count  = card.ability.extra.c_energy_count
    end 
    
    for i = 1, #scaled_evos do
      local name = nil
      if not card.name and card.ability.name then
        name = card.ability.name
      else
        name = card.name
      end
      if name == scaled_evos[i] then
        scaled_values = copy_scaled_values(card)
        scaled = true
        break
      end
    end
    
    if type_sticker_applied then
      poketype_list = {"grass", "fire", "water", "lightning", "psychic", "fighting", "colorless", "dark", "metal", "fairy", "dragon", "earth"}
      for l, v in pairs(poketype_list) do
        if card.ability[v.."_sticker"] then
          type_sticker = v
          break
        end
      end
    end
    
    if card.ability.extra_value then
      previous_extra_value = card.ability.extra_value
    end
    
    G.E_MANAGER:add_event(Event({
        remove(self, card, context)
      }))
    
    if G.GAME.modifiers.apply_type then
      G.GAME.modifiers.apply_type = false
      reset_apply_type = true
    end
    
    local temp_card = {set = "Joker", area = G.jokers, key = forced_key, no_edition = true}
    local new_card = SMODS.create_card(temp_card)
    
    if reset_apply_type then
      G.GAME.modifiers.apply_type = true
    end
    
    if previous_edition then
      if shiny then
        local edition = {poke_shiny = true}
         new_card:set_edition(edition, true)
         new_card.config.shiny_on_add = true
      else
        new_card:set_edition(previous_edition, true)
      end
    end
    
    if previous_perishable then
       new_card.ability.perishable = previous_perishable
       new_card.ability.perish_tally = G.GAME.perishable_rounds
    end

    if previous_eternal then
      new_card.ability.eternal = previous_eternal
    end

    if previous_rental then
      new_card.ability.rental = previous_rental
    end
    
    if new_card.ability and new_card.ability.extra and previous_energy_count then
      new_card.ability.extra.energy_count = previous_energy_count
    end
    
    if new_card.ability and new_card.ability.extra and previous_c_energy_count then
      new_card.ability.extra.c_energy_count = previous_c_energy_count
    end
    
    if new_card.ability and new_card.ability.extra and (new_card.ability.extra.energy_count or new_card.ability.extra.c_energy_count) then
      energize(new_card, nil, true)
    end
    
    if scaled then
      for l, v in pairs(scaled_values) do
        if v > 0 and new_card.ability and new_card.ability.extra and type(new_card.ability.extra) == "table" and v > new_card.ability.extra[l] then
          new_card.ability.extra[l] = v
        end
      end
    end
    
    if type_sticker then
      apply_type_sticker(new_card, type_sticker)
    end
    
    if previous_extra_value then
      new_card.ability.extra_value = previous_extra_value
      new_card:set_cost()
    end
    
    new_card:add_to_deck()
    G.jokers:emplace(new_card)
    return localize("poke_evolve_success")
  end
end

can_evolve = function(self, card, context, forced_key, ignore_step, allow_level)
  if not G.P_CENTERS[forced_key] then return false end
  if next(find_joker("everstone")) and not allow_level then return false end
  if ((not context.repetition and not context.individual and context.end_of_round) or ignore_step) and not context.blueprint and not pokermon_config.no_evos then
    return true
  else
    return false
  end
end

level_evo = function(self, card, context, forced_key)
    if can_evolve(self, card, context, forced_key) and card.ability.extra.rounds then
      if card.ability.extra.rounds > 0 then
        card.ability.extra.rounds = card.ability.extra.rounds - 1
      end
      if card.ability.extra.rounds == 1 then
        local eval = function(card) return not card.REMOVED end
        juice_card_until(card, eval, true)
      end
      if card.ability.extra.rounds <= 0 then
        return {
          message = evolve (self, card, context, forced_key)
        }
      elseif card.ability.extra.rounds > 0 then
        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize("poke_evolve_level")})
      end
    elseif can_evolve(self, card, context, forced_key, nil, true) and card.ability.extra.rounds then
      if card.ability.extra.rounds > 0 then
        card.ability.extra.rounds = card.ability.extra.rounds - 1
        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize("poke_evolve_level")})
      end
    end
end

item_evo = function(self, card, context, forced_key)
    if (card.ability.extra.evolve and ((card.ability.extra.evolve == true) or type(card.ability.extra.evolve) == "string")) then
      if type(card.ability.extra.evolve) == "string" then
        forced_key = card.ability.extra.evo_list[card.ability.extra.evolve]
      end
      if forced_key and can_evolve(self, card, context, forced_key) then
        return {
          message = evolve (self, card, context, forced_key)
        }
      end
    end
end

scaling_evo = function (self, card, context, forced_key, current, target)
  if can_evolve(self, card, context, forced_key) and current >= target then
    return {
      message = evolve (self, card, context, forced_key)
    }
  end
  if can_evolve(self, card, context, forced_key, true) and current >= target and not card.ability.extra.juiced then
    card.ability.extra.juiced = true
    local eval = function(card) return current >= target and not card.REMOVED and not G.RESET_JIGGLES end
    juice_card_until(card, eval, true)
  end
end

type_evo = function (self, card, context, forced_key, type_req)
  if can_evolve(self, card, context, forced_key) and card.ability[type_req.."_sticker"] then
    return {
      message = evolve (self, card, context, forced_key)
    }
  elseif can_evolve(self, card, context, forced_key, true) and card.ability[type_req.."_sticker"] and not card.ability.extra.juiced then
    card.ability.extra.juiced = true
    local eval = function(card) return not card.REMOVED end
    juice_card_until(card, eval, true)
  end
end

deck_suit_evo = function (self, card, context, forced_key, suit, percentage)
  if can_evolve(self, card, context, forced_key) then
    local suit_count = 0
    for k, v in pairs(G.playing_cards) do
      if v:is_suit(suit) then suit_count = suit_count + 1 end
    end
    if suit_count/#G.playing_cards >= percentage then
      return {
        message = evolve (self, card, context, forced_key)
      }
    end
  end
end

deck_enhance_evo = function (self, card, context, forced_key, enhancement, percentage)
  if can_evolve(self, card, context, forced_key) then
    local enhance_count = 0
    for k, v in pairs(G.playing_cards) do
      if v.ability.name == enhancement.." Card" then enhance_count  = enhance_count  + 1 end
    end
    if enhance_count/#G.playing_cards >= percentage then
      return {
        message = evolve (self, card, context, forced_key)
      }
    end
  end
end

get_highest_evo = function(card)
  local name = nil
  local found = nil
  if not card.name and card.ability.name then
    name = card.ability.name
  else
    name = card.name or "bulbasaur"
  end
  for k, v in ipairs(family) do
    local evos = {}
    for x, y in ipairs(v) do
      if found and y == v[#v] and G.P_CENTERS["j_poke_"..y].stage ~= G.P_CENTERS["j_poke_"..name].stage then
        table.insert(evos, y)
      elseif found and G.P_CENTERS["j_poke_"..y].stage == G.P_CENTERS["j_poke_"..v[#v]].stage and G.P_CENTERS["j_poke_"..y].stage ~= G.P_CENTERS["j_poke_"..name].stage then
        table.insert(evos, y)
      elseif not found and y == name then
        found = true
      end
    end
    if #evos > 0 then
      if #evos == 1 then
        return evos[1]
      else
        return pseudorandom_element(evos, pseudoseed('highest'))
      end
    else
      found = false
    end
  end
  return false
end

pokemon_in_pool = function (self)
  if next(find_joker("Showman")) or next(find_joker("pokedex")) then
      return true
  end
  local name
  if not self.name and self.ability.name then
    name = self.ability.name
  else
    name = self.name or "bulbasaur"
  end
  local found_other
  local in_family
  for k, v in ipairs(family) do
    for l, p in ipairs(v) do
      if p ~= name and next(find_joker(p)) then
        found_other = true 
      elseif p == name then
        in_family = true
      end
    end
    if in_family and found_other then
      return false
    end
    found_other = false
    in_family = false
  end
  if next(find_joker(name)) then
    return false
  else
    if self.enhancement_gate and G.playing_cards then
      for k, v in pairs(G.playing_cards) do
          if v.config.center.key == self.enhancement_gate then
              return true
          end
      end
      return false
    end
    return true
  end
end

energy_use = function(self, card, area, copier)
  local applied = false
  local viable = false
  for k, v in pairs(G.jokers.cards) do
    if applied ~= true and (energy_matches(v, self.etype, true) or self.etype == "Trans") then
      if type(v.ability.extra) == "table" then
        if (pokermon_config.unlimited_energy) or (((v.ability.extra.energy_count or 0) + (v.ability.extra.c_energy_count or 0)) < energy_max + (G.GAME.energy_plus or 0)) then
          for l, data in pairs(v.ability.extra) do
            if type(data) == "number" then
              for m, name in ipairs(energy_whitelist) do
                if l == name then
                  viable = true
                end
              end
            end
          end
        end
      elseif applied ~= true and (type(v.ability.extra) == "number" or (v.ability.mult and v.ability.mult > 0) or (v.ability.t_mult and v.ability.t_mult > 0) or
            (v.ability.t_chips and v.ability.t_chips > 0)) then
        if (pokermon_config.unlimited_energy) or (((v.ability.energy_count or 0) + (v.ability.c_energy_count or 0)) < energy_max + (G.GAME.energy_plus or 0)) then
          viable = true
        end
      end
      if viable then
        if type(v.ability.extra) == "table" then
          if (energy_matches(v, self.etype, false) or self.etype == "Trans") then
            if v.ability.extra.energy_count then
              v.ability.extra.energy_count = v.ability.extra.energy_count + 1
            else
              v.ability.extra.energy_count = 1
            end
            energize(v, false)
            applied = true
          elseif self.etype == "Colorless" then
            if v.ability.extra.c_energy_count then
              v.ability.extra.c_energy_count = v.ability.extra.c_energy_count + 1
            else
              v.ability.extra.c_energy_count = 1
            end
            energize(v, self.etype, false)
            applied = true
          end
        elseif type(v.ability.extra) == "number" or (v.ability.mult and v.ability.mult > 0) or (v.ability.t_mult and v.ability.t_mult > 0) or 
               (v.ability.t_chips and v.ability.t_chips > 0) then
          if (energy_matches(v, self.etype, false) or self.etype == "Trans") then
            if v.ability.energy_count then
              v.ability.energy_count = v.ability.energy_count + 1
            else
              v.ability.energy_count = 1
            end
            energize(v, false)
            applied = true
          elseif self.etype == "Colorless" then
            if v.ability.c_energy_count then
              v.ability.c_energy_count = v.ability.c_energy_count + 1
            else
              v.ability.c_energy_count = 1
            end
            energize(v, self.etype, false)
            applied = true
          end
        end
      end
    end
  end
end

energy_increase = function(card, etype)
  local can_increase = false
  if card.ability.extra and type(card.ability.extra) == "table" and ((pokermon_config.unlimited_energy) or 
    (((card.ability.extra.energy_count or 0) + (card.ability.extra.c_energy_count or 0)) < energy_max + (G.GAME.energy_plus or 0))) then
    can_increase = true
  elseif not (card.ability.extra and type(card.ability.extra) == "table") and ((pokermon_config.unlimited_energy) or 
             (((card.ability.energy_count or 0) + (card.ability.c_energy_count or 0)) < energy_max + (G.GAME.energy_plus or 0))) then
    can_increase = true
  end
  
  if can_increase then
    if type(card.ability.extra) == "table" then
      if (energy_matches(card, etype, false) or etype == "Trans") then
        if card.ability.extra.energy_count then
          card.ability.extra.energy_count = card.ability.extra.energy_count + 1
        else
          card.ability.extra.energy_count = 1
        end
        energize(card, false)
      elseif etype == "Colorless" then
        if card.ability.extra.c_energy_count then
          card.ability.extra.c_energy_count = card.ability.extra.c_energy_count + 1
        else
          card.ability.extra.c_energy_count = 1
        end
        energize(card, etype, false)
      end
    elseif type(card.ability.extra) == "number" or (card.ability.mult and card.ability.mult > 0) or (card.ability.t_mult and card.ability.t_mult > 0) or 
         (card.ability.t_chips and card.ability.t_chips > 0) then
      if (energy_matches(card, etype, false) or etype == "Trans") then
        if card.ability.energy_count then
          card.ability.energy_count = card.ability.energy_count + 1
        else
          card.ability.energy_count = 1
        end
        energize(card, false)
      elseif etype == "Colorless" then
        if card.ability.c_energy_count then
          card.ability.c_energy_count = card.ability.c_energy_count + 1
        else
          card.ability.c_energy_count = 1
        end
        energize(card, etype, false)
      end
    end
  end
end

energy_can_use = function(self, card)
  for k, v in pairs(G.jokers.cards) do
    if energy_matches(v, self.etype, true) then
      if type(v.ability.extra) == "table" then
        if (pokermon_config.unlimited_energy or ((v.ability.extra.energy_count or 0) + (v.ability.extra.c_energy_count or 0)) < energy_max + (G.GAME.energy_plus or 0)) then
          for l, data in pairs(v.ability.extra) do
            if type(data) == "number" then
              for m, name in ipairs(energy_whitelist) do
                if l == name then
                  return true
                end
              end
            end
          end
        end
      elseif type(v.ability.extra) == "number" then
        if (pokermon_config.unlimited_energy) or (((v.ability.energy_count or 0) + (v.ability.c_energy_count or 0)) < energy_max + (G.GAME.energy_plus or 0)) then
          return true
        end
      elseif (v.ability.mult and v.ability.mult > 0) or (v.ability.t_mult and v.ability.t_mult > 0) or (v.ability.t_chips and v.ability.t_chips > 0) then
        if (pokermon_config.unlimited_energy) or (((v.ability.energy_count or 0) + (v.ability.c_energy_count or 0)) < energy_max + (G.GAME.energy_plus or 0)) then
          return true
        end
      end
    end
  end
  return false
end

matching_energy = function(card)
  local poketype_list = {"grass", "fire", "water", "lightning", "psychic", "fighting", "colorless", "dark", "metal", "fairy", "dragon", "earth"}
  if card.ability.extra and type(card.ability.extra) == "table" and card.ability.extra.ptype and card.ability.extra.ptype ~= "Bird" then
    if card.ability.extra.ptype == "Dark" or card.ability.extra.ptype == "dark" then
      return "c_poke_"..string.lower(card.ability.extra.ptype).."ness_energy"
    else
      return "c_poke_"..string.lower(card.ability.extra.ptype).."_energy"
    end
  end
  for l, v in pairs(poketype_list) do
    if card.ability[v.."_sticker"] then
      if v == "dark" then
        return "c_poke_"..v.."ness_energy"
      else
        return "c_poke_"..v.."_energy"
      end
    end
  end
end

evo_item_use = function(self, card, area, copier)
    local applied = false
    local evolve = false
    for k, v in pairs(G.jokers.cards) do
      if applied ~= true then
        if v.ability and v.ability.extra and type(v.ability.extra) == "table" and type(v.ability.extra.item_req) ~= "table" and v.ability.extra.item_req == self.name and not v.ability.extra.evolve then
          evolve = true
        elseif v.ability and v.ability.extra and type(v.ability.extra) == "table" and type(v.ability.extra.item_req) == "table" and not v.ability.extra.evolve then
          for l, p in pairs(v.ability.extra.item_req) do
            if p == self.name then
              evolve = p
            end
          end
        end
        
        if evolve then
          v.ability.extra.evolve = evolve
          applied = true
          local eval = function(v) return not v.REMOVED end
          juice_card_until(v, eval, true)
        end
      end
    end
    return true
end

highlighted_evo_item = function(self, card, area, copier)
    local evolve = false
    if not G.jokers.highlighted or #G.jokers.highlighted ~= 1 then return false end
    local choice = G.jokers.highlighted[1]
    if choice.ability and choice.ability.extra and type(choice.ability.extra) == "table" and type(choice.ability.extra.item_req) ~= "table" and choice.ability.extra.item_req == self.name and 
       not choice.ability.extra.evolve then
      evolve = true
    elseif choice.ability and choice.ability.extra and type(choice.ability.extra) == "table" and type(choice.ability.extra.item_req) == "table" and not choice.ability.extra.evolve then
      for l, p in pairs(choice.ability.extra.item_req) do
        if p == self.name then
          evolve = p
        end
      end
    end
    
    if evolve then
      choice.ability.extra.evolve = evolve
      local eval = function(choice) return not choice.REMOVED end
      juice_card_until(choice, eval, true)
    end
    return true
end

evo_item_in_pool = function(self)
    if G.jokers then
      for k, v in pairs(G.jokers.cards) do
        if v.ability and v.ability.extra and type(v.ability.extra) == "table" and type(v.ability.extra.item_req) ~= "table" and v.ability.extra.item_req == self.name then
          return true
        elseif v.ability and v.ability.extra and type(v.ability.extra) == "table" and type(v.ability.item_req) == "table" then
          for l, p in pairs(v.ability.extra.item_req) do
            if p == self.name then
              return true
            end
          end
        end
      end
    end
    return false
end

type_tooltip = function(self, info_queue, center)
  if center.ability.extra and type(center.ability.extra) == "table" and center.ability.extra.ptype and not type_sticker_applied(center) then
    info_queue[#info_queue+1] = {set = 'Other', key = center.ability.extra.ptype}
  end
  if not pokermon_config.unlimited_energy then
    if (center.ability and center.ability.extra and type(center.ability.extra) == "table" and ((center.ability.extra.energy_count or 0) + (center.ability.extra.c_energy_count or 0) > 0)) then
        info_queue[#info_queue+1] = {set = 'Other', key = "energy", vars = {(center.ability.extra.energy_count or 0) + (center.ability.extra.c_energy_count or 0), energy_max + (G.GAME.energy_plus or 0)}}
    elseif (center.ability and ((center.ability.energy_count or 0) + (center.ability.c_energy_count or 0) > 0)) then
        info_queue[#info_queue+1] = {set = 'Other', key = "energy", vars = {(center.ability.energy_count or 0) + (center.ability.c_energy_count or 0), energy_max + (G.GAME.energy_plus or 0)}}
    end
  end
end

apply_type_sticker = function(card, sticker_type)
  local poketype_list = {"Grass", "Fire", "Water", "Lightning", "Psychic", "Fighting", "Colorless", "Dark", "Metal", "Fairy", "Dragon", "Earth"}
  local apply_type = nil
  
  if sticker_type then
    apply_type = sticker_type
    card.ability[string.lower(apply_type).."_sticker"] = true
  else
    apply_type = pseudorandom_element(poketype_list, pseudoseed("tera"))
    card.ability[string.lower(apply_type).."_sticker"] = true
  end
  
  for l, v in pairs(poketype_list) do
    if string.lower(v) ~= string.lower(apply_type) then
      card.ability[string.lower(v).."_sticker"] = false
    end
  end
  
  if card.ability and card.ability.extra and type(card.ability.extra) == "table" and card.ability.extra.ptype then
    card.ability.extra.ptype = apply_type 
  end
  
  if card.config and type(card.config) == "table" and card.config.center and type(card.config.center) == "table" and not card.config.center.stage 
     and not G.P_CENTERS[card.config.center_key].taken_ownership then
    if G.P_CENTERS[card.config.center_key].loc_vars and type(G.P_CENTERS[card.config.center_key].loc_vars) == "function" then
      local lv = G.P_CENTERS[card.config.center_key].loc_vars
      SMODS.Joker:take_ownership(card.config.center_key, {
        unlocked = true, 
        discovered = true,
        loc_vars = function(self, info_queue, center)
          type_tooltip(self, info_queue, center)
          return lv(self, info_queue, center)
        end,
      }, true)
    else
      SMODS.Joker:take_ownership(card.config.center_key, {
        unlocked = true, 
        discovered = true,
        loc_vars = function(self, info_queue, center)
          type_tooltip(self, info_queue, center)
        end,
      }, true)
    end
  end
end

juice_flip = function()
  for i = 1, #G.hand.highlighted do
      G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.4,
          func = function()
              play_sound('tarot1')
              G.hand.highlighted[i]:juice_up(0.3, 0.5)
              return true
          end
      }))
      local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
      G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.15,
          func = function()
              G.hand.highlighted[i]:flip(); play_sound('card1', percent); G.hand.highlighted[i]:juice_up(0.3, 0.3); return true
          end
      }))
  end
end

create_random_poke_joker = function(pseed, stage, pokerarity, area, poketype)
  local poke_keys = {}
  local pokearea = area or G.jokers
  local poke_key
  local create_args = {set = "Joker", area = pokearea, key = ''}
  
  if pokerarity then
    if string.lower(pokerarity) == "common" then pokerarity = 1 end
    if string.lower(pokerarity) == "uncommon" then pokerarity = 2 end
    if string.lower(pokerarity) == "rare" then pokerarity = 3 end
  end
  
  for k, v in pairs(G.P_CENTERS) do
    if v.stage and v.stage ~= "Other" and not (stage and v.stage ~= stage) and not (pokerarity and v.rarity ~= pokerarity) and get_gen_allowed(v.atlas) and get_poke_allowed(v.key) 
       and not (poketype and poketype ~= v.ptype) then
      table.insert(poke_keys, v.key)
    end
  end
  
  if #poke_keys > 0 then
    poke_key = pseudorandom_element(poke_keys, pseudoseed(pseed))
  else
    poke_key = "j_poke_caterpie"
  end
  create_args.key = poke_key

  return SMODS.create_card(create_args)
end

get_gen_allowed = function(atlas)
  local gen_allowed = true
  if pokermon_config.gen_one and atlas ~= "poke_Pokedex1" and atlas ~= "poke_others" then
    gen_allowed = false
  end
  return gen_allowed
end

get_poke_allowed = function(key)
  local banned_keys = {"taurosh"}
  local allowed = true
  
  for i=1, #banned_keys do
    if banned_keys[i] == key then
      allowed = false
      break
    end
  end
  
  return allowed
end