Return-Path: <linux-wireless+bounces-21099-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A0CA794BC
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 19:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0E23B494B
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Apr 2025 17:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3907A1DF994;
	Wed,  2 Apr 2025 17:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqRP8jvb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5519C542
	for <linux-wireless@vger.kernel.org>; Wed,  2 Apr 2025 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743616275; cv=none; b=hUbZvdLw2JZu0a9nsWpn4t3ZQ/BvXFksXANX2IfAqv9anx7uuz0D5IJuoYKLZVcSDFiz/Wyz7FztxBqzm1MeGa2fed05RNanSFLt7CKPPbZnnpMjkvvnk3nHw7J8QjtL9yGbThJVOd0jk/daWBNPkhvlSmuQU+lnBh0G/2snYHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743616275; c=relaxed/simple;
	bh=7YVfMsBEvoPI0ge7hr+6InV7uXyjxVtD0Ut4TfOKQr8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kpbwVxqC7ZGZZSByGaL9JgA/wACxvvEedhcDzBPMnx00MO+0/LD83bqPzEZXcYCdwZ7qvhafG72CO2B8m5HrHWGRD4FwYHWKlkuMkjpB0U+lf+uxbe7rUvJx6EHO6cjkZptQ5w6R3BYohzSfnlCA/T++dSJOEMAojMY1CGHfFtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqRP8jvb; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3913b539aabso48898f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 02 Apr 2025 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743616271; x=1744221071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88DKgZh+hbKmrBXZ9bz7zcaMZHz1U1BcV0zNz6QsSUk=;
        b=OqRP8jvb0G4bcUYngA9xqIahZJlR1xc7rGxaHuX9/c+fmFVlogUthWZlsuJfo8aGk6
         WD1t9ej3WFKfVk2vhXIFwKOKZVw2p+xvNnwTsNADvOrtA8P6InQs04DhZPhqPArd+OTG
         forftozW/h7WASryZUiIj9ScD0RiCtrrqjIfO8Qe2T3LOMs8OnJOBznM7/Jl9ztXP8JB
         nYQzv/FwwGZJiJH8Vql00SseoDIlIPCthzHnbQ90iWd0J64DpTEeKdxCte3YtTdMFkhw
         LNa6/IHFKWLsDWnMdwaJTaFOMj/i7fuLmRlyovj+0cg3uVa6nhyGhOvp52pU57oyzEkK
         3YHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743616271; x=1744221071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88DKgZh+hbKmrBXZ9bz7zcaMZHz1U1BcV0zNz6QsSUk=;
        b=QiVbm5O63CYf17/l3IuHB8fOlraF3IF9PVLaqqLVim/eJqm+MhIsamwPxeDv+rtfnM
         2daYA6kQwfpzzzOcDNd8cT8w882r6mO8BNsg+VVJ7PL2Bz2A+KYH3+LbBu9XWlHyi1oF
         SWmsfmpAAYyHzFyReSwQI/Hadpsk3ycbn3TOzjQX+8o5S0UrGB6OnshyqAe04qMC09HO
         cSpx5ocsW7+Pu0PmrQJTpJzFa6VztQurJa75L8os9sqPz+mdkMKpjl/eWcfwp7Wi4W5/
         X5CGi6pWy5pY5VClilF8L3fbSCA6J6KEnVxz99yf+ADa20oWPJBrlejWPyYUseCyX7tP
         YHNA==
X-Forwarded-Encrypted: i=1; AJvYcCXlYt/Ac68vO8O6YDXihZ8RvmmuJn4UBlrTR/7mo4QnqKQ6/l6DPzwUI5a0cMIyGklbuPgltJm/Mw/dObEKKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo6/JJDZd+DHouE1uVg0G2P6VmTfbVLFvXzgpGnn2BitH0GKTB
	EFojSDqRXms8YJRj/yjtTVKCiLrTZ40WaHaWrp81c1ViyOLLU+mkPa4pKWWv6RXuJ1qkG5JsFsS
	Vbn53uQBB8bWm1DnEFIAJH8iIyYY=
