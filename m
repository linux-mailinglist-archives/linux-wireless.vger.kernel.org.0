Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB25637F9F
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 20:23:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiKXTXb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 14:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiKXTXa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 14:23:30 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BEC663DA
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:23:29 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f13so3809747lfa.6
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lhZ+OQdSJMYXunqhjRUBrGHzKvrTPm8PL7IukwstzIE=;
        b=iE8mB+nIGFEbOLe/3WFx4yguSDmkScZ/nqPKu70NjFfeNNJZ+fNCT/CgJXVb+7mxUp
         8CzNq/LlsRhQ09uuYjbukViIP/IgJMwGnnPpULDI07e1DrrUtrvB8gwlmqaHwh2/3XzI
         Hw0NMmLzc6Npd1IqgqBY6+SC64l7bkHOrwAaYj1zhZY0ZCWS6etS4PZMJMTYPRS1oxyu
         Tx9qlzCoDdZRSSPUppWvi6nF6cOYa1AQnUyDuUbPqIBJi4lF4OzPNzqxQPKUGJwuZDKu
         zxl2B3/+YnWtFgw+ktsCKburZPz3Sy9IVlHlXFz6gNckIspssnUOiSx5eMXU0eOH2Jz8
         FJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lhZ+OQdSJMYXunqhjRUBrGHzKvrTPm8PL7IukwstzIE=;
        b=4YxOvLTN3aSX92tViH60rJuJKIvPcrfGdi9xjJSs2aG4TVovEKa6xNEC2/o+iMkLc0
         cUwdo2hMllSicqIe5/SxhOFYrrDKWOxZ+BS6hXudWBIfW7wU4wuHNi4Fz56KDsOFNyhu
         rZvpWRljR+Xf7lSdf5a5fwXOM2Biel/HVOtMWeFJNTT+rQjT8E8YCct5IGuZ9pZWRuEY
         UbcGIFFCM7YA3zJKmbi0538ykUFsFeQQBuXCZIJLQf5ADTDBjwUkYaiJM7pDEOj0t7FL
         nihudrNt03ZJxV5Bqw6/tyAhq//an32W+J9dxEyHJLJT1v9FDqSprYU970dsmm6ugTlG
         W2Ww==
X-Gm-Message-State: ANoB5pkzC14dTVgtCB+brc7bmn2SIT03GxUOi3vknCSirkTCI7dT9zAe
        mFuxknV76OFMRyXSLuzZ1x67D3FTHvGUI6dHtD9suyvoK/gRvg==
X-Google-Smtp-Source: AA0mqf6VZZB1NwTST++8UDEDRxLZKuetNifzVLqe+BKW/InGwUxngKvIDetAR7qIZ6r9Jl70D1aT6yxRR6AQsOzneoY=
X-Received: by 2002:a19:7b1d:0:b0:497:9e0d:183 with SMTP id
 w29-20020a197b1d000000b004979e0d0183mr12751836lfc.537.1669317807519; Thu, 24
 Nov 2022 11:23:27 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Fri, 25 Nov 2022 21:22:17 +0200
Message-ID: <CADUzMVZVzGF6WeVUdCsZ8TFs3ppY4QV_WqNgaHPRTZZXQZ0Ocg@mail.gmail.com>
Subject: Centrino Wireless-N 135 BGN WPA3 SSID connection problem #4
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

Using the next miniPCIe card on Ubuntu boot I get:
[   67.545793] iwlwifi 0000:02:00.0: can't disable ASPM; OS doesn't
have ASPM control
[   67.660744] iwlwifi 0000:02:00.0: loaded firmware version
18.168.6.1 135-6.ucode op_mode iwldvm
[   67.896976] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEBUG disabled
[   67.896984] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEBUGFS enabled
[   67.896986] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEVICE_TRACING enabled
[   67.896988] iwlwifi 0000:02:00.0: Detected Intel(R) Centrino(R)
Wireless-N 135 BGN, REV=0x120
[   67.935220] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
[   67.953882] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
[  210.788613] iwlwifi 0000:02:00.0: Radio type=0x0-0x0-0x0
[  210.885387] iwlwifi 0000:02:00.0: Radio type=0x0-0x0-0x0

Here I attempted to connect to the WPA3 2,4GHz SSID:
[  635.393899] wlp2s0: authenticate with c6:27:28:**:**:**
[  635.398599] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  635.541017] wlp2s0: authenticate with c6:27:28:**:**:**
[  635.541040] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  635.653688] wlp2s0: authenticated
[  635.655837] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  635.660756] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  635.663211] wlp2s0: associated
[  635.755067] wlp2s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  635.860329] wlp2s0: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 1=UNSPECIFIED)
[  636.587846] wlp2s0: authenticate with c6:27:28:**:**:**
[  636.591256] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  636.595985] wlp2s0: authenticated
[  636.599836] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  636.609198] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  636.613482] wlp2s0: associated
[  636.678280] wlp2s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  636.756325] wlp2s0: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 1=UNSPECIFIED)
[  637.480110] wlp2s0: authenticate with c6:27:28:**:**:**
[  637.483551] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  637.485475] wlp2s0: authenticated
[  637.487863] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  637.500274] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  637.503709] wlp2s0: associated
[  637.604245] wlp2s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  637.664384] wlp2s0: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 1=UNSPECIFIED)
[  638.529199] wlp2s0: authenticate with c6:27:28:**:**:**
[  638.537850] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  638.539808] wlp2s0: authenticated
[  638.543799] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  638.549210] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  638.551653] wlp2s0: associated
[  638.622410] wlp2s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  638.692346] wlp2s0: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 1=UNSPECIFIED)
[  649.078070] wlp2s0: authenticate with c6:27:28:**:**:**
[  649.081447] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  649.083502] wlp2s0: authenticated
[  649.087822] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  649.092920] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  649.095389] wlp2s0: associated
[  649.169732] wlp2s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  649.252343] wlp2s0: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 1=UNSPECIFIED)

This is the device:
Network controller [0280]: Intel Corporation Centrino Wireless-N 135
[8086:0892] (rev c4)
    Subsystem: Intel Corporation Centrino Wireless-N 135 BGN [8086:0062]
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 4 bytes
    Interrupt: pin A routed to IRQ 39
    NUMA node: 0
    Region 0: Memory at fddfe000 (64-bit, non-prefetchable) [size=8K]
    Capabilities: [c8] Power Management version 3
        Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fee08004  Data: 0025
    Capabilities: [e0] Express (v1) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W
        DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
        LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <4us, L1 <32us
            ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
        LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s, Width x1
            TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
    Capabilities: [100 v1] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt:    DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
        AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap- ECRCChkEn-
            MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
        HeaderLog: 00000000 00000000 00000000 00000000
    Capabilities: [140 v1] Device Serial Number 0c-d2-92-ff-**-**-**-**
    Kernel driver in use: iwlwifi
    Kernel modules: iwlwifi
00: 86 80 92 08 06 04 10 00 c4 00 80 02 01 00 00 00
10: 04 e0 df fd 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 62 00
30: 00 00 00 00 c8 00 00 00 00 00 00 00 05 01 00 00
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 01 d0 23 c8 00 00 00 0d
d0: 05 e0 81 00 04 80 e0 fe 00 00 00 00 25 00 00 00
e0: 10 00 01 00 c0 8e 00 10 10 08 19 00 11 ec 06 01
f0: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
100: 01 00 01 14 00 00 00 00 00 00 00 00 11 20 06 00
110: 00 20 00 00 00 20 00 00 00 00 00 00 00 00 00 00
