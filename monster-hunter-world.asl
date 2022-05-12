state("MonsterHunterWorld", "419914")
{
    // player_data
    // "MonsterHunterWorld.exe",0x5064090
    float sessionTime: "MonsterHunterWorld.exe",0x5064090,0x90,0x46A0,0x14;

    // session_quest
    // "MonsterHunterWorld.exe",0x5066060
    int questID : "MonsterHunterWorld.exe",0x5066060,0x4C;
    int questStatus : "MonsterHunterWorld.exe",0x5066060,0x54;
}

state("MonsterHunterWorld", "416251")
{
    float sessionTime: "MonsterHunterWorld.exe",0x4FB3FA0,0x90,0x46A0,0x14;

    int questID : "MonsterHunterWorld.exe",0x4FB5F70,0x4C;
    int questStatus : "MonsterHunterWorld.exe",0x4FB5F70,0x54;
}
state("MonsterHunterWorld", "421471") {
    
    // player_data
    // "MonsterHunterWorld.exe",0x506D270 
    float sessionTime: "MonsterHunterWorld.exe",0x0506D270,0x90,0x46A0,0x14;
    // session_quest
    // "MonsterHunterWorld.exe",0x506F240
    int questID : "MonsterHunterWorld.exe",0x0506F240,0x4C;
    int questStatus : "MonsterHunterWorld.exe", 0x0506F240, 0x54;
}
state("MonsterHunterWorld", "421631") {
    
    // player_data
    // "MonsterHunterWorld.exe",0x500AB60
    float sessionTime: "MonsterHunterWorld.exe",0x500AB60,0x90,0x46A0,0x14;
    
    // session_quest
    // "MonsterHunterWorld.exe",0x500CAF0
    int questID : "MonsterHunterWorld.exe", 0x500CAF0,0x4C;
    int questStatus : "MonsterHunterWorld.exe", 0x500CAF0, 0x54;
}

/*
 * Run when the script is first load.
 * Define settings
 */
startup
{
    Action<string> DebugOutput = (text) => {
        print("[MonsterHunterWorld] " + text);
    };
    vars.DebugOutput = DebugOutput;

    vars.DebugOutput("First load startup action with MHW.asl");
}


/*
 *
 */
init
{
    refreshRate = 60;

    string title = game.MainWindowTitle;
    vars.DebugOutput(title);

    string mhwVersion = title.Split('(', ')')[1];
    vars.DebugOutput(mhwVersion);

    version = mhwVersion;
}

exit
{

}

shutdown
{

}

update
{

}

start
{
    if (current.questID != -1 && current.questStatus == 2 && (current.sessionTime > 0.01666666754f && current.sessionTime < 1.0f))
    {
        vars.DebugOutput("MHW version : " + version);
        vars.DebugOutput("Quest ID : " + current.questID);
        vars.DebugOutput("start timer at session time " + current.sessionTime);
        return true;
    }
}

split
{
    if (current.questStatus == 3 && old.questStatus == 2)
    {
        vars.DebugOutput("Clear Quest");
        vars.DebugOutput("Split at " + current.sessionTime);
        return true;
    }
}

reset
{
    if (old.questStatus == 2 && (current.questStatus == 5 || current.questStatus == 6 || current.questStatus == 7))
    {
        vars.DebugOutput("Reset or return");
        return true;
    }
}