X-Gm-Gg: ASbGncvee1ulh2rRFSLpQuSxEFiiV+WVG8gS0jOnDgZNxSyfV84yWmX/oPlODjmSSPn
	kuDty0uGsILdwNqfUIAqEglM7g+Cl/tkdi1Ma51X+wo6G0bq9qit3bLSz21fu2V7JBm6vLrL/Nv
	Zw/uPUCV0F3gJE6nMdZBKAOas2
X-Google-Smtp-Source: AGHT+IF7Bxnij6eOzKakh4ZD23IxBFYpKtdGUfocBNUUc0cnlgTNdSmCu0odAAJocOjlPidWQQMir4/vHr+iq3fosws=
X-Received: by 2002:a05:6000:381:b0:39c:1f0a:ee0 with SMTP id
 ffacd0b85a97d-39c1f0a0f69mr8810844f8f.2.1743616271004; Wed, 02 Apr 2025
 10:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMb39_ngQs8=FUML5QXMh2RmEZBZ2NwUHefhGoTkGtHat+KWJA@mail.gmail.com>
 <f45323db-ce4d-4374-9c93-0be4d0645fcd@oss.qualcomm.com> <CAMb39_ki7F1XgezyVfb9Tkm9D-FZE0XK3RcSYtFmFf0jP8-M_Q@mail.gmail.com>
 <dc0abf98-862b-47f5-ae71-749c68cffc73@quicinc.com>
In-Reply-To: <dc0abf98-862b-47f5-ae71-749c68cffc73@quicinc.com>
From: Walt Holman <waltholman09@gmail.com>
Date: Wed, 2 Apr 2025 12:50:59 -0500
X-Gm-Features: AQ5f1JrdtxaAkq5bIKmbENCXzuYO6a-5yzjfw0l4A8Q9w8Rv0MC8NX73lQlYNE4
Message-ID: <CAMb39_kcv7QR5rw8Y=zaEd2gLNYbZVnjSBPNJdm0izQwoLPvZQ@mail.gmail.com>
Subject: Re: ath12k: No 6GHz Wireless found
To: Kang Yang <quic_kangyang@quicinc.com>
Cc: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, linux-wireless@vger.kernel.org, 
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Almost forgot. I've been running Kubuntu 24.10 until recently and am
now running the Beta of Kubuntu 25.04, which is the most recent
version available. My wpa_supplicant is built with 6Ghz support as I'm
running this OS on my other machines and both of them can connect to
my 6Ghz network. They are using different chipsets of course.

-Walt

On Tue, Apr 1, 2025 at 9:48=E2=80=AFPM Kang Yang <quic_kangyang@quicinc.com=
> wrote:
>
>
>
> On 4/2/2025 5:21 AM, Walt Holman wrote:
> > On Tue, Apr 1, 2025 at 1:53=E2=80=AFPM Jeff Johnson
> > <jeff.johnson@oss.qualcomm.com> wrote:
> >>
> >> On 3/30/2025 7:28 AM, Walt Holman wrote:
> >>> Hello,
> >>>
> >>> I have a wcn7850 hw2.0 based m.2 wireless card in my laptop and am
> >>> unable to see or connect to 6Ghz networks. I have an ASUS BE30000 wif=
i
> >>> router setup with a separate 6ghz only network, which my phone and
> >>> other laptops can connect to. I'm unable to even see this network on
> >>> this particular laptop. Months ago (maybe September), I could see it
> >>> occasionally, but now it never shows up. I'm using firmware from
> >>> git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware=
.git
> >>> and track the kernels pretty closely. I'm currently running 6.14.0
> >>> built from source. Any suggestions? Some HW info is below:
> >>>
> >>> 63:00.0 Network controller: Qualcomm Technologies, Inc WCN785x Wi-Fi
> >>> 7(802.11be) 320MHz 2x2 [FastConnect 7800
> >>> ] (rev 01)
> >>>         Subsystem: Quectel Wireless Solutions Co., Ltd. Device 8000
> >>>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> >>> ParErr- Stepping- SERR- FastB2B- DisINTx+
> >>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbo=
rt+
> >>> <TAbort- <MAbort- >SERR- <PERR- INTx-
> >>>         Latency: 0, Cache Line Size: 64 bytes
> >>>         Interrupt: pin ? routed to IRQ 111
> >>>         IOMMU group: 19
> >>>         Region 0: Memory at dd800000 (64-bit, non-prefetchable) [size=
=3D2M]
> >>>         Capabilities: [40] Power Management version 3
> >>>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> >>> PME(D0+,D1-,D2-,D3hot+,D3cold+)
> >>>                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0=
 PME-
