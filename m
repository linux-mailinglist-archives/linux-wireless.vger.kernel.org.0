Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB59637F80
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Nov 2022 20:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiKXTQW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Nov 2022 14:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiKXTQV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Nov 2022 14:16:21 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1629F8757C
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:16:20 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id p8so3764746lfu.11
        for <linux-wireless@vger.kernel.org>; Thu, 24 Nov 2022 11:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lWUtCC0Ocx35hjGcGDA+XUG/ns04fCZPtbnrNYGF/0c=;
        b=XEvdBjm3hB0lB4soyZYtmHUaw7f51ujivEJNbrUFn9aO1NV/sj7JzP9bPJhN6P7uOB
         o9QAlg7y82Appar1swks3FtQBNfPVSvCD0xNHVxpm8avVt/MszcEFtkUm1gPhHaoPFr/
         7O1CK+EpKlAd4vwpyN6OuMYFr596Ao18B0ueh0ohWGXI3QcRSl00eJSXIfIWQX79IcHR
         IBzlS2vl0snIdmCqGRq6kanMrQkql1Cw5Sq9/2+cxidE4GYa+TiLmuu+GuZbVOa1c4HQ
         mtkiHSUo6Xt98FyzvcNQB58jYCTNTQPVcdscw5hatuLm7XKvxv1ym6vzlu3ZHn6A3T/s
         DJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lWUtCC0Ocx35hjGcGDA+XUG/ns04fCZPtbnrNYGF/0c=;
        b=VEX1EJ0mkbrxqQCJTriBPLAHFZc2/Ajs8SOTUStsL1d4yQ0KiHsT8WUZX+Y04LdHdJ
         FZtjJz/mRr6iMjZRsDlOfqpr1Twus7nOAKYgSqbWTxC8oRBbqrxnN9B6wCSi2AqLTA9g
         Y4ULDIbmlYks2YXLRpDmPRCLzpXIhmlumYoyBnslSgNHkv7xfqYLm0e9h1TZy2fL5uJN
         qWR6/9E9fz/IPb74Z7w3jmV01VMh7oRJh1g/ChT9UzYXsAivnJwRmdi3rzvw4FxcPI32
         2WjB4WGz8i3I2TGLvmORLIhO6LPe0g3iGOZNUQAhcJxsEbKJzjbaKK6xfXRZH16qV5HJ
         zcaA==
X-Gm-Message-State: ANoB5pmi5oueaGdq7qclruL0qDggnRviZENf7FG/R8ke/fK79tOmQ+wK
        ZyEnsNKvP6SNylGlFrPCU7vc/G5fJP4BBr8nbqhfIzAb/caLPg==
X-Google-Smtp-Source: AA0mqf5ob1sSc1ao38ofiny+VryNZwKaP7B1gvLsopa2mj+pyOUk40aBnpbpug/NcXo/UGkuv1EVHarLSZZ5rylSY9o=
X-Received: by 2002:a05:6512:746:b0:4a2:4f74:f47c with SMTP id
 c6-20020a056512074600b004a24f74f47cmr11062651lfs.367.1669317378305; Thu, 24
 Nov 2022 11:16:18 -0800 (PST)
MIME-Version: 1.0
From:   Ioannis Barkas <jnyb.de@gmail.com>
Date:   Fri, 25 Nov 2022 21:15:07 +0200
Message-ID: <CADUzMVZD4v6P6S6whM+s0vp-qZ1EkqEZRBUs-AvwUdH1AWziNQ@mail.gmail.com>
Subject: Centrino 1000 Intel WPA3 SSID connection problem #2
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

Moving to the next one, here is how it boots on Debian:
[    9.736612] iwlwifi 0000:02:00.0: can't disable ASPM; OS doesn't
have ASPM control
[    9.807509] iwlwifi 0000:02:00.0: firmware: direct-loading firmware
iwlwifi-1000-5.ucode
[    9.807688] iwlwifi 0000:02:00.0: loaded firmware version 39.31.5.1
build 35138 1000-5.ucode op_mode iwldvm
[    9.807716] iwlwifi 0000:02:00.0: firmware: failed to load
iwl-debug-yoyo.bin (-2)
[   10.293590] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEBUG disabled
[   10.293597] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEBUGFS disabled
[   10.293601] iwlwifi 0000:02:00.0: CONFIG_IWLWIFI_DEVICE_TRACING disabled
[   10.293606] iwlwifi 0000:02:00.0: Detected Intel(R) Centrino(R)
Wireless-N 1000 BGN, REV=0x6C
[   10.329537] ieee80211 phy0: Selected rate control algorithm 'iwl-agn-rs'
[   10.432410] iwlwifi 0000:02:00.0 wlp2s0: renamed from wlan0
[   15.744573] iwlwifi 0000:02:00.0: Radio type=0x0-0x0-0x3

