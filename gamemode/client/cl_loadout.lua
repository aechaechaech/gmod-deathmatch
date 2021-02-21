local function give_guns()
    local file_data = file.Read(save_file_name, "DATA")
    if file_data ~= nil or file_data ~= "" then
        for k, v in pairs(string.Split(file_data, ",")) do
            if v ~= "" then
                net.Start("give_player_guns")
                net.WriteString(v)
                net.SendToServer()
            end
        end
    end
end

-- wrapped in this hook as a hack to make sure player is fully spawned in b4 giving them weapons
-- alot of this code is p hacky because of the fact we need to wait until the player is valid  
-- before we can do anything, also the client doesnt have access to a player spawn in hook which is p dumb
hook.Add("Think","wait_unti_player_is_valid",function()
    if LocalPlayer():IsValid() then
        save_file_name = "maymays_deathmatch"..tostring(LocalPlayer():SteamID64())..".txt"

        -- make it so that whenever the player spawns in they get their loadout
        net.Receive("player_spawned", give_guns)
        -- but we also need to manually call give_guns because the first time they spawn in, theyre spawned before valid
        give_guns()
        
        -- adding console commands to be later used with the option menu
        concommand.Add( "update_loadout", function()
            file.Write(save_file_name, "")
            for k, v in pairs(LocalPlayer():GetWeapons()) do
                file.Append(save_file_name, v:GetClass()..",")
            end
            RunConsoleCommand("spawnmenu_reload")
        end )

        concommand.Add( "clear_loadout", function()
            file.Write(save_file_name, "")
        end )
        
        RunConsoleCommand("spawnmenu_reload")
        hook.Remove("Think","wait_unti_player_is_valid")
    end
end)

hook.Add( "PopulateToolMenu", "LoadoutSettings", function()
    spawnmenu.AddToolMenuOption( "Options", "ⓗ's Deathmatch", "loadout_menu", "Loadout", "", "", function( loadout_panel )
        loadout_panel:ClearControls()
        loadout_panel:Button("Update Loadout","update_loadout")
        loadout_panel:Button("Clear Loadout","clear_loadout")
        loadout_panel:Help("Current Loadout:")

        for k, v in pairs(string.Split(file.Read(save_file_name,"DATA"),",")) do
            if v ~= "" then
                weapon_from_text = weapons.Get(v)

                if weapon_from_text ~= nil then
                    loadout_panel:Help(weapon_from_text["PrintName"])
                else
                    loadout_panel:Help(v)
                end
            end
        end
    end )
end )