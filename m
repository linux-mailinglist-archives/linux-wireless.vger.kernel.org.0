Return-Path: <linux-wireless+bounces-28677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5B8C3EFA4
	for <lists+linux-wireless@lfdr.de>; Fri, 07 Nov 2025 09:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30225188BF14
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Nov 2025 08:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345E630FF1D;
	Fri,  7 Nov 2025 08:35:20 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B87F2C21F2
	for <linux-wireless@vger.kernel.org>; Fri,  7 Nov 2025 08:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504520; cv=none; b=WbhPkEH2e/b2ZB6IilztqAVn3QpRtriSuxiKXLfosDmrOboxYH/QEjUDomtxTuY8aRNCsCZcHA8KKNXRz09UZwrhVhzxL2LOpMB7FP2LAUbVsLU/RmyhnGurIfvdexBKYwGkg10kBliFwlkhlGpMoRskd3iyr6BxFk1sCb5vnwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504520; c=relaxed/simple;
	bh=9JcvPVILVy97hsdXJNb7VMxu6BBjGO1PhoJ8NRS9yLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lEzCwqTRif/uhygPZogITs5YOZGw3rnZ+lQdH818x2j+zsIbPu0x1qS/bqHkg51N95yXgRfwyRQG8jP9N5jowgCspW0NBbRuF8gO4GF8S4LmWjT4mu8bauACdkcqA2cixqwwZKEP8IKESGUOovrA0n0w+9gC5uvA9X5gqgjy1Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5d5fbfca7e2so393021137.0
        for <linux-wireless@vger.kernel.org>; Fri, 07 Nov 2025 00:35:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762504517; x=1763109317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsHZezS59+NExnNGIIdIy6ER8EF0CQG8kO0yNppcdcI=;
        b=KLl7h0rxiavV185ATS+mSBRDGtV7wLfkvBSOL6Wpq2XVTA7PFw76mnkCYA2+vEyutA
         zYoHdEM2TdXJk/UWygStPKF1Nda+y6vlvyM+lXqqS/th8r3LB3+UeSWI2Ldw+yQasH4s
         WKv4c2yOVG5U28YTrS15bW7+KUGIBvxyQRn3Oh7l/cKeCAVvgTbpUAow7gFfpaINUtZD
         PaGSXoxlA6Max0wjRq8ozUvdQl9KXXJ95xmOG4EU7Y3hyagI7E1EnNUZ1WaAMbVhq6in
         4tVBORkF6TbberPpZPS41LhiMH3OITiJWq2i79LSIjb+8E3R5BBIiITr3PaallzjcVd8
         wgSw==
X-Forwarded-Encrypted: i=1; AJvYcCVzy3rt9659382G8CBmpZOf7zYf7MXWrglaMLh5qhzrItFQPNkuFfqE2AZluvZfssWjsuzxQwWa7ksQMgeu8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj9DpDzwSm2u8XuKWIQXAf+ZPhLR+DYTBH3P5YcRKQDbfdsok1
	sladllw1PSnnqetNokvaNE34YaLv+4Hz3CXvLep9eOcU7Q3gf098sRID0Iq/VDd3oUw=
X-Gm-Gg: ASbGncvDiEzbWVO1eoIzgHX78Cp5wENn80/YXSjABUkFSXbb8WzjPQGNXvR+dBk3HvG
	jy1x1C1q/JCZubqqNJhNXlIkQEeQ0InKlOm/86SauzImmFouJQxtTSOXZpSte8ixya6xhJeBkuT
	mv/zTUJBqWjNZNeJqrvuNoLRt3u89EUYmjTD8k8hPOAZ5o3git6KY/lmXhS8R6Y/Kx7cI4EKfBw
	mdx2/9ua+6R29jBle531F0JLr9fYhT01A+zhqhJDyvWwTP2Z8u5HsnJgMG/2yGsZ78wQkFWbvPg
	WpdMrQrlkNyT1osh/sAAC8LidzyUkV29EOAoDrvsgmfe/8hn+8qNFXLcDOFKdHCmqWenyN5s/mL
	cCxlUaLMtV2YPdID06GzpFeHPlNwmXTrXE0Z07CSnZ/BouXRbwusmi5bgD96HIbhgTqpkFEFyjq
	AFeTcIldksKMTOyK0qCJYcT7cx/dgy8dzBzClGEw==
X-Google-Smtp-Source: AGHT+IE8m7ArA5pBXePY5KX0MZuyGJA3lgnJ3DW4MYUuWLByOfFRpSv6+QTQ5pNv2gMkDXUNvUU6yw==
X-Received: by 2002:a05:6102:b0d:b0:5b8:e08f:eb38 with SMTP id ada2fe7eead31-5ddb9d949acmr257461137.14.1762504516803;
        Fri, 07 Nov 2025 00:35:16 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55995694597sm2596996e0c.7.2025.11.07.00.35.14
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 00:35:15 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-5dbde7f4341so439420137.1
        for <linux-wireless@vger.kernel.org>; Fri, 07 Nov 2025 00:35:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKUYvCiGeRHRUmfV7H0b0nAdJLkYLGQ56deVWI1pO2ZeFqXUT1g+y2O5XYe72z5YRV4RhREDD3CFrrszw73Q==@vger.kernel.org
