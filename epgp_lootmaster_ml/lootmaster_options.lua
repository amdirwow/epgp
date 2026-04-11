local mod = LootMaster:NewModule("EPGPLootmaster_Options")

--local LootMasterML = false

function mod:OnEnable()
  local options = {
    name = "amdir EPGP LootMaster",
    type = "group",
    get = function(i) return LootMaster.db.profile[i[#i]] end,
    set = function(i, v) LootMaster.db.profile[i[#i]] = v end,
    args = {
        
        global = {
            order = 1,
            type = "group",
            hidden = function(info) return not LootMasterML end,
            name = "Загальні налаштування",
            
                args = {
                
                help = {
                    order = 0,
                    type = "description",
                    name = "EPGP - це ігрова система розподілу луту. LootMaster допомагає роздавати предмети в рейді та реєструє їх у системі EPGP.",
                },
                
                
                
                no_ml = {
                    order = 2,
                    type = "description",
                    hidden = function(info) return LootMasterML end,
                    name = "\r\n\r\n|cFFFF8080УВАГА: Багато налаштувань приховано, бо модуль EPGPLootmaster 'ML' вимкнений. Увімкніть його в налаштуваннях аддонів.|r",
                },
                
                config_group = {
                    order = 12,
                    type = "group",
                    guiInline = true,
                    hidden = function(info) return not LootMasterML end,
                    name = "Загальні налаштування",
                    args = {
                        
                        use_epgplootmaster = {
                            order = 2,
                            type = "select",
			                width = "double",
                            set = function(i, v) 
                                LootMaster.db.profile.use_epgplootmaster = v;
                                if v == 'enabled' then
                                    LootMasterML:EnableTracking();
                                elseif v == 'disabled' then
                                    LootMasterML:DisableTracking();
                                else
                                    LootMasterML.current_ml = nil;
                                    LootMasterML:GROUP_UPDATE();
                                end                               
                                
                            end,
                            name = "Використовувати EPGPLootmaster",
                            desc = "Керує тим, чи ввімкнений EPGPLootmaster.",
                            values = {
                                ['enabled'] = 'Завжди використовувати EPGPLootmaster без запиту',
                                ['disabled'] = 'Ніколи не використовувати EPGPLootmaster',
                                ['ask'] = 'Питати щоразу, коли я стаю майстром здобичі'
                            },
                        },
                        
                        loot_timeout = {
                            order = 14,
                            type = "select",
			                width = "double",
                            name = "Таймаут вибору луту",
                            desc = "Визначає, скільки часу кандидат має на відповідь щодо предмета.",
                            values = {
                                [0] = 'Без таймауту',
                                [10] = '10 с',
                                [15] = '15 с',
                                [20] = '20 с',
                                [30] = '30 с',
                                [40] = '40 с',
                                [50] = '50 с',
                                [60] = '1 хв',
                                [90] = '1 хв 30 с',
                                [150] = '2 хв 30 с',
                                [300] = '5 хв',
                            },
                        }, 
                        
                        --[[defaultMainspecGP = {
                            order = 15.1,
                            type = "input",                    
                            name = "Default mainspec GP",
                            desc = "Fill this field to override the GP value for mainspec loot.",
                            width = 'normal',
                            validate = function(data, value) if value=='' then return true end; if not strmatch(value, '^%s*%d+%s-%%?%s*$') then return false else return true end end,
                            set = function(i, v) 
                                
                                if v == '' or not v then
                                    v = ''
                                    LootMaster.db.profile.defaultMainspecGPPercentage = false;
                                    LootMaster.db.profile.defaultMainspecGPValue = nil;
                                else
                                    value, perc = strmatch(v, '^%s*(%d+)%s-(%%?)%s*$')
                                    LootMaster.db.profile.defaultMainspecGPPercentage = (perc~=nil and perc~='');
                                    LootMaster.db.profile.defaultMainspecGPValue = tonumber(value);
                                end                               
                                LootMaster.db.profile.defaultMainspecGP = v;
                            end,
                            usage = "\r\nEmpty: use normal GP value"..
                                    "\r\n50%: use 50% of normal GP value"..
                                    "\r\n25: all items are worth 25 GP"
                        },
                        
                        defaultMinorUpgradeGP = {
                            order = 15.2,
                            type = "input",                    
                            name = "Default minor upgrade GP",
                            desc = "Fill this field to override the GP value for minor upgrade mainspec loot.",
                            width = 'normal',
                            validate = function(data, value) if value=='' then return true end; if not strmatch(value, '^%s*%d+%s-%%?%s*$') then return false else return true end end,
                            set = function(i, v) 
                                
                                if v == '' or not v then
                                    v = ''
                                    LootMaster.db.profile.defaultMinorUpgradeGPPercentage = false;
                                    LootMaster.db.profile.defaultMinorUpgradeGPValue = nil;
                                else
                                    value, perc = strmatch(v, '^%s*(%d+)%s-(%%?)%s*$')
                                    LootMaster.db.profile.defaultMinorUpgradeGPPercentage = (perc~=nil and perc~='');
                                    LootMaster.db.profile.defaultMinorUpgradeGPValue = tonumber(value);
                                end                               
                                LootMaster.db.profile.defaultMinorUpgradeGP = v;
                            end,
                            usage = "\r\nEmpty: use normal GP value"..
                                    "\r\n50%: use 50% of normal GP value"..
                                    "\r\n25: all items are worth 25 GP"
                        },
                        
                        defaultOffspecGP = {
                            order = 15.3,
                            type = "input",                    
                            name = "Default offspec GP",
                            desc = "Fill this field to override the GP value for offspec loot.",
                            width = 'normal',
                            validate = function(data, value) if value=='' then return true end; if not strmatch(value, '^%s*%d+%s-%%?%s*$') then return false else return true end end,
                            set = function(i, v) 
                                
                                if v == '' or not v then
                                    v = ''
                                    LootMaster.db.profile.defaultOffspecGPPercentage = false;
                                    LootMaster.db.profile.defaultOffspecGPValue = nil;
                                else
                                    value, perc = strmatch(v, '^%s*(%d+)%s-(%%?)%s*$')
                                    LootMaster.db.profile.defaultOffspecGPPercentage = (perc~=nil and perc~='');
                                    LootMaster.db.profile.defaultOffspecGPValue = tonumber(value);
                                end                               
                                LootMaster.db.profile.defaultOffspecGP = v;
                            end,
                            usage = "\r\nEmpty: use normal GP value"..
                                    "\r\n50%: use 50% of normal GP value"..
                                    "\r\n25: all items are worth 25 GP"
                        },
                        
                        defaultGreedGP = {
                            order = 15.4,
                            type = "input",                    
                            name = "Default greed GP",
                            desc = "Fill this field to override the GP value for greed loot.",
                            width = 'normal',
                            validate = function(data, value) if value=='' then return true end; if not strmatch(value, '^%s*%d+%s-%%?%s*$') then return false else return true end end,
                            set = function(i, v) 
                                
                                if v == '' or not v then
                                    v = ''
                                    LootMaster.db.profile.defaultGreedGPPercentage = false;
                                    LootMaster.db.profile.defaultGreedGPValue = nil;
                                else
                                    value, perc = strmatch(v, '^%s*(%d+)%s-(%%?)%s*$')
                                    LootMaster.db.profile.defaultGreedGPPercentage = (perc~=nil and perc~='');
                                    LootMaster.db.profile.defaultGreedGPValue = tonumber(value);
                                end                               
                                LootMaster.db.profile.defaultGreedGP = v;
                            end,
                            usage = "\r\nEmpty: use normal GP value"..
                                    "\r\n50%: use 50% of normal GP value"..
                                    "\r\n25: all items are worth 25 GP"
                        },]]
                        
                        ignoreResponseCorrections = {
                            type = "toggle",
                            order = 17,
                            width = 'full',
                            name = "Приймати лише першу відповідь кандидата на предмет.",
                            desc = "Зазвичай кандидат може кілька разів змінити відповідь через whisper. Якщо ввімкнути цю опцію, враховуватиметься лише перша відповідь.",
                        },
                        
                        allowCandidateNotes = {
                            type = "toggle",
                            order = 18,
                            width = 'full',
                            name = "Дозволити кандидатам додавати нотатки до предметів.",
                            desc = "Кандидати зможуть надсилати нотатки, які з'являтимуться іконкою у вікні луту. Це корисно для коментарів на кшталт 'потрібно лише якщо більше нікому не треба'.",
                        },
                        
                        filterEPGPLootmasterMessages = {
                            type = "toggle",
                            order = 19,
                            width = 'full',
                            name = "Фільтрувати оголошення та whisper-повідомлення.",
                            desc = "EPGPLootmaster дозволяє навіть гравцям без аддона відповідати через whisper і повідомлення в чат рейду. Увімкніть це, щоб приховати такі повідомлення у вашому чаті.",
                        },
                        
                        audioWarningOnSelection = {
                            type = "toggle",
                            order = 20,
                            width = 'full',
                            name = "Програвати звук при відкритті вікна вибору луту.",
                            desc = "Відтворює звукове попередження, коли відкривається вікно вибору предмета.",
                        },
                    }
                },
                
                buttons_group = {
                    order = 12.5,
                    type = "group",
                    guiInline = true,
                    hidden = function(info) return not LootMasterML end,
                    name = "Кнопки вибору",
                    args = {
                        
                        help = {
                            order = 0,
                            type = "description",
                            name = "Тут можна налаштувати кнопки вибору на інтерфейсі рейдерів. Порядок кнопок також визначає порядок сортування відповідей. Має бути щонайменше одна кнопка, а кнопка пасу завжди буде видима.",
                        },
                        
                        buttonNum = {
                            type = "range",
                            width = 'full',
                            order = 1,
                            name = "Кількість кнопок для показу:",
                            min = 1,
                            max = EPGPLM_MAX_BUTTONS,
                            step = 1,
                            desc = "Вкажіть, скільки кнопок показувати гравцям. Потрібна щонайменше одна кнопка, а кнопка пасу додається завжди.",
                        },
                        
                        
                        button1 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 1 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.1,
                            name = "button1",
                            desc = "Налаштувати цю кнопку вибору.",
                        },
                        
                        button2 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 2 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.2,
                            name = "button2",
                            desc = "Налаштувати цю кнопку вибору.",
                        },
                        
                        button3 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 3 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.3,
                            name = "button3",
                            desc = "Налаштувати цю кнопку вибору.",
                        },
                        
                        button4 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 4 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.4,
                            name = "button4",
                            desc = "Налаштувати цю кнопку вибору.",
                        },
                        
                        button5 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 5 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.5,
                            name = "button5",
                            desc = "Налаштувати цю кнопку вибору.",
                        },
                        
                        button6 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 6 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.6,
                            name = "button6",
                            desc = "Налаштувати цю кнопку вибору.",
                        },
                        
                        button7 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 7 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.7,
                            name = "button7",
                            desc = "Налаштувати цю кнопку вибору.",
                        },
                        
                        btnTestPopup = {
                            order = 3,
                            type = "execute",
                            width = 'full',
                            name = "Відкрити тестове вікно та монітор",
                            desc = "Відкриває тестове вікно і вікно монітора, щоб побачити, як це виглядатиме у гравців. Після перевірки натисніть кнопку відхилення луту, щоб закрити монітор.",
                            func = function()
                                local lootLink
                                for i=1, 20 do
                                  lootLink = GetInventoryItemLink("player", i)
                                  if lootLink then break end
                                end
                                if not lootLink then return end
                                
                                ml = LootMasterML        
                                local loot = ml:GetLoot(lootLink)
                                local added = false
                                if not loot then
                                    local lootID = ml:AddLoot(lootLink, true)
                                    loot = ml:GetLoot(lootID)
                                    loot.announced = false
                                    loot.manual = true
                                    added = true
                                end
                                if not loot then return self:Print('Unable to register loot.') end          
                                ml:AddCandidate(loot.id, UnitName('player'))
                                ml:AnnounceLoot(loot.id)
                                for i=1, LootMaster.db.profile.buttonNum do
                                  ml:AddCandidate(loot.id, 'Button ' .. i)
                                  ml:SetCandidateResponse(loot.id, 'Button ' .. i, LootMaster.RESPONSE['button'..i], true)
                                end
                                ml:ReloadMLTableForLoot(loot.link)
                            end
                        },
                    },
                },
                
                auto_hiding_group = {
                    order = 13,
                    type = "group",
                    guiInline = true,
                    hidden = function(info) return not LootMasterML end,
                    name = "Автоприховування",
                    args = {
                        
                        help = {
                            order = 0,
                            type = "description",
                            name = "Тут можна керувати автоматичним приховуванням вікон EPGPLootmaster.",
                        },
                                
                        hideOnSelection = {
                            type = "toggle",
                            order = 16,
                            width = 'full',
                            name = "Ховати вікно моніторингу, коли відкривається вибір луту.",
                            desc = "Автоматично приховує вікно Master Looter/Monitor, коли вам треба обрати need/greed/pass.",
                        },
                        
                        hideMLOnCombat = {
                            type = "toggle",
                            order = 17,
                            width = 'full',
                            name = "Ховати вікно моніторингу при вході в бій.",
                            desc = "Автоматично приховує вікно Master Looter/Monitor під час бою та повертає його після виходу з бою.",
                        },
                        
                        hideSelectionOnCombat = {
                            type = "toggle",
                            order = 18,
                            width = 'full',
                            name = "Ховати вікно вибору луту при вході в бій.",
                            desc = "Автоматично приховує інтерфейс need/greed/pass під час бою та повертає його після виходу з бою.",
                        },
                    },
                },
                
                auto_announce_group = {
                    order = 14,
                    type = "group",
                    guiInline = true,
                    hidden = function(info) return not LootMasterML end,
                    name = "Автооголошення",
                    args = {
                        
                        help = {
                            order = 0,
                            type = "description",
                            name = "Автооголошення EPGP Lootmaster дозволяє автоматично оголошувати вибраний лут у рейд.",
                        },
                                
                        auto_announce_threshold = {
                            order = 13,
                            type = "select",
                            width = 'full',
                            hidden = function(info) return not LootMasterML end,
                            name = "Поріг автооголошення",
                            desc = "Будь-який лут цієї якості або вищої буде автоматично оголошено учасникам рейду.",
                            values = {
                                [0] = 'Ніколи не оголошувати автоматично',
                                [2] = ITEM_QUALITY2_DESC,
                                [3] = ITEM_QUALITY3_DESC,
                                [4] = ITEM_QUALITY4_DESC,
                                [5] = ITEM_QUALITY5_DESC,
                            },
                        },
                    },
                },
                
                
                AutoLootGroup = {
            
                            type = "group",
                            order = 16,
                            guiInline = true,
                            name = "Автолут",
                            desc = "Автоматична передача предметів",
                            hidden = function(info) return not LootMasterML end,
                            args = {
                                
                                help = {
                                    order = 0,
                                    type = "description",
                                    name = "Автолут EPGP Lootmaster дозволяє без запиту передавати певні BoU і BoE предмети заздалегідь визначеному кандидату.",
                                },
                                
                                AutoLootThreshold = {
                                    order = 1,
                                    type = "select",
                                    width = 'full',
                                    hidden = function(info) return not LootMasterML end,
                                    name = "Поріг автолуту (лише BoE і BoU)",
                                    desc = "Будь-який BoE або BoU предмет цієї якості або нижче буде автоматично надісланий кандидату нижче.",
                                    values = {
                                        [0] = 'Ніколи не лутати автоматично',
                                        [2] = ITEM_QUALITY2_DESC,
                                        [3] = ITEM_QUALITY3_DESC,
                                        [4] = ITEM_QUALITY4_DESC,
                                        [5] = ITEM_QUALITY5_DESC,
                                    },
                                },
                                
                                AutoLooter = {
                                    type = "select",
                                    style = 'dropdown',
                                    order = 2,
                                    width = 'full',
                                    name = "Ім'я кандидата за замовчуванням:",
                                    desc = "Вкажіть ім'я кандидата, який отримуватиме BoE і BoU предмети.",
                                    disabled = function(info) return (LootMaster.db.profile.AutoLootThreshold or 0)==0 end,
                                    values = function()
                                        local names = {}
                                        local name;
                                        local num = GetNumRaidMembers()
                                        if num>0 then
                                            -- we're in raid
                                            for i=1, num do 
                                                name = GetRaidRosterInfo(i)
                                                names[name] = name
                                            end
                                        else
                                            num = GetNumPartyMembers()
                                            if num>0 then
                                                -- we're in party
                                                for i=1, num do 
                                                    names[UnitName('party'..i)] = UnitName('party'..i)
                                                end
                                                names[UnitName('player')] = UnitName('player')
                                            else
                                                -- Just show everyone in guild.
                                                local num = GetNumGuildMembers(true);
                                                for i=1, num do repeat
                                                    name = GetGuildRosterInfo(i)
                                                    names[name] = name
                                                until true end     
                                            end                                   
                                        end
                                        sort(names)
                                        return names;
                                    end
                                },
                            }
                },
            
        
        
                MonitorGroup = {
                            type = "group",
                            order = 17,
                            guiInline = true,
                            hidden = function(info) return not LootMasterML end,
                            name = "Моніторинг",
                            desc = "Надсилання і отримання monitor-повідомлень від майстра здобичі та перегляд вибору інших рейдерів.",
                            args = {
                                
                                help = {
                                    order = 0,
                                    type = "description",
                                    name = "Монітор EPGP Lootmaster дозволяє надсилати повідомлення іншим гравцям у рейді. Вони бачитимуть майже той самий інтерфейс, що і ML, і зможуть допомагати з розподілом луту.",
                                },
                
                                monitor = {
                                    type = "toggle",
                                    set = function(i, v)
                                        LootMaster.db.profile[i[#i]] = v;
                                        if LootMasterML and LootMasterML.UpdateUI then
                                            LootMasterML.UpdateUI( LootMasterML );
                                        end
                                    end,
                                    order = 1,
                                    width = 'full',
                                    name = "Отримувати оновлення монітора",
                                    desc = "Увімкніть, якщо хочете бачити вхідні monitor-оновлення. Це дозволяє бачити інтерфейс майстра здобичі й допомагати з рішеннями щодо розподілу луту.",
                                    disabled = false,
                                },
                                
                                monitorIncomingThreshold = {
                                    order = 2,
                                    width = 'normal',
                                    type = "select",
                                    name = "Отримувати лише для якості не нижче",
                                    desc = "Отримувати monitor-повідомлення з рейду лише для предметів цієї якості або вище. Враховуйте, що шаблони та подібні винятки також підпадають під цей поріг.",
                                    disabled = function(info) return not LootMaster.db.profile.monitor end,
                                    values = {
                                        [2] = ITEM_QUALITY2_DESC,
                                        [3] = ITEM_QUALITY3_DESC,
                                        [4] = ITEM_QUALITY4_DESC,
                                        [5] = ITEM_QUALITY5_DESC,
                                    },
                                },
                                
                                monitorSend = {
                                    type = "toggle",
                                    order = 3.1,
                                    width = 'full',
                                    name = "Надсилати monitor-оновлення",
                                    desc = "Увімкніть, якщо хочете надсилати вихідні monitor-повідомлення. Тоді інші рейдери бачитимуть інтерфейс майстра здобичі й зможуть допомагати з розподілом луту. Працює лише якщо ви майстер здобичі.",
                                    disabled = false,
                                },
                                
                                monitorSendAssistantOnly = {
                                    type = "toggle",
                                    order = 3.2,
                                    disabled = function(info) return not LootMaster.db.profile.monitorSend end,
                                    width = 'full',
                                    name = "Надсилати лише підвищеним гравцям",
                                    desc = "Створює додаткове навантаження, бо monitor-повідомлення надсилаються окремо асистам і рейд-лідеру. Лишіть вимкненим, якщо хочете, щоб монітор бачили всі. У вимкненому стані монітори також реагують швидше.",
                                },
                                
                                hideResponses = {
                                    type = "toggle",
                                    disabled = function(info) return not LootMaster.db.profile.monitorSend end,
                                    order = 3.3,
                                    width = 'full',
                                    name = "Приховувати відповіді під час вибору",
                                    desc = "Це налаштування діє на весь рейд. Воно приховує відповіді гравців у monitor-вікнах, поки спостерігач ще не зробив власний вибір по предмету. Це заважає підлаштовуватись під чужі відповіді й пришвидшує вибір.",
                                },
                                
                                monitorThreshold = {
                                    order = 4,
                                    width = 'normal',
                                    type = "select",
                                    name = "Надсилати лише для якості не нижче",
                                    desc = "Надсилати monitor-повідомлення в рейд лише для предметів цієї якості або вище. Враховуйте, що шаблони та подібні винятки також підпадають під цей поріг.",
                                    disabled = function(info) return not LootMaster.db.profile.monitorSend end,
                                    values = {
                                        [2] = ITEM_QUALITY2_DESC,
                                        [3] = ITEM_QUALITY3_DESC,
                                        [4] = ITEM_QUALITY4_DESC,
                                        [5] = ITEM_QUALITY5_DESC,
                                    },
                                },
                                
                                hint = {
                                    order = 5,
                                    width = 'normal',
                                    hidden = function(info) return not LootMaster.db.profile.monitorSend end,
                                    type = "description",
                                    name = "  Фільтрація застосовується лише до\r\n  предметів BoE та BoU. Предмети BoP\r\n  завжди надсилають monitor-повідомлення.",
                                },
                            }
                },
                
                ExtraFunctionGroup = {
                            type = "group",
                            order = 18,
                            guiInline = true,
                            hidden = function(info) return not LootMasterML end,
                            name = "Додаткові функції",
                            args = {
                                
                                help = {
                                    order = 0,
                                    type = "description",
                                    name = "Кілька додаткових функцій, які можуть стати у пригоді.",
                                },
                                btnVersionCheck = {
                                  order = 1000,
                                  type = "execute",
                                  name = "Перевірка версій",
                                  desc = "Відкриває вікно перевірки версій.",
                                  func = function()
                                           LootMaster:ShowVersionCheckFrame()
                                         end
                                },
                                
                                btnRaidInfoCheck = {
                                  order = 2000,
                                  type = "execute",
                                  name = "Перевірка збережень рейду",
                                  desc = "Перевіряє, чи мають гравці збереження на інстанс.",
                                  func = function()
                                           LootMasterML:ShowRaidInfoLookup()
                                         end
                                }
                                
                                
                                
                
                                
                            }
                }
            },
        },
    },
  }

  local config = LibStub("AceConfig-3.0")
  local dialog = LibStub("AceConfigDialog-3.0")

  config:RegisterOptionsTable("EPGPLootMaster-Bliz", options)
  dialog:AddToBlizOptions("EPGPLootMaster-Bliz", "EPGPLootMaster", nil, 'global')
  --dialog:AddToBlizOptions("EPGPLootMaster-Bliz", "Monitor", "EPGPLootMaster", 'MonitorGroup')
  
end
