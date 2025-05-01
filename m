Return-Path: <linux-wireless+bounces-22308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB16AA5D47
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 12:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605229C4C7B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 May 2025 10:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8192E219E8C;
	Thu,  1 May 2025 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b="FsaXCZ1b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725461FFC4F
	for <linux-wireless@vger.kernel.org>; Thu,  1 May 2025 10:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746095687; cv=none; b=CBiV64w0T0l0gQtIMroqJdPvpv1g6B05GaBq9O+rYA1ptjMKIFu/LYvwepdOmMACbTj9HuDqtwViqwPO/VUJWK0Zc04d7z23990cA6XcP7RWjIfnR+7oO8vtf2m0mFpZYVFma0DTtq0pSRjA10iwZDQMrOHwD1QDSYLsEhDPX9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746095687; c=relaxed/simple;
	bh=MUTaj/7IFe8Nqbi69i12FfDGJ44WM/LIkZkn7/gejDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aR5IboB0UzY1Pjyya85qLh39CqL0oYhmgPNVmH8Zkp2TQWTShN/gczYV7ztL+FLSL16J2OnNBtz0rAgJbFqH6lQWfiLLs5vRBjyQWyRL8ivqHbZSuabbOOHCPUYQR0CwSUwpNJXSTVOqK8+1nlPXbnk/RGoa+Q4Jeir6r2CuMu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl; spf=pass smtp.mailfrom=conclusive.pl; dkim=pass (2048-bit key) header.d=conclusive.pl header.i=@conclusive.pl header.b=FsaXCZ1b; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=conclusive.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=conclusive.pl
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5f435c9f2f9so1157724a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 01 May 2025 03:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=conclusive.pl; s=google; t=1746095684; x=1746700484; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQTqQXX6bF7BPtljE58vt7cyRRi/056r9gupueutWvo=;
        b=FsaXCZ1b22VXn9gIQX8I1UWTUl4EK9hk+mxr5a//czMvGSAcVnWPZNrXv/pUIf4zI0
         10ipcusWEQUcNZ7UwdTQL6t7gCbSpWK/hDexUndJYgpZdEqYGUj/7nXteWC/VDi3vi0M
         sjw0zyiojyo+tLE2X/2tF6JqJwEyAcaxKux3oFshxSRQlR7QOvcnloWAlV+RI9OLlcrg
         9L7fR7+Rkb1llVuWEAgfTJLWnP17TqvbRJA35jFKxsp+vlxQLnO4nDS4x8WcMXewyvx+
         tgpeAL6pcFTRl9gNkxHPAP15ZXhrKDo+sOeRnX/RvRkm9b7bqWZADrHX6fUC4pAj82X3
         h6Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746095684; x=1746700484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQTqQXX6bF7BPtljE58vt7cyRRi/056r9gupueutWvo=;
        b=br8IbYxQ9Pme9tjPjurkcgEN45Ym+8UDr7b69P/ru2IWrEZu8iF4sKKwhhBpX/SbFL
         gkZhc5CfApMQyh480BNLWJglE7Rk8s/j5rUmcqMM1UZI8JJfhAR1G9NwXNGzO++N0BzO
         ELfk49tCsYIUiSCox+duiHvI3doibRXg04vNJES7np0lHymTVAX5CLQnKaC0szBvBRpY
         egjA3SvYRkAYywvga/xnS061VkB3vAlXiOcBlQumpxejZY1GIBBYhHIKvwHA1fzu5v7I
         mtJxcNYJFTzqC71I3bHR4gVkg1+hq1e3d4Fvi+SX8CWMnWNTolIceWMCE9JNjz736e1B
         c/YA==
X-Forwarded-Encrypted: i=1; AJvYcCXEy6rjp0vKY701nyG2w8futq1ybJWki2IednzEf3o0TYYgFrnwO9fwI9zdnsSdOeYwA2nGOL1wJqYeC+CEwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzycjseWHLoj8YkQHgSBs1kGPWZrpua4CBC3FP5WTGTuLhC3+M
	uBeWfK/VKAObnAD+DkZWa8/+KXcKbFIq5XKdek62ZQU/0pyn8h4i89xUEbc9gICmKCk70lYMDEP
	qgSxyNVg5Q/drRwx7iMLTP8p0/VlZxCgllk5HkA==
