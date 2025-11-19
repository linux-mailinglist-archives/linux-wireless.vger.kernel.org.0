Return-Path: <linux-wireless+bounces-29127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B548AC6D7F1
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 09:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDFFE4F2414
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 08:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CFB31ED71;
	Wed, 19 Nov 2025 08:38:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E1132AACB
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541504; cv=none; b=q1X01JtKJcb+iTs/oJDBQ1VpzGAuGLbOQrJWwsmt97gJMab4H7ZrYuWt9acJhZYWSoSS59uAfpBmaKWsX/CsQQuCs2cBK/mIjkuiAJYTezK/Uf034YjcJRFkeH9SBk+jY/lVGXsEvMxh3tBwOt69VcD8m6xF27SzlUQvvBgs81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541504; c=relaxed/simple;
	bh=ny/AnZ++YidC1Sr/qjK3+DbdEu2xRrLYvhhb3wK8dYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjc7j1P3l4WfvNqWkSK7nNKmb137x442roqi9VDNgA6oGqDYGLz/JFlXxLtQ1HtZCSxGb3djRT5PEfV9lKo47kHY8A1Wt3nC4dq1LdU/01irLnEN96aC9K4o6e6L+/CAimgcpQEnBj2xe3M84MqUpSXbagcFltlROn6vMqoBA08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-5dfcfbcbcc0so1670664137.2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 00:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763541500; x=1764146300;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3olIEvv46EKoohjt1rvd/ggxwMd7dZjvEB7ssSNXcPA=;
        b=ns750XhYvIfKEg0XTazTi4AxFBVR1zkdtMr3R67PTF21x1fVBqpPtNN8nbadjFutsb
         JC/Q9/PysDZWBal/AiSJ1JhAfBy8d7o8GCkzG62fFB3kd/gtkquLWbY7vRv4lt7yEvRY
         1iMXi9MQ238S3QfJikAKR3Gi6egl7QvfyFwc06KX5oP+4NXztSQto8fJkJEx5WOWITZx
         WuhAntRss1cX+2yuBjkO0KDdtc4cOMC76VA6ySvdWq0dsH1wh5FEkh1L8j37chMVPUbf
         0W2G5q5gIOnT+5qZAMN+3Ty7pZ/KCF//bnIibqa8Pr2Wu5rxPCRS5kxVoHaJDWQA0m3f
         YMmA==
X-Gm-Message-State: AOJu0YxoN84Cs9tEoXhrdaozmojZ1OGCXngD1lzzVv+O8JbBMuorK642
	CegE2BxV2cfQCIysOy1Lz+pSxB8p+p17/sYJUFeeD3aCJeX/WE2JUdBhs4i7+0Zu
X-Gm-Gg: ASbGncuyYG5mNAWGbwiMMSpMYaXqTSYPpyNleVFwAjU2iuet4aD+mqhMCkSsylx/xNh
	W33cmPPAG61xxgOGeLRp1xDUT0BGRE4QnbO2aG+mmmO3ijdqpRKqbS1ODTmWEX697Kd5D3T1G1T
	oKUpNKZ/DCDE8gXcMTCXk4mgz8JX4oCwLP5LHrvd+aJUFlfgFPYM0D3ruoFd1TcMGkxP5N3ZRwH
	rsr7/YCvADTHluoMyTp9iUNwVeJ4kW6Sohmelp4VAAhJirHV0frANBgh8UVZvtCwrWIMdeCQwv5
	7m9YYU7fmHFICsuGLgZfnFrE3EH7PI++9Hs2K6JHBQSIyfKifnUnXhzX2RdRZQHO9a8b2s9x/1f
	vA0Ulgu9xeL3SyMHPmPo04FICdNXSqeyYei4yrXC5ZgbKi88qrNHBWEM9q660npihG6QHAmZ0Eu
	iv5Gv2dkCT7SWOdJ1ooFI/VS5opox2NHBaROiJR0uB15Os22pg
X-Google-Smtp-Source: AGHT+IH9+odom/IwcpVZk2GiUyyo595+zBfVaxflQzlg9cqz47toP8mrQh+RZ32/64jWTZW9CcELTg==
X-Received: by 2002:a05:6102:4487:b0:5db:3cda:cc3b with SMTP id ada2fe7eead31-5dfc5a73510mr6483616137.34.1763541499425;
        Wed, 19 Nov 2025 00:38:19 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-939161bab7asm4633525241.14.2025.11.19.00.38.19
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 00:38:19 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-5dfcfbcbcc0so1670659137.2
        for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 00:38:19 -0800 (PST)
