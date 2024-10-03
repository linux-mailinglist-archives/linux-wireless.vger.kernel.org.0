Return-Path: <linux-wireless+bounces-13437-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECA198EA10
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 09:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3B1285FBA
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 07:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81E1824BD;
	Thu,  3 Oct 2024 07:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=justmail.de header.i=@justmail.de header.b="XEIp0zM+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout0.freenet.de (mout0.freenet.de [195.4.92.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6402B1DFFC
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 07:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.4.92.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727939243; cv=none; b=dfbV8ZtwwLIFQUd6z3zkFbLZ9tJMEe6hAzvxHe0t9RVQQWtMCxbfPCSci3f80fUNU/ef8xZ4/W1dYBLnYRABseMJKkmp57X4IrvA2lv/yHq077T/2OaYt0IAzB1FN3jGr+3iN5Cpi4l7Z/SHokSZGkXVKE7dJed/+FnGIzoI19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727939243; c=relaxed/simple;
	bh=Zn9PT31hhBFMjUjbpuzetawwx9mBi/Fa1vLnrxMOP0I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=kWBm0D/u39/LEX+VsVQK4C4hOmX8OWv8jFOw/ziQndp/Q/DZuTCTV+wi8Eo38hyhc6TpmMmHagLY1zL2nS25uLKj8bahUQhTpNhKwaiKJupL+27dkGUH9ZIuJ6M78LJfIDhb87KDKvbuv0n4IkH4yjGHqwq5ty1M5LG05Mw7Jxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justmail.de; spf=pass smtp.mailfrom=justmail.de; dkim=pass (2048-bit key) header.d=justmail.de header.i=@justmail.de header.b=XEIp0zM+; arc=none smtp.client-ip=195.4.92.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=justmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justmail.de
Received: from [195.4.92.121] (helo=sub2.freenet.de)
	by mout0.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.94.2 #2)
	id 1swFva-008U1J-HP
	for linux-wireless@vger.kernel.org; Thu, 03 Oct 2024 09:07:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=justmail.de
	; s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MxiNkK+OkvDwiFPUKxfd+mYllXIR4gPbc7JULfhsSGs=; b=XEIp0zM+0biQK6wJf1HWFM1b9f
	vbEgghff9RFJVKJgHF5gzhAc6UYcwRz7qXm7wgt/Ydg0IP3iqGHu1neL/mjYF0b9On8VjiKhC8Fk6
	tAyXO1HiPxTb3MeyfBIuwqGfFAsznY0+oTd9/62VEeAtKaEcK3vFCCs6CAoi9CFnv1PW81a1QLwcg
	avlwx1vTcsPV+pylrnY9kwUpoFH83VbX8i6pGWgZk92yKb0n2AkZPypyXFrFp0K+xY/yM/FO6ZQU1
	tHhPnLVmXl0nei3h/faCa8+HrUHUBQBfFx/pi9KkS6nOHDgd2B/l3X9K2Rx57gxn16ep2mRYL+hh0
	Jbj5+moQ==;
Received: from p200300de574fb600505400fffec9e1d1.dip0.t-ipconnect.de ([2003:de:574f:b600:5054:ff:fec9:e1d1]:49616 helo=mail.maya.org)
	by sub2.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLS1.2:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (port 465) (Exim 4.94.2 #2)
	id 1swFva-00HTrp-86
	for linux-wireless@vger.kernel.org; Thu, 03 Oct 2024 09:07:10 +0200
Received: internal info suppressed
Message-ID: <dd887468-2209-472f-a6dd-6c062ccbf133@justmail.de>
Date: Thu, 3 Oct 2024 09:07:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Klaus_M=C3=BCller?= <kmueller@justmail.de>
Subject: rtw89_8852be - timed out to flush queues
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Language: de-DE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-FN-MUUID: 1727939230B30650293C61O
X-Originated-At: 2003:de:574f:b600:5054:ff:fec9:e1d1!49616
X-Scan-TS: Thu, 03 Oct 2024 09:07:10 +0200

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
                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR+, 
OBFF Disabled
                          AtomicOpsCtl: ReqEn-
                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
                          Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
                          Compliance De-emphasis: -6dB
                 LnkSta2: Current De-emphasis Level: -3.5dB, 
EqualizationComplete-, EqualizationPhase1-
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

