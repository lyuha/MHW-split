state("MonsterHunterWorld", "416251")
{
    float sessionTime: "MonsterHunterWorld.exe",0x4FB3FA0,0x90,0x46A0,0x14;
    int questStatus : "MonsterHunterWorld.exe",0x4FB5F70,0x54;
    int questID : "MonsterHunterWorld.exe",0x4FB5F70,0x4C;
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

init
{
    refreshRate = 60;
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
    if (current.questID != -1 && current.questStatus == 2)
    {
        vars.DebugOutput("start timer");
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