X-Gm-Gg: ASbGnctu1bf3nuzEU3sToHn8jb9vkXETWpb66vWe6gG1NHvWwF1y8j8DpP3D6zpERfQ
	WmFFCEvf2PW+Co4+DyWdBoigu2D5ihZ2UszjGC07vOirtLqPDOaAbj+gdqCtlcJlkSrRNhFXjMf
	rxX3QhGdVGP4YlbI8eTxJB+qU=
X-Google-Smtp-Source: AGHT+IHuZv2je4gGxhN7+ev1uXYmWjyBNOnwp20lzHsLJgfZTd7L6FICEpx+GOxp7dYxu+FNtnBrlAImRJQRK5hGbNU=
X-Received: by 2002:a05:6402:2786:b0:5f5:6299:ad68 with SMTP id
 4fb4d7f45d1cf-5f9124ec8dbmr2079272a12.11.1746095683491; Thu, 01 May 2025
 03:34:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250422175918.585022-1-artur@conclusive.pl> <20250422175918.585022-3-artur@conclusive.pl>
 <45b74f9f0831294e783a019cd6a1437fdad4eb6a.camel@sipsolutions.net>
 <CAGhaMFO_f_bvFB+39-z6xVF+y446ONwm1ROHQ=rXj=s4MnL54w@mail.gmail.com> <67cac31400c485ffee3bac24728fbfe128b73f6b.camel@sipsolutions.net>
In-Reply-To: <67cac31400c485ffee3bac24728fbfe128b73f6b.camel@sipsolutions.net>
From: Artur Rojek <artur@conclusive.pl>
Date: Thu, 1 May 2025 12:34:32 +0200
X-Gm-Features: ATxdqUF5U8dAltkMVsfQjIIWh1N9a22PvBa1CCHUXA5HYAtRc_3-gnwo5nUEqj4
Message-ID: <CAGhaMFOt01SXNejP9a07cQ-0czFGGbm0S08EBevO=dno0UpQ=A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] wifi: Add Nordic nRF70 series Wi-Fi driver
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jakub Klama <jakub@conclusive.pl>, 
	Wojciech Kloska <wojciech@conclusive.pl>, Ulf Axelsson <ulf.axelsson@nordicsemi.no>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 8:09=E2=80=AFPM Johannes Berg <johannes@sipsolution=
