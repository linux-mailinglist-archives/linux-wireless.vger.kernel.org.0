Return-Path: <linux-wireless+bounces-18881-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C51A335FC
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 04:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CAA1667BD
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 03:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C1A1F8EEC;
	Thu, 13 Feb 2025 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IifczGco"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055B2B663;
	Thu, 13 Feb 2025 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739416593; cv=none; b=PyKh0k5egrXYPr/K0ePXnIqLCaB1efBd15Kv8EVyakn2Ug7QoF2gRLPU5/oPVswBaH+VvrtuumNf7p+zO9huNpH+GJmjQi0VrurfPkN4EykTgt1fpWwcvfSPRBGj0NFeSdivqT8xTgk9dIy8N5PkSSDotFnHrqHJCBrdtZPqN9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739416593; c=relaxed/simple;
	bh=w+ue8yT5egHgOjoifuxFRdlucbvuDyhz9p777AX3bQc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nOXMVWO7RJAwsJ+0j8yE1AQnatR4diZ22VjiKPl64G0gcqG9+/qZj3ttLqOlQVH89udPhoWm9AwDoo5P2hwzNqIy88DH3ax0YGwEJmNbSXXk8CwqXJcexBXkPQAnnJw7SzCNBQ8/5WyAyD8oFrWFe5fYNyCdKa6NVHqdFAqNles=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IifczGco; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-726ed359c56so387023a34.3;
        Wed, 12 Feb 2025 19:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739416591; x=1740021391; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=irI0jvMtJ/a9PT0otL3CiFOLhyUZ4L6k9X/uzgx1e7Q=;
        b=IifczGcopUR+ZTy38EfYNqnDipia/IOTSD9sMJA8BaAyypm8cnwHiyHPgDbr2E5Xhd
         C5FT5GTnLaOan3d34n83BkzLdreCOQFkt6D6hkgHmmqCWAFrpK9dfae+ksWvFhq6JdqX
         2Gtgm8Z75jYQBITb539c1T//hb118YT8tpoglf4okl+kJ/POW0spj19cZDSVtPU5vc8t
         fwPPO5Klh2rBTwkj8aC4qUks8UWqHLHQfb39xyrff6hW431+s9aw9KsBvHaWKT74Mjq1
         ACkx/lLhLGnedHhR0s5fMg1MuogTQubIIWVmohajYKIw4gEhOcjfHJ1LZx6nNaV+NWQ0
         1org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739416591; x=1740021391;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=irI0jvMtJ/a9PT0otL3CiFOLhyUZ4L6k9X/uzgx1e7Q=;
        b=TdZ5iF5ik379Z7/XPgZ0eTsVTVToZsGsMoblMnmHrDa/XGzcM25Tf8qdWAFuggJWfo
         O+J9ySshJ+TO7uCO912+Xo3zOmglyQrOvKeKJapolglS2BeFmNnLzLfx8uwh9nFXS6ER
         aKeFIWByhoic0krcAzCjjR5fxXIDOhzKaNPNTCi1m9ntclToXWAomWBsv5gr48tKq9ZC
         7cbkB7zktL9cMdsZZgcjrmV6lJyCpTC/zZzMqzBOIFix0kAqLhIDC0nemLd6emfTzwCu
         jO5xr3xVM2xEIg2p+7VgBCd1iDxURRkFWQrMYcPMJezecnn33pAPRdxitqtGDdsd5uO2
         /+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTttq7g/n/fP3EGg2jBNoaXJhErq0FJebhnhgZ3GnW/H1OqJFn7kpUxe62GKNvL+ZDxg8NA1c4lcoBSNPC8w==@vger.kernel.org, AJvYcCWDXxbjKl/vKIQaaCURdr/755Gphac3bPxOOHAk8ihmaFZbGw3SMfMf0JjkUtUyTEDKNvA05gbu@vger.kernel.org