Here I attempted to connect to the 2,4GHz WPA3 SSID:
[  335.382447] IPv6: ADDRCONF(NETDEV_CHANGE): enp5s0: link becomes ready
[  783.927578] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  784.080563] wlp2s0: authenticate with c6:27:28:**:**:**
[  784.080577] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  784.180917] wlp2s0: authenticated
[  784.188226] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  784.192796] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[  784.192810] wlp2s0: c6:27:28:**:**:** denied association (code=31)
[  784.776289] wlp2s0: authenticate with c6:27:28:**:**:**
[  784.778845] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  784.781365] wlp2s0: authenticated
[  784.788203] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  784.797859] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[  784.797873] wlp2s0: c6:27:28:**:**:** denied association (code=31)
[  784.842962] wlp2s0: authenticate with c6:27:28:**:**:**
[  784.845749] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  784.988586] wlp2s0: authenticate with c6:27:28:**:**:**
[  784.988598] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  785.103288] wlp2s0: authenticated
[  785.108228] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  785.112749] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[  785.112762] wlp2s0: c6:27:28:**:**:** denied association (code=31)
[  786.131604] wlp2s0: authenticate with c6:27:28:**:**:**
[  786.134085] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  786.136574] wlp2s0: authenticated
[  786.144211] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  786.148837] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[  786.148854] wlp2s0: c6:27:28:**:**:** denied association (code=31)
[  786.185989] wlp2s0: authenticate with c6:27:28:**:**:**
[  786.188668] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  786.333363] wlp2s0: authenticate with c6:27:28:**:**:**
[  786.333377] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  786.451704] wlp2s0: authenticated
[  786.460191] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  786.473059] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[  786.473073] wlp2s0: c6:27:28:**:**:** denied association (code=31)
[  788.009741] wlp2s0: authenticate with c6:27:28:**:**:**
[  788.012272] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  788.014716] wlp2s0: authenticated
[  788.020337] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  788.024913] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[  788.024918] wlp2s0: c6:27:28:**:**:** denied association (code=31)
[  788.083630] wlp2s0: authenticate with c6:27:28:**:**:**
[  788.086190] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  788.228160] wlp2s0: authenticate with c6:27:28:**:**:**
[  788.228181] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  788.353649] wlp2s0: authenticated

