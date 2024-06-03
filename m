Return-Path: <linux-wireless+bounces-8429-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26748D8586
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 16:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4918B23832
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 14:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F370A12D1F1;
	Mon,  3 Jun 2024 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjJZr+Vj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE1C12F5A5
	for <linux-wireless@vger.kernel.org>; Mon,  3 Jun 2024 14:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717426367; cv=none; b=ssL0dtLcBhP9ivLQ9AEBdky+OTwjrPKIFQNB5cv2YdGb1PxiTzlVPO90ibAFrDtrftDLUXCuS2Yd+zK8s44BG+8CIRMB//JjAPlJMUp4hfCupWXYmy5Jk1OySpXjzA0sJTlAqR40WJDYwATRrkdNb9kXdl5Tc/usUsnrrolpF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717426367; c=relaxed/simple;
	bh=L50mzYHAl+broDDdUVPJTzCnMe6cWLR2pEk07R4/mA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tj+Z5rFt/hVpq4rkSFdrywFWHzGUD3pxMiM2FO6BcVvdFPtLWt5u23MWENuemf8dYZuaj7kGbKsFCiF591bfq8uBU+27FDNSpelEqAD+abRT+miJTGM0eAh5G0W2+RO4gDdbZOjtIxC9xRmEbsjSQmKrc17bbPAtZ5hL1T+lI6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjJZr+Vj; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70109d34a16so4037711b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 03 Jun 2024 07:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717426366; x=1718031166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L50mzYHAl+broDDdUVPJTzCnMe6cWLR2pEk07R4/mA4=;
        b=EjJZr+Vj9yUTaoeNSqElsB0yCfdohdsa1zmnMmBJ41DcD3abzhS71iLpMeDB4Gk9WO
         2otcqFkUZAR6VbcI3qbb177bH+a3xkqNfi0naHVcmyjWhDkToEGaXe78c+rpKzOYRP7q
         V4Yw8yKmTn8MnYF9XOBuV7t+NiuGdju+3+xGef/214JyGsig+teqCcUL+P0L683nlEeY
         VDxl7e5BdBvUkwwnWwcQxC4rfh5EMNwQBXEbHmXz4KxrZRexHF0YIDE47FvsxkXZ1tgf
         Masryez8UA6NbvNtUTs0tU2LrY8kRjoBTgAh7WXXPv3oFDJC27tmAZq4rMgmg+/b3fig
         42RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717426366; x=1718031166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L50mzYHAl+broDDdUVPJTzCnMe6cWLR2pEk07R4/mA4=;
        b=iZpC8HDUwku2j6oVS/FGYsm1mArMsTmSbd0kRf9xPfjIMyyqJHB2uMLHski5vrRLRl
         4lhyQvaDJYQ3a3FvYHzBrWOH4EGwaZeTkD2VsuSRVpLXB8CJ3eiAlZcuMJXO6TG3gfeZ
         Oiv1Jle5gqyWuFAQ7FZqe+qv+m12hc5KQ1jYduo5I10X3C9p1SL/FEGMlXGTkwAENuNW
         F/PaFvgUSJKbzs5F2i1Iz9POac+MLQK6lZs1JQnLJWDM84KSGzDSMr/3+Jo+Zu2kahqm
         5iG+aNhyUV4YrvyrfxGHk/IqSyDJOX/XgK2B2TWo5KLA7YZokYa0ABRvEUZdmtzfszwq
         wBew==
X-Gm-Message-State: AOJu0Yxoq08XDUdYe7VwjUhL1gX+TEM1EOGLsraO16z4ZTBDQbOW0bvl
	FhvAVnxrRmpQPOTvTshj4txmD6CvWWLugX/jTyJOhkScwNNFX/qU7lpELh9jbwxd1hHLzgYzxPJ
	IMqiO9xbKDZtO6pPkJgYZrDlxoRk=
