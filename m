Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED81637FCD
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 20:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiKXTwl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 14:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiKXTwk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 14:52:40 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD3418B28
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:52:37 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g7so3897617lfv.5
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=weBqc2Kg74EU61STcbu0lKP4lCVzmfJVUu3+MSgOqpc=;
        b=H7XPelrY1P4jWSlAfy00GmiFrrsPhLpgHvg8hRa4a9lvGFx9/7hWx0z0MFc+zMbCWO
         IgeUiFE+b8hi1MhXoMc52rAccGn8sMpqDKpKrDqOv6ZM+VGGCWjfSW/fqSfRXcIIO+5O
         RqdcZZAZKezRfJXAKXvdYvuUfwMHBo674aEq8MkCg7yIBo7Q0yM07CuPA6jZ/fL7jWBa
         ngLBLW7x+s/hYlY3nFKJciO7BT8aHesmXjHjP0ztEO2CpiLR183FrhX5XzvMgekEa0O1
         nqUej/nBP/KiZj0NoBCvTxdtO4LLsrOIeLbYVQONEnk2/Nzc2S5YknM9pD5TB4t0xLpO
         AscA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=weBqc2Kg74EU61STcbu0lKP4lCVzmfJVUu3+MSgOqpc=;
        b=T2OyEklXV3OpxvHnGHXnOW4MSFHEAkg3a9DmAenYP6vkRb205fg/XXdVwhXGsksfpx
         Rwcbp98jGDeXXbTgEKi5FzYVsGOdxHPYKG5MOmgK+XnfVb/QdjeciAKSIDrITnorze6X
         gOsCkGLxfy1iITufCIyfLuizVWS5NwKjQbnVRj+G3qOmtGKCKTD8Ld8MBepZvHhc9rbn
         6yuJyQ9BCmRTieYZkl0p+zIyBDp0CTnfaaHsF0ssKbLBKKvdlCWLlGdemEU+BeEAfAAL
         RI5ZthXRDkH3e7jBzxePByaPiW0nk0ssyNWtW4wyX+zX9EqVo59Bm0iQVRJX/vF9ZCZr
         Xkfw==
X-Gm-Message-State: ANoB5pk/8ZLNUE3EqE/hizx7pqjP2HPn9yB0DQZx/77AJaxJIvn3aMWg
        kJdGvpR6RSm/5H/Xjie3vWWoWVYjtVTcq71Z/iSy5mu+ReOu9A==
X-Google-Smtp-Source: AA0mqf4t1VazmnMhwB655Gx5KxZ41qRWj2pRX3Tq5rOnlFm4hewGzrKsfuUbi2P1FDNDixluYLz7mwBGdNlk0SytxYw=
X-Received: by 2002:a05:6512:4c8:b0:4a2:7d11:80e8 with SMTP id
 w8-20020a05651204c800b004a27d1180e8mr10891661lfq.464.1669319555971; Thu, 24
 Nov 2022 11:52:35 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Fri, 25 Nov 2022 21:51:25 +0200
Message-ID: <CADUzMVaTb3WUuFO-NjAgrnHzEa5-7WvSkROcLwWF1MuM2wJQ6A@mail.gmail.com>
Subject: BCM4352 Broadcom support
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

I have tested a hybrid laptop device which is actually a tablet(YOGA 3
Pro-1370) and has a BCM Wi-Fi.

On Ubuntu boot I get:
[    2.294215] bcma-pci-bridge 0000:01:00.0: bus0: Found chip with id
0x4352, rev 0x03 and package 0x00
[    2.294263] bcma-pci-bridge 0000:01:00.0: bus0: Core 0 found:
ChipCommon (manuf 0x4BF, id 0x800, rev 0x2B, class 0x0)
[    2.294290] bcma-pci-bridge 0000:01:00.0: bus0: Core 1 found: IEEE
802.11 (manuf 0x4BF, id 0x812, rev 0x2A, class 0x0)
[    2.294348] bcma-pci-bridge 0000:01:00.0: bus0: Core 2 found: ARM
CR4 (manuf 0x4BF, id 0x83E, rev 0x02, class 0x0)
[    2.294398] bcma-pci-bridge 0000:01:00.0: bus0: Core 3 found: PCIe
Gen2 (manuf 0x4BF, id 0x83C, rev 0x01, class 0x0)
[    2.294424] bcma-pci-bridge 0000:01:00.0: bus0: Core 4 found: USB
2.0 Device (manuf 0x4BF, id 0x81A, rev 0x11, class 0x0)
[    2.332079] cryptd: max_cpu_qlen set to 1000
[    2.350696] bcma: Unsupported SPROM revision: 11
[    2.350760] bcma-pci-bridge 0000:01:00.0: bus0: Invalid SPROM read
from the PCIe card, trying to use fallback SPROM
[    2.350764] bcma-pci-bridge 0000:01:00.0: bus0: Using fallback
SPROM failed (err -2)
[    2.350767] bcma-pci-bridge 0000:01:00.0: bus0: No SPROM available
[    2.353785] bcma-pci-bridge 0000:01:00.0: bus0: Bus registered
[   34.766808] b43-phy0: Broadcom 4352 WLAN found (core revision 42)
[   34.787320] bcma-pci-bridge 0000:01:00.0: bus0: HT force timeout
[   34.930930] bcma-pci-bridge 0000:01:00.0: bus0: PLL enable timeout
[   34.930980] b43-phy0 ERROR: FOUND UNSUPPORTED PHY (Analog 12, Type
11 (AC), Revision 1)
[   34.931036] b43: probe of bcma0:1 failed with error -95
[   34.931136] Broadcom 43xx driver loaded [ Features: PNL ]

