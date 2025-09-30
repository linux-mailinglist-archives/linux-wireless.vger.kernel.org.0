Return-Path: <linux-wireless+bounces-27735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8328BAC088
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 10:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59D3116BD5B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 08:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1C32765C3;
	Tue, 30 Sep 2025 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifmpje4a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9478221F17
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 08:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220807; cv=none; b=JI08MD+mpT7HNT8JYrS3V1vtg2FtoEaleRWOzdm1O+irj5T16NU6B+FaBLe0LbkOhm/nqEsJT5GrT0/3hDzuK4wNESWmVk4oT5ZBb27qMrh1NXOVq0pLM6zTx5oGmTob1nc8KUdJJDdhxf4vtSwA956DoYo5pYVWxPT+6nZb3OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220807; c=relaxed/simple;
	bh=bTsE/7rZCnwcod1Y0MXLHFehjSu6dnBbUq7kAxbDgIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Axp+WvxZlwoKcBQVIrlz3KPSJQ+5G6K4vzuiODMXSAxlRijz1y01drFMdFKRwcA9bRfjdkfx3O93+shFsLEOZ0ksaCsGAeMAgGrrmshS00u4x9ewi6CSqFHFt0ic4zNdSuJa7ojBRfya9mwJYaY4SoWX+448ZwxZJ3VTmDrumA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifmpje4a; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-634bc2d6137so7773294a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 01:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759220804; x=1759825604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yCCvV271rsdqfptu10r0u0/kEuRoIYrEG6Rb3RKJDc=;
        b=ifmpje4aGjm9eSwhqJaRaVY2qO/X1ZA1rrEp6uVpudUrFwxEbQ/i0d0f6ppkR+KJ/g
         y/iS93DEMN/DShWv1SRYvvDZbmWAJqGjm0TUz9311EC4IYRey0UVJjjbdGEHLcI0FhDp
         tDr/Ye1+0bDlV4/RS9QDr6UxUx0m4P5K/pm0dpvvFGo1oMd7JOgSAW78NgNJNjP12UEL
         UPL/ulYcPYCwGR48I9BQPcMClDnydExZsL4xVn2Kk+KWIUW5sODAQb01lY+aiXPnN8s4
         4UBMKpnqrdDrVQ26KgI5gjGdaJjIeygPMWvHIMfR/pN3Uiou57f+6Ht1CxmR8cZhxOL7
         qDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759220804; x=1759825604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yCCvV271rsdqfptu10r0u0/kEuRoIYrEG6Rb3RKJDc=;
        b=umDmxigbEGOnmpiuwj/W60xZnY0VmaAH3uL5kkiOVJ5rtDpkjdeeh1HAhHdT39Bz7e
         3sn7rq1YDoiMvtZf0UijiqsrDZyqkG//dGPa/S/INusR3/B+eO4PAsFbvXw3E3nq6mig
         n5iE5KZhEx/6/pFos6jlK1xj1vPwECb3er2nSzxZ6pxSSPxLZDEjftGQDLeKTB+Hh24Z
         pID32RNXUZk5BALM+AmgYwKkHKtUlvi4B3d1NM0+UArXmstp1Cbt241+T6yhVZgoRTxW
         GfpuM0unhz6dZmRstFuHB9ONKy/rmY9od9M8Ekk2ZUKroenjXxbdER/BpNDU56/i9eG6
         eOkg==
X-Forwarded-Encrypted: i=1; AJvYcCXHOtV5IgDkE0p3DKh57mDtYrN25b55JLyFl/pJs9U9bgrir4ZaXpS0MI4bCrsnNB/YGtbdyVzkCDW9FNGOfg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDfeId6lHr41i0q04Q0swCO7UP1Dip+N/99Dmszplq6qxtY2VR
	MWGgq7iTgKpkon8ZI79KPmuVLhZry35qAQcOo8anq5i9JFMWqfL2s1l2X9bhCiSrrrcMgNxxAtt
	IJhmr80mZOvVzMZC2quho+7/d18nwhCQ=
X-Gm-Gg: ASbGncsml5UHf2cOiS6HQ8Cq73njGu9Obze+UpMlT19rJMx20sci8LqHOEBS/GQA19W
	p+mOPqR1jZVCfmvZCGCGoB5yAQWLXVNeGbDze7aFKyFL6HeoSegQ7UBNM9IrfJoOwz1/aEPW4YQ
	H8WkTE3iLlkztgBuZfuqALTB1ctTTQFNVjJljPf+g6dVjtZuNkFnZm7VfahmEz9lHBxxD2cr36L
	r/Pu7nnokq0Es7MCr2w/bjNnjmcgq6uOv4oz3oEiw==
