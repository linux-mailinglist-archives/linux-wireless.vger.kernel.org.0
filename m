Return-Path: <linux-wireless+bounces-9010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D39908AF4
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 13:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EEB61C21CA3
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 11:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C33195B16;
	Fri, 14 Jun 2024 11:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KiJmhpMG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7E31922D1
	for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 11:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718365341; cv=none; b=K3GHQ2rherot3cyJjGIdsWO2tmqBbbMrxZS8W33tm2ONP34hBN6I3+eEz78dyrz+3neBKCOWg1XQaqpOj3gOJ2bNWm0PDKqgTfHBtO7ROKCKVPh3wrDRL8fcnOGH1x/eVyrMeuzf4d9/OC2/EY9WWff1nxqedBiALomwP6dC2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718365341; c=relaxed/simple;
	bh=BBCzqjahF3rXHFw2sbMJwaWElWdZgcrNAMl/TvdD1ZQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+j+ppsV80pdcfD1r85+9UZrDB8axEnWC153sMHNbq4erCUT1m6sTsC2Spzr2J1kjnkhHDmUDz9d41zfdJyU/S2Q2btYY5tzShV5OZAal/jMiILu1azYkeDiw/ZBl4x6UmS0oTAduz3o0zZqL+X8v1Oo3zDyPOiSgafVIqwsSZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KiJmhpMG; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c2e31d319eso1684522a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 04:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718365340; x=1718970140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBCzqjahF3rXHFw2sbMJwaWElWdZgcrNAMl/TvdD1ZQ=;
        b=KiJmhpMG9dQf+NSC3r1SV2uoMXNy4prwUntj2FyRsN3PdE344VBCIULFrzWAoPUBYd
         qnmb8++OJF3J6rawq24J6SD+x0kZXrLsb2PymIVMYS0ssOpNpsR4iyNgTIZCbZU7jeDb
         mpD5ZxPlqqK+IvrnwZpgEKrAB0cR3IemjsZRXrz3byfIFVMr7HKynB8GkaGJG6p0Idks
         kMs2CV36S+A2iCJ57y0oJVriom8D6qOyAb3MvZDZ5sDsEsyYlZhxVy18oZGgRDdXcnzu
         HEbKl2qjovwYyy4MESX5oo0XOAIVsKAotRtjf9ph1UW6V6Z/WNldUz3uWlSjh42Y3tqS
         4d0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718365340; x=1718970140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBCzqjahF3rXHFw2sbMJwaWElWdZgcrNAMl/TvdD1ZQ=;
        b=e5IkmjZlq6X5yKXS8jpJdNPJo+V83x+BbPi3ONBjO9A2KoGCoCZWormhyPJCE5O3m6
         Fb8JH1jzk++0sjLgxKrJV1kFjXlMK00H0+RoTo/ro0twhRhgGcO8jUmxSE/McM9ipT6l
         s3mT+jWOMWqDIY8b6uoBXc0pZfJyz7HUsyVq6s5/Zm0T8BNbDJbcFPD9fqrBGvl4lgGv
         3pKO0LgSoyz3fbWUocwXDWL4tg1CKNAO56n5MPq+Vzrz9v2q31Sz3Yh+UlOx3XRab+uc
         wDXWBKMnuQXcI80sUTEbQRGzYjSmsbvnHUZgm7LX91z4vz0O7ZJDMZ0DD+pareUXOKwv
         CPpQ==
X-Gm-Message-State: AOJu0Yzdp4OuOiVyix2UxkcHscaIQ2RzYAiEi0kAKETNIFsTIvkMz7Um
	jMzoIh5/+8dafq4sCZqlT4Bny/bHljeNB8vqV6g+o5+vPjTwPmtYjrWJpogbpxL5gOkgQuzlQ3k
	q7Kkp88KRBKkv461/eKgijcjMxMo=
