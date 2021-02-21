concommand.Add( "reset_leaderboard", function(ply)
    if ply:IsAdmin() then
        net.Start("reset_leaderboard")
        net.SendToServer("reset_leaderboard")
    end
end)

-- this is a dumb way to do this but i cant be bothered to do it better
concommand.Add( "change_noclip_state", function(ply)
    if ply:IsAdmin() then
        net.Start("change_noclip_state")
        net.SendToServer("change_noclip_state")
    end
end)

-- same hack as cl_loadout
hook.Add("Think","wait_till_admin_valid",function()
    if LocalPlayer():IsValid() then
        if LocalPlayer():IsAdmin() then
            hook.Add("PopulateToolMenu", "AdminOptions", function()
                spawnmenu.AddToolMenuOption("Options", "ⓗ's Deathmatch", "admin_menu", "Admin Settings", "", "", function(admin_panel)
                    admin_panel:ClearControls()
                    admin_panel:Button("Reset Leaderboard","reset_leaderboard")
                    admin_panel:Button("Change Noclip State", "change_noclip_state")
                end)
            end)
        end
        RunConsoleCommand("spawnmenu_reload")
        hook.Remove("Think","wait_till_admin_valid")
    end
end)