X-Received: by 2002:a05:6102:424b:b0:5db:2b4d:f1ee with SMTP id
 ada2fe7eead31-5dfc55369femr6175703137.17.1763541498769; Wed, 19 Nov 2025
 00:38:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117032910.11224-1-pkshih@realtek.com> <20251117032910.11224-3-pkshih@realtek.com>
 <CAMuHMdUx6qY66bCcGsm1YHK3=H+=Td6YM_gsXJ=UgjAYJpGo0Q@mail.gmail.com> <c19306a1d41f4946801cf1c5b70c8528@realtek.com>
In-Reply-To: <c19306a1d41f4946801cf1c5b70c8528@realtek.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Nov 2025 09:38:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUu9=4ypfR69_hQpVAuh-mciwtpLsVv0eBa5KX4KTYjxw@mail.gmail.com>
X-Gm-Features: AWmQ_bkSQliBVZa201E35Dq0KttCSqfm-O946KFCRvI1QzDSJ7Hug8dhTb-oGQM
Message-ID: <CAMuHMdUu9=4ypfR69_hQpVAuh-mciwtpLsVv0eBa5KX4KTYjxw@mail.gmail.com>
Subject: Re: [PATCH rtw-next 2/2] wifi: rtw89: avoid to use not consecutive
 mask in __write_ctrl()
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Ping-Ke,

On Wed, 19 Nov 2025 at 02:15, Ping-Ke Shih <pkshih@realtek.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, 17 Nov 2025 at 04:30, Ping-Ke Shih <pkshih@realtek.com> wrote:
> > > The power value and enable bit fields can be not consecutive mask, but
> > > normally we expect mask argument of rtw89_mac_txpwr_write32_mask() is
> > > consecutive bit mask. Therefore, change the code accordingly.
> > >
> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> >
> > Thanks for your patch!
> >
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > > --- a/drivers/net/wireless/realtek/rtw89/mac.h
> > > +++ b/drivers/net/wireless/realtek/rtw89/mac.h
> > > @@ -1456,6 +1456,26 @@ static inline int rtw89_mac_txpwr_write32_mask(struct rtw89_dev *rtwdev,
> > >         return 0;
> > >  }
> > >
> > > +static inline
> > > +void rtw89_mac_write_txpwr_ctrl(struct rtw89_dev *rtwdev, u32 reg, u32 mask, u32 val,
> > > +                               u32 mask_en, bool cond)
> > > +{
> > > +       u32 wrt = u32_encode_bits(val, mask);
> >
> > Nit: you could do without this variable...
> >
> > > +       u32 val32;
> > > +       int ret;
> > > +
> > > +       if (cond)
> > > +               wrt |= mask_en;
> > > +
> > > +       ret = rtw89_mac_txpwr_read32(rtwdev, RTW89_PHY_0, reg, &val32);
> > > +       if (ret)
> > > +               return;
> > > +
> > > +       val32 &= ~(mask | mask_en);
> > > +       val32 |= wrt;
> >
> > val32 |= u32_encode_bits(val, mask);
> > if (cond)
> >         cal32 |= mask_en;
>
> With this change, ARCH arm is failed to build (x86 is well):
>
> In file included from /build/rtw89/core.h:9,
>                  from /build/rtw89/coex.h:8,
>                  from /build/rtw89/rtw8851b.c:5:
> In function 'field_multiplier',
>     inlined from 'field_mask' at ./include/linux/bitfield.h:170:17,
>     inlined from 'u32_encode_bits' at ./include/linux/bitfield.h:200:1,
>     inlined from 'rtw89_mac_write_txpwr_ctrl' at /build/rtw89/mac.h:1468:11:
> ./include/linux/bitfield.h:165:17: error: call to '__bad_mask' declared with attribute error: bad bitfield mask
>   165 |                 __bad_mask();
>       |                 ^~~~~~~~~~~~
> In function 'field_multiplier',

Hmm...

Note that u32_encode_bits() really requires a constant mask, just
like FIELD_PREP().  So probably the compiler can no longer deduce it
is called with a constant after restructuring the code...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

