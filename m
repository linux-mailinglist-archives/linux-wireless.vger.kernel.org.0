Return-Path: <linux-wireless+bounces-18887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D91EFA336DE
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 05:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45210188B408
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 04:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283D8205E2E;
	Thu, 13 Feb 2025 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGb2OQ+3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19772054F2;
	Thu, 13 Feb 2025 04:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739420786; cv=none; b=cZ5O6QGpkjpsHj++q5uCSdbV/TAu6zFcYo1mZ3McsJbW1b1znTazWHqWWuUwk+CGfiWibI9O7W0kua610Xy995AXUPctubnhK2OIrQEVyU6TzA+epgW2O4xFsVqAUs88agGxmcDURxTZ+LPOtgZ/vLMy3n+6sWdGpGZwNicQtc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739420786; c=relaxed/simple;
	bh=xULLMWScW9h+mva36iDHvgoWVOtbHhBr7+say9/fUfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOJem+0/uPRQm7nGN2vexpJdNplKas9/LgzEFInBhnVZWSKvnGXyNyR+2oY/tBa1UHLlGK5BHJSxHhElBlQ1ffGai+uTJXPjKAH6FLM5fihQ7wcWPQgqjH58lJ9YlHPLsz/GFtTMuZxFa8l5pk0lz9FJ0I7SRcyTkwvRTnPSr7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGb2OQ+3; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-71e1158fe3eso321622a34.1;
        Wed, 12 Feb 2025 20:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739420783; x=1740025583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EvAcjjrE3dE26d0fNeIwktwvUlR8Vhig3nIKQZftbk=;
        b=kGb2OQ+3CSmdxvUWsakP7x6QV1o3U+mtEyC8npV+UJgq/nheDoKazeHNDHVwEP7xNC
         dAl01lS5xvCvaeK2vmODEy3WXQ89U/NexohHjAXNKVqWoKnA5ZTeX3W6qsUGiCrAkrhf
         DypaDDTfgENhbIiGZ/yVEYxXCO1a+vhKW80VBTJ0L4ieaViyTZvHvSNwaV2GOSmPOIEe
         5iv+HKX1VAorV5IB44a1E2o0I3/OpgSEOKe3RYmWKSuJV9QNP267V9Xna9wI592YQ00i
         JbgLY/fIYWt2h1V+3gPVjYRPyfuZtQk37rM0PSRkLJW9dggFGoFDjZpikXlALzfT4Z41
         UCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739420783; x=1740025583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EvAcjjrE3dE26d0fNeIwktwvUlR8Vhig3nIKQZftbk=;
        b=BO6zoJ1OiA47l46AuA2MXGq4lTX9EmZknCahlPBgHV+dfL0GCZwBIJ30eNv0rXqpX4
         K3U+N//DyIHs3F1XoBI3A5lr0T2PtEV49+13MJTXAVdqjaUGrgHnerW9l5OpCwXEpm33
         hzkVmbcgjAbFPX0aRlNl2uK188axF0RMj7m7GJPSXmdYKVlXct6XDoJxNVZWct47V6yD
         EOqEWi7g/rhLKe7a26Us4UgxI6fnxNO7o5TxD3Wva8txL3NQgN2VaFP5hjbEy/8KNMB2
         w1Al0dJblbPTpRMs0VFpLFgq5d7CE0FRCV56WZVTUNZq+zj8sQ6pIP/uGkb+tTfu0EuY
         4eIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPPJ35AihqrvWe3NatRuw98DNjnEQUq83NfGcH7NwsK3shApBeF0jSpdsFr889mC7kOjfmnf3j@vger.kernel.org, AJvYcCUakswvsnC/yeSIMmOA8u6xl0E/8mec0tKTEpc1Hb8MXg6lw40ZS6MURXiS1biH8ycVVL/YyPbF+Wb/iiSvnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhWyxs6zptCj+WiMdsSMx1GHyJyPbN1SSY3onaEnAd4XnQYKhZ
	SiW79RzG7y0lML7dXm4bYOkvWaGIaLWjB67cqY6qd8DJ+C/ee6j2VSt+PHdXeTMO7r5qBevTCPS
	+pPJuxPD7ZM+GUSX/+T3pggEn1d0=
