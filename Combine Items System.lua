        -- Ссылка на конвертер четырёхсимвольного кода https://ubershmekel.github.io/fourcc-to-text/

        -- В стандартном API есть функция UnitAddItemById, но нет UnitRemoveItemById. Эта функция исправляет данное недоразумение.
        function UnitRemoveItemById(unit, id, amount, slot)
            if slot == 6 then
                return
            end

            local item = UnitItemInSlot(unit, slot)

            if GetItemTypeId(item) == id then
                RemoveItem(item)
                amount = amount - 1
            end

            if amount > 0 then
                UnitRemoveItemById(unit, id, amount, slot + 1)
            end
        end

        -- Список комбинайций. За индексом 1 в списке комбинаций предмет, получаемый в результате сборки.
        COMBINATIONS = {
            {
                [1919182130] = 5, -- Кольцо защиты + 3
                [1919182131] = 1, -- Кольцо защиты + 4
                [1] = 1920428410 -- Соби Маска
            },
            {
                [1651732580] = 1, -- Сапоги-скороходы
                [1868850534] = 1, -- Сфера Тьмы
                [1886549620] = 1, -- Амулет жизни
                [1918989366] = 2, -- Боевые когти + 5
                [1] = 1818715240 -- Рог Легиона
            },
            {
                [1651732580] = 3, -- Сапоги-скороходы
                [1868850534] = 2, -- Сфера Тьмы
                [1886549620] = 1, -- Амулет жизни
                [1] = 1668446579 -- Хрустальный шар
            }

        }

        -- Функция подсчёта элементов таблицы с непоследовательными индексами
        function countElements(t)
            local count = 0
            for _ in pairs(t) do
                count = count + 1
            end
            return count
        end


        --[[
             Триггеры. Здесь создаётся герой и к нему привязывается триггер, это сугубо для примера. Реализацию можно сделать глобальной, но можно и 
             определить тех героев, для которых эта функция будет работат. Зависит от реализации в конкретной карте.
          ]]
        COMBINE_ITEMS_SYS_TRG = CreateTrigger()
        TriggerRegisterUnitEvent(COMBINE_ITEMS_SYS_TRG,CreateUnit(Player(0),FourCC('Hmkg'),0,0,270.0),EVENT_UNIT_PICKUP_ITEM)
        TriggerAddAction(COMBINE_ITEMS_SYS_TRG,function()
            CombineItems(GetTriggerUnit(),COMBINATIONS[1])
        end)

        -- Система комбинирования предметов
        function CombineItems(unit)
            -- Создаем таблицу списка инвентаря юнита
            local inventory = {}
            for i = 0, 5 do
                local item_id = GetItemTypeId(UnitItemInSlot(unit, i))
                inventory[item_id] = (inventory[item_id] or 0) + 1
            end

            -- Ищем количество совпадающих предметов по рецептам и передаём ID рецепта в id_successful_combo
            local id_successful_combo = false
            local combo
            for i = 1, #COMBINATIONS do
                combo = 0
                for key, value in pairs(COMBINATIONS[i]) do
                    if COMBINATIONS[i][key] == inventory[key] then
                        combo = combo + 1
                        if combo == (countElements(COMBINATIONS[i]) - 1) then
                             id_successful_combo = i
                        end
                    end
                end
            end

            if id_successful_combo then
                -- Удаляем все предметы из списка
                for key, value in pairs(COMBINATIONS[id_successful_combo]) do
                    if  key ~= 1 then
                        UnitRemoveItemById(unit,key,value,0)
                    end
                end
                -- Добавляем результат комбинации в инвентарь юнита
                UnitAddItemById(unit,COMBINATIONS[id_successful_combo][1])
            end

        end
