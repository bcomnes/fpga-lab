<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="XLXN_1" />
        <signal name="XLXN_2" />
        <signal name="CX" />
        <signal name="DX" />
        <signal name="AX" />
        <signal name="BX" />
        <signal name="XOR4" />
        <port polarity="Input" name="CX" />
        <port polarity="Input" name="DX" />
        <port polarity="Input" name="AX" />
        <port polarity="Input" name="BX" />
        <port polarity="Output" name="XOR4" />
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
        <block symbolname="xor2" name="XLXI_1">
            <blockpin signalname="BX" name="I0" />
            <blockpin signalname="AX" name="I1" />
            <blockpin signalname="XLXN_1" name="O" />
        </block>
        <block symbolname="xor2" name="XLXI_2">
            <blockpin signalname="CX" name="I0" />
            <blockpin signalname="XLXN_1" name="I1" />
            <blockpin signalname="XLXN_2" name="O" />
        </block>
        <block symbolname="xor2" name="XLXI_3">
            <blockpin signalname="DX" name="I0" />
            <blockpin signalname="XLXN_2" name="I1" />
            <blockpin signalname="XOR4" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="640" y="640" name="XLXI_1" orien="R0" />
        <instance x="1040" y="992" name="XLXI_2" orien="R0" />
        <instance x="1376" y="1296" name="XLXI_3" orien="R0" />
        <branch name="XLXN_1">
            <wire x2="960" y1="544" y2="544" x1="896" />
            <wire x2="960" y1="544" y2="864" x1="960" />
            <wire x2="1040" y1="864" y2="864" x1="960" />
        </branch>
        <branch name="XLXN_2">
            <wire x2="1328" y1="896" y2="896" x1="1296" />
            <wire x2="1328" y1="896" y2="1168" x1="1328" />
            <wire x2="1376" y1="1168" y2="1168" x1="1328" />
        </branch>
        <branch name="CX">
            <wire x2="1040" y1="928" y2="928" x1="640" />
        </branch>
        <branch name="DX">
            <wire x2="1376" y1="1232" y2="1232" x1="640" />
        </branch>
        <branch name="AX">
            <wire x2="640" y1="512" y2="512" x1="608" />
        </branch>
        <iomarker fontsize="28" x="608" y="512" name="AX" orien="R180" />
        <branch name="BX">
            <wire x2="640" y1="576" y2="576" x1="608" />
        </branch>
        <iomarker fontsize="28" x="608" y="576" name="BX" orien="R180" />
        <iomarker fontsize="28" x="640" y="928" name="CX" orien="R180" />
        <iomarker fontsize="28" x="640" y="1232" name="DX" orien="R180" />
        <branch name="XOR4">
            <wire x2="1664" y1="1200" y2="1200" x1="1632" />
        </branch>
        <iomarker fontsize="28" x="1664" y="1200" name="XOR4" orien="R0" />
    </sheet>
</drawing>