> >>>         Capabilities: [50] MSI: Enable+ Count=3D16/32 Maskable+ 64bit=
-
> >>>                 Address: fee00000  Data: 0000
> >>>                 Masking: ffff8000  Pending: 00000000
> >>>         Capabilities: [70] Express (v2) Endpoint, IntMsgNum 0
> >>>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0=
s
> >>> unlimited, L1 unlimited
> >>>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLRese=
t-
> >>> SlotPowerLimit 75W TEE-IO-
> >>>                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
> >>>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
> >>>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
> >>>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> >>> AuxPwr+ TransPend-
> >>>                 LnkCap: Port #0, Speed 8GT/s, Width x2, ASPM L0s L1,
> >>> Exit Latency L0s <1us, L1 <64us
> >>>                         ClockPM- Surprise- LLActRep- BwNot- ASPMOptCo=
mp+
> >>>                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- Co=
mmClk+
> >>>                         ExtSynch+ ClockPM- AutWidDis- BWInt- AutBWInt=
-
> >>>                 LnkSta: Speed 8GT/s, Width x1 (downgraded)
> >>>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWM=
gmt-
> >>>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
> >>> NROPrPrP- LTR+
> >>>                          10BitTagComp- 10BitTagReq- OBFF Not Supporte=
d,
> >>> ExtFmt- EETLPPrefix-
> >>>                          EmergencyPowerReduction Not Supported,
> >>> EmergencyPowerReductionInit-
> >>>                          FRS- TPHComp+ ExtTPHComp-
> >>>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> >>>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis=
-
> >>>                          AtomicOpsCtl: ReqEn-
> >>>                          IDOReq- IDOCompl- LTR+ EmergencyPowerReducti=
onReq-
> >>>                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
> >>>                 LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink-
> >>> Retimer- 2Retimers- DRS-
> >>>                 LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- S=
peedDis-
> >>>                          Transmit Margin: Normal Operating Range,
> >>> EnterModifiedCompliance- ComplianceSOS-
> >>>                          Compliance Preset/De-emphasis: -6dB
> >>> de-emphasis, 0dB preshoot
> >>>                 LnkSta2: Current De-emphasis Level: -3.5dB,
> >>> EqualizationComplete+ EqualizationPhase1+
> >>>                          EqualizationPhase2+ EqualizationPhase3+
> >>> LinkEqualizationRequest-
> >>>                          Retimer- 2Retimers- CrosslinkRes: unsupporte=
d
> >>>         Capabilities: [100 v2] Advanced Error Reporting
> >>>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> >>> UnxCmplt- RxOF- MalfTLP-
> >>>                         ECRC- UnsupReq- ACSViol- UncorrIntErr-
> >>> BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
> >>>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> >>> MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> >>>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> >>> UnxCmplt- RxOF- MalfTLP-
> >>>                         ECRC- UnsupReq- ACSViol- UncorrIntErr+
> >>> BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
> >>>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> >>> MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> >>>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
> >>> UnxCmplt- RxOF+ MalfTLP+
> >>>                         ECRC- UnsupReq- ACSViol- UncorrIntErr+
> >>> BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
> >>>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> >>> MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> >>>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> >>> AdvNonFatalErr- CorrIntErr- HeaderOF-
> >>>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> >>> AdvNonFatalErr+ CorrIntErr+ HeaderOF+
> >>>                 AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenE=
n-
> >>> ECRCChkCap+ ECRCChkEn-
> >>>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrL=
ogCap-
> >>>                 HeaderLog: 00000000 00000000 00000000 00000000
> >>>         Capabilities: [148 v1] Secondary PCI Express
> >>>                 LnkCtl3: LnkEquIntrruptEn- PerformEqu-
> >>>                 LaneErrStat: 0
> >>>         Capabilities: [158 v1] Transaction Processing Hints
> >>>                 No steering table available
> >>>         Capabilities: [1e4 v1] Latency Tolerance Reporting
> >>>                 Max snoop latency: 1048576ns
> >>>                 Max no snoop latency: 1048576ns
> >>>         Capabilities: [1ec v1] L1 PM Substates
> >>>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> >>> ASPM_L1.1+ L1_PM_Substates+
> >>>                           PortCommonModeRestoreTime=3D70us PortTPower=
OnTime=3D0us
> >>>                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_=
L1.1+
> >>>                            T_CommonMode=3D0us LTR1.2_Threshold=3D1669=
12ns
> >>>                 L1SubCtl2: T_PwrOn=3D90us
> >>>         Kernel driver in use: ath12k_pci
> >>>         Kernel modules: ath12k
> >>>
> >>> root@walt-ROG-zephyrus:~# iw reg get
> >>> global
> >>> country US: DFS-FCC
> >>>          (902 - 904 @ 2), (N/A, 30), (N/A)
> >>>          (904 - 920 @ 16), (N/A, 30), (N/A)
> >>>          (920 - 928 @ 8), (N/A, 30), (N/A)
> >>>          (2400 - 2472 @ 40), (N/A, 30), (N/A)
> >>>          (5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
> >>>          (5250 - 5350 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
> >>>          (5470 - 5730 @ 160), (N/A, 24), (0 ms), DFS
> >>>          (5730 - 5850 @ 80), (N/A, 30), (N/A), AUTO-BW
> >>>          (5850 - 5895 @ 40), (N/A, 27), (N/A), NO-OUTDOOR, AUTO-BW, P=
ASSIVE-SCAN
> >>>          (5925 - 7125 @ 320), (N/A, 12), (N/A), NO-OUTDOOR, PASSIVE-S=
CAN
> >>>          (57240 - 71000 @ 2160), (N/A, 40), (N/A)
> >>>
> >>> phy#0 (self-managed)
> >>> country na: DFS-UNSET
> >>>          (2402 - 2472 @ 40), (N/A, 20), (N/A)
> >>>          (2457 - 2482 @ 20), (N/A, 20), (N/A), PASSIVE-SCAN
> >>>          (5170 - 5330 @ 160), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
> >>>          (5490 - 5730 @ 160), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
> >>>          (5735 - 5895 @ 160), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
> >>>          (5945 - 7125 @ 320), (N/A, 30), (N/A), AUTO-BW, PASSIVE-SCAN
> >>>
> >>
> >> I added the ath12k list to make sure this has the proper attention.
> >> Since you are building from source, can you please test with the follo=
wing patch:
> >> https://msgid.link/20250401020840.357-1-quic_kangyang@quicinc.com
> >>
> >> This is in my pending queue.
> >>
> >> /jeff
> >>
> >
> > Hi Jeff,
> >
> > No dice on the 6Ghz networks. It fixed up the registration info, but I
> > still don't see any 6Ghz networks. Even from an 'iw wlp99s0 scan'
> >
> > global
> > country US: DFS-FCC
> >         (902 - 904 @ 2), (N/A, 30), (N/A)
> >         (904 - 920 @ 16), (N/A, 30), (N/A)
> >         (920 - 928 @ 8), (N/A, 30), (N/A)
> >         (2400 - 2472 @ 40), (N/A, 30), (N/A)
> >         (5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
> >         (5250 - 5350 @ 80), (N/A, 24), (0 ms), DFS, AUTO-BW
> >         (5470 - 5730 @ 160), (N/A, 24), (0 ms), DFS
> >         (5730 - 5850 @ 80), (N/A, 30), (N/A), AUTO-BW
> >         (5850 - 5895 @ 40), (N/A, 27), (N/A), NO-OUTDOOR, AUTO-BW, PASS=
IVE-SCAN
> >         (5925 - 7125 @ 320), (N/A, 12), (N/A), NO-OUTDOOR, PASSIVE-SCAN
> >         (57240 - 71000 @ 2160), (N/A, 40), (N/A)
> >
> > phy#0 (self-managed)
> > country US: DFS-FCC
> >         (2402 - 2472 @ 40), (6, 30), (N/A)
> >         (5170 - 5250 @ 80), (6, 24), (N/A), AUTO-BW
> >         (5250 - 5330 @ 80), (6, 24), (0 ms), DFS, AUTO-BW
> >         (5490 - 5730 @ 160), (6, 24), (0 ms), DFS, AUTO-BW
> >         (5735 - 5855 @ 80), (6, 30), (N/A), AUTO-BW
> >         (5855 - 5925 @ 40), (6, 30), (N/A), NO-OUTDOOR, AUTO-BW
> >         (5925 - 7125 @ 320), (N/A, 30), (N/A), NO-OUTDOOR, AUTO-BW
> >
> >
>
> Test on 6.14.0-rc5-wt-ath+, with the firmware you used.
> I can get 6 GHz AP and connect to it.
>
> ath12k_pci 0000:03:00.0: fw_version 0x100301e1 fw_build_timestamp
> 2023-12-06 04:05 fw_build_id
> QC_IMAGE_VERSION_STRING=3DWLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILI=
CONZ-3
>
> yk@yk-Mayan:~$ sudo iw wls1 scan | tee iw_scan.log:
> BSS 62:03:7f:12:64:64(on wls1) -- associated
>          TSF: 606308271476 usec (7d, 00:25:08)
>          freq: 6275
>          beacon interval: 100 TUs
>          capability: ESS Privacy SpectrumMgmt ShortSlotTime (0x0511)
>          signal: -17.00 dBm
>          last seen: 52 ms ago
>          Information elements from Probe Response frame:
>          SSID: MLO-KANG-6G
> and other 6 GHz APs:
>         SSID: 6G-gxia
>         SSID: NETGEAR97-6G
>         =E2=80=A6=E2=80=A6
>
>
> kernel log:
> [88158.033218] wls1: Inserted STA 62:03:7f:12:64:64
> [88158.033232] wls1: authenticate with 62:03:7f:12:64:64 (local
> address=3D00:03:7f:37:12:54)
> [88158.033242] wls1: send auth to 62:03:7f:12:64:64 (try 1/3)
> [88158.041895] wls1: authenticated
> [88158.041914] wls1: moving STA 62:03:7f:12:64:64 to state 2
> [88158.044291] wls1: determined local STA to be EHT, BW limited to 320 MH=
z
> [88158.045719] wls1: associate with 62:03:7f:12:64:64 (try 1/3)
> [88158.067045] wls1: RX AssocResp from 62:03:7f:12:64:64 (capab=3D0x511
> status=3D0 aid=3D4)
> [88158.089090] wls1: associated
>
> I can even connect to it by Ubuntu GUI.
>
> Can you update to 6.14.0-rc5-wt-ath+ and have a retry? Also please make
> sure that your wpa_supplicant/iw support 6 GHz(or directly update to the
> latest version).
>
> If you still cannot find 6 GHz AP, you can set debug_mask to 0xffffffff
> to get ath12k logs. Then give it to us.
>
>
> > -Walt
> >
>

