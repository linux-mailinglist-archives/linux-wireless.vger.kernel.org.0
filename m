Return-Path: <linux-wireless+bounces-20421-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6755BA64338
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 08:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 700073A7CF3
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 07:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0452A21ADD1;
	Mon, 17 Mar 2025 07:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBf6zZWX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0EE21B18A;
	Mon, 17 Mar 2025 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742195888; cv=none; b=hiSBqjuwu47ix7PCPpLTde7q+9676oI7SymLSvN4rjGr7kTPP37VAa1J6wlwRb/5xmPdCdFU29clwgvWFmNVj2z3+Elq6kYa+ofkw6PrnM/me351Jm33/Si/YPUIlXIkqYQknBb0BbMN1ownIgNP/RWAQcSNaVzWmbCu60FiikM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742195888; c=relaxed/simple;
	bh=eHIwsN6Abmy3U973+5Mx78LBVNlGSdUy8PsUDtqGj9c=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gg58aH0OqfjEl8cuAXDG5KGRuxB4j2kypHkCki9XbPHQBSDxfS7a5SrwxVBSpzi9tV6qoYKiJZCRlqxytWbwVry+bCzZ/2S+ouJVF8MbE1RicBWfWDduVMLtawRAnklMzE1zBsFEMHb8rLBGfVG1+Ewun7zZ2qlGH0h0DMoonvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBf6zZWX; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-524125f6cadso2678854e0c.2;
        Mon, 17 Mar 2025 00:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742195886; x=1742800686; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AH2HYt2r1KmI4Zyzljw4+AJ7HTRk4dVIoYMbtEO/GLA=;
        b=YBf6zZWXJx4TRnrY4Cr3Hrviv6KLj1Xw3r3ei+29sV8sIG3ecRAUpgpCCxpK8oTGbQ
         CcPif+7+pfp2DbCelEl/eVZBKjx7y1PXZXjDagvR24uezB8eOy6kqnhlrTAbOOH2jNct
         CygLO6NeK1nJ/PmslOLOsMglDOKI4wl3GJ/uc9VynqIFzHMLX1SrZpGkMetzHlihBzA+
         8A61WoTqZFZs9hAU8xNkcuHRPnnZ7x8/gFfRz3yn4QR8fAPxmQL6BusSh81HkgJtrCK9
         DO8x4i3ITxUvtlg7L4bmKhjHEJ06TqKLFgEi2DCxYmOY6jUlf1+DEXFXgAiuTDJv0N+x
         UceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742195886; x=1742800686;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AH2HYt2r1KmI4Zyzljw4+AJ7HTRk4dVIoYMbtEO/GLA=;
        b=NrAUwE4oZJ82PcVNrgP7gehnALw9O1FsWFj1iUMmU5MPlmfh/Cr6d9saMcju2tLbei
         fBeEjBqK+taF6n0I7oUogSfkssboQTNWXkUMLtIxdmUR8JHf3L2D/v7hSew+QIe/3Dju
         MD0CMKOKyMlGShUCFMsUZsvqrzopNqx2jxWafLY2n2FjfDAQmkrZJdr05PH5KJ89IPC0
         G+XxJGNBSYtPz6miIwbUDYUByZp6qRblyOyfeMoUruOnVYcj0U9sHpIN1Dt/TZRn2PKY
         GSoqIB9yP8iij1hyrgUeK6384DQO9AT+L+uZIj8Y/jnylcC71LH6b4GM4my9H3SUgh8V
         Fiww==
X-Forwarded-Encrypted: i=1; AJvYcCUf51JWWp/uusOfgIubVpiSYA5i4/7J4u3M5n4Ick/NLWzqgyAermEHLHqkvREhAYWyHSL0+YCwz0ZTQ13kzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzBla1SLuhfQnEKY0SxA1vdgiccF5prs5TZ+yCauT0/2g9/p0O/
	q2/jqyBfB+KDb3ZDQk3pzlMPdd9WMg94U9ZID9DSEb9FJYqScpWB2Cs96mREP2TLXBcfEfyonka
	Pe4gKkw1QH+wwns61FOIfRM7jh8J6yK8K
X-Gm-Gg: ASbGncs9EmYnMjlsj++fN016vW00xLcNgtFmjp41WZ2fCSmDTw5IsQHKauY4dCIaWJG
	CJE53oi3lUuM3btuaxGxtDiq+ayqByYhzMQDs4Jm8vKrnApicM23/inxIUlMnX6yoPL+GiglrsN
	3OR9NcXrZkGM2kHPrPb4WX90Vc
X-Google-Smtp-Source: AGHT+IF5nZsXFhv0x61B5lLZXjl6XJjrC/v6qUzWhCh86DAF6p8MJWQClVaGlTKU9ceW3BS3KeHcYXv/y9g2Kt1b1BM=
X-Received: by 2002:a05:6122:660f:b0:520:60c2:3f3 with SMTP id
 71dfb90a1353d-524498ba1b1mr7539795e0c.4.1742195885927; Mon, 17 Mar 2025
 00:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?Q?Jean=2DFran=C3=A7ois_INGELAERE?= <masterprenium.lkml@gmail.com>
Date: Mon, 17 Mar 2025 08:17:55 +0100
X-Gm-Features: AQ5f1JqZ3sk5XcXTZKtYXvP9xiv1rrojiY1ZguEyPbjMkkVtcj7mBcZy314OqyQ
Message-ID: <CACr2tqv6ZsEt1heUKvYeSOT9joYqCFsepn6j8sqVO7ErhKvGeQ@mail.gmail.com>
Subject: Wireless speed regression issue with >6.12.12/6.13.x + firmware
 update for mediatek MT7925
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello guys,

