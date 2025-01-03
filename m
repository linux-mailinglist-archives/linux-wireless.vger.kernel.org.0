Return-Path: <linux-wireless+bounces-17038-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92560A006DF
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 10:26:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C53E41883211
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 09:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64E61DE4D0;
	Fri,  3 Jan 2025 09:26:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73731DE4C9;
	Fri,  3 Jan 2025 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735896373; cv=none; b=atOwSr7NtivXVKOWCxt+XPSlbsG3uezqOEA3aPj7A9k2d+S9Yq/a3i2FoB3Y3GpA2bfi+JXPhgFKwlD1deQmuIhWMkiDz5aK0u7lUNiD6c+bX8rk92uAwnAv+D1+z5AADrBdHPKtR/aot7K8dEiL/nxvXXjSs2bmOjo/veb3ReE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735896373; c=relaxed/simple;
	bh=GEfzkV0EtIyjRBocsE1C64+YgnJLZHuYD/FZvAzNRK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ToFWff55MpdMGxTQeObXBTiSIn+TTELodUHTaPAB9qGq8Kiil9FIWLXHxOITMaZPpvaPGzscwknZrh6VMrPhiB6Hrctl8msPI1ki91oDuQEO6YF9tz8Hv1H9F9GlKoP5/coUDVWfI1UgUhyrroiRv//MTbwyTvOBilmHbIdyIkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5174f9c0d2aso3632569e0c.1;
        Fri, 03 Jan 2025 01:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735896369; x=1736501169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OjhYyamqLdDEJy3N4MKnSa94M/Zio7ELm/v+tKn61jg=;
        b=LVEtYvtFNMjvCuq+qsLE2K6mUybERwvVGTDVCTbwTgalm+kYi5iI1x2ObVDA+TMzAR
         OORHuc8Iyj2ivA9OV8J2TBpjV8NNnoR/u4mKsbRhaev7dgflgBwT7yYiWLF7W5c1NxPW
         QzKuXDez+vndLqbzZSmrUPSXjwHzZEOK+mhHA56YhfkeiAVInJV005oJdortbvrhzDW6
         eGap1YVvbBlmarjLEKwMFObcyM7tve4UsagDseNp6Jb0U7UqZiBpEBoh0zhZ0lpM84iV
         j0kFJFlM0Ucrm157XXxuRNW+/sxQKkA1IBBkS/V9+Kf9udbfGrKzPVTCcF2uLt8+SboJ
         rK1g==
X-Forwarded-Encrypted: i=1; AJvYcCUIA5fanBR/B8u88c2PsntqNOy0MVfj2xro490SdlpltMXbLCqzTX7wVEoubCy0SVfkfUN9JjpvUPjE9ew=@vger.kernel.org, AJvYcCUUjb2ZTLcukpDmnrV6zR8LQNlt9a5+iF4TcnWMCcL1Bq/kQdqu0/KHehPLZ3/BLI3APoCpnkfY@vger.kernel.org, AJvYcCWlND4wdX6rFCQIi360N5bFmJaTGIAtL4kw2Zi7uy/IYZe3k6pn5GTsXDL+mPe3/8G4xeXc3pw7GLkjUnyluDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo60YRKbRJiXn+ESU2eDZay+YMYLVrui3VhO/ZQjmPzKW3rDN0
	rdnkJwyTs0u44O9ub5JDMcsKGeK89QTzHb+gCrw+Xv5chA5DGOikleDq3HOS
X-Gm-Gg: ASbGncsxiQhMDT0ICgHHnUbwp5tbckJrFCjOZ55kFthcGY5atbdY3duxeqb5c1v0exq
	JPQ7ADpWDHPXPmE1PH8RAAi9Gp7YlrTwGs3g65NgseOaIJEh19N5ycwEhY8YoUa/c37mASx4+7n
	Wz3ADdzF57e+lsr6BzawXPyKe8lpEz01ayk6HhDQKy0OdxEYCKNm+3H6xQcZoALpCatui+VFAiR
	LsGRn7Lu9s+4e/F64V1SG75Szsz+XeAfWtY7l98Auz/phhGVu0hWbxyb4JyctxmoPDgV1qc4p0i
	vSTq3a++CAv1lT79tCk=