X-Google-Smtp-Source: AGHT+IEZ1/sLHld0TckfMBDGKCziLaLmZ5s/Sltpa7v3V9+zDBZl2DaNPjl02PUVjARd7Bh4vV3AtYZQIiTSd9XcTy4=
X-Received: by 2002:a05:6402:5052:b0:62d:4988:cc70 with SMTP id
 4fb4d7f45d1cf-6349fa83a01mr17509552a12.32.1759220803825; Tue, 30 Sep 2025
 01:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930042948.427154-1-wens@kernel.org> <CAHrRpunr+hbWiO1jY=jGZOiqGWcXFGYBSJi17+r-AgOMwssaXg@mail.gmail.com>
 <CAGb2v65wSPCeW=qgrjX1cBUfbYj55U9HUOdPw3n0zHm0PJpNNA@mail.gmail.com>
In-Reply-To: <CAGb2v65wSPCeW=qgrjX1cBUfbYj55U9HUOdPw3n0zHm0PJpNNA@mail.gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Tue, 30 Sep 2025 16:26:32 +0800
X-Gm-Features: AS18NWCMXtOMGLGQONzfH4-t6VHI8AtjPmmTHP7jsf6YrFUw8Qez5l22Ch3327Q
Message-ID: <CAHrRpum=kos=b+h=dPvQ2YaoXqPCEudjuU9-VNGQYRg928x=Ug@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Permit lower 6 GHz band for Kazakhstan (KZ)
To: wens@kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>, Pavel Starosek <starosekpd@gmail.com>, 
	wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chen-Yu Tsai <wens@kernel.org> wrote:
>
> On Tue, Sep 30, 2025 at 3:25=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> w=
rote:
> >
> > Chen-Yu Tsai <wens@kernel.org> wrote:
> > >
> > > By Order of the Minister of Digital Development No. 564/NK dated
> > > September 19, 2024 [1], an amendment was made to the assignment of
> > > frequency bands, opening up the lower part of the 6 GHz band (5,945 M=
Hz
> > > to 6,425 MHz) was opened up to "SRD (wideband data transmission syste=
ms)
> > > WAS/RLAN Data transmission systems/radio local area networks".
> > >
> > > The power is limited to 200 mW e.i.r.p. with a spectral density of 10
> > > mW/MHz. Only indoor use is permitted.
> > >
> > > While at it, also change the power limits to use mW units to match th=
e
> > > official documents.
> > >
> > > Initial information was provided by the Wi-Fi Alliance website, which
> > > has a map [2] showing all countries that have enabled 6 GHz WiFi, and
> > > links to official documents. This document was not sufficient as it d=
id
> > > not include power limits or other restrictions.
> > >
> > > A subsequent search found a blog post [3] providing details and title=
s
> > > of the official documents in English. An AI agent was used to search
> > > for the original text of said order [1] after rummaging through
> > > government websites in Russian and Kazakh failed to find anything.
> > >
> > > [1] https://adilet.zan.kz/rus/docs/V2400035100
> > > [2] https://www.wi-fi.org/regulations-enabling-6-ghz-wi-fi
> > > [3] https://www.onewindow.pro/blog-posts/6-ghz-band-regulation-in-the=
-republic-of-kazakhstan
> > >
> > > Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
> > > ---
> > > If you received this patch, please help review it. The changes are
> > > based on translations of the original text / tables, so a second set
> > > of eyes would be appreciated.
> > >
> > >  db.txt | 9 +++++----
> > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/db.txt b/db.txt
> > > index 6e1ad30..16bcb32 100644
> > > --- a/db.txt
> > > +++ b/db.txt
> > > @@ -1136,11 +1136,12 @@ country KY: DFS-FCC
> > >  # http://adilet.zan.kz/rus/docs/V1500010730
> > >  # http://adilet.zan.kz/rus/docs/V1500010375
> > >  country KZ: DFS-ETSI
> > > -       (2400 - 2483.5 @ 40), (20)
> > > -       (5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW
> > > +       (2400 - 2483.5 @ 40), (100 mW)
> > > +       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> > >         (5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW
> >
> > The power limit of 5150-5350 MHz is 200 mW, maximum spectral density
> > e.i.r.p. 10 mW/MHz.
> >
> > So, 5250 - 5350 should be 23 dBm or 200 mW.
>
> I had this question as well. Looking at the original submission history,
> it seems that the limit for 5250-5350 MHz was halved to cover TPC
> requirements. See [1]. I'd like to follow the existing values unless
> someone can point to documents stating otherwise.

Thanks for the info. Would you like to add the reference to commit message?
Anyway, it is fine to me.

Reviewed-by: Ping-Ke Shih <pkshih@gmail.com>

>
> Thanks
> ChenYu
>
> [1] https://lore.kernel.org/wireless-regdb/20191029144815.GR30813@ubuntu-=
xps13/
>
> > > -       (5470 - 5725 @ 160), (20), NO-OUTDOOR, DFS
> > > -       (5725 - 5850 @ 80), (20), NO-OUTDOOR
> > > +       (5470 - 5725 @ 160), (100 mW), NO-OUTDOOR, DFS
> > > +       (5725 - 5850 @ 80), (100 mW), NO-OUTDOOR
> > > +       (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
> > >         (57000 - 66000 @ 2160), (40)
> > >
> > >  country LB: DFS-FCC
> > > --
> > > 2.47.3
> > >
> > >

