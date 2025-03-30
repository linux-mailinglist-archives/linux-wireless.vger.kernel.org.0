Return-Path: <linux-wireless+bounces-20975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C869A75A54
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 16:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98313A5B32
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Mar 2025 14:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFBF1ADC8D;
	Sun, 30 Mar 2025 14:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CROflYXu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792F91C3F34
	for <linux-wireless@vger.kernel.org>; Sun, 30 Mar 2025 14:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743344898; cv=none; b=lYm/VbSkfD9ld0AZGS0D7pG2i90+YZVLu5X4WiJvx/XKLlZpJBDbb/RQ0GFE+5xQxVVHOtpLUsjNI/dNgujgjJv2LJCkiyOHuSVCESVz8seqP40MYkzppEMQFtTLr27gv1wmeb6eKFwUAB7fKCfgolE8h5v49m0Q6WvCzmQjv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743344898; c=relaxed/simple;
	bh=hTr3I8/qiH0oDPI3K1dHUbtx9xX0sFijwgeONeHUE+8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OrDDWgxJ1WhzpcqmSuCoPM2iLDItRSiwKHNDesnupar08FE5FSuv7IA2PlnsjuaqlvjLD7DCWXEu3BNgL0gKQZpskLlDyD+ibumiRalo64xJrRrtvWLfUOeDFBRlXW0wKkTr5SljI0Ilf1cxF0CFLpR9Xn2xONAsMf9TdvsGNvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CROflYXu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so22772535e9.0
        for <linux-wireless@vger.kernel.org>; Sun, 30 Mar 2025 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743344894; x=1743949694; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4Y+UQqFWryxXyxqljL2bdb5G/7fyDOEe72jjzQiA+GU=;
        b=CROflYXumKOHypP6XblmAZu+n9jnhhoJjCenpA7khhjitK8Vp2z+ztEOQslD5fuwEi
         rlPLDoZuNHo9ww+iHtbBLV/ip4ySc3It4H27izi7Ahiade3vsI0kbesl1uTXjq/P/qK2
         IZ2GkvVL3QSyRl0CmJh6CCS7h0u9FJ+jDmP5sEk+99kK1j+zt+/pfl03NcinKr/Coody
         3fzDxeKdC3tffnCEjSi+QNPhnoMRzYkmCnOg6mUeLh8H7QqgrzF52k9DKEuJntXvjWNn
         soqRaqk8TCFVvit2tf5YP3lEvqnXMCNQfSbg22mraTCBncBTCxUblu0AGcO+67F+P9vp
         htRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743344894; x=1743949694;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4Y+UQqFWryxXyxqljL2bdb5G/7fyDOEe72jjzQiA+GU=;
        b=BGoukpei77EzLRw1Z9c8IEsxguU4Lchy+oJ7LIZUmsALXAyvg7sAtGICfY1M46/llc
         G0yKu9QWoWTC3BQfLyQcdT9dcxeTOdXPZ/61bpxcom5zEQBUFLH60eSjXfkLrV+CZuBP
         xLXKueflEnzJtAFJbvdRwSJqbbyzWFRqtu2oHQjQItnBzZR1YMQ4nNk4M1u1Cw7O8dgX
         hAFlhv8VnOJ7w08lYSl9gerB/XiYChO/r9LIzsKi0cmgRGGruhKLG6f5zrj3qsO2b8KG
         ZzeQmurN/vQ9XDlFBtPhmrFIDZJJdL8UtMGaoqkZHwJ3CvIZA1j6KlyGx0KOG0PyhYF+
         pzBw==
X-Gm-Message-State: AOJu0YweSIHO5TYGvyW/Pm+Xi2TWRzcpl7beCdZSo/oLqfhX/Lt8UUs9
	otCiLS+f8DiCmmc3ns7UInqqrk79E9xD/yDmQyG8L6jdikpweyqZUuXhAP67JsFRZ9r6gAbUXiK
	KAQ/EAdgejU5mTSuLuHhBTuTlzFwJsPb9
X-Gm-Gg: ASbGnctykH7gM8WM5dpZSYUugiIA8+4xVMpomfNTuhyKpAfXAyEFK4z5iR/dfa1ujah
	3bkQG875l1hjeOjaxuoS6On0/C4WdV8mK9bW0Ryua+r/kn4M2M8jlRhyGrKAiqf7Rh+H0r0DbJj
	vY0EmBKsZDZ9mxvfO2Zv8H2OEf
X-Google-Smtp-Source: AGHT+IGGkUO4CpU4adi8wJ2zMdT9SbtfsR08VFG2tlh54g+zBEXIC+jv/2oHEuupENw9e5Ubj2J/zZHzoOh3gvBS/QA=
X-Received: by 2002:a05:600c:5251:b0:43d:300f:fa51 with SMTP id
 5b1f17b1804b1-43db6226654mr44203945e9.9.1743344893820; Sun, 30 Mar 2025
 07:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Walt Holman <waltholman09@gmail.com>
Date: Sun, 30 Mar 2025 09:28:03 -0500
X-Gm-Features: AQ5f1JosJGfTMJAyHo-V4ljt8JziA2XovTaRMq9jQhPtkTLFFrSf7G5tW8UD67M
Message-ID: <CAMb39_ngQs8=FUML5QXMh2RmEZBZ2NwUHefhGoTkGtHat+KWJA@mail.gmail.com>
Subject: ath12k: No 6GHz Wireless found
To: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I have a wcn7850 hw2.0 based m.2 wireless card in my laptop and am
unable to see or connect to 6Ghz networks. I have an ASUS BE30000 wifi
router setup with a separate 6ghz only network, which my phone and
other laptops can connect to. I'm unable to even see this network on
this particular laptop. Months ago (maybe September), I could see it
occasionally, but now it never shows up. I'm using firmware from
git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
and track the kernels pretty closely. I'm currently running 6.14.0
built from source. Any suggestions? Some HW info is below:

