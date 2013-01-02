<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_3" />
        <signal name="B" />
        <signal name="XLXN_5" />
        <signal name="A" />
        <signal name="Cin" />
        <signal name="XLXN_10" />
        <signal name="XLXN_11" />
        <signal name="XLXN_12" />
        <signal name="Cout" />
        <signal name="SUM" />
        <port polarity="Input" name="B" />
        <port polarity="Input" name="A" />
        <port polarity="Input" name="Cin" />
        <port polarity="Output" name="Cout" />
        <port polarity="Output" name="SUM" />
        <blockdef name="xor2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="60" y1="-128" y2="-128" x1="0" />
            <line x2="208" y1="-96" y2="-96" x1="256" />
            <arc ex="44" ey="-144" sx="48" sy="-48" r="56" cx="16" cy="-96" />
            <arc ex="64" ey="-144" sx="64" sy="-48" r="56" cx="32" cy="-96" />
            <line x2="64" y1="-144" y2="-144" x1="128" />
            <line x2="64" y1="-48" y2="-48" x1="128" />
            <arc ex="128" ey="-144" sx="208" sy="-96" r="88" cx="132" cy="-56" />
            <arc ex="208" ey="-96" sx="128" sy="-48" r="88" cx="132" cy="-136" />
        </blockdef>
        <blockdef name="and2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="144" ey="-144" sx="144" sy="-48" r="48" cx="144" cy="-96" />
            <line x2="64" y1="-48" y2="-48" x1="144" />
            <line x2="144" y1="-144" y2="-144" x1="64" />
            <line x2="64" y1="-48" y2="-144" x1="64" />
        </blockdef>
        <blockdef name="or2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="192" ey="-96" sx="112" sy="-48" r="88" cx="116" cy="-136" />
            <arc ex="48" ey="-144" sx="48" sy="-48" r="56" cx="16" cy="-96" />
            <line x2="48" y1="-144" y2="-144" x1="112" />
            <arc ex="112" ey="-144" sx="192" sy="-96" r="88" cx="116" cy="-56" />
            <line x2="48" y1="-48" y2="-48" x1="112" />
        </blockdef>
        <block symbolname="xor2" name="XLXI_1">
            <blockpin signalname="B" name="I0" />
            <blockpin signalname="A" name="I1" />
            <blockpin signalname="XLXN_10" name="O" />
        </block>
        <block symbolname="xor2" name="XLXI_2">
            <blockpin signalname="Cin" name="I0" />
            <blockpin signalname="XLXN_10" name="I1" />
            <blockpin signalname="SUM" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_3">
            <blockpin signalname="Cin" name="I0" />
            <blockpin signalname="XLXN_10" name="I1" />
            <blockpin signalname="XLXN_11" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_4">
            <blockpin signalname="A" name="I0" />
            <blockpin signalname="A" name="I1" />
            <blockpin signalname="XLXN_12" name="O" />
        </block>
        <block symbolname="or2" name="XLXI_6">
            <blockpin signalname="XLXN_12" name="I0" />
            <blockpin signalname="XLXN_11" name="I1" />
            <blockpin signalname="Cout" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="640" y="528" name="XLXI_1" orien="R0" />
        <instance x="1024" y="688" name="XLXI_2" orien="R0" />
        <instance x="1232" y="1056" name="XLXI_3" orien="R0" />
        <instance x="1232" y="1280" name="XLXI_4" orien="R0" />
        <instance x="1744" y="1152" name="XLXI_6" orien="R0" />
        <branch name="B">
            <wire x2="640" y1="464" y2="464" x1="448" />
        </branch>
        <branch name="A">
            <wire x2="480" y1="400" y2="400" x1="448" />
            <wire x2="480" y1="400" y2="688" x1="480" />
            <wire x2="496" y1="688" y2="688" x1="480" />
            <wire x2="496" y1="688" y2="1216" x1="496" />
            <wire x2="1232" y1="1216" y2="1216" x1="496" />
            <wire x2="560" y1="400" y2="400" x1="480" />
            <wire x2="640" y1="400" y2="400" x1="560" />
            <wire x2="560" y1="400" y2="1152" x1="560" />
            <wire x2="1232" y1="1152" y2="1152" x1="560" />
        </branch>
        <branch name="Cin">
            <wire x2="640" y1="624" y2="624" x1="448" />
            <wire x2="1024" y1="624" y2="624" x1="640" />
            <wire x2="640" y1="624" y2="992" x1="640" />
            <wire x2="1232" y1="992" y2="992" x1="640" />
        </branch>
        <branch name="XLXN_10">
            <wire x2="1008" y1="432" y2="432" x1="896" />
            <wire x2="1008" y1="432" y2="560" x1="1008" />
            <wire x2="1024" y1="560" y2="560" x1="1008" />
            <wire x2="944" y1="560" y2="928" x1="944" />
            <wire x2="1232" y1="928" y2="928" x1="944" />
            <wire x2="1008" y1="560" y2="560" x1="944" />
        </branch>
        <branch name="XLXN_11">
            <wire x2="1616" y1="960" y2="960" x1="1488" />
            <wire x2="1616" y1="960" y2="1024" x1="1616" />
            <wire x2="1744" y1="1024" y2="1024" x1="1616" />
        </branch>
        <branch name="XLXN_12">
            <wire x2="1616" y1="1184" y2="1184" x1="1488" />
            <wire x2="1616" y1="1088" y2="1184" x1="1616" />
            <wire x2="1744" y1="1088" y2="1088" x1="1616" />
        </branch>
        <branch name="Cout">
            <wire x2="2240" y1="1056" y2="1056" x1="2000" />
        </branch>
        <branch name="SUM">
            <wire x2="2240" y1="592" y2="592" x1="1280" />
        </branch>
        <iomarker fontsize="28" x="448" y="400" name="A" orien="R180" />
        <iomarker fontsize="28" x="448" y="464" name="B" orien="R180" />
        <iomarker fontsize="28" x="448" y="624" name="Cin" orien="R180" />
        <iomarker fontsize="28" x="2240" y="592" name="SUM" orien="R0" />
        <iomarker fontsize="28" x="2240" y="1056" name="Cout" orien="R0" />
    </sheet>
</drawing>