This is the device:
01:00.0 Network controller [0280]: Broadcom Inc. and subsidiaries
BCM4352 802.11ac Wireless Network Adapter [14e4:43b1] (rev 03)
    Subsystem: Lenovo BCM4352 802.11ac Wireless Network Adapter [17aa:0623]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 18
    Region 0: Memory at c1200000 (64-bit, non-prefetchable) [size=32K]
    Region 2: Memory at c1000000 (64-bit, non-prefetchable) [size=2M]
    Capabilities: [48] Power Management version 3
        Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA
PME(D0+,D1+,D2+,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=2 PME-
    Capabilities: [58] MSI: Enable- Count=1/1 Maskable- 64bit+
        Address: 0000000000000000  Data: 0000
    Capabilities: [68] Vendor Specific Information: Len=44 <?>
    Capabilities: [ac] Express (v2) Endpoint, MSI 00
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s
<4us, L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 10W
        DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr+ NoSnoop+
            MaxPayload 128 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+ TransPend-
        LnkCap:    Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <2us, L1 <32us
            ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
        LnkCtl:    ASPM L0s L1 Enabled; RCB 64 bytes, Disabled- CommClk+
            ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1
            TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
             10BitTagComp- 10BitTagReq- OBFF Via WAKE#, ExtFmt- EETLPPrefix-
             EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
             FRS- TPHComp- ExtTPHComp-
             AtomicOpsCap: 32bit- 64bit- 128bitCAS-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR-
10BitTagReq- OBFF Disabled,
             AtomicOpsCtl: ReqEn-
        LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
             EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
             Retimer- 2Retimers- CrosslinkRes: unsupported
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
        AERCap:    First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
            MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
        HeaderLog: 00000000 00000000 00000000 00000000
    Capabilities: [13c v0] Device Serial Number ac-d1-00-ff-**-**-**-**
    Capabilities: [150 v1] Power Budgeting <?>
    Capabilities: [160 v1] Virtual Channel
        Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:    ArbSelect=Fixed
        Status:    InProgress-
        VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
            Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
            Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
            Status:    NegoPending- InProgress-
    Kernel driver in use: bcma-pci-bridge
    Kernel modules: bcma
00: e4 14 b1 43 06 00 10 00 03 00 80 02 10 00 00 00
10: 04 00 20 c1 00 00 00 00 04 00 00 c1 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 aa 17 23 06
30: 00 00 00 00 48 00 00 00 00 00 00 00 ff 01 00 00
40: 00 00 00 00 00 00 00 00 01 58 03 fe 08 40 00 00
50: 00 00 00 00 00 00 00 00 05 68 80 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 09 ac 44 00 01 01 00 00
70: 00 10 10 18 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 10 00 18 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 02 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 40 00 05 00 10 00 02 00
b0: 81 8f 90 05 10 2c 10 00 11 dc 46 00 43 01 11 10
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 1f 00 08 00 00 00 00 00 00 00 00 00 01 00 01 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
100: 01 00 c1 13 00 00 00 00 00 00 00 00 30 20 06 00
110: 00 00 00 00 00 20 00 00 a0 00 00 00 00 00 00 00
120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
130: 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 15

As it says UNSUPPORTED PHY and 43b1 is not supported with no
alternative as can be seen[1], can this device be used? What is the
SPROM issue about?

[1]https://wireless.wiki.kernel.org/en/users/Drivers/b43