63:00.0 Network controller: Qualcomm Technologies, Inc WCN785x Wi-Fi
7(802.11be) 320MHz 2x2 [FastConnect 7800
] (rev 01)
       Subsystem: Quectel Wireless Solutions Co., Ltd. Device 8000
       Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
       Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort+
<TAbort- <MAbort- >SERR- <PERR- INTx-
       Latency: 0, Cache Line Size: 64 bytes
       Interrupt: pin ? routed to IRQ 111
       IOMMU group: 19
       Region 0: Memory at dd800000 (64-bit, non-prefetchable) [size=2M]
       Capabilities: [40] Power Management version 3
               Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
               Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
       Capabilities: [50] MSI: Enable+ Count=16/32 Maskable+ 64bit-
               Address: fee00000  Data: 0000
               Masking: ffff8000  Pending: 00000000
       Capabilities: [70] Express (v2) Endpoint, IntMsgNum 0
               DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                       ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
SlotPowerLimit 75W TEE-IO-
               DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
                       RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
                       MaxPayload 128 bytes, MaxReadReq 512 bytes
               DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr+ TransPend-
               LnkCap: Port #0, Speed 8GT/s, Width x2, ASPM L0s L1,
Exit Latency L0s <1us, L1 <64us
                       ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
               LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
                       ExtSynch+ ClockPM- AutWidDis- BWInt- AutBWInt-
               LnkSta: Speed 8GT/s, Width x1 (downgraded)
                       TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
               DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
NROPrPrP- LTR+
                        10BitTagComp- 10BitTagReq- OBFF Not Supported,
ExtFmt- EETLPPrefix-
                        EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                        FRS- TPHComp+ ExtTPHComp-
                        AtomicOpsCap: 32bit- 64bit- 128bitCAS-
               DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                        AtomicOpsCtl: ReqEn-
                        IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
                        10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
               LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink-
Retimer- 2Retimers- DRS-
               LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                        Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                        Compliance Preset/De-emphasis: -6dB
de-emphasis, 0dB preshoot
               LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+ EqualizationPhase1+
                        EqualizationPhase2+ EqualizationPhase3+
LinkEqualizationRequest-
                        Retimer- 2Retimers- CrosslinkRes: unsupported
       Capabilities: [100 v2] Advanced Error Reporting
               UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                       ECRC- UnsupReq- ACSViol- UncorrIntErr-
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                       PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
               UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP-
                       ECRC- UnsupReq- ACSViol- UncorrIntErr+
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                       PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
               UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+
                       ECRC- UnsupReq- ACSViol- UncorrIntErr+
BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
                       PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
               CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr- CorrIntErr- HeaderOF-
               CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr+ HeaderOF+
               AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
ECRCChkCap+ ECRCChkEn-
                       MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
               HeaderLog: 00000000 00000000 00000000 00000000
       Capabilities: [148 v1] Secondary PCI Express
               LnkCtl3: LnkEquIntrruptEn- PerformEqu-
               LaneErrStat: 0
       Capabilities: [158 v1] Transaction Processing Hints
               No steering table available
       Capabilities: [1e4 v1] Latency Tolerance Reporting
               Max snoop latency: 1048576ns
               Max no snoop latency: 1048576ns
       Capabilities: [1ec v1] L1 PM Substates
               L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
ASPM_L1.1+ L1_PM_Substates+
                         PortCommonModeRestoreTime=70us PortTPowerOnTime=0us
               L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
                          T_CommonMode=0us LTR1.2_Threshold=166912ns
               L1SubCtl2: T_PwrOn=90us
       Kernel driver in use: ath12k_pci
       Kernel modules: ath12k

root@walt-ROG-zephyrus:~# iw reg get
global
country US: DFS-FCC
        (902 - 904 @ 2), (N/A, 30), (N/A)
        (904 - 920 @ 16), (N/A, 30), (N/A)
        (920 - 928 @ 8), (N/A, 30), (N/A)
        (2400 - 2472 @ 40), (N/A, 30), (N/A)
        (5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
        (5250 - 5350 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
        (5470 - 5730 @ 160), (N/A, 24), (0 ms), DFS
        (5730 - 5850 @ 80), (N/A, 30), (N/A), AUTO-BW
        (5850 - 5895 @ 40), (N/A, 27), (N/A), NO-OUTDOOR, AUTO-BW, PASSIVE-SCAN
        (5925 - 7125 @ 320), (N/A, 12), (N/A), NO-OUTDOOR, PASSIVE-SCAN
        (57240 - 71000 @ 2160), (N/A, 40), (N/A)

phy#0 (self-managed)
country na: DFS-UNSET
        (2402 - 2472 @ 40), (N/A, 20), (N/A)
        (2457 - 2482 @ 20), (N/A, 20), (N/A), PASSIVE-SCAN
        (5170 - 5330 @ 160), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
        (5490 - 5730 @ 160), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
        (5735 - 5895 @ 160), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
        (5945 - 7125 @ 320), (N/A, 30), (N/A), AUTO-BW, PASSIVE-SCAN

