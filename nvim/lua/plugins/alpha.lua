local M = {}

function M.setup()
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
        [[                    ."-,.__                                                    ]],
        [[                    `.     `.  ,                                               ]],
        [[                .--'  .._,'"-' `.                                              ]],
        [[                .    .'         `'                                             ]],
        [[                `.   /          ,'                                             ]],
        [[                `  '--.   ,-"'                                                 ]],
        [[                    `"`   |  \                                                 ]],
        [[                    -. \, |                                                    ]],
        [[                        `--Y.'      ___.                                       ]],
        [[                            \     L._, \                                       ]],
        [[                _.,        `.   <  <\                _                         ]],
        [[                ,' '           `, `.   | \            ( `                      ]],
        [[            ../, `.            `  |    .\`.           \ \_                     ]],
        [[            ,' ,..  .           _.,'    ||\l            )  '".                 ]],
        [[            , ,'   \           ,'.-.`-._,'  |           .  _._`.               ]],
        [[        ,' /      \ \        `' ' `--/   | \          / /   ..\                ]],
        [[        .'  /        \ .         |\__ - _ ,'` `        / /     `.`.            ]],
        [[        |  '          ..         `-...-"  |  `-'      / /        . `.          ]],
        [[        | /           |L__           |    |          / /          `. `.        ]],
        [[    , /            .   .          |    |         / /             ` `           ]],
        [[    / /          ,. ,`._ `-_       |    |  _   ,-' /               ` \         ]],
        [[    / .           \"`_/. `-_ \_,.  ,'    +-' `-'  _,        ..,-.    \`.       ]],
        [[    .  '         .-f    ,'   `    '.       \__.---'     _   .'   '     \ \     ]],
        [[    ' /          `.'    l     .' /          \..      ,_|/   `.  ,'`     L`     ]],
        [[    |'      _.-""` `.    \ _,'  `            \ `.___`.'"`-.  , |   |    | \    ]],
        [[    ||    ,'      `. `.   '       _,...._        `  |    `/ '  |   '     .|    ]],
        [[    ||  ,'          `. ;.,.---' ,'       `.   `.. `-'  .-' /_ .'    ;_   ||    ]],
        [[    || '              V      / /           `   | `   ,'   ,' '.    !  `. ||    ]],
        [[    ||/            _,-------7 '              . |  `-'    l         /    `||    ]],
        [[    . |          ,' .-   ,' ||               | .-.        `.      .'     ||    ]],
        [[    `'        ,'    `".'    |               |    `.        '. -.'       `'     ]],
        [[            /      ,'      |               |,'    \-.._,.'/'                   ]],
        [[            .     /        .               .       \    .''                    ]],
        [[            .`.    |         `.             /         :_,'.'                   ]],
        [[            \ `...\   _     ,'-.        .'         /_.-'                       ]],
        [[            `-.__ `,  `'   .  _.>----''.  _  __  /                             ]],
        [[                    .'        /"'          |  "'   '_                          ]],
        [[                /_|.-'\ ,".             '.'`__'-( \                            ]],
        [[                    / ,"'"\,'               `/  `-.|"                          ]],
        [[                                                                               ]],
        [[                                                                               ]],
        [[                __   __  ______  ______  __   ____  __    __                   ]],
        [[               /\ "-.\ \/\  ___\/\  __ \/\ \ / /\ \/\ "-./  \                  ]],
        [[               \ \ \-.  \ \  __\\ \ \/\ \ \ \'/\ \ \ \ \-./\ \                 ]],
        [[                \ \_\\"\_\ \_____\ \_____\ \__| \ \_\ \_\ \ \_\                ]],
        [[                 \/_/ \/_/\/_____/\/_____/\/_/   \/_/\/_/  \/_/                ]],
        [[                                                                               ]],
        [[                                                                               ]],
    }

    dashboard.section.buttons.val = {
        dashboard.button("e", "  >  New file", ":ene <bar> startinsert <cr>"),
        dashboard.button("m", "  >  Recent Files", ":Telescope frecency<cr>"),
        dashboard.button("f", "  >  Search Files", ":Telescope find_files<cr>"),
        dashboard.button("s", "  >  Find word", ":Telescope live_grep<cr>"),
        dashboard.button("g", "  >  Git", ":Neogit<cr>"),
        dashboard.button("in", "  >  Packer Install", ":PackerInstall<cr>"),
        dashboard.button("up", "  >  Packer Update", ":PackerSync<cr>"),
        dashboard.button("cl", "  >  Packer Clean", ":PackerClean<cr>"),
        dashboard.button("q", "  >  Quit nvim", ":qa!<cr>"),
    }

    dashboard.section.footer.val = {
        [[                                ]],
        [[  Everything is made of atoms.  ]],
        [[                  - R. Feynman  ]],
        [[                                ]],
    }

    require("alpha").setup(dashboard.opts)
end

return M
