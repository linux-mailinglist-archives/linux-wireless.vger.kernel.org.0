Return-Path: <linux-wireless+bounces-18885-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1031CA33664
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 04:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71C1A188539E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 03:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C89178F39;
	Thu, 13 Feb 2025 03:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrbvYYli"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AC3537E5;
	Thu, 13 Feb 2025 03:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739418669; cv=none; b=uULfWw1wvrT/j7ghjNMC1hRW+Z1HAKeN6cXqrmQiYKmPQI1HzSlTwgHWApRSUdq2LZUmGZJYBBVh21Kh/ET+x6n1cA9jdN1pIoUFHZ7ZPbtiUcpbzj8ylunSuFSAK+IGK6m7sCV86RQdke1Noy3D9UhDIm3aUbpz/sRTqsVtfdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739418669; c=relaxed/simple;
	bh=lYdRUTjdGUMGBjq5Het7Fpx6Vr+r9CEUM7q8eqAwPh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DA+y8zW2Oq62FWKTHpmpiw/A/cZO2kHmRTLPsJvhPU1nCBy4A3lIMundOBHwAYn5B3NAbH2ANRuxYHhX+fE4JsVTD5lCtgX7UIBSY6T9oAHBdIR54w/A6QomvTtoZT1JYcfpxjg6u22M7rME1plvYepOaYMq7Oc+/pipMhDmZ/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrbvYYli; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2b840a0cad9so248534fac.3;
        Wed, 12 Feb 2025 19:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739418666; x=1740023466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8bRWl1MFRCch+jKLduWB5KUQ2cIuUsuLsVsCHPOgJA=;
        b=LrbvYYlinrXzLLVXDVggatCcMcIvju6GFscrzUlVb6XM5lbfELPR+MHS9UjDiHJTqa
         Y5mLXETlr77uiiP/dmShv22O6a0/XkH5gdLYcnhVhng3M+enpHEaPHpg77JNj29/nhli
         AmK8F2iCBJS/W8UA2nIZo7us0vrVKk75rTQdY170x0onVWwqY5J9PSiAIGh1CwLGoEz8
         W6nydB7xu+VreEDKu8bpvcl0Mgeq8yzwYnkpCZmKx8Ncy10hHkyo0wNw9xF+znv/VMx5
         u5n8G0zNVNo7DbrJcFxWxtAWaZM71yv3mS1PusPvwzlg96pUV16uM6mH+hlo3JOhUdfm
         otng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739418666; x=1740023466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8bRWl1MFRCch+jKLduWB5KUQ2cIuUsuLsVsCHPOgJA=;
        b=cSgORxh7D1Ev7IyrvOOFGCSyJpcXs4hxc4TXxzPoci/KHxK2H5qptYQDrAFmNlN/K+
         P2K8Zi7tePe+WMqMoGKM07iVp5PglXvQ2Q/3Un9Ybad6PhZmTMhzjVEZE6PQ+nyHU0k4
         jAh93AkgJYFTapA1QAK5jZrkZZMdgAI2CnkcxxDUHuW0XgZqDo+d5slf+fyalq5YrDdL
         oetyh3MEMvrPBziVmWRDcVf7CredXimX9oZlxlOuT3m1VsypI2C3UDeSa2STH33gd2Bo
         u3oGQO1yXN6QNiq4rhbifwdq8Ige0x5H7mwG5cPb7Zv6gwbeiIqMTDSsMH3K5O4mx6Hm
         cyMA==
X-Forwarded-Encrypted: i=1; AJvYcCXD04qiN02LCHYsqtGAuZbnA0AlDpTC/X7LrYDlUko8KAly/6JUHXDVqJzs61MowhlTkyw8Z06Bdx9yI3k6AQ==@vger.kernel.org, AJvYcCXHtHt0/2+VNEfGmnewsM+904W0LdEe85OQKKO70SFJnKl78xNZ1+5SzfD8tvhpzQIwDd5QtiHW@vger.kernel.org
X-Gm-Message-State: AOJu0YwlqMRdmOp5Pvm/yr3fUlEcXfgpaZBNtFQy9zmrPnNS7KdpaoyK
	LUCIVZA4d1bVtctZfF044N++pLXFmq/0ECO6vAg5Ecu+gVi8NPlDSifSViVpyJKxat24d+s7W4T
	Klus3WK2dbnrq7K/ZjItfkXaP5vs=
