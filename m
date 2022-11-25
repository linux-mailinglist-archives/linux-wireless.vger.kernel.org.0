Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9261E637F99
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 20:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiKXTSy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 14:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiKXTSr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 14:18:47 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996D16BDF4
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:18:45 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id u2so2938759ljl.3
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Ye7wS+CyfUu6dRlqp1yW2Tka1AIM35S1fV3Wmd4F6k=;
        b=K5sxZEafJu0mG07pq/FGMb5v1ZM3bx0pAldOcB5jwe4tryuCItnCRKFqeCeKnxVRKq
         EoJz4eyX4xPYNsybodmq9Ta424KeUjPc5ecQhhIO08wgSQ/AmxBdK/cVj5F5V6z+IBDr
         quZo4TghhTOXaTh7IGk6ywyEoTA606W5WvYZQMNQpt6mHsoSR34ZiCh1Hv5ccjQ+6DkW
         NilS2OuW+EH1rMTuVebp46/kFVwmlKACBngYWAdLy6nMAmmPiE2com9ugmKZU0/h9t48
         5Xhu7hO28lbrRxpbWDAiRC1O6e085lmPxZfhnaXkLVP2T2wXYnoJJg9xfFCFMtr+mG0X
         GI6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Ye7wS+CyfUu6dRlqp1yW2Tka1AIM35S1fV3Wmd4F6k=;
        b=E3dZzQtFql/iiozfDjXY4Hsr7wLQIJfsuTfiLpJezn9RP/iSTCA1ALF+WBpJObD8Qt
         PqAg4xFgxeIaR3hH6UQt9KrWZn2xcJIA5i6G+H5fH1C+5+80VO+3X9g3FxU8bXP0BStn
         7G14yTU2+1c0TRXhW9vAr4DcPaK1Vm7n/MLld1EsBaPffU4mo3WkTyrYQ7f3TWkid0pF
         1O06beSKgRosQ2XOMozgo4P9EgxF7lQ8nacmXIo88QyNO7cJtf2WZCBgmA5UuBTnl2pj
         g6a54uu2qBPOka7jdq6xSWkwfdQG8979kRII1SdRg1br8AnhuEnWYI7ju5UCkr8FFM8F
         HA+A==
X-Gm-Message-State: ANoB5pnSwG6JT8+b2Am03MTXmMjMaNr/56y9MHdDr140SSwqXYreqyuq
        mHJHvNefMAXJbtnQ3byS0OUPQKPv5SPXvPg0zQgQ6ju9mLCxfg==
X-Google-Smtp-Source: AA0mqf4ySGHvepRyzKadHrmDFVRHcwAc66qye8+iTuKxAaYBxy6rhDIyQ8RL9w0LrTZfbaZF+tKMXfa7+Ps9Rf3iGc0=
X-Received: by 2002:a2e:bf27:0:b0:279:74ab:77bd with SMTP id
 c39-20020a2ebf27000000b0027974ab77bdmr3486274ljr.380.1669317523948; Thu, 24
 Nov 2022 11:18:43 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Fri, 25 Nov 2022 21:17:33 +0200
Message-ID: <CADUzMVbZsjyp-6C6TMW7T3PGZOf5VOALXUZ0kRYZHSi5OLSdOQ@mail.gmail.com>
Subject: Centrino Wireless-N 2230 Intel WPA3 SSID connection problem #3
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

Hello, this is the next one.

Here is how it boots on Ubuntu:
[   91.632788] Intel(R) Wireless WiFi driver for Linux
[   91.633167] iwlwifi 0000:02:00.0: can't disable ASPM; OS doesn't
have ASPM control
[   91.696044] iwlwifi 0000:02:00.0: loaded firmware version
18.168.6.1 2030-6.ucode op_mode iwldvm
[   91.935989] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEBUG disabled
[   91.935998] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEBUGFS enabled
[   91.936000] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEVICE_TRACING enabled
[   91.936001] iwlwifi 0000:02:00.0: Detected Intel(R) Centrino(R)
Wireless-N 2230 BGN, REV=0xC8
[   91.968074] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
[   91.976419] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
[  223.834284] iwlwifi 0000:02:00.0: Radio type=0x2-0x0-0x0
[  224.115757] iwlwifi 0000:02:00.0: Radio type=0x2-0x0-0x0

