Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 384222B8907
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Nov 2020 01:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgKSA1b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Nov 2020 19:27:31 -0500
Received: from avasout01.plus.net ([84.93.230.227]:47326 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgKSA1b (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Nov 2020 19:27:31 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Nov 2020 19:27:30 EST
Received: from webmail.plus.net ([84.93.228.144])
        by smtp with ESMTPA
        id fXg6kTaHvn8O7fXg7kRjWf; Thu, 19 Nov 2020 00:19:59 +0000
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Ld6nFgXi c=1 sm=1 tr=0
 a=Fy01bzDlhC/AJhvt6vj9bg==:117 a=BB0vsANcpiYA:10 a=kj9zAlcOel0A:10
 a=nNwsprhYR40A:10 a=OLL_FvSJAAAA:8 a=xlXRCmqtAAAA:8 a=SNl7DHA7_5c7ayURd24A:9
 a=CjuIK1q_8ugA:10 a=jfiaXplBvMQA:10 a=v7AIkUVAObcA:10
 a=oIrB72frpwYPwTMnlWqB:22 a=HsnKl83PEsP7o53OI5Pf:22
X-AUTH: andywas@andywas.plus.com:2500
Received: from 233.237.159.143.dyn.plus.net ([143.159.237.233])
 by webmail.plus.net
 with HTTP (HTTP/1.1 POST); Thu, 19 Nov 2020 00:19:58 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 19 Nov 2020 00:19:58 +0000
From:   Andrew Wasielewski <andrew@wasielewski.co.uk>
To:     linux-wireless@vger.kernel.org
Subject: Problem loading ath10k firmware for QCA9984 device (PCI ID 168c:0046)
Message-ID: <83372af5d9ad2731c5d837bfc32d950e@wasielewski.co.uk>
X-Sender: andrew@wasielewski.co.uk
User-Agent: Webmail
X-Originating-IP: [143.159.237.233]
X-CMAE-Envelope: MS4wfCulTUklkIClicvXzf7YJaz4mUrlg6IzRqXfbK5JIG/FH5HV4kQHL5xD4PjtWpgG0uLRb2nHy+mcO5jnOsrIn9ZV1JrJiQvdUzxvKhJB24hzNa3tdUo/
 orEMK/GA8v9T2iUxi0kw+b8qw9b7GiELNlVJ0giGTKiOWqY1q4cJBZn6HqNO4rWnXLpgaNesz5WZCA==
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Linux Wireless devs,

I'm having problems loading the ath10k firmware for a Qualcomm Atheros 
QCA9984 802.11ac wireless module (Compex WLE1216VX) in a x86_64 PC.  
This particular unit is 2.4/5 GHz dual band.

When I modprobe ath10k_pci I get the following syslog error messages:

Nov 18 23:49:31 localhost.localdomain kernel: cfg80211: Loading 
compiled-in X.509 certificates for regulatory database
Nov 18 23:49:31 localhost.localdomain kernel: cfg80211: Loaded X.509 
cert 'sforshee: 00b28ddf47aef9cea7'
Nov 18 23:49:31 localhost.localdomain kernel: ath10k_pci 0000:03:00.0: 
pci irq msi oper_irq_mode 2 irq_mode 0 reset_mode 0
Nov 18 23:49:31 localhost.localdomain kernel: ath10k_pci 0000:03:00.0: 
qca9984/qca9994 hw1.0 target 0x01000000 chip_id 0x00000000 sub 168c:cafe
Nov 18 23:49:31 localhost.localdomain kernel: ath10k_pci 0000:03:00.0: 
kconfig debug 0 debugfs 1 tracing 0 dfs 0 testmode 0
Nov 18 23:49:31 localhost.localdomain kernel: ath10k_pci 0000:03:00.0: 
firmware ver 10.4-3.9.0.2-00131 api 5 features 
no-p2p,mfp,peer-flow-ctrl,btcoex-param,allows-mesh-bcast,no-ps,peer-fixed-rate 
crc32 23bd9e43
Nov 18 23:49:32 localhost.localdomain kernel: ath10k_pci 0000:03:00.0: 
failed to fetch board data for bus=pci,bmi-chip-id=0,bmi-board-id=11 
from ath10k/QCA9984/hw1.0/board-2.bin
Nov 18 23:49:32 localhost.localdomain kernel: ath10k_pci 0000:03:00.0: 
failed to fetch board-2.bin or board.bin from ath10k/QCA9984/hw1.0
Nov 18 23:49:32 localhost.localdomain kernel: ath10k_pci 0000:03:00.0: 
failed to fetch board file: -2
Nov 18 23:49:32 localhost.localdomain kernel: ath10k_pci 0000:03:00.0: 
could not probe fw (-2)

This is with firmware ver. 10.4-3.9.0.2-00131, which is the most recent 
I can find on Git, and on kernel 5.9.8-200 (Fedora 33); I get the same 
error - apart from reported firmware version - with 10.4-3.9.0.2-00070 
which is installed by linux-firmware-20201022-113 (latest Fedora 
package) as well as on earlier kernels and firmware versions, and other 
x86_64 hardware.  The board-2.bin and firmware-5.bin files do exist in 
the /lib/firmware/ath10k/QCA9984/hw1.0 directory, which matches the 
exact chipset ID.

This thread reports a very similar issue on the same chipset: 
https://www.spinics.net/lists/linux-wireless/msg196425.html.  I also 
raised a thread on the ClearOS forum 
(https://www.clearos.com/clearfoundation/social/community/why-is-the-clearos-7-kernel-version-still-3-10) 
as initially I thought the problem might be with the kernel version; 
however ClearOS 7 (Centos / Red Hat-based) has a fully patched and 
backported kernel.  (The aim is for the QCA9984 to go in my ClearOS 7 
firewall / wireless AP, also on x86_64 hardware.)

lspci -nn output reports PCI ID 168c:0046.

Grateful for any suggestions.  I'm no hardware expert, but I will do 
anything I can to help (e.g. pull requests) and obviously do any testing 
I can.  More lspci and modinfo output appended below.

Many thanks,
Andrew

[root@localhost QCA9984]# lspci -s 03:00.0 -vvv
03:00.0 Network controller: Qualcomm Atheros QCA9984 802.11ac Wave 2 
Wireless Network Adapter
         Subsystem: Qualcomm Atheros Device cafe
         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0, Cache Line Size: 32 bytes
         Interrupt: pin A routed to IRQ 35
         Region 0: Memory at f7800000 (64-bit, non-prefetchable) 
[size=2M]
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable+ Count=1/32 Maskable+ 64bit+
                 Address: 00000000fee02004  Data: 4023
                 Masking: fffffffe  Pending: 00000000
         Capabilities: [70] Express (v2) Endpoint, MSI 00
                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s 
unlimited, L1 unlimited
                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- 
SlotPowerLimit 10.000W
                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 128 bytes, MaxReadReq 512 bytes
                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- 
AuxPwr+ TransPend-
                 LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM not 
supported
                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                 LnkSta: Speed 5GT/s (ok), Width x1 (ok)
                         TrErr- Train- SlotClk+ DLActive- BWMgmt- 
ABWMgmt-
                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+, 
NROPrPrP-, LTR+
                          10BitTagComp-, 10BitTagReq-, OBFF Not 
Supported, ExtFmt-, EETLPPrefix-
                          EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
                          FRS-, TPHComp-, ExtTPHComp-
                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, 
LTR-, OBFF Disabled
                          AtomicOpsCtl: ReqEn-
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- 
SpeedDis-
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete-, EqualizationPhase1-
                          EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
         Capabilities: [100 v2] Advanced Error Reporting
                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr-
                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- 
HdrLogCap-
                 HeaderLog: 00000000 00000000 00000000 00000000
         Capabilities: [148 v1] Device Serial Number 
00-00-00-00-00-00-00-00
         Capabilities: [158 v1] Latency Tolerance Reporting
                 Max snoop latency: 0ns
                 Max no snoop latency: 0ns
         Capabilities: [160 v1] L1 PM Substates
                 L1SubCap: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- 
ASPM_L1.1- L1_PM_Substates-
                 L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- 
ASPM_L1.1-
                 L1SubCtl2:
         Kernel driver in use: ath10k_pci
         Kernel modules: ath10k_pci

[root@localhost QCA9984]# modinfo ath10k_pci
filename:       
/lib/modules/5.9.8-200.fc33.x86_64/kernel/drivers/net/wireless/ath/ath10k/ath10k_pci.ko.xz
firmware:       ath10k/QCA9377/hw1.0/board.bin
firmware:       ath10k/QCA9377/hw1.0/firmware-5.bin
firmware:       ath10k/QCA9377/hw1.0/firmware-6.bin
firmware:       ath10k/QCA6174/hw3.0/board-2.bin
firmware:       ath10k/QCA6174/hw3.0/board.bin
firmware:       ath10k/QCA6174/hw3.0/firmware-6.bin
firmware:       ath10k/QCA6174/hw3.0/firmware-5.bin
firmware:       ath10k/QCA6174/hw3.0/firmware-4.bin
firmware:       ath10k/QCA6174/hw2.1/board-2.bin
firmware:       ath10k/QCA6174/hw2.1/board.bin
firmware:       ath10k/QCA6174/hw2.1/firmware-5.bin
firmware:       ath10k/QCA6174/hw2.1/firmware-4.bin
firmware:       ath10k/QCA9887/hw1.0/board-2.bin
firmware:       ath10k/QCA9887/hw1.0/board.bin
firmware:       ath10k/QCA9887/hw1.0/firmware-5.bin
firmware:       ath10k/QCA988X/hw2.0/board-2.bin
firmware:       ath10k/QCA988X/hw2.0/board.bin
firmware:       ath10k/QCA988X/hw2.0/firmware-5.bin
firmware:       ath10k/QCA988X/hw2.0/firmware-4.bin
firmware:       ath10k/QCA988X/hw2.0/firmware-3.bin
firmware:       ath10k/QCA988X/hw2.0/firmware-2.bin
license:        Dual BSD/GPL
description:    Driver support for Qualcomm Atheros 802.11ac WLAN 
PCIe/AHB devices
author:         Qualcomm Atheros
alias:          pci:v0000168Cd00000050sv*sd*bc*sc*i*
alias:          pci:v0000168Cd00000042sv*sd*bc*sc*i*
alias:          pci:v0000168Cd00000046sv*sd*bc*sc*i*
alias:          pci:v0000168Cd00000056sv*sd*bc*sc*i*
alias:          pci:v0000168Cd00000040sv*sd*bc*sc*i*
alias:          pci:v0000168Cd0000003Esv*sd*bc*sc*i*
alias:          pci:v0000168Cd00000041sv*sd*bc*sc*i*
alias:          pci:v0000168Cd0000003Csv*sd*bc*sc*i*
alias:          pci:v00000777d000011ACsv*sd*bc*sc*i*
depends:        ath10k_core
retpoline:      Y
intree:         Y
name:           ath10k_pci
vermagic:       5.9.8-200.fc33.x86_64 SMP mod_unload
sig_id:         PKCS#7
signer:         Fedora kernel signing key
sig_key:        
33:36:25:96:B7:D1:5F:C3:7A:F5:2D:F4:24:3A:F5:D2:B6:5F:E7:55
sig_hashalgo:   sha256
signature:      
66:8D:AA:68:97:70:E1:35:27:C9:12:F4:3F:C8:7B:57:4D:26:0A:3E:
                 
A0:C9:E3:C6:CF:F5:9A:A1:E4:3E:F1:C0:16:C2:53:22:C1:90:59:93:
                 
71:A8:C0:FE:3B:85:F5:34:8B:A1:A0:64:61:7D:B7:79:43:1D:51:CB:
                 
1B:F4:54:80:48:E0:26:59:4B:D7:97:3E:85:8E:4E:A6:77:8A:CC:28:
                 
64:35:4F:06:EC:19:E3:3A:63:DA:54:31:58:39:F6:38:89:93:DA:0F:
                 
5B:63:5F:A9:52:A0:11:47:28:32:6C:F5:F2:24:BB:A3:48:02:10:A1:
                 
5B:DF:4C:ED:EE:63:0E:32:EE:A0:2C:2D:13:D4:B4:40:CA:9B:CA:52:
                 
0A:15:BA:0B:40:CB:58:C7:9F:6D:FF:B6:E0:D7:4C:B6:80:8C:D5:25:
                 
82:51:21:59:17:5E:84:72:DA:A8:75:AF:B6:2D:51:E3:12:5D:AD:71:
                 
82:11:AA:BF:74:7A:EA:18:EF:F7:EC:76:76:B5:3A:FC:04:FF:44:E7:
                 
16:50:EA:1C:C2:BF:89:FC:A4:A1:04:A3:89:7C:1D:21:A2:02:08:1E:
                 
D3:0B:42:B4:2E:24:0F:F8:73:BC:04:C0:60:25:84:21:2D:DE:6E:9E:
                 
87:37:20:DE:6F:9E:A7:52:BC:39:8A:63:EF:78:A8:4C:BE:19:FD:F8:
                 
6B:9D:23:24:82:7D:8B:8E:A8:6E:D5:CA:E2:34:B1:8F:71:79:17:4F:
                 
2A:30:54:47:98:85:E1:2E:4A:EA:C4:98:14:86:86:97:05:D2:1D:5B:
                 
74:68:BF:DE:E8:DE:B8:0F:CC:36:00:5C:FC:B3:3D:07:9F:39:AC:12:
                 
9E:FE:8A:2A:86:67:3D:6F:6E:A0:D4:41:76:5D:55:2F:D7:E7:64:A0:
                 
96:34:BD:40:F4:2A:6E:D7:65:F8:92:21:82:A7:3C:D1:7C:56:A6:3D:
                 
81:2B:2C:7F:38:0B:6E:D2:F7:6B:18:59:7E:21:2B:F0:CF:2E:99:38:
                 
4C:94:DF:6E:82:DA:C5:56:2B:5B:78:CB:8E:D7:9E:A5:37:1B:FE:BB:
                 
C6:3E:5E:33:11:5D:64:3A:BF:94:90:E6:75:ED:4F:96:F6:CA:A1:1E:
                 
5B:A6:97:93:62:22:7A:8F:53:5B:33:E3:3C:6A:DD:43:A9:8A:A5:15:
                 
5B:8A:C5:D2:BE:FF:FF:29:4C:DC:77:85:2E:90:33:A8:7B:5A:CB:56:
                 
72:65:97:50:E8:D4:68:A3:ED:C5:55:AE:9B:5A:84:4E:84:6C:DD:D9:
                 
12:24:AA:73:77:EF:78:E2:75:01:5C:C6:DD:BF:88:F2:F9:11:3D:5C:
                 8E:30:41:FB:39:73:C8:D7:3F:CE:F1:46
parm:           irq_mode:0: auto, 1: legacy, 2: msi (default: 0) (uint)
parm:           reset_mode:0: auto, 1: warm only (default: 0) (uint)




