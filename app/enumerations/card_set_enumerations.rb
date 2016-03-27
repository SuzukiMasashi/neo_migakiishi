module CardSetEnumerations
  extend Enumerize

  enumerize :card_set, in: {
    :'INVALID'        => 0,
    :'TEST_TEMPORARY' => 1,
    :'CORE'           => 2,
    :'EXPERT1'        => 3,
    :'REWARD'         => 4,
    :'MISSIONS'       => 5,
    :'DEMO'           => 6,
    :'NONE'           => 7,
    :'CHEAT'          => 8,
    :'BLANK'          => 9,
    :'DEBUG_SP'       => 10,
    :'PROMO'          => 11,
    :'NAXX'           => 12,
    :'GVG'            => 13,
    :'BRM'            => 14,
    :'TGT'            => 15,
    :'CREDITS'        => 16,
    :'HERO_SKINS'     => 17,
    :'TB'             => 18,
    :'SLUSH'          => 19,
    :'LOE'            => 20,
  }
end
