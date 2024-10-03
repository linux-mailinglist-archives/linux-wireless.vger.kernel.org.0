Return-Path: <linux-wireless+bounces-13436-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAFE98EA0F
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 09:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94618B23C99
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 07:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B371DFFC;
	Thu,  3 Oct 2024 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="DVCsWygZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5226A126BE2
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939083; cv=none; b=aWQwjK5XcjqvjTgcky9yX6kKciSTgC61vN2qO/IKwmvIc7NJ8fi7Ir0m89+rH6c/ZjzG1OqDn/2lMjm8Be2UUQMdD68ZuoYl4Kb+UwaDa1QItqJak/nhS3x4WBKwtaozw3TEzaKPtYxTWW9aShY2SCL0XIsFHVs4Oz+C2oQvA3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939083; c=relaxed/simple;
	bh=iqIjlV6mJZ5T14cz1/CiJ9Jzq3NN4RoKxLM/4AXXPAM=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:Content-Type; b=aBvZV0/P/LcGGd/lA15Tpw1BChZSNxICnRckSo6k5k/KBoCR+qSCtXDXt3ExZ1BuCBbQckIVa0mJJ12JRf/yO5rnOXmshvvmx+fKmDBqAP90fGO9LBKSm9KKoBO4nIPC4E7wfRsojIpgGqZ7W5aJjifpP8Z6JrmCEzAd76u3eu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=DVCsWygZ; arc=none smtp.client-ip=195.4.92.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Received: from [195.4.92.123] (helo=sub4.freenet.de)
	by mout0.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1swFo9-008Iju-RN
	for linux-wireless@vger.kernel.org; Thu, 03 Oct 2024 08:59:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:Subject:To:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dG11QWLGff1rJ211Vbm24v4MWigpVrNzQiaFNdxHMJU=; b=DVCsWygZQofJ9VnrvEruFj3Hms
	JMm/LHlFpaFprNvnmT9OqBpau0kOHoU98/zthPQMH7rnxbDMOAMn8nuZ21Pd/5bKw98sV24jyoQ6K
	XAcjeIT6GCbOz2qD6WMVAG0DnJg8bnk8rAA0UsqnUdnc6CJFwhly44KptpWVRMM24ajGeIlteFoGk
	nwx3lh465R5X0P+eKlCahEnLjgrQ9w22We40ECfRjkbXsu7G34CkRCRE/JOkwT4EoidOjl0pZJVYu
	+fJWnm64KDgFvVQw49XUuOmy4HD6w5M6yl1m8/+t9FC9KrX+jlr/2nzMMuJ+CbYs2P0ewm8GQhk1y
	3u0iNU1A==;
Received: from p200300de574fb600505400fffec9e1d1.dip0.t-ipconnect.de ([2003:de:574f:b600:5054:ff:fec9:e1d1]:44450 helo=mail.maya.org)
	by sub4.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLS1.2:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1swFo9-004Tt1-IC
	for linux-wireless@vger.kernel.org; Thu, 03 Oct 2024 08:59:29 +0200
Received: internal info suppressed
Message-ID: <a6619735-a8a9-459e-bac9-c62adf6aeaf8@maya.org>
Date: Thu, 3 Oct 2024 08:59:27 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Andreas Hartmann <andihartmann@freenet.de>
Content-Language: de-DE, en-US
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: rtw89_8852be - timed out to flush queues
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FN-MUUID: 17279387695AB0308CA372O
X-Originated-At: 2003:de:574f:b600:5054:ff:fec9:e1d1!44450
X-Scan-TS: Thu, 03 Oct 2024 08:59:29 +0200

Hello dear developers of rtw89,

I have the following device:

0a:00.0 0280: 10ec:b852
        Subsystem: 1a3b:5471

0a:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8852BE PCIe 
802.11ax Wireless Network Controller
        Subsystem: AzureWave Device 5471
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- 
<MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 121
        Region 0: I/O ports at c000 [size=256]
        Region 2: Memory at 80200000 (64-bit, non-prefetchable) [size=1M]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=375mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
                Address: 00000000fee00000  Data: 0000
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 <64us
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset+ 
SlotPowerLimit 26.000W
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+ Unsupported+
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
                        MaxPayload 256 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit 
Latency L0s <4us, L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM L1 Enabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- 
BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR+, 
OBFF Via message/WAKE#
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, OBFF 
Disabled
                         AtomicOpsCtl: ReqEn-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB, EqualizationComplete-, 
EqualizationPhase1-
                         EqualizationPhase2-, EqualizationPhase3-, 
LinkEqualizationRequest-
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- 
MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ 
MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- 
ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [148 v1] Device Serial Number 00-e0-4c-
        Capabilities: [158 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
        Capabilities: [160 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+ 
L1_PM_Substates+
                          PortCommonModeRestoreTime=30us PortTPowerOnTime=60us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=0us LTR1.2_Threshold=284672ns
                L1SubCtl2: T_PwrOn=150us
        Kernel driver in use: rtw89_8852be
        Kernel modules: rtw89_8852be

It is part of an Asus Prime X670-P Wifi motherboard.


The module load (Linux 6.10.12) reports:

Oct 03 07:41:43 dualc kernel: rtw89_8852be 0000:0a:00.0: loaded firmware 
rtw89/rtw8852b_fw-1.bin
Oct 03 07:41:43 dualc kernel: rtw89_8852be 0000:0a:00.0: enabling device (0000 -> 
0003)
Oct 03 07:41:43 dualc kernel: rtw89_8852be 0000:0a:00.0: Firmware version 
0.29.29.1 (799134c3), cmd version 0, type 5
Oct 03 07:41:43 dualc kernel: rtw89_8852be 0000:0a:00.0: Firmware version 
0.29.29.1 (799134c3), cmd version 0, type 3
Oct 03 07:41:44 dualc kernel: rtw89_8852be 0000:0a:00.0: chip rfe_type is 1

I use it as an AP and I'm getting often entries like these:

rtw89_8852be 0000:0a:00.0: timed out to flush queues

I already tested lwfinger's rtw89 git repository but the behavior is the same. Do 
you have any idea how to fix the problem? I might do some tests for you if you 
like. The time out messages are really frequent!

I already detected some workarounds (disabling power saving, ...) but I prefer to 
get a solution.


Thanks for any hints
Klaus