I'm reporting an issue with Linux kernel >6.12.12 and 6.13.x with
mediatek 7925 serie Wi-Fi card. Reproducible ALWAYS.
I got a regression with newer firmware and kernel >6.12.12.
The regression seems to be between 6.12.12 and 6.12.13 (and ported to 6.13.x).
I'm having low speed connection and especially really bad Upload speed
(<4Mbit/s) while running in 802.11ax (better speed in 802.11ac), the
MIMO/channel width function seems to be linked with this issue.

Here are some speed reports & infos :

With 6.12.1 + firmware-202412x speed is correct (1Gbps/800Mbps)
With 6.12.12 + firmware-202412x speed is correct (1Gbps/800Mbps)
With 6.12.12 + firmware-202503x speed is NOT correct but between
acceptable and unacceptable (350Mbps/25Mbps)
With 6.12.13 + firmware-202412x speed is NOT correct but between
acceptable and unacceptable (280Mbps/80Mbps)
With 6.12.13 + firmware-202503x speed is unacceptable (280Mbps/3mbps)
With 6.12.13 + firmware-202503x BUT with only one Wi-Fi channel (here
ch 36) (See at the end of this message) ie 20Mhz channel width, I got
better upload speed than in wider channel width (80Mbps/30Mbps).



Kernel 6.13 +
Linux Firmware 202412 version.
[24305.691750] Loading firmware: mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin
[24305.695281] mt7925e 0000:73:00.0: ASIC revision: 79250000
[24305.772614] Loading firmware:
mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin
[24305.772732] mt7925e 0000:73:00.0: HW/SW Version: 0x8a108a10, Build
Time: 20241104132949a
[24306.121223] Loading firmware: mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin
[24306.121674] mt7925e 0000:73:00.0: WM Firmware Version: ____000000,
Build Time: 20241104133053
[24306.207593] Loading firmware: mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin
[24306.804659] mt7925e 0000:73:00.0 wlp115s0: renamed from wlan0


Linux-firmware >=202501, upload speed unacceptable (download quite the same) :
[23925.753738] Loading firmware: mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin
[23925.757066] mt7925e 0000:73:00.0: ASIC revision: 79250000
[23925.834400] Loading firmware:
mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin
[23925.834518] mt7925e 0000:73:00.0: HW/SW Version: 0x8a108a10, Build
Time: 20250113153001a
[23926.197786] Loading firmware: mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin
[23926.198160] mt7925e 0000:73:00.0: WM Firmware Version: ____000000,
Build Time: 20250113153106
[23926.281524] Loading firmware: mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin



lspci -vvvv
73:00.0 Network controller: MEDIATEK Corp. Device 7925
        Subsystem: AzureWave Device 6002
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 195
        IOMMU group: 25
        Region 0: Memory at 82200000 (64-bit, non-prefetchable) [size=2M]
        Region 2: Memory at 82400000 (64-bit, non-prefetchable) [size=32K]
        Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+
FLReset+ SlotPowerLimit 10W TEE-IO-
                DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                        RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
AuxPwr- TransPend-
                LnkCap: Port #1, Speed 5GT/s, Width x1, ASPM L0s L1,
Exit Latency L0s <2us, L1 <8us
                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 5GT/s, Width x1
                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
NROPrPrP- LTR+
                         10BitTagComp- 10BitTagReq- OBFF Not
Supported, ExtFmt+ EETLPPrefix-
                         EmergencyPowerReduction Not Supported,
EmergencyPowerReductionInit-
                         FRS- TPHComp- ExtTPHComp-
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
                         AtomicOpsCtl: ReqEn-
                         IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
                         10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
                LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink-
Retimer- 2Retimers- DRS-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance Preset/De-emphasis: -6dB
de-emphasis, 0dB preshoot
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete- EqualizationPhase1-
                         EqualizationPhase2- EqualizationPhase3-
LinkEqualizationRequest-
                         Retimer- 2Retimers- CrosslinkRes: unsupported
        Capabilities: [e0] MSI: Enable+ Count=1/32 Maskable+ 64bit+
                Address: 00000000fee54000  Data: 0022
                Masking: fffffffe  Pending: 00000000
        Capabilities: [f8] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [100 v1] Vendor Specific Information: ID=1556
Rev=1 Len=008 <?>
        Capabilities: [108 v1] Latency Tolerance Reporting
                Max snoop latency: 3145728ns
                Max no snoop latency: 3145728ns
        Capabilities: [110 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=3us PortTPowerOnTime=52us
                L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=0us LTR1.2_Threshold=118784ns
                L1SubCtl2: T_PwrOn=52us
        Capabilities: [200 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt-
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
AdvNonFatalErr+ CorrIntErr+ HeaderOF-
                AERCap: First Error Pointer: 0e, ECRCGenCap-
ECRCGenEn- ECRCChkCap- ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Kernel driver in use: mt7925e
        Kernel modules: mt7925e



The AP is a Cisco 9120AXI running in 160Mhz channel width @ (52, 56,
60, 64, 36, 40, 44, 48) channels (yes reported in this order, I think
it can mind) 52 is the primary one.
Also tested this setup with another cheap AP with channel in "correct"
order ? It can maybe be a little better but doesn't change a lot of
things.


The setup is the same as previously where I was able to get 1Gbit/s
Upload speed, just kernel & firmware update.

Any way to fix it ?
Best regards,

