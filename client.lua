local QBCore=exports[Config.Core]:GetCoreObject();
local function dothisShit();
    local v=Config.Target;exports[v.target]:
    AddBoxZone('nawaf-archive',v.coords,v.a,v.b,{name="nawaf-archive",heading=v.heading,debugPoly=v.debugPoly,minZ=v.minZ,maxZ=v.maxZ},{options={{event='nawaf:client:openArchive',icon='fa fa-archive',label='Search on files',params={}}},job={v.job},distance=v.distance})
end;
local function archiveList(data);
    local array={
        {
            header='Police Archive',
            text='File #'..tostring(data),
            isMenuHeader=true
        },
        {
            header='Open Archive',
            params={
                event='nawaf:client:openArchiveByNumber',
                args={num=tostring(data)
            }
        }
    },
    {
        header='Change Archive',
        params={
            event='nawaf:client:openArchive'
        }
    }
};
exports['qb-menu']:openMenu(array);end;
local function chooseArchive()
    ;local dialog=exports[Config.input]:ShowInput({
        header="Archive Number",
        submitText="Submit",
        inputs={
            {
                text="Amount",
                name="archive",
                type="number",
                isRequired=true
            }
        }
    });
    if(not dialog)then;return false;end;
    for k,v in pairs(dialog)do;
        archiveList(v);
    end;
end;

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function();
    dothisShit();
end);

AddEventHandler('nawaf:client:openArchive', function();
    chooseArchive();
end);

AddEventHandler('nawaf:client:openArchiveByNumber', function(data);
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "police_archive_"..tostring(data.num),{
        maxweight=4000000,
        slots=300
    });
    TriggerEvent("inventory:client:SetCurrentStash","police_archive_"..tostring(data.num))
end);