X-Gm-Gg: ASbGnctYfy3oJRiO5ZepABWbHJECDM/BLTHqd35uDUesfh72Cu5NkyNT1bJCh4IR1Ce
	Dw4B7yY8F8u/3FS//vyQZiDmzuLB8U6krfbiGzIwrY8RZWG5ewIV/hk/rKlQLnfIHFeTUACudJC
	E=
X-Google-Smtp-Source: AGHT+IEnggEurBCIRYUHoIdlwIqlX7394b0OjI/Xp1ZSVj9a/xsDaD6/hhOcnhnZ23pTuUTZ/RucN501Eubf1QB/B5c=
X-Received: by 2002:a05:6871:10a:b0:296:7b65:2fac with SMTP id
 586e51a60fabf-2b8d64795admr3572777fac.3.1739418666064; Wed, 12 Feb 2025
 19:51:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABD8wQ=pU9Yc45WE07FGO40MUBf+BSZFGcoO1ff7NxC1cXzx-A@mail.gmail.com>
 <d4c5d4f6f47d4d926c7a2469cb4b85c0850945ab.camel@mediatek.com>
In-Reply-To: <d4c5d4f6f47d4d926c7a2469cb4b85c0850945ab.camel@mediatek.com>
From: Caleb Jorden <cjorden@gmail.com>
Date: Wed, 12 Feb 2025 21:50:55 -0600
X-Gm-Features: AWEUYZkHEjZ3pRQlsHQQr8BZqe8Ry-e5VuSOVOZjNiHBNslrAv4BEHZXFjzHA-U
Message-ID: <CABD8wQ=K=xa4+KoEWuQNaMRP7A8fVY38ShyfW3DLcwVcU8R2aA@mail.gmail.com>
Subject: Re: [Stable Regression Bisected] Linux 6.13.2 breaks mt7925e
To: =?UTF-8?B?TWluZ3llbiBIc2llaCAo6Kyd5piO6Ku6KQ==?= <Mingyen.Hsieh@mediatek.com>
Cc: =?UTF-8?B?U2hheW5lIENoZW4gKOmZs+i7kuS4nik=?= <Shayne.Chen@mediatek.com>, 
	"lorenzo@kernel.org" <lorenzo@kernel.org>, Ryder Lee <Ryder.Lee@mediatek.com>, 
	"nbd@nbd.name" <nbd@nbd.name>, "kvalo@kernel.org" <kvalo@kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Sean Wang <Sean.Wang@mediatek.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, =?UTF-8?B?QWxsYW4gV2FuZyAo546L5a625YGJKQ==?= <Allan.Wang@mediatek.com>, 
	=?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 9:43=E2=80=AFPM Mingyen Hsieh (=E8=AC=9D=E6=98=8E=
=E8=AB=BA)
<Mingyen.Hsieh@mediatek.com> wrote:
>
> On Wed, 2025-02-12 at 21:16 -0600, Caleb Jorden wrote:
> >
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >
> >
> > Hello Kernel team,
> >
> > I discovered that the 6.13.2 kernel breaks my laptop's wireless.
> > Here
> > are the details of my system:
> >
> > - Framework 13 (AMD Ryzen 7840)
> > - mt7925e wireless card (purchased from:
> > https://urldefense.com/v3/__https://www.amazon.com/dp/B0DP68GV9V__;!!
> > CTRNKA9wMg0ARbw!nB_7DXY8l5AYSvgN3AMFpJZOJVng1dxSh_2yZLKT8S8DkDEwjaGvl
> > cmALUeik84J7ePLJnvOe-2oNQ7dxCM$ )
> > - Arch Linux, using IWD (3.3) to manage Wireless network connectivity
> >
> > When running the 6.13.0 and 6.13.1 kernels (from Arch), the wireless
> > adapter worked very well.  I was able to associate to my Wifi 7
> > network (Ubiquiti U7 Pros) and operate in the 6GHz spectrum with
> > 160MHz channels.  I also have an older wireless network that runs on
> > Google Nest routers.
> >
> > When I upgraded to the 6.13.2 kernel from Arch Linux, my wireless
> > suddenly stopped working.  I looked at the kernel logs and saw these
> > messages (wireless addresses changed to make clearer the different
> > points):
> >
> > [   10.007185] wlan0: authenticate with 28:80:xx:yy:zz:6e (local
> > address=3D40:1a:58:aa:bb:cc)
> > [   10.376446] wlan0: send auth to 28:80:xx:yy:zz:6e (try 1/3)
> > [   10.384610] wlan0: 28:80:xx:yy:zz:6e denied authentication (status
> > 77)
> > [   10.483900] wlan0: authenticate with 28:80:xx:yy:zz:6e (local
> > address=3D40:1a:58:aa:bb:cc)
> > [   10.490138] wlan0: send auth to 28:80:xx:yy:zz:6e (try 1/3)
> > [   10.507531] wlan0: send auth to 28:80:xx:yy:zz:6e (try 2/3)
> > [   10.525580] wlan0: send auth to 28:80:xx:yy:zz:6e (try 3/3)
> > [   10.543048] wlan0: authentication with 28:80:xx:yy:zz:6e timed out
> > [   10.619423] wlan0: authenticate with 28:80:aa:bb:cc:e1 (local
> > address=3D40:1a:58:aa:bb:cc)
> > [   10.749880] wlan0: send auth to 28:80:aa:bb:cc:e1 (try 1/3)
> > [   10.768530] wlan0: send auth to 28:80:aa:bb:cc:e1 (try 2/3)
> > [   10.786954] wlan0: send auth to 28:80:aa:bb:cc:e1 (try 3/3)
> > [   10.805792] wlan0: authentication with 28:80:aa:bb:cc:e1 timed out
> > [   10.881620] wlan0: authenticate with 28:80:ee:ff:gg:6d (local
> > address=3D40:1a:58:aa:bb:cc)
> > [   11.016891] wlan0: send auth to 28:80:ee:ff:gg:6d (try 1/3)
> > [   11.033622] wlan0: send auth to 28:80:ee:ff:gg:6d (try 2/3)
> > [   11.050574] wlan0: send auth to 28:80:ee:ff:gg:6d (try 3/3)
> > [   11.065250] wlan0: authentication with 28:80:ee:ff:gg:6d timed out
> > [   11.139745] wlan0: authenticate with 2a:80:hh:ii:jj:6f (local
> > address=3D40:1a:58:aa:bb:cc)
> > [   11.506205] wlan0: send auth to 2a:80:hh:ii:jj:6f (try 1/3)
> > [   11.528071] wlan0: send auth to 2a:80:hh:ii:jj:6f (try 2/3)
> > [   11.550043] wlan0: send auth to 2a:80:hh:ii:jj:6f (try 3/3)
> > [   11.572005] wlan0: authentication with 2a:80:hh:ii:jj:6f timed out
> > [   16.312942] wlan0: authenticate with 2a:80:kk:ll:mm:e3 (local
> > address=3D40:1a:58:aa:bb:cc)
> > [   16.675865] wlan0: send auth to 2a:80:kk:ll:mm:e3 (try 1/3)
> > [   16.702328] wlan0: send auth to 2a:80:kk:ll:mm:e3 (try 2/3)
> > [   16.726162] wlan0: send auth to 2a:80:kk:ll:mm:e3 (try 3/3)
> > [   16.748958] wlan0: authentication with 2a:80:kk:ll:mm:e3 timed out
> > [   16.829874] wlan0: authenticate with 2a:80:nn:oo:pp:e2 (local
> > address=3D40:1a:58:aa:bb:cc)
> > [   17.196579] wlan0: send auth to 2a:80:nn:oo:pp:e2 (try 1/3)
> > [   17.214256] wlan0: send auth to 2a:80:nn:oo:pp:e2 (try 2/3)
> > [   17.231852] wlan0: send auth to 2a:80:nn:oo:pp:e2 (try 3/3)
> > [   17.250116] wlan0: authentication with 2a:80:nn:oo:pp:e2 timed out
> >
> > Then IWD seems to have stopped attempting to associate for some time.
> > My wireless interface showed link down, and I had no IP address.  I
> > attempted to associate to my older Google Nest network, but that also
> > failed with the same behavior (thus showing the problem not to be
> > Wifi
> > 7 or Ubiquiti-specific).
> >
> > I compiled up the mainline 6.13.2 kernel myself and saw the same
> > behavior.
> >
> > I then went back to the Arch 6.13.1 kernel, and the system operated
> > perfectly fine as expected.
> >
> > I bisected the break to this commit:
> >
> > $ git bisect good
> > c76fba3b07c7fb841c4f8f2acc0f01ff3cf73674 is the first bad commit
> > commit c76fba3b07c7fb841c4f8f2acc0f01ff3cf73674
> > Author: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> > Date:   Tue Dec 10 17:19:25 2024 -0800
> >
> >     wifi: mt76: mt7925: Cleanup MLO settings post-disconnection
> >
> >     [ Upstream commit 816161051a039eeb1226fc85e2b38389f508906c ]
> >
> >     Clean up MLO settings after disconnection.
> >
> >     Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the
> > firmware supports it")
> >     Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> >     Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> >     Link:
> > https://urldefense.com/v3/__https://patch.msgid.link/20241211011926.5
> > 002-16-
> > sean.wang@kernel.org__;!!CTRNKA9wMg0ARbw!nB_7DXY8l5AYSvgN3AMFpJZOJVng
> > 1dxSh_2yZLKT8S8DkDEwjaGvlcmALUeik84J7ePLJnvOe-2okec0mTc$
> >     Signed-off-by: Felix Fietkau <nbd@nbd.name>
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> >  drivers/net/wireless/mediatek/mt76/mt7925/main.c | 37
> > +++++++++++++++++++++++++++++++++++--
> >  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  |  4 ++--
> >  drivers/net/wireless/mediatek/mt76/mt7925/mcu.h  |  2 +-
> >  3 files changed, 38 insertions(+), 5 deletions(-)
> >
> > I attempted to revert this commit on top of 6.13.2, but there are
> > other commits that modify these files, so it can not be reverted by
> > itself.  I looked at the commit, and a thought occurred to me that
> > maybe wpa_supplicant might still function even though iwd did not.
> >
> > I set up wpa_supplicant, and found that I was able to associate and
> > pass network traffic.  HOWEVER, when running a simple iperf3 test,
> > saw
> > very slow speeds while associated (about 10 times slower than seen
> > with the 6.13.1 kernel).  Thus, I think this is quite clearly a
> > regression.  My guess is that this wireless adapter is new enough
> > that
> > many people have yet to hit this.
> >
> > Here are the details of the card:
> > # dmesg | grep mt79:
> > [   12.617246] mt7925e 0000:01:00.0: enabling device (0000 -> 0002)
> > [   12.622426] mt7925e 0000:01:00.0: ASIC revision: 79250000
> > [   12.698681] mt7925e 0000:01:00.0: HW/SW Version: 0x8a108a10, Build
> > Time: 20241104132949a
> > [   13.047884] mt7925e 0000:01:00.0: WM Firmware Version: ____000000,
> > Build Time: 20241104133053
> >
> > # lspci -vvv (mediatek device):
> > 01:00.0 Network controller: MEDIATEK Corp. Device 7925 (rev 01)
> >     Subsystem: Hewlett-Packard Company Device 8c38
> >     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > ParErr- Stepping- SERR- FastB2B- DisINTx+
> >     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> > <TAbort- <MAbort- >SERR- <PERR- INTx-
> >     Latency: 0, Cache Line Size: 64 bytes
> >     Interrupt: pin A routed to IRQ 116
> >     IOMMU group: 12
> >     Region 0: Memory at 90600000 (64-bit, non-prefetchable) [size=3D2M]
> >     Region 2: Memory at 90800000 (64-bit, non-prefetchable)
> > [size=3D32K]
> >     Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
> >         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> > unlimited, L1 unlimited
> >             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> > SlotPowerLimit 75W TEE-IO-
> >         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
> >             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
> >             MaxPayload 256 bytes, MaxReadReq 512 bytes
> >         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> > TransPend-
> >         LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
> > Latency L0s <2us, L1 <8us
> >             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
> >         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes, LnkDisable-
> > CommClk+
> >             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> >         LnkSta:    Speed 5GT/s, Width x1
> >             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> >         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
> > NROPrPrP- LTR+
> >              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+
> > EETLPPrefix-
> >              EmergencyPowerReduction Not Supported,
> > EmergencyPowerReductionInit-
> >              FRS- TPHComp- ExtTPHComp-
> >              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> >         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> >              AtomicOpsCtl: ReqEn-
> >              IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
> >              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
> >         LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink-
> > Retimer-
> > 2Retimers- DRS-
> >         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> >              Transmit Margin: Normal Operating Range,
> > EnterModifiedCompliance- ComplianceSOS-
> >              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
> > preshoot
> >         LnkSta2: Current De-emphasis Level: -3.5dB,
> > EqualizationComplete- EqualizationPhase1-
> >              EqualizationPhase2- EqualizationPhase3-
> > LinkEqualizationRequest-
> >              Retimer- 2Retimers- CrosslinkRes: unsupported
> >     Capabilities: [e0] MSI: Enable+ Count=3D1/32 Maskable+ 64bit+
> >         Address: 00000000fee00000  Data: 0000
> >         Masking: fffffffe  Pending: 00000000
> >     Capabilities: [f8] Power Management version 3
> >         Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> >         Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> >     Capabilities: [100 v1] Vendor Specific Information: ID=3D1556 Rev=
=3D1
> > Len=3D008 <?>
> >     Capabilities: [108 v1] Latency Tolerance Reporting
> >         Max snoop latency: 1048576ns
> >         Max no snoop latency: 1048576ns
> >     Capabilities: [110 v1] L1 PM Substates
> >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > L1_PM_Substates+
> >               PortCommonModeRestoreTime=3D3us PortTPowerOnTime=3D52us
> >         L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> >                T_CommonMode=3D0us LTR1.2_Threshold=3D166912ns
> >         L1SubCtl2: T_PwrOn=3D150us
> >     Capabilities: [200 v2] Advanced Error Reporting
> >         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> > RxOF- MalfTLP-
> >             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
> > AtomicOpBlocked- TLPBlockedErr-
> >             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
> > PCRC_CHECK- TLPXlatBlocked-
> >         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> > RxOF- MalfTLP-
> >             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
> > AtomicOpBlocked- TLPBlockedErr-
> >             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
> > PCRC_CHECK- TLPXlatBlocked-
> >         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
> > RxOF+ MalfTLP+
> >             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
> > AtomicOpBlocked- TLPBlockedErr-
> >             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
> > PCRC_CHECK- TLPXlatBlocked-
> >         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> > AdvNonFatalErr+ CorrIntErr- HeaderOF-
> >         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> > AdvNonFatalErr+ CorrIntErr+ HeaderOF-
> >         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
> > ECRCChkCap- ECRCChkEn-
> >             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> >         HeaderLog: 00000000 00000000 00000000 00000000
> >     Kernel driver in use: mt7925e
> >     Kernel modules: mt7925e
> >
> > On my system, /etc/iwd/main.conf contains:
> > ------------
> > [Scan]
> > DisablePeriodicScan=3Dtrue
> >
> > [General]
> > EnableNetworkConfiguration=3Dtrue
> > Country=3DUS
> > ------------
> >
> > At this point my suggestion is that the v6.13.2 mt7925 changes should
> > be reverted from the stable series for now, unless a fix can be
> > quickly found.  I have not yet tested 6.14-rc2, but would be willing
> > to do so if it would be helpful.
> >
> > Note: I am not subscribed to any of these lists, so please CC me if
> > you want to contact me about this.
> >
> > Respectfully submitted,
> > Caleb Jorden
> > cjorden@gmail.com
>
> Hi Caleb,
>
> Here are some patches are currently ongoing.
> Could you please apply these patches and try again?
>
> https://patchwork.kernel.org/project/linux-wireless/list/?series=3D925106
>
> Thanks~
>
> Best Regards,
> Yen.
>

Hi Yen,

Thank you for getting back to me so quickly.  However, I can't apply
these patches to the v6.13.2 kernel.  It appears that these apply
cleanly to the v6.14-rc2 kernel, but the stable series seems to have
only a subset of those changes.  Is this what you expect, or am I
missing something?


Respectfully submitted,
Caleb Jorden
cjorden@gmail.com