X-Received: by 2002:a05:6102:4425:b0:5db:e32d:a3ff with SMTP id
 ada2fe7eead31-5ddb9e056aemr278996137.19.1762504514580; Fri, 07 Nov 2025
 00:35:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1762435376.git.geert+renesas@glider.be> <cfc32f8530d5c0d4a7fb33c482a4bf549f26ec24.1762435376.git.geert+renesas@glider.be>
 <aQy0T2vUINze_6_q@smile.fi.intel.com> <CAMuHMdXVUJq36GvNUQE8FnHsX+=1jG4GOJ_034r=fgr_Rw4Djg@mail.gmail.com>
 <aQzIIqNnTY41giH_@smile.fi.intel.com> <CAMuHMdW8ndAdGnSHopYFMWvw7wk7wKz_7+N91M1jRHoqK1KBrg@mail.gmail.com>
 <c62eb5a727f149fb9d8b4a4c8d77418a@realtek.com>
In-Reply-To: <c62eb5a727f149fb9d8b4a4c8d77418a@realtek.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Nov 2025 09:35:03 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU3hWDOWXxuOJcBA7tphBT7X-0H+g0-oq0tZdKw+O5W3A@mail.gmail.com>
X-Gm-Features: AWmQ_bkZe8xF0tkRpW5gVlylkcfm2r3jZb2Xa1XdOQVS8F7wx8KXagIs6XSHJvI
Message-ID: <CAMuHMdU3hWDOWXxuOJcBA7tphBT7X-0H+g0-oq0tZdKw+O5W3A@mail.gmail.com>
Subject: Re: [PATCH v6 12/26] bitfield: Add less-checking __FIELD_{GET,PREP}()
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Yury Norov <yury.norov@gmail.com>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Miller <davem@davemloft.net>, Linus Walleij <linus.walleij@linaro.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Crt Mori <cmo@melexis.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Jacky Huang <ychuang3@nuvoton.com>, 
	Shan-Chun Hung <schung@nuvoton.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Jakub Kicinski <kuba@kernel.org>, Alex Elder <elder@ieee.org>, 
	David Laight <david.laight.linux@gmail.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	Jason Baron <jbaron@akamai.com>, Borislav Petkov <bp@alien8.de>, Tony Luck <tony.luck@intel.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Kim Seer Paller <kimseer.paller@analog.com>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Richard Genoud <richard.genoud@bootlin.com>, 
	Cosmin Tanislav <demonsingur@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Jianping Shen <Jianping.Shen@de.bosch.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>, "qat-linux@intel.com" <qat-linux@intel.com>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, 
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Ping-Ke,

On Fri, 7 Nov 2025 at 02:16, Ping-Ke Shih <pkshih@realtek.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > The extra checking in field_prep() in case the compiler can
> > determine that the mask is a constant already found a possible bug
> > in drivers/net/wireless/realtek/rtw89/core.c:rtw89_roc_end():
> >
> >     rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rtwdev->hal.rx_fltr);
> >
> > drivers/net/wireless/realtek/rtw89/reg.h:
> >
> >     #define B_AX_RX_MPDU_MAX_LEN_MASK GENMASK(21, 16)
> >     #define B_AX_RX_FLTR_CFG_MASK ((u32)~B_AX_RX_MPDU_MAX_LEN_MASK)
> >
> > so it looks like B_AX_RX_FLTR_CFG_MASK is not the proper mask for
> > this operation...
>
> The purpose of the statements is to update values excluding bits of
> B_AX_RX_MPDU_MAX_LEN_MASK. The use of B_AX_RX_FLTR_CFG_MASK is tricky, but
> the operation is correct because bit 0 is set, so __ffs(mask) returns 0 in
> rtw89_write32_mask(). Then, operation looks like
>
>    orig = read(reg);
>    new = (orig & ~mask) | (data & mask);
>    write(new);

Thanks for your quick confirmation!
So the intention really is to clear bits 22-31, and write the rx_fltr
value to bits 0-15?

if the clearing is not needed, it would be better to use
#define B_AX_RX_FLTR_CFG_MASK GENMASK(15, 0)

If the clearing is needed, I still think it would be better to
change B_AX_RX_FLTR_CFG_MASK, and split the clearing off in a separate
operation, to make it more explicit and obvious for the casual reader.

> Since we don't use FIELD_{GET,PREP} macros with B_AX_RX_FLTR_CFG_MASK, how
> can you find the problem? Please guide us. Thanks.

I still have "[PATCH/RFC 17/17] rtw89: Use bitfield helpers"
https://lore.kernel.org/all/f7b81122f7596fa004188bfae68f25a68c2d2392.1637592133.git.geert+renesas@glider.be/
in my local tree, which started flagging the use of a discontiguous
mask with the improved checking in field_prep().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