X-Google-Smtp-Source: AGHT+IFqorXq+HifS811xR7ulyfgQe91irwhg+z8+RdxovU5PSbjVha+xTZGRBPCHUc2cfU0h9wjptvNix0CC+1FVls=
X-Received: by 2002:aa7:8890:0:b0:702:2d79:f4e5 with SMTP id
 d2e1a72fcca58-702477be3bbmr11434555b3a.5.1717426365554; Mon, 03 Jun 2024
 07:52:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527173454.459264-1-marcin.slusarz@gmail.com>
 <9bfc8f01e99b43e485b2afc6ae4fd661@realtek.com> <CA+GA0_sQ_Bnp8CUq1Pmxf7zut1Kocaxbw4iXT4hYC5_ceXb7WQ@mail.gmail.com>
 <3cc9cc75468d487c988dbacd8dfc5f57@realtek.com> <CA+GA0_tUy0EuXm0CGYa8SsS78oRNHUanBNwRf_BLXERa1=MYdg@mail.gmail.com>
 <b9c85972ab634364bf8a705a4f4513fd@realtek.com>
In-Reply-To: <b9c85972ab634364bf8a705a4f4513fd@realtek.com>
From: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date: Mon, 3 Jun 2024 16:52:39 +0200
Message-ID: <CA+GA0_v1rpoFrRVxpKpYqOrjdxEecn_m3+RKwxYc9H761dpMvw@mail.gmail.com>
Subject: Re: wifi: rtw88: 8821CU hangs after some number of power-off/on cycles
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, =?UTF-8?Q?Marcin_=C5=9Alusarz?= <mslusarz@renau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

czw., 30 maj 2024 o 05:13 Ping-Ke Shih <pkshih@realtek.com> napisa=C5=82(a)=
:
>
> Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> > =C5=9Br., 29 maj 2024 o 03:52 Ping-Ke Shih <pkshih@realtek.com> napisa=
=C5=82(a):
> > >
> > > Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> > > > wt., 28 maj 2024 o 05:52 Ping-Ke Shih <pkshih@realtek.com> napisa=
=C5=82(a):
> > > > >
> > > > > Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> > > > > >
> > > > > > I found out that the reason for those hangs is a power-off+on s=
equence that's
> > > > > > triggered by the above steps.
> > > > >
> > > > > To avoid power-off/on sequence once device becomes idle, I would =
like to add
> > > > > a ips_disabled helper. Please revert your changes and apply my at=
tached patch.
> > > >
> > > > My first attempt was very similar, and it fixed some cases but not =
all of them.
> > > >
> > > > This is due to the existence of a second source of power-offs - rtw=
_ops_stop,
> > > > which is called, e.g., on downing the interface (ifconfig wlan0 dow=
n).
> > >
> > > Please try attached v2 patch. I would like to have an explicit helper
> > > (i.e. always_power_on in v2) to have this fix, so days later people c=
an be easy
> > > to understand how it works. Not prefer adjusting existing flags to im=
plicitly
> > > have behavior you want.
> >
> > So, do you think this is a chip issue, not just some driver misconfigur=
ation?
>
> I asked internal USB WiFi people who say vendor drivers of USB/SDIO can't
> power-on/-off frequently but not very sure if hardware issue or driver is=
sue.
>
> >
> > I'm asking because if we are going in this direction, there's something
> > more to fix... With your v2, very frequently, I hit WARN_ON(!local->sta=
rted) in
> > ieee80211_rx_napi (in wireless-next, the code was moved to ieee80211_rx=
_list).
> >
> > With my patch, I checked and hit that WARN_ON, too, but very occasional=
ly.
> >
> > I think the difference is in what happens in rtw_ips_enter - I disabled=
 only
> > the power_off, but you also disabled everything else, including the can=
celation
> > of work_structs.
> >
> > The warning itself sounds harmless, but I think users should never see =
such
> > warnings, so this needs to be fixed somehow. Probably some additional
> > work_struct(s) need to be canceled?
> >
>
> I forgot to say my patch is compiled test only, and I didn't consider flo=
w
> too much, just to close the behavior of your patches. You can improve my =
patch
> to be more reliable to avoid WARN_ON().

Two variants of the patch that fix this issue will follow. They are
built on top of yours
v2 and my "wifi: rtw88: schedule rx work after everything is set up"
from the other thread.
Please choose the one you like more :).

