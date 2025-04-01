Return-Path: <linux-wireless+bounces-21039-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39077A783F5
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 23:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC6116DEA5
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Apr 2025 21:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58A82139C8;
	Tue,  1 Apr 2025 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EoIu4Rdl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4F1214221
	for <linux-wireless@vger.kernel.org>; Tue,  1 Apr 2025 21:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743542482; cv=none; b=DFTV9aqxpY9TL6Leom7D+gTA89FkBtk4668zOOOHLrHYqhU66H7RuyTNhsI3ZfrYV/LFYDAPJR8dOaUPmLlNRmezgj3NlcYAppOJcwwNVF61P7E7yGm/szoFQWYuGi/I5r4Iak7lomyRRcoB9TlI8CSAR1Z9yOL6u9Z8SvsquX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743542482; c=relaxed/simple;
	bh=fjL77kuEdHcuLTeYe1hCvEFq7n5ZZT/HvuHO9COpgtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abD6pk6glkLW2ZfYzrIX1N7GqFq2OfrXwU3D6SCXO/09n/KNk8srmh24lz/JjS8wsrQMB429bwm5/bpKv5Bzrg3SEcYcgjt+zuFkwbXG/WR7FDEohNxKvNmkKX75vffX3CV8gPUwvNQJ1ZHqZP+rHrytFajL/3gpEJ7eg1wVf3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EoIu4Rdl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso40205345e9.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Apr 2025 14:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743542479; x=1744147279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=brQMt7KRwFhUPNaYkRwQiw3naGxlWQjOv0I1qKaBsaM=;
        b=EoIu4Rdly+6jUiuFNxLpTikosBq/qsHGTzVCZ/vKXZvAdeGEnEEp3KQhdy5Gpi9M8W
         9JLfEvqAyEg6o4Y/i7ArYkE//34B4FJpkkOqgwuGLpjxIVs3ysDHAZ2BWlFoDGttXYLl
         tI5A6561ZvcsIzKIp8gxJYmAAUNZ8iQ/0O+pbbl9POEoV/ZcrA4iwIbKN/S9yTOok+jw
         1pMDFIQuNkWw958xi1zbusVvRYTPqkgS5c245+T1EFkmg3N29KfLEZXsX9h8rHzsy96i
         5OSaqCCcL9ay/RwmVzRwpTbuZDwPY5mqz8WJ0grtvbu2AdzqMgwj58LLAGYOuTkljhAb
         zadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743542479; x=1744147279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=brQMt7KRwFhUPNaYkRwQiw3naGxlWQjOv0I1qKaBsaM=;
        b=wqa+RUg0gyyolhzziD7Atvey3L2q1AZBKFS7bhUIOq59gywecq5SAs2+xUFhvEqwyb
         gK/83XILfKsiFfeBoULPw9KjVGmgiQAAmpneSZJaZxEfag7CMex/tC8TL7Dlq6b2NRma
         JAIl6rBa3+pV7HzVY2WFzZRGyxqi1sLisH4murPOvFswdrlO5gpt9nb1tBFnTVAPKMVn
         rDqVUbZGU0Y05LDFoDX5f070W1CNY75DX+x9IiwFBKslli/jp+sNgtPEY7MhJZFPGKF9
         gP6lt3Akf48NriJ9H5YgOq6EzhfGgjA31vSYJWucwpAIXIQ2vmr2l4yOBZQ/Zvhwf7jp
         WG1A==
X-Gm-Message-State: AOJu0Yw440ZYP05hWHBiR7jvznnK03eeGzVv2KR9GqGGRSf2wPYNYuI8
	R+9nh7OxbAeZUYRsm26gJuaoKr+p5rCgZNWdyXUJDu4rPA9csouUs0RgA1YfRDi9o4D1URAlfkf
	W+nWF7K/FDO8a/23L42WInSRD3ocY4YCE
X-Gm-Gg: ASbGncvJMFVUHpDH3BNNrv6RB6jc91vuacPrdceuR8s5OJhzMUeCU30MKvwgO0Hj0ds
	Pe428yaVqwmxqY6Qn96ZcFKlJRrz98wgqZ3UPSABdjloIByLE5M1eMQRom+1+r4nwsL6JsHScwK
	9mDIWA826WVs5tIKntBynF81WW