After I attempted to connect to the WPA3 SSID:
[  784.647437] wlp2s0: authenticate with c6:27:28:**:**:**
[  784.650625] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  784.795505] wlp2s0: authenticate with c6:27:28:**:**:**
[  784.795527] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  784.914387] wlp2s0: authenticated
[  784.915897] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  784.920931] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  784.923018] wlp2s0: associated
[  784.967986] wlp2s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  785.169948] wlp2s0: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 1=UNSPECIFIED)
[  785.848998] wlp2s0: authenticate with c6:27:28:**:**:**
[  785.852199] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  785.854158] wlp2s0: authenticated
[  785.855876] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  785.860860] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  785.862922] wlp2s0: associated
[  785.889573] wlp2s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  786.020324] wlp2s0: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 1=UNSPECIFIED)
[  786.735162] wlp2s0: authenticate with c6:27:28:**:**:**
[  786.737451] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  786.739393] wlp2s0: authenticated
[  786.739891] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  786.746800] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  786.748966] wlp2s0: associated
[  786.811275] wlp2s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  786.884357] wlp2s0: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 1=UNSPECIFIED)
[  787.589005] wlp2s0: authenticate with c6:27:28:**:**:**
[  787.591411] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  787.595727] wlp2s0: authenticated
[  787.599885] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  787.604904] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  787.606983] wlp2s0: associated
[  787.630469] wlp2s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  787.764312] wlp2s0: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 1=UNSPECIFIED)
[  797.969645] wlp2s0: authenticate with c6:27:28:**:**:**
[  797.974992] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  797.976970] wlp2s0: authenticated
[  797.979863] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  797.984863] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=0 aid=16)
[  797.986918] wlp2s0: associated
[  798.075575] wlp2s0: Limiting TX power to 30 (30 - 0) dBm as
advertised by c6:27:28:**:**:**
[  798.136325] wlp2s0: deauthenticating from c6:27:28:**:**:** by
local choice (Reason: 1=UNSPECIFIED)

Here is what iw sees:
1668844086.756097: wlp2s0 (phy #0): scan started
1668844087.278822: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1668844087.292584: wlp2s0: new station c6:27:28:**:**:**
1668844087.439258: wlp2s0 (phy #0): auth c6:27:28:**:**:** ->
68:5d:43:29:c7:ff status: 0: Successful
1668844087.550560: wlp2s0 (phy #0): auth c6:27:28:**:**:** ->
68:5d:43:29:c7:ff status: 0: Successful
1668844087.564113: wlp2s0 (phy #0): assoc c6:27:28:**:**:** ->
68:5d:43:29:c7:ff status: 0: Successful
1668844087.564291: wlp2s0 (phy #0): connected to c6:27:28:**:**:**
1668844087.564342: phy #0: regulatory domain change: set to GR by a
country IE request on phy0
1668844087.664898: wlp2s0 (phy #0): ctrl. port TX status (cookie 23): acked
1668844087.669554: wlp2s0 (phy #0): ctrl. port TX status (cookie 24): acked
1668844087.806455: wlp2s0: del station c6:27:28:**:**:**
1668844087.808750: wlp2s0 (phy #0): deauth 68:5d:43:29:c7:ff ->
c6:27:28:**:**:** reason 1: Unspecified
1668844087.808879: wlp2s0 (phy #0): disconnected (local request)
reason: 1: Unspecified
1668844087.847892: phy #0: regulatory domain change: set to world
roaming by the wireless core upon initialization request
1668844087.948173: wlp2s0 (phy #0): scan started
1668844088.473959: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1668844097.479769: wlp2s0 (phy #0): scan started
1668844097.934716: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1668844097.938555: wlp2s0: new station c6:27:28:**:**:**
1668844097.940816: wlp2s0 (phy #0): auth c6:27:28:**:**:** ->
68:5d:43:29:c7:ff status: 0: Successful
1668844097.949038: wlp2s0 (phy #0): assoc c6:27:28:**:**:** ->
68:5d:43:29:c7:ff status: 0: Successful
1668844097.949117: wlp2s0 (phy #0): connected to c6:27:28:**:**:**
1668844097.949216: phy #0: regulatory domain change: set to GR by a
country IE request on phy0
1668844098.055248: wlp2s0 (phy #0): ctrl. port TX status (cookie 25): acked
1668844098.060191: wlp2s0 (phy #0): ctrl. port TX status (cookie 26): acked
1668844098.182492: wlp2s0: del station c6:27:28:**:**:**
1668844098.184833: wlp2s0 (phy #0): deauth 68:5d:43:29:c7:ff ->
c6:27:28:**:**:** reason 1: Unspecified
1668844098.184964: wlp2s0 (phy #0): disconnected (local request)
reason: 1: Unspecified
1668844098.211840: phy #0: regulatory domain change: set to world
roaming by the wireless core upon initialization request
1668844098.312126: wlp2s0 (phy #0): scan started
1668844098.815619: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3"

This is the device:
02:00.0 Network controller [0280]: Intel Corporation Centrino
Wireless-N 2230 [8086:0887] (rev c4)
    Subsystem: Intel Corporation Centrino Wireless-N 2230 BGN [8086:4062]
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
        Address: 00000000fee20004  Data: 0024
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
    Capabilities: [140 v1] Device Serial Number 68-5d-43-ff-**-**-**-**
    Kernel driver in use: iwlwifi
    Kernel modules: iwlwifi
00: 86 80 87 08 06 04 10 00 c4 00 80 02 01 00 00 00
10: 04 e0 df fd 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 62 40
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
d0: 05 e0 81 00 04 00 e2 fe 00 00 00 00 24 00 00 00
e0: 10 00 01 00 c0 8e 00 10 10 08 19 00 11 ec 06 01
f0: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
100: 01 00 01 14 00 00 00 00 00 00 00 00 11 20 06 00
110: 00 20 00 00 00 20 00 00 00 00 00 00 00 00 00 00
120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