X-Google-Smtp-Source: AGHT+IH3twrlcVk9arJG3iTjqKuJVdSwCIpJmQ23+wKUjavbTsDYOuLtleOruUQTuYX+0rYMOXRzXQ==
X-Received: by 2002:a05:6122:1e07:b0:519:fcf2:ef51 with SMTP id 71dfb90a1353d-51b75c5cb4emr37816093e0c.5.1735896369391;
        Fri, 03 Jan 2025 01:26:09 -0800 (PST)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51b68cd94fbsm3281081e0c.41.2025.01.03.01.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 01:26:09 -0800 (PST)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-4b24d969db1so2945759137.0;
        Fri, 03 Jan 2025 01:26:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU2GEbFCXxdotQ0KhAc6wOXGO7Myhg1BxLMVxhsMrCPSf69it6H4PWA17aTR+tGBN7DEVgYIrYZ@vger.kernel.org, AJvYcCUsacDAC7DqYv/kdZ11Zx0/98gVGDXZB4WTkk8cFPuzZ27mCmLO+2+riCNMv6IAoSsaqjl1POebFEF/44o=@vger.kernel.org, AJvYcCWZmWwHaPxn4/e7pDAvFQWNs1UX8tuLim9MA6GI4DpasP1HZxBQGWkpRSv2RIRP4FzYPN/9gRpqUdxx+MKg3J8=@vger.kernel.org
X-Received: by 2002:a05:6102:50a7:b0:4b2:cbe5:fbc5 with SMTP id
 ada2fe7eead31-4b2cc462478mr39231786137.20.1735896368688; Fri, 03 Jan 2025
 01:26:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224080755.194508-1-philipp.g.hortmann@gmail.com>
 <b811d4af6a634d61389dfefacd49853c0e77f1d7.camel@sipsolutions.net>
 <39256db9-3d73-4e86-a49b-300dfd670212@gmail.com> <CAMuHMdVGdpVqkdvoFxu84YgBh_0fsAKeBhWFEg+nDyGLwbruig@mail.gmail.com>
 <11ae0b7362284d4828021068b05b38a280a9cee5.camel@infradead.org>
In-Reply-To: <11ae0b7362284d4828021068b05b38a280a9cee5.camel@infradead.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 3 Jan 2025 10:25:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXPSK-6_bMoiJyAsV4nhfW7HytZpOpf7Odg-4YKYNZfEA@mail.gmail.com>
Message-ID: <CAMuHMdXPSK-6_bMoiJyAsV4nhfW7HytZpOpf7Odg-4YKYNZfEA@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: toshiba: ps3_gelic_wireless: Remove driver
 using deprecated API wext
To: David Woodhouse <dwmw2@infradead.org>
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Geoff Levand <geoff@infradead.org>, Simon Horman <horms@kernel.org>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, 
	Larry Finger <Larry.Finger@lwfinger.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Pavel Machek <pavel@ucw.cz>, Stanislaw Gruszka <stf_xl@wp.pl>, 
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-staging@lists.linux.dev, 
	linux-wireless@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Stefan Lippers-Hollmann <s.l-h@gmx.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Fri, Jan 3, 2025 at 10:14=E2=80=AFAM David Woodhouse <dwmw2@infradead.or=
g> wrote:
> On Fri, 2025-01-03 at 09:53 +0100, Geert Uytterhoeven wrote:
> > > The following points are also in the list of reasons:
> > > - This driver has a maximum 54MBit/s as it supports only 802.11 b/g.
> > > - Using this hardware is security wise not state of the art as WPA3 i=
s
> > >     not supported.
> >
> > If you only do VPN over such an insecure link, I guess it's still safe?
>
> Why VPN? If it's public Internet that any you only use secure protocols
> such as https/ssh/etc over it that's just fine too.

Oh sure.

I was also considering it from the side of the wireless access point:
if you have to provide an non-secure access point just for your PS3,
an attacker can not only impact PS3 wireless traffic, but also connect
to the access point.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