X-Google-Smtp-Source: AGHT+IHdXNWd5eq30kJsTbsYWSieLZ5+j2awy73MHQEiOTSgKk1nYM59UJcyKmdI1traddMuHFFbUC155pHv7hgQpG4=
X-Received: by 2002:a05:600c:138d:b0:43c:f44c:72b7 with SMTP id
 5b1f17b1804b1-43db61ff68bmr147565705e9.14.1743542478516; Tue, 01 Apr 2025
 14:21:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMb39_ngQs8=FUML5QXMh2RmEZBZ2NwUHefhGoTkGtHat+KWJA@mail.gmail.com>
 <f45323db-ce4d-4374-9c93-0be4d0645fcd@oss.qualcomm.com>
In-Reply-To: <f45323db-ce4d-4374-9c93-0be4d0645fcd@oss.qualcomm.com>
From: Walt Holman <waltholman09@gmail.com>
Date: Tue, 1 Apr 2025 16:21:07 -0500
X-Gm-Features: AQ5f1JoSZf-yy1EmaTbK8BPUbzxITVZm8Kp_D6XmMMWHmn5GIZ4NzT5J0_vT_mY
Message-ID: <CAMb39_ki7F1XgezyVfb9Tkm9D-FZE0XK3RcSYtFmFf0jP8-M_Q@mail.gmail.com>
Subject: Re: ath12k: No 6GHz Wireless found
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, 
	"ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 1:53=E2=80=AFPM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 3/30/2025 7:28 AM, Walt Holman wrote:
> > Hello,
> >
> > I have a wcn7850 hw2.0 based m.2 wireless card in my laptop and am
> > unable to see or connect to 6Ghz networks. I have an ASUS BE30000 wifi
> > router setup with a separate 6ghz only network, which my phone and
> > other laptops can connect to. I'm unable to even see this network on
> > this particular laptop. Months ago (maybe September), I could see it
> > occasionally, but now it never shows up. I'm using firmware from
> > git://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.g=
it
> > and track the kernels pretty closely. I'm currently running 6.14.0
> > built from source. Any suggestions? Some HW info is below:
> >
> > 63:00.0 Network controller: Qualcomm Technologies, Inc WCN785x Wi-Fi
> > 7(802.11be) 320MHz 2x2 [FastConnect 7800
> > ] (rev 01)
> >        Subsystem: Quectel Wireless Solutions Co., Ltd. Device 8000
> >        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B- DisINTx+
> >        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort+
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> >        Latency: 0, Cache Line Size: 64 bytes
> >        Interrupt: pin ? routed to IRQ 111
> >        IOMMU group: 19
> >        Region 0: Memory at dd800000 (64-bit, non-prefetchable) [size=3D=
2M]
> >        Capabilities: [40] Power Management version 3
> >                Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> >                Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PM=
E-
> >        Capabilities: [50] MSI: Enable+ Count=3D16/32 Maskable+ 64bit-
> >                Address: fee00000  Data: 0000
> >                Masking: ffff8000  Pending: 00000000
> >        Capabilities: [70] Express (v2) Endpoint, IntMsgNum 0
> >                DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s
> > unlimited, L1 unlimited
> >                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
> > SlotPowerLimit 75W TEE-IO-
> >                DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
> >                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
> >                        MaxPayload 128 bytes, MaxReadReq 512 bytes
> >                DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq-
> > AuxPwr+ TransPend-
> >                LnkCap: Port #0, Speed 8GT/s, Width x2, ASPM L0s L1,
> > Exit Latency L0s <1us, L1 <64us
> >                        ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
> >                LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommC=
lk+
> >                        ExtSynch+ ClockPM- AutWidDis- BWInt- AutBWInt-
> >                LnkSta: Speed 8GT/s, Width x1 (downgraded)
> >                        TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt=
-
> >                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
> > NROPrPrP- LTR+
> >                         10BitTagComp- 10BitTagReq- OBFF Not Supported,
> > ExtFmt- EETLPPrefix-
> >                         EmergencyPowerReduction Not Supported,
> > EmergencyPowerReductionInit-
> >                         FRS- TPHComp+ ExtTPHComp-
> >                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> >                DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> >                         AtomicOpsCtl: ReqEn-
> >                         IDOReq- IDOCompl- LTR+ EmergencyPowerReductionR=
eq-
> >                         10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
> >                LnkCap2: Supported Link Speeds: 2.5-8GT/s, Crosslink-
> > Retimer- 2Retimers- DRS-
> >                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- Spee=
dDis-
> >                         Transmit Margin: Normal Operating Range,
> > EnterModifiedCompliance- ComplianceSOS-
> >                         Compliance Preset/De-emphasis: -6dB
> > de-emphasis, 0dB preshoot
> >                LnkSta2: Current De-emphasis Level: -3.5dB,
> > EqualizationComplete+ EqualizationPhase1+
> >                         EqualizationPhase2+ EqualizationPhase3+
> > LinkEqualizationRequest-
> >                         Retimer- 2Retimers- CrosslinkRes: unsupported
> >        Capabilities: [100 v2] Advanced Error Reporting
> >                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF- MalfTLP-
> >                        ECRC- UnsupReq- ACSViol- UncorrIntErr-
> > BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
> >                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> > MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> >                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF- MalfTLP-
> >                        ECRC- UnsupReq- ACSViol- UncorrIntErr+
> > BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
> >                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> > MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> >                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
> > UnxCmplt- RxOF+ MalfTLP+
> >                        ECRC- UnsupReq- ACSViol- UncorrIntErr+
> > BlockedTLP- AtomicOpBlocked- TLPBlockedErr-
> >                        PoisonTLPBlocked- DMWrReqBlocked- IDECheck-
> > MisIDETLP- PCRC_CHECK- TLPXlatBlocked-
> >                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> > AdvNonFatalErr- CorrIntErr- HeaderOF-
> >                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> > AdvNonFatalErr+ CorrIntErr+ HeaderOF+
> >                AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn-
> > ECRCChkCap+ ECRCChkEn-
> >                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogC=
ap-
> >                HeaderLog: 00000000 00000000 00000000 00000000
> >        Capabilities: [148 v1] Secondary PCI Express
> >                LnkCtl3: LnkEquIntrruptEn- PerformEqu-
> >                LaneErrStat: 0
> >        Capabilities: [158 v1] Transaction Processing Hints
> >                No steering table available
> >        Capabilities: [1e4 v1] Latency Tolerance Reporting
> >                Max snoop latency: 1048576ns
> >                Max no snoop latency: 1048576ns
> >        Capabilities: [1ec v1] L1 PM Substates
> >                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
> > ASPM_L1.1+ L1_PM_Substates+
> >                          PortCommonModeRestoreTime=3D70us PortTPowerOnT=
ime=3D0us
> >                L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.=
1+
> >                           T_CommonMode=3D0us LTR1.2_Threshold=3D166912n=
s
> >                L1SubCtl2: T_PwrOn=3D90us
> >        Kernel driver in use: ath12k_pci
> >        Kernel modules: ath12k
> >
> > root@walt-ROG-zephyrus:~# iw reg get
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
> > country na: DFS-UNSET
> >         (2402 - 2472 @ 40), (N/A, 20), (N/A)
> >         (2457 - 2482 @ 20), (N/A, 20), (N/A), PASSIVE-SCAN
> >         (5170 - 5330 @ 160), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
> >         (5490 - 5730 @ 160), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
> >         (5735 - 5895 @ 160), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
> >         (5945 - 7125 @ 320), (N/A, 30), (N/A), AUTO-BW, PASSIVE-SCAN
> >
>
> I added the ath12k list to make sure this has the proper attention.
> Since you are building from source, can you please test with the followin=
g patch:
> https://msgid.link/20250401020840.357-1-quic_kangyang@quicinc.com
>
> This is in my pending queue.
>
> /jeff
>

Hi Jeff,

No dice on the 6Ghz networks. It fixed up the registration info, but I
still don't see any 6Ghz networks. Even from an 'iw wlp99s0 scan'

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
       (5850 - 5895 @ 40), (N/A, 27), (N/A), NO-OUTDOOR, AUTO-BW, PASSIVE-S=
CAN
       (5925 - 7125 @ 320), (N/A, 12), (N/A), NO-OUTDOOR, PASSIVE-SCAN
       (57240 - 71000 @ 2160), (N/A, 40), (N/A)

phy#0 (self-managed)
country US: DFS-FCC
       (2402 - 2472 @ 40), (6, 30), (N/A)
       (5170 - 5250 @ 80), (6, 24), (N/A), AUTO-BW
       (5250 - 5330 @ 80), (6, 24), (0 ms), DFS, AUTO-BW
       (5490 - 5730 @ 160), (6, 24), (0 ms), DFS, AUTO-BW
       (5735 - 5855 @ 80), (6, 30), (N/A), AUTO-BW
       (5855 - 5925 @ 40), (6, 30), (N/A), NO-OUTDOOR, AUTO-BW
       (5925 - 7125 @ 320), (N/A, 30), (N/A), NO-OUTDOOR, AUTO-BW


-Walt