X-Gm-Message-State: AOJu0YwP5IN72UM3pnR+IPjE/cXpMeCDJfYeusZQb6zVvOLA4jODUef5
	9rgcJYf0SIdyFdFPIXtqU++eT8jntT74XOTrGDQC1vXt9Ivt/bImIAbUipXWiv+bY3LtaySHC0f
	dqkMuSrFiuywk75YnhD6WeUycXqA=
X-Gm-Gg: ASbGncsIASlYmmwKZ42PSXoWHg2h07dRYqsoCMWyHEEBp2ENV060E/81nA7j2cWupcj
	fFP3kNWHjwRbxGyXVTKCVPLSMar0HQZbxUMkfi4C/P89JckiDPOX7e+lu4fQoSNe+NRXdpQjev2
	Y=
X-Google-Smtp-Source: AGHT+IHp/WHCq9cbrCOBnU/BGYyaESeCTfe0PT842/DW9bIfnxlKqi2pYB4x9wE3UTlR6RWxCtBnQ0SufIsKtHChdlE=
X-Received: by 2002:a05:6830:3c0d:b0:727:cf:aba9 with SMTP id
 46e09a7af769-72700cfaeeemr382838a34.9.1739416590863; Wed, 12 Feb 2025
 19:16:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Caleb Jorden <cjorden@gmail.com>
Date: Wed, 12 Feb 2025 21:16:20 -0600
X-Gm-Features: AWEUYZk6Jt5mlR468IIp6Q6DTN_LkGAl6xf-1zeWBX6wt0CxyRKCp7UihvmZ9fA
Message-ID: <CABD8wQ=pU9Yc45WE07FGO40MUBf+BSZFGcoO1ff7NxC1cXzx-A@mail.gmail.com>
Subject: [Stable Regression Bisected] Linux 6.13.2 breaks mt7925e
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Kalle Valo <kvalo@kernel.org>, Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, 
	linux-wireless@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello Kernel team,

I discovered that the 6.13.2 kernel breaks my laptop's wireless.  Here
are the details of my system:

- Framework 13 (AMD Ryzen 7840)
- mt7925e wireless card (purchased from: https://www.amazon.com/dp/B0DP68GV9V)
- Arch Linux, using IWD (3.3) to manage Wireless network connectivity

When running the 6.13.0 and 6.13.1 kernels (from Arch), the wireless
adapter worked very well.  I was able to associate to my Wifi 7
network (Ubiquiti U7 Pros) and operate in the 6GHz spectrum with
160MHz channels.  I also have an older wireless network that runs on
Google Nest routers.

When I upgraded to the 6.13.2 kernel from Arch Linux, my wireless
suddenly stopped working.  I looked at the kernel logs and saw these
messages (wireless addresses changed to make clearer the different
points):

[   10.007185] wlan0: authenticate with 28:80:xx:yy:zz:6e (local
address=40:1a:58:aa:bb:cc)
[   10.376446] wlan0: send auth to 28:80:xx:yy:zz:6e (try 1/3)
[   10.384610] wlan0: 28:80:xx:yy:zz:6e denied authentication (status 77)
[   10.483900] wlan0: authenticate with 28:80:xx:yy:zz:6e (local
address=40:1a:58:aa:bb:cc)
[   10.490138] wlan0: send auth to 28:80:xx:yy:zz:6e (try 1/3)
[   10.507531] wlan0: send auth to 28:80:xx:yy:zz:6e (try 2/3)
[   10.525580] wlan0: send auth to 28:80:xx:yy:zz:6e (try 3/3)
[   10.543048] wlan0: authentication with 28:80:xx:yy:zz:6e timed out
[   10.619423] wlan0: authenticate with 28:80:aa:bb:cc:e1 (local
address=40:1a:58:aa:bb:cc)
[   10.749880] wlan0: send auth to 28:80:aa:bb:cc:e1 (try 1/3)
[   10.768530] wlan0: send auth to 28:80:aa:bb:cc:e1 (try 2/3)
[   10.786954] wlan0: send auth to 28:80:aa:bb:cc:e1 (try 3/3)
[   10.805792] wlan0: authentication with 28:80:aa:bb:cc:e1 timed out
[   10.881620] wlan0: authenticate with 28:80:ee:ff:gg:6d (local
address=40:1a:58:aa:bb:cc)
[   11.016891] wlan0: send auth to 28:80:ee:ff:gg:6d (try 1/3)
[   11.033622] wlan0: send auth to 28:80:ee:ff:gg:6d (try 2/3)
[   11.050574] wlan0: send auth to 28:80:ee:ff:gg:6d (try 3/3)
[   11.065250] wlan0: authentication with 28:80:ee:ff:gg:6d timed out
[   11.139745] wlan0: authenticate with 2a:80:hh:ii:jj:6f (local
address=40:1a:58:aa:bb:cc)
[   11.506205] wlan0: send auth to 2a:80:hh:ii:jj:6f (try 1/3)
[   11.528071] wlan0: send auth to 2a:80:hh:ii:jj:6f (try 2/3)
[   11.550043] wlan0: send auth to 2a:80:hh:ii:jj:6f (try 3/3)
[   11.572005] wlan0: authentication with 2a:80:hh:ii:jj:6f timed out
[   16.312942] wlan0: authenticate with 2a:80:kk:ll:mm:e3 (local
address=40:1a:58:aa:bb:cc)
[   16.675865] wlan0: send auth to 2a:80:kk:ll:mm:e3 (try 1/3)
[   16.702328] wlan0: send auth to 2a:80:kk:ll:mm:e3 (try 2/3)
[   16.726162] wlan0: send auth to 2a:80:kk:ll:mm:e3 (try 3/3)
[   16.748958] wlan0: authentication with 2a:80:kk:ll:mm:e3 timed out
[   16.829874] wlan0: authenticate with 2a:80:nn:oo:pp:e2 (local
address=40:1a:58:aa:bb:cc)
[   17.196579] wlan0: send auth to 2a:80:nn:oo:pp:e2 (try 1/3)
[   17.214256] wlan0: send auth to 2a:80:nn:oo:pp:e2 (try 2/3)
[   17.231852] wlan0: send auth to 2a:80:nn:oo:pp:e2 (try 3/3)
[   17.250116] wlan0: authentication with 2a:80:nn:oo:pp:e2 timed out

Then IWD seems to have stopped attempting to associate for some time.
My wireless interface showed link down, and I had no IP address.  I
attempted to associate to my older Google Nest network, but that also
failed with the same behavior (thus showing the problem not to be Wifi
7 or Ubiquiti-specific).

I compiled up the mainline 6.13.2 kernel myself and saw the same behavior.

I then went back to the Arch 6.13.1 kernel, and the system operated
perfectly fine as expected.

I bisected the break to this commit:

$ git bisect good
c76fba3b07c7fb841c4f8f2acc0f01ff3cf73674 is the first bad commit
commit c76fba3b07c7fb841c4f8f2acc0f01ff3cf73674
Author: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Date:   Tue Dec 10 17:19:25 2024 -0800

    wifi: mt76: mt7925: Cleanup MLO settings post-disconnection

    [ Upstream commit 816161051a039eeb1226fc85e2b38389f508906c ]

    Clean up MLO settings after disconnection.

    Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the
firmware supports it")
    Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
    Signed-off-by: Sean Wang <sean.wang@mediatek.com>
    Link: https://patch.msgid.link/20241211011926.5002-16-sean.wang@kernel.org
    Signed-off-by: Felix Fietkau <nbd@nbd.name>
    Signed-off-by: Sasha Levin <sashal@kernel.org>

 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 37
+++++++++++++++++++++++++++++++++++--
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.h  |  2 +-
 3 files changed, 38 insertions(+), 5 deletions(-)

I attempted to revert this commit on top of 6.13.2, but there are
other commits that modify these files, so it can not be reverted by
itself.  I looked at the commit, and a thought occurred to me that
maybe wpa_supplicant might still function even though iwd did not.

I set up wpa_supplicant, and found that I was able to associate and
pass network traffic.  HOWEVER, when running a simple iperf3 test, saw
very slow speeds while associated (about 10 times slower than seen
with the 6.13.1 kernel).  Thus, I think this is quite clearly a
regression.  My guess is that this wireless adapter is new enough that
many people have yet to hit this.

Here are the details of the card:
# dmesg | grep mt79:
[   12.617246] mt7925e 0000:01:00.0: enabling device (0000 -> 0002)
[   12.622426] mt7925e 0000:01:00.0: ASIC revision: 79250000
[   12.698681] mt7925e 0000:01:00.0: HW/SW Version: 0x8a108a10, Build
Time: 20241104132949a
[   13.047884] mt7925e 0000:01:00.0: WM Firmware Version: ____000000,
Build Time: 20241104133053

# lspci -vvv (mediatek device):
01:00.0 Network controller: MEDIATEK Corp. Device 7925 (rev 01)
    Subsystem: Hewlett-Packard Company Device 8c38
    Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 116
    IOMMU group: 12
    Region 0: Memory at 90600000 (64-bit, non-prefetchable) [size=2M]
    Region 2: Memory at 90800000 (64-bit, non-prefetchable) [size=32K]
    Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
        DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
            ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
SlotPowerLimit 75W TEE-IO-
        DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
            RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
            MaxPayload 256 bytes, MaxReadReq 512 bytes
        DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
        LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
Latency L0s <2us, L1 <8us
            ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
        LnkCtl:    ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
            ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta:    Speed 5GT/s, Width x1
            TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
        DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR+
             10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+ EETLPPrefix-
             EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
             FRS- TPHComp- ExtTPHComp-
             AtomicOpsCap: 32bit- 64bit- 128bitCAS-
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
             AtomicOpsCtl: ReqEn-
             IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
             10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
        LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink- Retimer-
2Retimers- DRS-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
             Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
             Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
        LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete- EqualizationPhase1-
             EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
             Retimer- 2Retimers- CrosslinkRes: unsupported
    Capabilities: [e0] MSI: Enable+ Count=1/32 Maskable+ 64bit+
        Address: 00000000fee00000  Data: 0000
        Masking: fffffffe  Pending: 00000000
    Capabilities: [f8] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
    Capabilities: [100 v1] Vendor Specific Information: ID=1556 Rev=1
Len=008 <?>
    Capabilities: [108 v1] Latency Tolerance Reporting
        Max snoop latency: 1048576ns
        Max no snoop latency: 1048576ns
    Capabilities: [110 v1] L1 PM Substates
        L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
L1_PM_Substates+
              PortCommonModeRestoreTime=3us PortTPowerOnTime=52us
        L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
               T_CommonMode=0us LTR1.2_Threshold=166912ns
        L1SubCtl2: T_PwrOn=150us
    Capabilities: [200 v2] Advanced Error Reporting
        UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
            ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
            PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
        UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP-
            ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
            PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
        UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+
            ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
AtomicOpBlocked- TLPBlockedErr-
            PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
PCRC_CHECK- TLPXlatBlocked-
        CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr- HeaderOF-
        CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout-
AdvNonFatalErr+ CorrIntErr+ HeaderOF-
        AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
ECRCChkCap- ECRCChkEn-
            MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
        HeaderLog: 00000000 00000000 00000000 00000000
    Kernel driver in use: mt7925e
    Kernel modules: mt7925e

On my system, /etc/iwd/main.conf contains:
------------
[Scan]
DisablePeriodicScan=true

[General]
EnableNetworkConfiguration=true
Country=US
------------

At this point my suggestion is that the v6.13.2 mt7925 changes should
be reverted from the stable series for now, unless a fix can be
quickly found.  I have not yet tested 6.14-rc2, but would be willing
to do so if it would be helpful.

Note: I am not subscribed to any of these lists, so please CC me if
you want to contact me about this.

Respectfully submitted,
Caleb Jorden
cjorden@gmail.com