X-Gm-Gg: ASbGncvATkZcL+fiPdr8dIwjzxYqW3iQExGnG19YcJykEmciTEw7SzmHu1shSSDLPbm
	fDhNT82nnPUTN7J0PmBAQlc2DW50Wmdtz2ADgw6bxOBo0iGAPDiPoOrCnNfpRWID8xQPPP2LZPo
	I=
X-Google-Smtp-Source: AGHT+IEqXxFbP5b5I24hpSrKq+MgZKA0AbABolj/rAJJhT3FWtA7NqTcoIgz0fhkBBtqecYuMu7g4rggKbU94MmvCsQ=
X-Received: by 2002:a05:6830:6e08:b0:726:f139:42b2 with SMTP id
 46e09a7af769-726f1ceeb21mr4091786a34.17.1739420782882; Wed, 12 Feb 2025
 20:26:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABD8wQ=pU9Yc45WE07FGO40MUBf+BSZFGcoO1ff7NxC1cXzx-A@mail.gmail.com>
 <d4c5d4f6f47d4d926c7a2469cb4b85c0850945ab.camel@mediatek.com> <CABD8wQ=K=xa4+KoEWuQNaMRP7A8fVY38ShyfW3DLcwVcU8R2aA@mail.gmail.com>
In-Reply-To: <CABD8wQ=K=xa4+KoEWuQNaMRP7A8fVY38ShyfW3DLcwVcU8R2aA@mail.gmail.com>
From: Caleb Jorden <cjorden@gmail.com>
Date: Wed, 12 Feb 2025 22:26:12 -0600
X-Gm-Features: AWEUYZnsL7Lvk1Evt5ZCZYFHu8IYnLzCwei8uM3nLVdabJqBVVW8kr6W7aEQJhk
Message-ID: <CABD8wQnRAdEUnc=NUeYjTXNOt5oX6secXw5jgC1C0Eb2wp4cTQ@mail.gmail.com>
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