s.net> wrote:
>
> Hi,
>
> > This is commercial work. I am employed by Conclusive Engineering, and
> > was tasked with writing this driver. It was done for our internal needs
> > (we sell hardware [1] with nRF70 on-board), however I was also asked to
> > send the series upstream.
>
> Makes sense.
>
> > Nordic showed interest in this work, hence why their representative is
> > CCd to this conversation. They agreed to use our hardware as a referenc=
e
> > board for nRF70 used in Linux context.
>
> :)
>
> > I fully understand your concerns with maintenance (I am privately
> > a kernel contributor as well), and discussed this topic internally with
> > appropriate decision making people. They understand the responsibilitie=
s
> > involved and agreed to allocate time for me to support this driver long
> > term. As such, I will add myself to MAINTAINERS in v3.
>
> Cool good to hear :)
>
> > > https://lore.kernel.org/linux-wireless/21896d2788b8bc6c7fcb534cd43e75=
671a57f494.camel@sipsolutions.net/
> >
> > Bearing in mind above time constraints, I have no objections to helping
> > out. That said, this is my first Wi-Fi driver, and as such I am not tha=
t
> > familiar with the cfg80211 subsystem (hence why this series is RFC), so
> > my expertise will be limited at best.
> > What sort of help would you expect from me with the reviews?
>
> I'm just handwaving I guess ;-) It'd just be good to see people a bit
> involved in the community. Some apparently don't even have anyone who
> follows the list and what happens in the community at all.
>
> But it's a bit of a tit-for-tat thing - why would anyone review your
> code? Why would you even expect anyone to? The already overloaded
> maintainer? But on the other hand PHBs often think that sending their
> code upstream magically makes it better. There's real effort involved in
> keeping that true. :)
>
> > > That CPU_LITTLE_ENDIAN seems like a cop-out. Do we really want that?
> > > Asking not specifically you I guess...
> >
> > I addressed this in the cover letter (Patch 0/2), but nRF70 communicate=
s
> > using little-endian, byte packed messages, where each message type has
> > a unique set of fields.
>
> Sorry. Reading comprehension: 1, Johannes: 0. Guess I should look at
> that and reply there too.
>
> > This makes it a challenge to prepare said
> > messages on a big-endian system. I am aware of the packing API [2],
>
> I'm not familiar with it, tbh.
>
> > however a cursory look at it indicates that I would need to provide
> > custom code for each and every message (there's almost 150 of those in
> > total, even if the driver doesn't support all of them at the moment -
> > take a look at nrf70_cmds.h).
>
> Looking at this, I don't see why? They're all just fixed structures? The
> packing API appears (I never saw it before) to be for some form of bit-
> packing, I'd think?
>
> Looking at how you define the structures and how you use them, I'd say
> all you need to do is replace u32/s32 by __le32, u16 by __le16, and then
> fix the resulting sparse warnings by doing cpu_to_leXY()?
>
> > Unless the __packed attribute is guaranteed to align the bytes the same
> > way regardless of the endianness, and so calling cpu_to_le* for every
> > field of a message is good enough (these messages are byte packed, not
> > bit packed)?
>
> Now I'm confused, what did you think would happen? If you have
>
> struct foo {
>   u16 a;
>   u32 b;
> } __packed;
>
> you will get the 6 bytes, regardless of whether that's __le16/__le32 or
> u16/u32. 'a' will be two bytes, and 'b' will be 4 bytes, and all you
> need to do is convert the individual fields?
>
> Maybe I don't understand the question.

No, you're right. I somehow imagined that unaligned access will play
a role, but access to packed members should be completely independent
from byte swapping the lvalues.

PS. I expected this to be more complicated, but it turns out aarch64
can switch endianness at runtime, so I can continue testing on the same
hardware as before. All I had to do is tick CONFIG_CPU_BIG_ENDIAN=3Dy,
rebuild the rootfs for BE, and do minor hacks to the QSPI controller
driver, and now nRF70 driver is beginning to work with BE. On a side
note, I am taking a few days off, so v3 will come with a slight delay.

Cheers,
Artur

>
> > > > +struct __packed nrf70_fw_img {
> > > > +     u32 type;
> > > > +     u32 length;
> > > > +     u8 data[];
> > > > +};
> > >
> > > making the u32's here __le32's (and fixing sparse) would probably go =
a
> > > long way of making it endian clean. The __packed is also placed oddly=
.
> >
> > When declaring structure members for the messages (in nrf70_cmds.h),
> > I noticed that this attribute has to go before the braces:
> > > struct __packed { ... } name;
> > rather than after braces:
> > > struct { ... } __packed name;
>
> Wait .. that syntax isn't right either way? But it can be
>
> struct name { ... } __packed;
>
> and that's what roughly everyone else does?
>
> > > This sounds like you pretty much built the firmware for cfg80211 ;-)
> >
> > That's because the firmware *is* cfg80211.
>
> Actually it appears to be also mac80211?
>
> > Perhaps I am opening a can of worms here,
>
> Heh, I guess.
>
> >  but it has to be opened at some point during firmware
> > upstream. From what I've seen, part of the nRF70 firmware (called UMAC)
> > is derived from the cfg80211 project. Nordic makes the source code
> > publicly available at this location [3]. I have also asked Nordic to
> > provide a matching version of the source code for the fw blob they will
> > be upstreaming to the linux-firmware project (I believe I will be
> > assisting in that process as well). I hope everything there is dandy
> > license-wise, as I am not a lawyer :)
>
> Neither am I but the SFC says you have to have a way to build it. That
> might be a real challenge since this integrates cfg80211/mac80211 (GPL)
> and clearly unpublished proprietary code ("lmac").
>
> Nordic folks might want to consult their lawyers on this.
>
> johannes