X-Google-Smtp-Source: AGHT+IHwqQHg/0F+9Kj2TJPuTy1nESElg6fGsQUE8Jee7CMa9psViRlY6HRIfxtopi1ncFRJI6xRU5rMMZy/YMQMrvY=
X-Received: by 2002:a17:90b:1048:b0:2c4:af6a:a8f1 with SMTP id
 98e67ed59e1d1-2c4db44ba91mr2733916a91.23.1718365339780; Fri, 14 Jun 2024
 04:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527173454.459264-1-marcin.slusarz@gmail.com>
 <9bfc8f01e99b43e485b2afc6ae4fd661@realtek.com> <CA+GA0_sQ_Bnp8CUq1Pmxf7zut1Kocaxbw4iXT4hYC5_ceXb7WQ@mail.gmail.com>
 <3cc9cc75468d487c988dbacd8dfc5f57@realtek.com> <CA+GA0_tUy0EuXm0CGYa8SsS78oRNHUanBNwRf_BLXERa1=MYdg@mail.gmail.com>
 <b9c85972ab634364bf8a705a4f4513fd@realtek.com> <CA+GA0_v1rpoFrRVxpKpYqOrjdxEecn_m3+RKwxYc9H761dpMvw@mail.gmail.com>
 <6267f0999f34475ab21d0c42707f1bd9@realtek.com>
In-Reply-To: <6267f0999f34475ab21d0c42707f1bd9@realtek.com>
From: =?UTF-8?Q?Marcin_=C5=9Alusarz?= <marcin.slusarz@gmail.com>
Date: Fri, 14 Jun 2024 13:42:08 +0200
Message-ID: <CA+GA0_tpf4zrdvUEVEpiF7KPO_XRcwRXPbJbgnt40LiM+i2YPA@mail.gmail.com>
Subject: Re: wifi: rtw88: 8821CU hangs after some number of power-off/on cycles
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, =?UTF-8?Q?Marcin_=C5=9Alusarz?= <mslusarz@renau.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

wt., 4 cze 2024 o 02:50 Ping-Ke Shih <pkshih@realtek.com> napisa=C5=82(a):
>
> Marcin =C5=9Alusarz <marcin.slusarz@gmail.com> wrote:
> > > >
> > > > I'm asking because if we are going in this direction, there's somet=
hing
> > > > more to fix... With your v2, very frequently, I hit WARN_ON(!local-=
>started) in
> > > > ieee80211_rx_napi (in wireless-next, the code was moved to ieee8021=
1_rx_list).
> > > >
> > > > With my patch, I checked and hit that WARN_ON, too, but very occasi=
onally.
> > > >
> > > > I think the difference is in what happens in rtw_ips_enter - I disa=
bled only
> > > > the power_off, but you also disabled everything else, including the=
 cancelation
> > > > of work_structs.
> > > >
> > > > The warning itself sounds harmless, but I think users should never =
see such
> > > > warnings, so this needs to be fixed somehow. Probably some addition=
al
> > > > work_struct(s) need to be canceled?
> > > >
> > >
> > > I forgot to say my patch is compiled test only, and I didn't consider=
 flow
> > > too much, just to close the behavior of your patches. You can improve=
 my patch
> > > to be more reliable to avoid WARN_ON().
> >
> > Two variants of the patch that fix this issue will follow. They are
> > built on top of yours
> > v2 and my "wifi: rtw88: schedule rx work after everything is set up"
> > from the other thread.
> > Please choose the one you like more :).
>
> The patch "wifi: rtw88: usb: drop rx skbs when device is not running" is
> to drop all skb it receives. USB is still working, so I don't prefer this=
.
>
> "wifi: rtw88/usb: stop rx work before potential power off" seems to stop
> RX. But how rtw_usb_cancel_rx_bufs() can stop RX? Remove RX urb to stop i=
t?

Yes, URBs are removed, so the buffers will not be filled in, and
completion callbacks will not be called.

> Not sure if this is regular method for USB devices?

I'm not sure, either. Ideally, it should be disabled in hardware, but
AFAIK there's no public documentation for this chip, so no way for me
to figure out how to do it, and we are dealing with a case of power
management failure here.

> By the way, please take and refine my v2 patch into your patchset. That w=
ill
> be easier to me to merge patches finally.
>
> Ping-Ke
>