On Wed, Feb 12, 2025 at 9:50=E2=80=AFPM Caleb Jorden <cjorden@gmail.com> wr=
ote:
>
> On Wed, Feb 12, 2025 at 9:43=E2=80=AFPM Mingyen Hsieh (=E8=AC=9D=E6=98=8E=
=E8=AB=BA)
> <Mingyen.Hsieh@mediatek.com> wrote:
> >
> > On Wed, 2025-02-12 at 21:16 -0600, Caleb Jorden wrote:
> > >
> > > External email : Please do not click links or open attachments until
> > > you have verified the sender or the content.
> > >
> > >
> > > Hello Kernel team,
> > >
> > > I discovered that the 6.13.2 kernel breaks my laptop's wireless.
> > > Here
> > > are the details of my system:
> > >
> > > - Framework 13 (AMD Ryzen 7840)
> > > - mt7925e wireless card (purchased from:
> > > https://urldefense.com/v3/__https://www.amazon.com/dp/B0DP68GV9V__;!!
> > > CTRNKA9wMg0ARbw!nB_7DXY8l5AYSvgN3AMFpJZOJVng1dxSh_2yZLKT8S8DkDEwjaGvl
> > > cmALUeik84J7ePLJnvOe-2oNQ7dxCM$ )
> > > - Arch Linux, using IWD (3.3) to manage Wireless network connectivity
> > >
> > > When running the 6.13.0 and 6.13.1 kernels (from Arch), the wireless
> > > adapter worked very well.  I was able to associate to my Wifi 7
> > > network (Ubiquiti U7 Pros) and operate in the 6GHz spectrum with
> > > 160MHz channels.  I also have an older wireless network that runs on
> > > Google Nest routers.
> > >
> > > When I upgraded to the 6.13.2 kernel from Arch Linux, my wireless
> > > suddenly stopped working.  I looked at the kernel logs and saw these
> > > messages (wireless addresses changed to make clearer the different
> > > points):
> > >
> > > [   10.007185] wlan0: authenticate with 28:80:xx:yy:zz:6e (local
> > > address=3D40:1a:58:aa:bb:cc)
> > > [   10.376446] wlan0: send auth to 28:80:xx:yy:zz:6e (try 1/3)
> > > [   10.384610] wlan0: 28:80:xx:yy:zz:6e denied authentication (status
> > > 77)
> > > [   10.483900] wlan0: authenticate with 28:80:xx:yy:zz:6e (local
> > > address=3D40:1a:58:aa:bb:cc)
> > > [   10.490138] wlan0: send auth to 28:80:xx:yy:zz:6e (try 1/3)
> > > [   10.507531] wlan0: send auth to 28:80:xx:yy:zz:6e (try 2/3)
> > > [   10.525580] wlan0: send auth to 28:80:xx:yy:zz:6e (try 3/3)
> > > [   10.543048] wlan0: authentication with 28:80:xx:yy:zz:6e timed out
> > > [   10.619423] wlan0: authenticate with 28:80:aa:bb:cc:e1 (local
> > > address=3D40:1a:58:aa:bb:cc)
> > > [   10.749880] wlan0: send auth to 28:80:aa:bb:cc:e1 (try 1/3)
> > > [   10.768530] wlan0: send auth to 28:80:aa:bb:cc:e1 (try 2/3)
> > > [   10.786954] wlan0: send auth to 28:80:aa:bb:cc:e1 (try 3/3)
> > > [   10.805792] wlan0: authentication with 28:80:aa:bb:cc:e1 timed out
> > > [   10.881620] wlan0: authenticate with 28:80:ee:ff:gg:6d (local
> > > address=3D40:1a:58:aa:bb:cc)
> > > [   11.016891] wlan0: send auth to 28:80:ee:ff:gg:6d (try 1/3)
> > > [   11.033622] wlan0: send auth to 28:80:ee:ff:gg:6d (try 2/3)
> > > [   11.050574] wlan0: send auth to 28:80:ee:ff:gg:6d (try 3/3)
> > > [   11.065250] wlan0: authentication with 28:80:ee:ff:gg:6d timed out
> > > [   11.139745] wlan0: authenticate with 2a:80:hh:ii:jj:6f (local
> > > address=3D40:1a:58:aa:bb:cc)
> > > [   11.506205] wlan0: send auth to 2a:80:hh:ii:jj:6f (try 1/3)
> > > [   11.528071] wlan0: send auth to 2a:80:hh:ii:jj:6f (try 2/3)
> > > [   11.550043] wlan0: send auth to 2a:80:hh:ii:jj:6f (try 3/3)
> > > [   11.572005] wlan0: authentication with 2a:80:hh:ii:jj:6f timed out
> > > [   16.312942] wlan0: authenticate with 2a:80:kk:ll:mm:e3 (local
> > > address=3D40:1a:58:aa:bb:cc)
> > > [   16.675865] wlan0: send auth to 2a:80:kk:ll:mm:e3 (try 1/3)
> > > [   16.702328] wlan0: send auth to 2a:80:kk:ll:mm:e3 (try 2/3)
> > > [   16.726162] wlan0: send auth to 2a:80:kk:ll:mm:e3 (try 3/3)
> > > [   16.748958] wlan0: authentication with 2a:80:kk:ll:mm:e3 timed out
> > > [   16.829874] wlan0: authenticate with 2a:80:nn:oo:pp:e2 (local
> > > address=3D40:1a:58:aa:bb:cc)
> > > [   17.196579] wlan0: send auth to 2a:80:nn:oo:pp:e2 (try 1/3)
> > > [   17.214256] wlan0: send auth to 2a:80:nn:oo:pp:e2 (try 2/3)
> > > [   17.231852] wlan0: send auth to 2a:80:nn:oo:pp:e2 (try 3/3)
> > > [   17.250116] wlan0: authentication with 2a:80:nn:oo:pp:e2 timed out
> > >
> > > Then IWD seems to have stopped attempting to associate for some time.
> > > My wireless interface showed link down, and I had no IP address.  I
> > > attempted to associate to my older Google Nest network, but that also
> > > failed with the same behavior (thus showing the problem not to be
> > > Wifi
> > > 7 or Ubiquiti-specific).
> > >
> > > I compiled up the mainline 6.13.2 kernel myself and saw the same
> > > behavior.
> > >
> > > I then went back to the Arch 6.13.1 kernel, and the system operated
> > > perfectly fine as expected.
> > >
> > > I bisected the break to this commit:
> > >
> > > $ git bisect good
> > > c76fba3b07c7fb841c4f8f2acc0f01ff3cf73674 is the first bad commit
> > > commit c76fba3b07c7fb841c4f8f2acc0f01ff3cf73674
> > > Author: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> > > Date:   Tue Dec 10 17:19:25 2024 -0800
> > >
> > >     wifi: mt76: mt7925: Cleanup MLO settings post-disconnection
> > >
> > >     [ Upstream commit 816161051a039eeb1226fc85e2b38389f508906c ]
> > >
> > >     Clean up MLO settings after disconnection.
> > >
> > >     Fixes: 86c051f2c418 ("wifi: mt76: mt7925: enabling MLO when the
> > > firmware supports it")
> > >     Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> > >     Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > >     Link:
> > > https://urldefense.com/v3/__https://patch.msgid.link/20241211011926.5
> > > 002-16-
> > > sean.wang@kernel.org__;!!CTRNKA9wMg0ARbw!nB_7DXY8l5AYSvgN3AMFpJZOJVng
> > > 1dxSh_2yZLKT8S8DkDEwjaGvlcmALUeik84J7ePLJnvOe-2okec0mTc$
> > >     Signed-off-by: Felix Fietkau <nbd@nbd.name>
> > >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> > >
> > >  drivers/net/wireless/mediatek/mt76/mt7925/main.c | 37
> > > +++++++++++++++++++++++++++++++++++--
> > >  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  |  4 ++--
> > >  drivers/net/wireless/mediatek/mt76/mt7925/mcu.h  |  2 +-
> > >  3 files changed, 38 insertions(+), 5 deletions(-)
> > >
> > > I attempted to revert this commit on top of 6.13.2, but there are
> > > other commits that modify these files, so it can not be reverted by
> > > itself.  I looked at the commit, and a thought occurred to me that
> > > maybe wpa_supplicant might still function even though iwd did not.
> > >
> > > I set up wpa_supplicant, and found that I was able to associate and
> > > pass network traffic.  HOWEVER, when running a simple iperf3 test,
> > > saw
> > > very slow speeds while associated (about 10 times slower than seen
> > > with the 6.13.1 kernel).  Thus, I think this is quite clearly a
> > > regression.  My guess is that this wireless adapter is new enough
> > > that
> > > many people have yet to hit this.
> > >
> > > Here are the details of the card:
> > > # dmesg | grep mt79:
> > > [   12.617246] mt7925e 0000:01:00.0: enabling device (0000 -> 0002)
> > > [   12.622426] mt7925e 0000:01:00.0: ASIC revision: 79250000
> > > [   12.698681] mt7925e 0000:01:00.0: HW/SW Version: 0x8a108a10, Build
> > > Time: 20241104132949a
> > > [   13.047884] mt7925e 0000:01:00.0: WM Firmware Version: ____000000,
> > > Build Time: 20241104133053
> > >
> > > # lspci -vvv (mediatek device):
> > > 01:00.0 Network controller: MEDIATEK Corp. Device 7925 (rev 01)
> > >     Subsystem: Hewlett-Packard Company Device 8c38
> > >     Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> > > ParErr- Stepping- SERR- FastB2B- DisINTx+
> > >     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort-
> > > <TAbort- <MAbort- >SERR- <PERR- INTx-
> > >     Latency: 0, Cache Line Size: 64 bytes
> > >     Interrupt: pin A routed to IRQ 116
> > >     IOMMU group: 12
> > >     Region 0: Memory at 90600000 (64-bit, non-prefetchable) [size=3D2=
M]
> > >     Region 2: Memory at 90800000 (64-bit, non-prefetchable)
> > > [size=3D32K]
> > >     Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
> > >         DevCap:    MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> > > unlimited, L1 unlimited
> > >             ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset+
> > > SlotPowerLimit 75W TEE-IO-
> > >         DevCtl:    CorrErr- NonFatalErr- FatalErr- UnsupReq-
> > >             RlxdOrd- ExtTag+ PhantFunc- AuxPwr- NoSnoop+ FLReset-
> > >             MaxPayload 256 bytes, MaxReadReq 512 bytes
> > >         DevSta:    CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr-
> > > TransPend-
> > >         LnkCap:    Port #1, Speed 5GT/s, Width x1, ASPM L0s L1, Exit
> > > Latency L0s <2us, L1 <8us
> > >             ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
> > >         LnkCtl:    ASPM L1 Enabled; RCB 64 bytes, LnkDisable-
> > > CommClk+
> > >             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> > >         LnkSta:    Speed 5GT/s, Width x1
> > >             TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
> > >         DevCap2: Completion Timeout: Range ABCD, TimeoutDis+
> > > NROPrPrP- LTR+
> > >              10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt+
> > > EETLPPrefix-
> > >              EmergencyPowerReduction Not Supported,
> > > EmergencyPowerReductionInit-
> > >              FRS- TPHComp- ExtTPHComp-
> > >              AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> > >         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> > >              AtomicOpsCtl: ReqEn-
> > >              IDOReq- IDOCompl- LTR+ EmergencyPowerReductionReq-
> > >              10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
> > >         LnkCap2: Supported Link Speeds: 2.5-5GT/s, Crosslink-
> > > Retimer-
> > > 2Retimers- DRS-
> > >         LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
> > >              Transmit Margin: Normal Operating Range,
> > > EnterModifiedCompliance- ComplianceSOS-
> > >              Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB
> > > preshoot
> > >         LnkSta2: Current De-emphasis Level: -3.5dB,
> > > EqualizationComplete- EqualizationPhase1-
> > >              EqualizationPhase2- EqualizationPhase3-
> > > LinkEqualizationRequest-
> > >              Retimer- 2Retimers- CrosslinkRes: unsupported
> > >     Capabilities: [e0] MSI: Enable+ Count=3D1/32 Maskable+ 64bit+
> > >         Address: 00000000fee00000  Data: 0000
> > >         Masking: fffffffe  Pending: 00000000
> > >     Capabilities: [f8] Power Management version 3
> > >         Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0mA
> > > PME(D0+,D1-,D2-,D3hot+,D3cold+)
> > >         Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME-
> > >     Capabilities: [100 v1] Vendor Specific Information: ID=3D1556 Rev=
=3D1
> > > Len=3D008 <?>
> > >     Capabilities: [108 v1] Latency Tolerance Reporting
> > >         Max snoop latency: 1048576ns
> > >         Max no snoop latency: 1048576ns
> > >     Capabilities: [110 v1] L1 PM Substates
> > >         L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > > L1_PM_Substates+
> > >               PortCommonModeRestoreTime=3D3us PortTPowerOnTime=3D52us
> > >         L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
> > >                T_CommonMode=3D0us LTR1.2_Threshold=3D166912ns
> > >         L1SubCtl2: T_PwrOn=3D150us
> > >     Capabilities: [200 v2] Advanced Error Reporting
> > >         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> > > RxOF- MalfTLP-
> > >             ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP-
> > > AtomicOpBlocked- TLPBlockedErr-
> > >             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
> > > PCRC_CHECK- TLPXlatBlocked-
> > >         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
> > > RxOF- MalfTLP-
> > >             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
> > > AtomicOpBlocked- TLPBlockedErr-
> > >             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
> > > PCRC_CHECK- TLPXlatBlocked-
> > >         UESvrt:    DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
> > > RxOF+ MalfTLP+
> > >             ECRC- UnsupReq- ACSViol- UncorrIntErr+ BlockedTLP-
> > > AtomicOpBlocked- TLPBlockedErr-
> > >             PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisIDETLP-
> > > PCRC_CHECK- TLPXlatBlocked-
> > >         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> > > AdvNonFatalErr+ CorrIntErr- HeaderOF-
> > >         CEMsk:    RxErr- BadTLP- BadDLLP- Rollover- Timeout-
> > > AdvNonFatalErr+ CorrIntErr+ HeaderOF-
> > >         AERCap:    First Error Pointer: 00, ECRCGenCap- ECRCGenEn-
> > > ECRCChkCap- ECRCChkEn-
> > >             MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> > >         HeaderLog: 00000000 00000000 00000000 00000000
> > >     Kernel driver in use: mt7925e
> > >     Kernel modules: mt7925e
> > >
> > > On my system, /etc/iwd/main.conf contains:
> > > ------------
> > > [Scan]
> > > DisablePeriodicScan=3Dtrue
> > >
> > > [General]
> > > EnableNetworkConfiguration=3Dtrue
> > > Country=3DUS
> > > ------------
> > >
> > > At this point my suggestion is that the v6.13.2 mt7925 changes should
> > > be reverted from the stable series for now, unless a fix can be
> > > quickly found.  I have not yet tested 6.14-rc2, but would be willing
> > > to do so if it would be helpful.
> > >
> > > Note: I am not subscribed to any of these lists, so please CC me if
> > > you want to contact me about this.
> > >
> > > Respectfully submitted,
> > > Caleb Jorden
> > > cjorden@gmail.com
> >
> > Hi Caleb,
> >
> > Here are some patches are currently ongoing.
> > Could you please apply these patches and try again?
> >
> > https://patchwork.kernel.org/project/linux-wireless/list/?series=3D9251=
06
> >
> > Thanks~
> >
> > Best Regards,
> > Yen.
> >
>
> Hi Yen,
>
> Thank you for getting back to me so quickly.  However, I can't apply
> these patches to the v6.13.2 kernel.  It appears that these apply
> cleanly to the v6.14-rc2 kernel, but the stable series seems to have
> only a subset of those changes.  Is this what you expect, or am I
> missing something?
>
>
> Respectfully submitted,
> Caleb Jorden
> cjorden@gmail.com

Hello again,

I decided to test the 6.14-rc2 kernel, and found it is broken just
like the 6.13.2 kernel.

I then tried applying the patches found here:

https://patchwork.kernel.org/project/linux-wireless/list/?series=3D925106

as suggested by Yen on top of 6.14-rc2, and everything seems to be
working normally again!  Speed seems to be very good (possibly better
than even 6.13.1).

So, I would suggest the 6.14 series pick up that set of patches.

For the stable 6.13.y series, it appears that either these patches
(and any necessary predecessors) need to be applied, or the changes
for the mt7925 driver introduced by 6.13.2 need to be reverted in
order to fix the currently-broken state.

If there is any further checking I can do that would be helpful,
please let me know.

Warm Regards,
Caleb Jorden
cjorden@gmail.com

