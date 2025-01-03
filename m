Return-Path: <linux-wireless+bounces-17041-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8ABA00873
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 12:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F04B3A45C5
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 11:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627EF1F9F51;
	Fri,  3 Jan 2025 11:16:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323A61F9ECF;
	Fri,  3 Jan 2025 11:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735903017; cv=none; b=LIuFiO1XkBEZkvkKwsZ+pXUD3FZxpLt157s4DIp/UlqpcA8YpBC8KZ2lwU+mEQEBgoCWw4DZm8tDtFNF9BRv2Y5GvV+8QmMB8b+E7EY75GdHPYldu4lAimQlMt4lr95YAGMA3aLoPD7+oA/MAoqctzUJCRHOWs4Cr/Jo14Adi00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735903017; c=relaxed/simple;
	bh=L46r5y3XyXMN/GlccWSjfXZAWkNDi6AOwGcboh8Kgt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mMdJwagfzoM6s7FitgCEEv63N7eddUMGhLraHmsLn8FKCZMEb5dqzlZTnO4GuTcELkRr7CRY6XtNFCzwBRe46RsPdUgCsccUufiaZ0Dh5dS0zsJulQl1/UfqC1JX4dTTnPkbfQiZR0a0TJBwrp3kxbk3Lwwnqd5Fni8A8fMW7jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-4b24d969db1so2961406137.0;
        Fri, 03 Jan 2025 03:16:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735903012; x=1736507812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZmSRcWChTP1b8zCChxx/86+scbNEDzughwHQ+tv0ThM=;
        b=f4USLOY3F0/YgDv7AIIdrkEwIZj5c55Un1fdjv7mWn9OL4BXDl9BntzXuiwFuUfc8P
         Ao4JOmV35aiBevKIzeA27PNT7kMBy8CKr1AOIWotO/yLH4kAVGABa6NqEa4CYrhqO32o
         52yi2OaFyymx+g5CWJbsjGqnSfJaZSM7Axr9YBC1SQxb/7gKZIpuOkLo+5BR26UILHJc
         oRWkbddbCOt82Kw+iWV9FyYDFNzksjPo+moVkGq1q0iNJnyX+baYTT91tqspS+psdxrU
         Lmf3yan/6uGLz0xDzWt06/S2xuAxDXnUVMaQHTiarRU4nvZ67TmO5WYHvFzVgIHctIOy
         aaJw==
X-Forwarded-Encrypted: i=1; AJvYcCWGRYfWBKvL3vBpCKxkupFbvNeL4Vv1dOvfO/852WXrwHV7zfMHESX66tnR3Cr8mlkywCxNhLxb@vger.kernel.org, AJvYcCXPlEH1spK/TzkGwiTaOj2WdvzCKar6vZgVFv45PSZYdP/KlSqFLAMFkD7ZdIWmk7dyT2f2WR3tdB314/fjveA=@vger.kernel.org, AJvYcCXWAwVqdHVSorjyWCC5thBEA+Uk2aaa6/o8Aea3w5L/MSXgoxQSz9F0XCLzdhi9YSdKbxUDij1aPh9WbEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxChNzzNqKGzRoa2NQUxt8ve8S++1YmwGtthWv6n9gxfZxSXgI3
	Rg/rGD5Vqy7ZuskyTrcToFhmtfXMbzWBBYClUostO7a/di8IwKZzj6DgdU4PxFM=
X-Gm-Gg: ASbGncvx5eUdP18biE8h+qqGsSOrtEg4RHw3wa0mtaADMCbsMmTCpfNyByIMe2ttGTY
	fbPtRaBsqsinJkpz0wmsT7FZS+kPfkOqEc/yMylYqKBFDCfGQ6xQwxJC8zGzpHRffSg1biQqx+L
	8yzuIwyP2XibAyOJgJvfZ3Dz8ofFvrSgIlZKx7vnd7ykOZMfI4YRLqmNtC8gJeEUYZO3OLBkGIl
	X+FblAQaH4zP50Ou/bLD0q0vGwK4FSbXgGICkKeC1h8FboDwTdPI5Sq2MIwOzIdNRg6PA2y5nb8
	kqiPLtGgwIDFwbhViUA=
X-Google-Smtp-Source: AGHT+IEUXmPvSmzfOd8j8syZoYxzob9xBITG7RwvlUeeBCTV7lvwrV1KarUXxtMdaDTi9ymni78OMQ==
X-Received: by 2002:a05:6102:442a:b0:4b1:340a:ce63 with SMTP id ada2fe7eead31-4b2cc3740f1mr39286981137.11.1735903011910;
        Fri, 03 Jan 2025 03:16:51 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b2bf9a7155sm5522154137.11.2025.01.03.03.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 03:16:51 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4afed7b7d1bso3718605137.2;
        Fri, 03 Jan 2025 03:16:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUR34r/Ab000bJ9adTWI6MCSZmDiLHWgeur6bAT9WFlqpi9L/A0trO/xCCENN2ZD6qwMsSq9fKW5J6/xbxHoxA=@vger.kernel.org, AJvYcCV4s2ztdg+d7PUVkHKIOGt5gUdLrfzG/taIyR780F/0ysFgUmp5qls4ayey53TiEBw2dpgneLdLuvjS3bY=@vger.kernel.org, AJvYcCVrdUSGHNmN2GDIebIEQTiJ01U2MemsaCohOSi6f/cTLvIj2zdmhgGB19MvX9RatIERweX/Kpqm@vger.kernel.org
X-Received: by 2002:a05:6102:3e83:b0:4b2:af6e:5fef with SMTP id
 ada2fe7eead31-4b2cc35c2d5mr38018549137.9.1735903010498; Fri, 03 Jan 2025
 03:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241224080755.194508-1-philipp.g.hortmann@gmail.com>
 <b811d4af6a634d61389dfefacd49853c0e77f1d7.camel@sipsolutions.net>
 <39256db9-3d73-4e86-a49b-300dfd670212@gmail.com> <CAMuHMdVGdpVqkdvoFxu84YgBh_0fsAKeBhWFEg+nDyGLwbruig@mail.gmail.com>
 <8dfe122d-ce0e-4a1d-9a2f-f7585036b989@gmail.com>
In-Reply-To: <8dfe122d-ce0e-4a1d-9a2f-f7585036b989@gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 3 Jan 2025 12:16:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX_P9WGBiShm6Dp64Y9GRvESH-Nn=b=rRrsGbwza81VeA@mail.gmail.com>
Message-ID: <CAMuHMdX_P9WGBiShm6Dp64Y9GRvESH-Nn=b=rRrsGbwza81VeA@mail.gmail.com>
Subject: Re: [PATCH] net: ethernet: toshiba: ps3_gelic_wireless: Remove driver
 using deprecated API wext
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Geoff Levand <geoff@infradead.org>, 
	Simon Horman <horms@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, netdev@vger.kernel.org, 
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

Hi Philipp,

On Fri, Jan 3, 2025 at 12:02=E2=80=AFPM Philipp Hortmann
<philipp.g.hortmann@gmail.com> wrote:
> On 03.01.25 09:53, Geert Uytterhoeven wrote:
> > Care to tell us where the fix is?
>
> please find all patches for T2 on this page:
> https://wiki.t2linux.org/guides/kernel/
> More exact here:
> git clone --depth=3D1 https://github.com/t2linux/linux-t2-patches patches

Thanks, but I cannot find a ps3disk fix there?

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

