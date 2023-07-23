Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEF575DFBC
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Jul 2023 04:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjGWCnq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Jul 2023 22:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjGWCnp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Jul 2023 22:43:45 -0400
Received: from carlos101.mail.rambler.ru (carlos101.mail.rambler.ru [81.19.78.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F13710DC
        for <linux-wireless@vger.kernel.org>; Sat, 22 Jul 2023 19:43:42 -0700 (PDT)
Received: from carlos101.mail.rambler.ru (unknown [127.0.0.1])
        by carlos101.mail.rambler.ru (Postfix) with ESMTP id 129C5F60B4C
        for <linux-wireless@vger.kernel.org>; Sun, 23 Jul 2023 05:43:40 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ro.ru; s=mail;
        t=1690080219; bh=IOYfvQV5loyXLrjYFA7gicFa5GCviOUpcYzPAzxQNmc=;
        h=Date:From:Subject:To;
        b=2H3/s746j+HfqDHCCOo4AVKT+L6+5Pv3p1Hu23irxL87wg80bCIKt/ViMqffLE386
         XfQ+C4aqB0EZPkh65wMkVkJt77A3m7KIbgCqtwBYllkHITLJ10IcshfXNgo8FDGwH5
         ApIue4WQ7n0XeuMBuiAspvx8Y3L0u6GI6vfvq2uY=
Message-ID: <29374f28-9c6e-c67a-85a7-81d1e7776b21@ro.ru>
Date:   Sun, 23 Jul 2023 04:43:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   AlMa <AlMa0@ro.ru>
Subject: iwlwifi: api flags index 2 larger than supported by driver
To:     linux-wireless@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear iwlwifi developers,

I get a yellow warning in the journal: “iwlwifi 0000:b3:00.0: api flags 
index 2 larger than supported by driver”.


The card:

AX3000 Dual Band
PCE-AX3000
Wi-Fi 6 PCI-E Adapter


The preceding journal entries:

Jul 22 22:35:22 AnonymizedMachineName kernel: iwlwifi 0000:b3:00.0: 
enabling device (0100 -> 0102)
Jul 22 22:35:22 AnonymizedMachineName kernel: [drm] Initialized ast 
0.1.0 20120228 for 0000:04:00.0 on minor 0
Jul 22 22:35:22 AnonymizedMachineName kernel: AVX2 version of 
gcm_enc/dec engaged.
Jul 22 22:35:22 AnonymizedMachineName kernel: ipmi_si IPI0001:00: IPMI 
message handler: Found new BMC (man_id: 0x000a3f, prod_id: 0x0f83, 
dev_id: 0x20)
Jul 22 22:35:22 AnonymizedMachineName kernel: AES CTR mode by8 
optimization enabled
Jul 22 22:35:22 AnonymizedMachineName kernel: asus_wmi: ASUS WMI generic 
driver loaded
Jul 22 22:35:22 AnonymizedMachineName kernel: Console: switching to 
colour frame buffer device 128x48
Jul 22 22:35:22 AnonymizedMachineName kernel: ast 0000:04:00.0: [drm] 
fb0: astdrmfb frame buffer device
Jul 22 22:35:22 AnonymizedMachineName kernel: iwlwifi 0000:b3:00.0: 
firmware: direct-loading firmware iwlwifi-cc-a0-72.ucode
Jul 22 22:35:22 AnonymizedMachineName kernel: iwlwifi 0000:b3:00.0: api 
flags index 2 larger than supported by driver


The (hopefully) relevant lshw portion:

       *-pci:2
            description: PCI bridge
            product: Sky Lake-E PCI Express Root Port A
            vendor: Intel Corporation
            physical id: 0
            bus info: pci@0000:b2:00.0
            version: 07
            width: 32 bits
            clock: 33MHz
            capabilities: pci msi pciexpress pm normal_decode bus_master 
cap_list
            configuration: driver=pcieport
            resources: irq:35 memory:fbe00000-fbefffff
          *-network
               description: Wireless interface
               product: Wi-Fi 6 AX200
               vendor: Intel Corporation
               physical id: 0
               bus info: pci@0000:b3:00.0
               logical name: wlp179s0
               version: 1a
               serial: AnonymizedSerial
               width: 64 bits
               clock: 33MHz
               capabilities: pm msi pciexpress msix bus_master cap_list 
ethernet physical wireless
               configuration: broadcast=yes driver=iwlwifi 
driverversion=6.1.0-10-amd64 firmware=72.daa05125.0 cc-a0-72.ucode 
ip=192.168.1.49 latency=0 link=yes multicast=yes wireless=IEEE 802.11
               resources: irq:94 memory:fbe00000-fbe03fff


The (hopefully) relevant lspci portion:
b3:00.0 Network controller: Intel Corporation Wi-Fi 6 AX200 (rev 1a)
          Subsystem: Intel Corporation Wi-Fi 6 AX200NGW
          Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B- DisINTx+
          Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
          Latency: 0, Cache Line Size: 32 bytes
          Interrupt: pin A routed to IRQ 94
          NUMA node: 0
          IOMMU group: 1
          Region 0: Memory at fbe00000 (64-bit, non-prefetchable) [size=16K]
          Capabilities: [c8] Power Management version 3
                  Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                  Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
          Capabilities: [d0] MSI: Enable- Count=1/1 Maskable- 64bit+
                  Address: 0000000000000000  Data: 0000
          Capabilities: [40] Express (v2) Endpoint, MSI 00
                  DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s 
<512ns, L1 unlimited
                          ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ 
FLReset+ SlotPowerLimit 0W
                  DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                          RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+ 
FLReset-
                          MaxPayload 128 bytes, MaxReadReq 128 bytes
                  DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ 
AuxPwr+ TransPend-
                  LnkCap: Port #0, Speed 5GT/s, Width x1, ASPM L1, Exit 
Latency L1 <8us
                          ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                  LnkCtl: ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
                          ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                  LnkSta: Speed 5GT/s, Width x1
                          TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                  DevCap2: Completion Timeout: Range B, TimeoutDis+ 
NROPrPrP- LTR+
                           10BitTagComp- 10BitTagReq- OBFF Via WAKE#, 
ExtFmt- EETLPPrefix-
                           EmergencyPowerReduction Not Supported, 
EmergencyPowerReductionInit-
                           FRS- TPHComp- ExtTPHComp-
                           AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                  DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis+ 
LTR- 10BitTagReq- OBFF Disabled,
                           AtomicOpsCtl: ReqEn-
                  LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- 
Retimer- 2Retimers- DRS-
                  LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- 
SpeedDis-
                           Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                           Compliance Preset/De-emphasis: -6dB 
de-emphasis, 0dB preshoot
                  LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete- EqualizationPhase1-
                           EqualizationPhase2- EqualizationPhase3- 
LinkEqualizationRequest-
                           Retimer- 2Retimers- CrosslinkRes: unsupported
          Capabilities: [80] MSI-X: Enable+ Count=16 Masked-
                  Vector table: BAR=0 offset=00002000
                  PBA: BAR=0 offset=00003000
          Capabilities: [100 v1] Advanced Error Reporting
                  UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                  UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                  UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- 
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                  CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
                  CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- 
AdvNonFatalErr+
                  AERCap: First Error Pointer: 00, ECRCGenCap- 
ECRCGenEn- ECRCChkCap- ECRCChkEn-
                          MultHdrRecCap- MultHdrRecEn- TLPPfxPres- 
HdrLogCap-
                  HeaderLog: 00000000 00000000 00000000 00000000
          Capabilities: [14c v1] Latency Tolerance Reporting
                  Max snoop latency: 0ns
                  Max no snoop latency: 0ns
          Capabilities: [154 v1] L1 PM Substates
                  L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ 
ASPM_L1.1+ L1_PM_Substates+
                            PortCommonModeRestoreTime=30us 
PortTPowerOnTime=18us
                  L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                             T_CommonMode=0us LTR1.2_Threshold=0ns
                  L1SubCtl2: T_PwrOn=10us
          Kernel driver in use: iwlwifi
          Kernel modules: iwlwifi


Ben thinks in http://bugs.debian.org/1035885 that the firmware might 
advertise some features that the driver doesn't know how to use.  
Perhaps, it's time to upgrade the driver?  Or does the aforementioned 
yellow message really wants to warn me an admin or a user, and I should 
take some action (to avoid what?) ?


Gratefully,
AlMa