Here is what iw sees:
1669148394.465924: wlp2s0 (phy #0): scan started
1669148394.923386: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, ""
1669148412.443038: wlp2s0 (phy #0): scan started
1669148412.871915: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1669148417.876332: wlp2s0 (phy #0): scan started
1669148418.343882: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1669148423.346105: wlp2s0 (phy #0): scan started
1669148423.795789: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1669148428.802074: wlp2s0 (phy #0): scan started
1669148429.278468: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1669148434.281790: wlp2s0 (phy #0): scan started
1669148434.731620: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1669148437.680611: wlp2s0 (phy #0): scan started
1669148438.161088: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, ""
1669148438.389004: wlp2s0 (phy #0): scan started
1669148438.815398: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1669148443.818370: wlp2s0 (phy #0): scan started
1669148444.296830: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1669148449.303261: wlp2s0 (phy #0): scan started
1669148449.803695: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1669148454.806737: wlp2s0 (phy #0): scan started
1669148455.287208: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1669148460.293563: wlp2s0 (phy #0): scan started
1669148460.795738: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1669148463.676666: wlp2s0 (phy #0): scan started
1669148464.111529: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, ""
1669148464.364551: wlp2s0 (phy #0): scan started
1669148464.840720: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1669148469.845271: wlp2s0 (phy #0): scan started
1669148470.332861: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1669148473.464529: wlp2s0 (phy #0): scan started
1669148473.920007: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1669148475.700862: wlp2s0 (phy #0): scan started
1669148476.162845: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, ""
1669148476.725793: wlp2s0 (phy #0): scan started
1669148477.122202: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1669148477.953950: wlp2s0 (phy #0): scan started
1669148478.455176: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1669148479.915952: wlp2s0 (phy #0): scan started
1669148480.440272: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+3" ""
1669148492.902895: wlp2s0 (phy #0): scan started

A subsequent attempt to use the combo WPA2,3 SSID failed:
[  792.575719] wlp2s0: authenticate with c6:27:28:**:**:**
[  792.579125] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  792.718225] wlp2s0: authenticate with c6:27:28:**:**:**
[  792.718239] wlp2s0: send auth to c6:27:28:**:**:** (try 1/3)
[  792.835225] wlp2s0: authenticated
[  792.836181] wlp2s0: associate with c6:27:28:**:**:** (try 1/3)
[  792.842242] wlp2s0: RX AssocResp from c6:27:28:**:**:**
(capab=0x1431 status=31 aid=16)
[  792.842256] wlp2s0: c6:27:28:**:**:** denied association (code=31)
[  794.599226] iwlwifi 0000:02:00.0: Radio type=0x0-0x0-0x3

Here is what iw sees:
1669148493.408304: wlp2s0 (phy #0): scan finished: 2412 2417 2422 2427
2432 2437 2442 2447 2452 2457 2462 2467 2472, "AI-2+23" ""
1669148493.422926: wlp2s0: new station c6:27:28:**:**:**
1669148493.574441: wlp2s0 (phy #0): auth c6:27:28:**:**:** ->
74:e5:0b:19:ae:76 status: 0: Successful
1669148493.676333: wlp2s0 (phy #0): auth c6:27:28:**:**:** ->
74:e5:0b:19:ae:76 status: 0: Successful
1669148493.707672: wlp2s0: del station c6:27:28:**:**:**
1669148493.709898: wlp2s0 (phy #0): assoc c6:27:28:**:**:** ->
74:e5:0b:19:ae:76 status: 31: Robust Management frame policy violation
1669148493.710015: wlp2s0 (phy #0): failed to connect to
c6:27:28:**:**:**, status: 31: Robust Management frame policy
violation

This is the device:
02:00.0 Network controller [0280]: Intel Corporation Centrino
Wireless-N 1000 [Condor Peak] [8086:0084]
    Subsystem: Intel Corporation Centrino Wireless-N 1000 BGN [8086:1315]
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
        Address: 00000000fee02004  Data: 0025
    Capabilities: [e0] Express (v1) Endpoint, MSI 00
        DevCap:    MaxPayload 128 bytes, PhantFunc 0, Latency L0s
<512ns, L1 unlimited
            ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ SlotPowerLimit 0W
        DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
            RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
            MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta:    CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr+ TransPend-
        LnkCap:    Port #1, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <128ns, L1 <32us
            ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
        LnkCtl:    ASPM Disabled; RCB 64 bytes, Disabled- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 2.5GT/s (ok), Width x1 (ok)
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
    Capabilities: [140 v1] Device Serial Number 74-e5-0b-ff-**-**-**-**
    Kernel driver in use: iwlwifi
    Kernel modules: iwlwifi
00: 86 80 84 00 06 04 10 00 00 00 80 02 01 00 00 00
10: 04 e0 df fd 00 00 00 00 00 00 00 00 00 00 00 00
20: 00 00 00 00 00 00 00 00 00 00 00 00 86 80 15 13
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
d0: 05 e0 81 00 04 80 e0 fe 00 00 00 00 24 40 00 00
e0: 10 00 01 00 c0 8e 00 10 10 08 19 00 11 9c 06 01
f0: 40 00 11 10 00 00 00 00 00 00 00 00 00 00 00 00
100: 01 00 01 14 00 00 00 00 00 00 00 00 11 20 06 00
110: 00 20 00 00 00 20 00 00 00 00 00 00 00 00 00 00
120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

uname -a
Linux debian 5.10.0-18-amd64 #1 SMP Debian 5.10.140-1 (2022-09-02)
x86_64 GNU/Linux
