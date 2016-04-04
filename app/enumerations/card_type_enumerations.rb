module CardTypeEnumerations
  extend Enumerize

  enumerize :card_type,
            in: {
                  :'INVALID'     => 0,
                  :'GAME'        => 1,
                  :'PLAYER'      => 2,
                  :'HERO'        => 3,
                  :'MINION'      => 4,
                  :'SPELL'       => 5,
                  :'ENCHANTMENT' => 6,
                  :'WEAPON'      => 7,
                  :'ITEM'        => 8,
                  :'TOKEN'       => 9,
                  :'HERO_POWER'  => 10,
                },
            scope: true
end
